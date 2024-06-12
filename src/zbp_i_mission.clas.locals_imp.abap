CLASS lhc_mission DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Mission RESULT result.
    METHODS calculatemissionkey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR mission~calculatemissionkey.

    METHODS validatedates FOR VALIDATE ON SAVE
      IMPORTING keys FOR mission~validatedates.

    METHODS validatedescription FOR VALIDATE ON SAVE
      IMPORTING keys FOR mission~validatedescription.

    METHODS validatetitre FOR VALIDATE ON SAVE
      IMPORTING keys FOR mission~validatetitre.

ENDCLASS.

CLASS lhc_mission IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD CalculateMissionKey.
  READ ENTITIES OF zi_mission IN LOCAL MODE
      ENTITY Mission
        FIELDS ( missionid ) WITH CORRESPONDING #( keys )
      RESULT DATA(missions).

    " remove lines where CongeID is already filled.
    DELETE missions WHERE missionid IS NOT INITIAL.

    " anything left ?
    CHECK missions IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zpfe_mission
        FIELDS MAX( missionid )
        INTO @DATA(max_missionid).

    " Set the travel ID
    MODIFY ENTITIES OF zi_mission IN LOCAL MODE
    ENTITY Mission
      UPDATE
        FROM VALUE #( FOR mission IN missions INDEX INTO i (
          %tky              = mission-%tky
          missionid         = max_missionid + i
          %control-missionid = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateDates.
   READ ENTITIES OF zi_mission IN LOCAL MODE
      ENTITY Mission
        FIELDS ( missionid datedebut datefin ) WITH CORRESPONDING #( keys )
      RESULT DATA(missions).

    LOOP AT missions INTO DATA(mission).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = mission-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-MISSION.

      IF mission-datefin < mission-datedebut.
        APPEND VALUE #( %tky = mission-%tky ) TO failed-MISSION.
        APPEND VALUE #( %tky               = mission-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date incorrecte'
                        ) )
                    TO reported-MISSION.

      ELSEIF mission-datedebut < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = mission-%tky ) TO failed-MISSION.
        APPEND VALUE #( %tky               = mission-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Début incorrecte'
                        ) )
                       TO reported-MISSION.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDescription.
   READ ENTITIES OF zi_mission IN LOCAL MODE
    ENTITY Mission
    FIELDS ( description ) WITH CORRESPONDING #( keys )
    RESULT DATA(missions).

    LOOP AT missions INTO DATA(mission).

      IF mission-description = ''.
        APPEND VALUE #( %tky = mission-%tky ) TO failed-MISSION.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Description incorrecte'
                    ) )
                    TO reported-MISSION.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateTitre.
  READ ENTITIES OF zi_mission IN LOCAL MODE
    ENTITY Mission
    FIELDS ( titre ) WITH CORRESPONDING #( keys )
    RESULT DATA(missions).

    LOOP AT missions INTO DATA(mission).

      IF mission-titre = ''.
        APPEND VALUE #( %tky = mission-%tky ) TO failed-MISSION.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Titre incorrecte'
                    ) )
                    TO reported-MISSION.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

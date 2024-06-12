CLASS lhc_formation DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateFormationKey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Formation~CalculateFormationKey.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Formation~validateDates.

    METHODS validateFormateur FOR VALIDATE ON SAVE
      IMPORTING keys FOR Formation~validateFormateur.

        METHODS validateModalite FOR VALIDATE ON SAVE
      IMPORTING keys FOR Formation~validateModalite.

    METHODS validateSujet FOR VALIDATE ON SAVE
      IMPORTING keys FOR Formation~validateSujet.

ENDCLASS.

CLASS lhc_formation IMPLEMENTATION.

  METHOD CalculateFormationKey.
  READ ENTITIES OF zi_formation IN LOCAL MODE
      ENTITY Formation
        FIELDS ( FormationId ) WITH CORRESPONDING #( keys )
      RESULT DATA(formations).

    " remove lines where CongeID is already filled.
    DELETE formations WHERE FormationId IS NOT INITIAL.

    " anything left ?
    CHECK formations IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zpfe_formation
        FIELDS MAX( FormationId )
        INTO @DATA(max_FormationId).

    " Set the travel ID
    MODIFY ENTITIES OF zi_formation IN LOCAL MODE
    ENTITY Formation
      UPDATE
        FROM VALUE #( FOR formation IN formations INDEX INTO i (
          %tky              = formation-%tky
          formationid         = max_FormationId + i
          %control-FormationId = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateModalite.
  READ ENTITIES OF zi_formation IN LOCAL MODE
    ENTITY Formation
    FIELDS ( modalite ) WITH CORRESPONDING #( keys )
    RESULT DATA(formations).

     DATA: lt_valid_values TYPE TABLE OF zpfe_mod_forma,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( modalite = 'Sur site' ) ( modalite = 'En ligne' ) ).

  LOOP AT formations INTO DATA(formation).
    lv_entered_value = formation-modalite.  " Get the value to validate

    " Initialize the flag
    lv_valid_flag = abap_false.

    " Check if the entered value is in the list of valid values
    LOOP AT lt_valid_values INTO DATA(lv_valid_value).

       IF lv_entered_value = lv_valid_value .
        lv_valid_flag = abap_true.  " Set flag to true if entered value matches any valid value
        EXIT.  " Exit loop if a match is found
      ENDIF.
    ENDLOOP.

    " If the entered value is not valid, add it to failed-formation and reported-conge
    IF lv_valid_flag = abap_false.
      APPEND VALUE #( %tky = formation-%tky ) TO failed-formation.
      APPEND VALUE #( %tky               = formation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Modalité incorrecte'
                      ) )
                     TO reported-formation.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateDates.
  READ ENTITIES OF zi_formation  IN LOCAL MODE
      ENTITY Formation
        FIELDS ( formationid datedebut datefin ) WITH CORRESPONDING #( keys )
      RESULT DATA(formations).

    LOOP AT formations INTO DATA(formation).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = formation-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-formation.

      IF formation-datefin < formation-datedebut.
        APPEND VALUE #( %tky = formation-%tky ) TO failed-formation.
        APPEND VALUE #( %tky               = formation-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date incorrecte'
                        ) )
                    TO reported-formation.

      ELSEIF formation-datedebut < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = formation-%tky ) TO failed-formation.
        APPEND VALUE #( %tky               = formation-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Début incorrecte'
                        ) )
                       TO reported-formation.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateFormateur.
  READ ENTITIES OF zi_formation IN LOCAL MODE
    ENTITY Formation
    FIELDS ( formateur ) WITH CORRESPONDING #( keys )
    RESULT DATA(formations).

    LOOP AT formations INTO DATA(formation).

      IF formation-formateur = ''.
        APPEND VALUE #( %tky = formation-%tky ) TO failed-formation.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Formateur incorrecte'
                    ) )
                    TO reported-formation.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateSujet.
  READ ENTITIES OF zi_formation IN LOCAL MODE
    ENTITY Formation
    FIELDS ( sujet ) WITH CORRESPONDING #( keys )
    RESULT DATA(formations).

    LOOP AT formations INTO DATA(formation).

      IF formation-sujet = ''.
        APPEND VALUE #( %tky = formation-%tky ) TO failed-formation.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Sujet incorrecte'
                    ) )
                    TO reported-formation.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR DemandeEmploi RESULT result.
    METHODS calculstudent_id FOR DETERMINE ON MODIFY
      IMPORTING keys FOR DemandeEmploi~calculstudent_id.
                METHODS validateDateDispo FOR VALIDATE ON SAVE
            IMPORTING keys FOR DemandeEmploi~validateDateDispo.

          METHODS validateExperience FOR VALIDATE ON SAVE
            IMPORTING keys FOR DemandeEmploi~validateExperience.

          METHODS validatePostesouhaite FOR VALIDATE ON SAVE
            IMPORTING keys FOR DemandeEmploi~validatePostesouhaite.

          METHODS validateSpecialisation FOR VALIDATE ON SAVE
            IMPORTING keys FOR DemandeEmploi~validateSpecialisation.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD calculstudent_id.
 READ ENTITIES OF zi_studentt  IN LOCAL MODE
      ENTITY DemandeEmploi
        FIELDS ( id ) WITH CORRESPONDING #( keys )
      RESULT DATA(demandesemplois).

    " remove lines where CongeID is already filled.
    DELETE demandesemplois WHERE id IS NOT INITIAL.

    " anything left ?
    CHECK demandesemplois IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zi_studentt
        FIELDS MAX( id )
        INTO @DATA(max_id).

    " Set the travel ID
    MODIFY ENTITIES OF zi_studentt IN LOCAL MODE
    ENTITY DemandeEmploi
      UPDATE
        FROM VALUE #( FOR demandeemploi IN demandesemplois INDEX INTO i (
          %tky              = demandeemploi-%tky
          id         = max_id + i
          %control-id = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.
    METHOD validateDateDispo.
     READ ENTITIES OF zi_studentt IN LOCAL MODE
    ENTITY DemandeEmploi
    FIELDS ( Experience ) WITH CORRESPONDING #( keys )
    RESULT DATA(demandesemplois).

    LOOP AT demandesemplois INTO DATA(demandeemploi).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = demandeemploi-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-DemandeEmploi.

      IF demandeemploi-Disponibilite < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = demandeemploi-%tky ) TO failed-DemandeEmploi.
        APPEND VALUE #( %tky               = demandeemploi-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Disponibilite incorrecte'
                        ) )
                       TO reported-DemandeEmploi.

       ELSEIF demandeemploi-Disponibilite  = cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = demandeemploi-%tky ) TO failed-DemandeEmploi.
        APPEND VALUE #( %tky               = demandeemploi-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Disponibilite incorrecte'
                        ) )
                       TO reported-DemandeEmploi.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateExperience.
    READ ENTITIES OF zi_studentt IN LOCAL MODE
    ENTITY DemandeEmploi
    FIELDS ( Experience ) WITH CORRESPONDING #( keys )
    RESULT DATA(demandesemplois).

    LOOP AT demandesemplois INTO DATA(demandeemploi).

      IF demandeemploi-Experience = ''.
        APPEND VALUE #( %tky = demandeemploi-%tky ) TO failed-DemandeEmploi.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Experience incorrecte'
                    ) )
                    TO reported-DemandeEmploi.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validatePostesouhaite.
      READ ENTITIES OF zi_studentt IN LOCAL MODE
    ENTITY DemandeEmploi
    FIELDS ( Postesouhaite ) WITH CORRESPONDING #( keys )
    RESULT DATA(demandesemplois).

    LOOP AT demandesemplois INTO DATA(demandeemploi).

      IF demandeemploi-Postesouhaite = ''.
        APPEND VALUE #( %tky = demandeemploi-%tky ) TO failed-DemandeEmploi.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Poste souhaite incorrecte'
                    ) )
                    TO reported-DemandeEmploi.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateSpecialisation.
    READ ENTITIES OF zi_studentt IN LOCAL MODE
    ENTITY DemandeEmploi
    FIELDS ( Specialisation ) WITH CORRESPONDING #( keys )
    RESULT DATA(demandesemplois).

    LOOP AT demandesemplois INTO DATA(demandeemploi).

      IF demandeemploi-Specialisation = ''.
        APPEND VALUE #( %tky = demandeemploi-%tky ) TO failed-DemandeEmploi.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Specialisation incorrecte'
                    ) )
                    TO reported-DemandeEmploi.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

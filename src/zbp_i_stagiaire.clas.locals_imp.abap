CLASS lhc_stagiaire DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stagiaire~validateDates.
    METHODS validateDuree FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stagiaire~validateDuree.
    METHODS validateCv FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stagiaire~validateCv.
    METHODS validateEcole FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stagiaire~validateEcole.
    METHODS validateDepartement FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stagiaire~validateDepartement.

ENDCLASS.

CLASS lhc_stagiaire IMPLEMENTATION.

  METHOD validateDates.
  DATA: lv_valid_flag TYPE abap_bool.
  " Read relevant conge instance data
    READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
      ENTITY stagiaire
        FIELDS ( datedebut datefin ) WITH CORRESPONDING #( keys )
      RESULT DATA(stagiaires).

    LOOP AT stagiaires INTO DATA(stagiaire).

      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = stagiaire-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-stagiaire.

* Initialize the flag
    lv_valid_flag = abap_true.

* Check if the date naissance is blank
    IF stagiaire-datedebut IS INITIAL OR stagiaire-datedebut CO '0000-00-00' AND stagiaire-datefin IS INITIAL OR stagiaire-datefin CO '0000-00-00'.
      lv_valid_flag = abap_false.
    ENDIF.

* Add the user to failed-user_s with appropriate message if the date is incorrect
    IF lv_valid_flag = abap_false.
      APPEND VALUE #( %tky = stagiaire-%tky ) TO failed-stagiaire.
      APPEND VALUE #( %tky               = keys[ 1 ]-%tky
                      "%state_area        = 'VALIDATE_DATES'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Date Début et fin incorrecte'
                      ) )
                     TO reported-stagiaire.


      ELSEIF stagiaire-datedebut > cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = stagiaire-%tky ) TO failed-stagiaire.
        APPEND VALUE #( %tky               = stagiaire-%tky
                        "%state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Début incorrecte'
                        ) )
                       TO reported-stagiaire.



      ELSEIF stagiaire-datefin < stagiaire-datedebut.
        APPEND VALUE #( %tky = stagiaire-%tky ) TO failed-stagiaire.
        APPEND VALUE #( %tky               = stagiaire-%tky
                        "%state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date incorrecte'
                        ) )
                    TO reported-stagiaire.

      ELSEIF stagiaire-datefin < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = stagiaire-%tky ) TO failed-stagiaire.
        APPEND VALUE #( %tky               = stagiaire-%tky
                        "%state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date fin incorrecte'
                        ) )
                       TO reported-stagiaire.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDuree.
  READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
    ENTITY stagiaire
    FIELDS ( duree ) WITH CORRESPONDING #( keys )
    RESULT DATA(stagiaires).

    LOOP AT stagiaires INTO DATA(stagiaire).

      IF stagiaire-duree = ''.
        APPEND VALUE #( %tky = stagiaire-%tky ) TO failed-stagiaire.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Durée incorrecte'
                    ) )
                    TO reported-stagiaire.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateCv.
  READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY stagiaire
    FIELDS ( cv ) WITH CORRESPONDING #( keys )
    RESULT DATA(stagiaires).

    LOOP AT stagiaires INTO DATA(stagiaire).

      IF stagiaire-cv = ''.
        APPEND VALUE #( %tky = stagiaire-%tky ) TO failed-stagiaire.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'CV incorrecte'
                    ) )
                    TO reported-stagiaire.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateEcole.
  READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Stagiaire
    FIELDS ( ecole ) WITH CORRESPONDING #( keys )
    RESULT DATA(stagiaires).

    LOOP AT stagiaires INTO DATA(stagiaire).

      IF stagiaire-ecole = ''.
        APPEND VALUE #( %tky = stagiaire-%tky ) TO failed-stagiaire.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Ecole incorrecte'
                    ) )
                    TO reported-stagiaire.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

     METHOD validateDepartement.
READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Stagiaire
    FIELDS ( departement ) WITH CORRESPONDING #( keys )
    RESULT DATA(stagiaires).

  DATA: lt_valid_values TYPE TABLE OF zpfe_departement,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( departement = 'RPA' ) ( departement = 'Opencell' ) ( departement = 'SAP' ) ).

  LOOP AT stagiaires INTO DATA(stagiaire).

    lv_entered_value = stagiaire-departement.  " Get the value to validate

    " Initialize the flag
    lv_valid_flag = abap_false.

    " Check if the entered value is in the list of valid values
    LOOP AT lt_valid_values INTO DATA(lv_valid_value).

       IF lv_entered_value = lv_valid_value .
        lv_valid_flag = abap_true.  " Set flag to true if entered value matches any valid value
        EXIT.  " Exit loop if a match is found
      ENDIF.
    ENDLOOP.

    " If the entered value is not valid, add it to failed-conge and reported-conge
    IF lv_valid_flag = abap_false.
      APPEND VALUE #( %tky = stagiaire-%tky ) TO failed-stagiaire.
      APPEND VALUE #( %tky               = stagiaire-%tky
                      "%state_area        = 'VALIDATE_DEPARTEMENT'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Departement incorrecte'
                      ) )
                     TO reported-stagiaire.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_admin DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateCv FOR VALIDATE ON SAVE
      IMPORTING keys FOR Admin~validateCv.

    METHODS validateDateDebut FOR VALIDATE ON SAVE
      IMPORTING keys FOR Admin~validateDateDebut.
    METHODS validatePoste FOR VALIDATE ON SAVE
      IMPORTING keys FOR Admin~validatePoste.

ENDCLASS.

CLASS lhc_admin IMPLEMENTATION.

  METHOD validateCv.
      READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Admin
    FIELDS ( cv ) WITH CORRESPONDING #( keys )
    RESULT DATA(admins).

    LOOP AT admins INTO DATA(admin).

      IF admin-cv = ''.
        APPEND VALUE #( %tky = admin-%tky ) TO failed-admin.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'CV incorrecte'
                    ) )
                    TO reported-admin.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDateDebut.
  DATA: lv_valid_flag TYPE abap_bool.

    READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
      ENTITY Admin
        FIELDS ( datedebut ) WITH CORRESPONDING #( keys )
      RESULT DATA(admins).

    LOOP AT admins INTO DATA(admin).

          APPEND VALUE #(  %tky        = admin-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-admin.

* Initialize the flag
    lv_valid_flag = abap_true.

* Check if the date naissance is blank
    IF admin-datedebut IS INITIAL OR admin-datedebut CO '0000-00-00'.
      lv_valid_flag = abap_false.
    ENDIF.

* Add the user to failed-user_s with appropriate message if the date is incorrect
    IF lv_valid_flag = abap_false.
      APPEND VALUE #( %tky = admin-%tky ) TO failed-admin.
      APPEND VALUE #( %tky               = keys[ 1 ]-%tky
                      "%state_area        = 'VALIDATE_DATES'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Date Début incorrecte'
                      ) )
                     TO reported-admin.


      ELSEIF admin-datedebut > cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = admin-%tky ) TO failed-admin.
        APPEND VALUE #( %tky               = admin-%tky
                        "%state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Début incorrecte'
                        ) )
                       TO reported-admin.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validatePoste.
  READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Admin
    FIELDS ( poste ) WITH CORRESPONDING #( keys )
    RESULT DATA(admins).

    DATA: lt_valid_values TYPE TABLE OF zpfe_poste,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( poste = 'Gérant' ) ( poste = 'Manager' ) ( poste = 'Chef de projet SI' ) ( poste = 'Responsable Ressources humaines' )
  ( poste = 'Responsable Sécurité SI' ) ( poste = 'Responsable Formation' ) ( poste = 'Responsable Management Qualité' ) ).

  LOOP AT admins INTO DATA(admin).

    lv_entered_value = admin-poste.  " Get the value to validate

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
      APPEND VALUE #( %tky = admin-%tky ) TO failed-admin.
      APPEND VALUE #( %tky               = admin-%tky
                      "%state_area        = 'VALIDATE_DEPARTEMENT'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Poste incorrecte'
                      ) )
                     TO reported-admin.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

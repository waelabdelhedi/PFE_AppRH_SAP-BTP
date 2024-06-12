CLASS lhc_consultant DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateCv FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateCv.

    METHODS validateDateDebut FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateDateDebut.

    METHODS validateDepartement FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateDepartement.

    METHODS validateMission FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateMission.

    METHODS validateNiveau FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateNiveau.

    METHODS validatePoste FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validatePoste.

ENDCLASS.

CLASS lhc_consultant IMPLEMENTATION.

  METHOD validateCv.
  READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( cv ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

    LOOP AT consultants INTO DATA(consultant).

      IF consultant-cv = ''.
        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'CV incorrecte'
                    ) )
                    TO reported-consultant.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDateDebut.
  READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
      ENTITY Consultant
        FIELDS ( datedebut ) WITH CORRESPONDING #( keys )
      RESULT DATA(consultants).

    LOOP AT consultants INTO DATA(consultant).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = consultant-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-consultant.

         IF consultant-datedebut IS INITIAL.
        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Date Début incorrecte : Date est vide'
                    ) )
                    TO reported-consultant.
ENDIF.
      IF consultant-datedebut > cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = consultant-%tky ) TO failed-consultant.
        APPEND VALUE #( %tky               = consultant-%tky
                        "%state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Début incorrecte'
                        ) )
                       TO reported-consultant.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDepartement.
   READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( departement ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

  DATA: lt_valid_values TYPE TABLE OF zpfe_departement,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( departement = 'RPA' ) ( departement = 'Opencell' ) ( departement = 'SAP' ) ).

  LOOP AT consultants INTO DATA(consultant).
    lv_entered_value = consultant-departement.  " Get the value to validate

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
      APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Departement incorrecte'
                      ) )
                     TO reported-consultant.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateMission.
*    READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
*    ENTITY Consultant
*    FIELDS ( mission ) WITH CORRESPONDING #( keys )
*    RESULT DATA(consultants).
*
*    LOOP AT consultants INTO DATA(consultant).
*
*      IF consultant-mission = ''.
*        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
*
*        APPEND VALUE #( %tky = keys[ 1 ]-%tky
*                      %msg = new_message_with_text(
*                    severity = if_abap_behv_message=>severity-error
*                    text = 'Mission incorrecte'
*                    ) )
*                    TO reported-consultant.
*
*      ENDIF.
*    ENDLOOP.
    READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( mission ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

 DATA:  lv_entered_value TYPE string.

   DATA lt_valid_values  TYPE SORTED TABLE OF ZI_MISSION WITH UNIQUE KEY titre.

lt_valid_values = CORRESPONDING #( consultants DISCARDING DUPLICATES MAPPING titre = mission EXCEPT * ).
    DELETE lt_valid_values WHERE titre IS INITIAL.



    SELECT FROM ZI_MISSION FIELDS titre
      FOR ALL ENTRIES IN @lt_valid_values
      WHERE titre = @lt_valid_values-titre
      INTO TABLE @DATA(lt_valid_values_db).

  LOOP AT consultants INTO DATA(consultant).
    lv_entered_value = consultant-mission.  " Get the value to validate

 " Check if the entered value is empty


  IF lv_entered_value IS INITIAL.
        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_MISSION'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Mission incorrecte : Mission est vide'
                      ) )
                     TO reported-consultant.
      CONTINUE.
    ENDIF.

         IF NOT line_exists( lt_valid_values_db[ titre = lv_entered_value  ] ).
      APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_MISSION'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Mission incorrecte'
                      ) )
                     TO reported-consultant.

    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateNiveau.
  READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( niveau ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

  DATA: lt_valid_values TYPE TABLE OF zpfe_niveau_cons,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( niveau = 'Junior' ) ( niveau = 'Confirmé' ) ( niveau = 'Senior' ) ).

  LOOP AT consultants INTO DATA(consultant).
    lv_entered_value = consultant-niveau.  " Get the value to validate

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
      APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Niveau incorrecte'
                      ) )
                     TO reported-consultant.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validatePoste.
  READ ENTITIES OF zi_user_stagiaire IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( poste ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

  DATA: lt_valid_values TYPE TABLE OF zpfe_poste_cons,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( poste = 'Consultant Technique' ) ( poste = 'Consultant Fonctionnel' ) ( poste = 'Consultant TechnicoFonctionnel' ) ).

  LOOP AT consultants INTO DATA(consultant).
    lv_entered_value = consultant-poste.  " Get the value to validate

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
      APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Poste incorrecte'
                      ) )
                     TO reported-consultant.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_consultant DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateEmail FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateEmail.

    METHODS validatePrenom FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validatePrenom.

    METHODS validateTauxJournalier FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateTauxJournalier.
    METHODS validateNom FOR VALIDATE ON SAVE
      IMPORTING keys FOR Consultant~validateNom.



ENDCLASS.

CLASS lhc_consultant IMPLEMENTATION.

  METHOD validateEmail.
 READ ENTITIES OF ZI_MISSION IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( email ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

 DATA:  lv_entered_value TYPE string.

   DATA lt_valid_values  TYPE SORTED TABLE OF ZI_USER_Stagiaire WITH UNIQUE KEY email.

lt_valid_values = CORRESPONDING #( consultants DISCARDING DUPLICATES MAPPING email = email EXCEPT * ).
    DELETE lt_valid_values WHERE email IS INITIAL.

    SELECT FROM ZI_USER_Stagiaire FIELDS email
      FOR ALL ENTRIES IN @lt_valid_values
      WHERE email = @lt_valid_values-email
      INTO TABLE @DATA(lt_valid_values_db).

  LOOP AT consultants INTO DATA(consultant).
    lv_entered_value = consultant-email.  " Get the value to validate

 " Check if the entered value is empty


  IF lv_entered_value IS INITIAL.
        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_EMAIL'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Email incorrecte : Email est vide'
                      ) )
                     TO reported-consultant.
      CONTINUE.
    ENDIF.

         IF NOT line_exists( lt_valid_values_db[ email = lv_entered_value  ] ).
      APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_EMAIL'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Email incorrecte'
                      ) )
                     TO reported-consultant.

    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validatePrenom.
    READ ENTITIES OF ZI_MISSION IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( prenom ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

 DATA:  lv_entered_value TYPE string.

   DATA lt_valid_values  TYPE SORTED TABLE OF ZI_USER_Stagiaire WITH UNIQUE KEY prenom.

lt_valid_values = CORRESPONDING #( consultants DISCARDING DUPLICATES MAPPING prenom = prenom EXCEPT * ).
    DELETE lt_valid_values WHERE prenom IS INITIAL.

    SELECT FROM ZI_USER_Stagiaire FIELDS prenom
      FOR ALL ENTRIES IN @lt_valid_values
      WHERE prenom = @lt_valid_values-prenom
      INTO TABLE @DATA(lt_valid_values_db).

  LOOP AT consultants INTO DATA(consultant).
    lv_entered_value = consultant-prenom.  " Get the value to validate

 " Check if the entered value is empty

  IF lv_entered_value IS INITIAL.
        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_NOM'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Prenom incorrecte : Le prenom est vide'
                      ) )
                     TO reported-consultant.
      CONTINUE.
    ENDIF.

         IF NOT line_exists( lt_valid_values_db[ prenom = lv_entered_value  ] ).
      APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_NOM'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Prenom incorrecte'
                      ) )
                     TO reported-consultant.

    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateTauxJournalier.
    READ ENTITIES OF ZI_MISSION IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( tauxjournalier ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

    LOOP AT consultants INTO DATA(consultant).

      IF consultant-tauxjournalier = ''.
        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Taux Journalier incorrecte'
                    ) )
                    TO reported-consultant.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.


  METHOD validateNom.
   READ ENTITIES OF ZI_MISSION IN LOCAL MODE
    ENTITY Consultant
    FIELDS ( nom ) WITH CORRESPONDING #( keys )
    RESULT DATA(consultants).

 DATA:  lv_entered_value TYPE string.

   DATA lt_valid_values  TYPE SORTED TABLE OF ZI_USER_Stagiaire WITH UNIQUE KEY nom.

lt_valid_values = CORRESPONDING #( consultants DISCARDING DUPLICATES MAPPING nom = nom EXCEPT * ).
    DELETE lt_valid_values WHERE nom IS INITIAL.

    SELECT FROM ZI_USER_Stagiaire FIELDS nom
      FOR ALL ENTRIES IN @lt_valid_values
      WHERE nom = @lt_valid_values-nom
      INTO TABLE @DATA(lt_valid_values_db).

  LOOP AT consultants INTO DATA(consultant).
    lv_entered_value = consultant-nom.  " Get the value to validate

 " Check if the entered value is empty

  IF lv_entered_value IS INITIAL.
        APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_NOM'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Nom incorrecte : Le nom est vide'
                      ) )
                     TO reported-consultant.
      CONTINUE.
    ENDIF.

         IF NOT line_exists( lt_valid_values_db[ nom = lv_entered_value  ] ).
      APPEND VALUE #( %tky = consultant-%tky ) TO failed-consultant.
      APPEND VALUE #( %tky               = consultant-%tky
                      "%state_area        = 'VALIDATE_NOM'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Nom incorrecte'
                      ) )
                     TO reported-consultant.

    ENDIF.
  ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

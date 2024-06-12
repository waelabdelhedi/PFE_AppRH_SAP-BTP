CLASS lhc_role DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateRoleKey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Role~CalculateRoleKey.

    METHODS validateNiveauAcces FOR VALIDATE ON SAVE
      IMPORTING keys FOR Role~validateNiveauAcces.

    METHODS validateNom FOR VALIDATE ON SAVE
      IMPORTING keys FOR Role~validateNom.

    METHODS validatePoste FOR VALIDATE ON SAVE
      IMPORTING keys FOR Role~validatePoste.

    METHODS validateRole FOR VALIDATE ON SAVE
      IMPORTING keys FOR Role~validateRole.

ENDCLASS.

CLASS lhc_role IMPLEMENTATION.

  METHOD CalculateRoleKey.
  READ ENTITIES OF ZI_ROLE IN LOCAL MODE
      ENTITY Role
        FIELDS ( roleid ) WITH CORRESPONDING #( keys )
      RESULT DATA(roles).


    DELETE roles WHERE roleid IS NOT INITIAL.


    CHECK roles IS NOT INITIAL.


    SELECT SINGLE
        FROM zpfe_role
        FIELDS MAX( roleid )
        INTO @DATA(max_roleid).


    MODIFY ENTITIES OF ZI_ROLE IN LOCAL MODE
    ENTITY Role
      UPDATE
        FROM VALUE #( FOR role IN roles INDEX INTO i (
          %tky              = role-%tky
          roleid         = max_roleid + i
          %control-roleid = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateNiveauAcces.
   READ ENTITIES OF ZI_ROLE IN LOCAL MODE
      ENTITY Role
        FIELDS ( niveauacces ) WITH CORRESPONDING #( keys )
      RESULT DATA(roles).

  DATA: lt_valid_values TYPE TABLE OF zpfe_niveauacces,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( niveauacces = 'Général ' ) ( niveauacces = 'De base (Accès limité)' ) ( niveauacces = 'Aucun accès' ) ).

  LOOP AT roles INTO DATA(role).
    lv_entered_value = role-niveauacces.  " Get the value to validate

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
      APPEND VALUE #( %tky = role-%tky ) TO failed-role.
      APPEND VALUE #( %tky               = role-%tky
                      %state_area        = 'VALIDATE_NIVEAUACCES'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Niveau Acces incorrecte'
                      ) )
                     TO reported-role.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateNom.
    READ ENTITIES OF ZI_ROLE IN LOCAL MODE
      ENTITY Role
        FIELDS ( nom ) WITH CORRESPONDING #( keys )
      RESULT DATA(roles).

 DATA:  lv_entered_value TYPE string.

   DATA lt_valid_values  TYPE SORTED TABLE OF ZI_USER_Stagiaire WITH UNIQUE KEY nom.

lt_valid_values = CORRESPONDING #( roles DISCARDING DUPLICATES MAPPING nom = nom EXCEPT * ).
    DELETE lt_valid_values WHERE nom IS INITIAL.

    SELECT FROM ZI_USER_Stagiaire FIELDS nom
      FOR ALL ENTRIES IN @lt_valid_values
      WHERE nom = @lt_valid_values-nom
      INTO TABLE @DATA(lt_valid_values_db).

  LOOP AT roles INTO DATA(role).
    lv_entered_value = role-nom.  " Get the value to validate

 " Check if the entered value is empty


  IF lv_entered_value IS INITIAL.
        APPEND VALUE #( %tky = role-%tky ) TO failed-role.
      APPEND VALUE #( %tky               = role-%tky
                      "%state_area        = 'VALIDATE_NOM'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Nom incorrecte : Le nom est vide'
                      ) )
                     TO reported-role.
      CONTINUE.
    ENDIF.

         IF NOT line_exists( lt_valid_values_db[ nom = lv_entered_value  ] ).
      APPEND VALUE #( %tky = role-%tky ) TO failed-role.
      APPEND VALUE #( %tky               = role-%tky
                      "%state_area        = 'VALIDATE_NOM'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Nom incorrecte'
                      ) )
                     TO reported-role.

    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateRole.
   READ ENTITIES OF ZI_ROLE IN LOCAL MODE
      ENTITY Role
        FIELDS ( nomrole ) WITH CORRESPONDING #( keys )
      RESULT DATA(roles).

  DATA: lt_valid_values TYPE TABLE OF zpfe_nomrole,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( nomrole = 'Administrateur' ) ( nomrole = 'Utilisateur standard' ) ).

  LOOP AT roles INTO DATA(role).
    lv_entered_value = role-nomrole.  " Get the value to validate

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
      APPEND VALUE #( %tky = role-%tky ) TO failed-role.
      APPEND VALUE #( %tky               = role-%tky
                      %state_area        = 'VALIDATE_ROLE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Role incorrecte'
                      ) )
                     TO reported-role.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validatePoste.
     READ ENTITIES OF ZI_ROLE IN LOCAL MODE
      ENTITY Role
        FIELDS ( poste ) WITH CORRESPONDING #( keys )
      RESULT DATA(roles).

  DATA: lt_valid_values TYPE TABLE OF zpfe_posterole,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #(       ( posterole = 'Consultant Technique' )
      ( posterole = 'Consultant Fonctionnel' )
      ( posterole = 'Consultant TechnicoFonctionnel' )
      ( posterole = 'Gérant' )
      ( posterole = 'Manager' )
      ( posterole = 'Chef de projet SI' )
      ( posterole = 'Responsable Ressources humaines' )
      ( posterole = 'Responsable Sécurité SI' )
      ( posterole = 'Responsable Formation' )
      ( posterole = 'Responsable Management Qualité' )
      ( posterole = 'Stagiaire' ) ).

  LOOP AT roles INTO DATA(role).
    lv_entered_value = role-poste.  " Get the value to validate

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
      APPEND VALUE #( %tky = role-%tky ) TO failed-role.
      APPEND VALUE #( %tky               = role-%tky
                      %state_area        = 'VALIDATE_POSTE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Poste incorrecte'
                      ) )
                     TO reported-role.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

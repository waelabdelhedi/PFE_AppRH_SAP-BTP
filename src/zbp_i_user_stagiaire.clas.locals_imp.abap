CLASS lhc_User_S DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR User_S RESULT result.
    METHODS validateadresse FOR VALIDATE ON SAVE
      IMPORTING keys FOR user_s~validateadresse.

    METHODS validateemail FOR VALIDATE ON SAVE
      IMPORTING keys FOR user_s~validateemail.

    METHODS validatenom FOR VALIDATE ON SAVE
      IMPORTING keys FOR user_s~validatenom.

    METHODS validateprenom FOR VALIDATE ON SAVE
      IMPORTING keys FOR user_s~validateprenom.

    METHODS validatetelephone FOR VALIDATE ON SAVE
      IMPORTING keys FOR user_s~validatetelephone.
    METHODS validatedatenaissance FOR VALIDATE ON SAVE
      IMPORTING keys FOR user_s~validatedatenaissance.
    METHODS calculateuserkey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR user_s~calculateuserkey.

ENDCLASS.

CLASS lhc_User_S IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD validateAdresse.
          READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
    ENTITY user_s
    FIELDS ( adresse ) WITH CORRESPONDING #( keys )
    RESULT DATA(user_ss).

    LOOP AT user_ss INTO DATA(user).

      IF user-adresse = ''.
        APPEND VALUE #( %tky = user-%tky ) TO failed-user_s.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Adresse incorrecte'
                    ) )
                    TO reported-user_s.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateEmail.
      DATA: lv_entered_email TYPE string,
        "lv_regex TYPE string VALUE '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
        lv_valid_flag TYPE abap_bool.

  " Initialize the flag
  lv_valid_flag = abap_false.

  " Read entities and loop through consultant entities
    READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
    ENTITY user_s
    FIELDS ( email ) WITH CORRESPONDING #( keys )
    RESULT DATA(user_ss).

  LOOP AT user_ss INTO DATA(user).
    lv_entered_email = user-email.  " Get the Email to validate
    " Validate the Email using regular expression
    FIND REGEX '^\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b' IN lv_entered_email MATCH COUNT lv_valid_flag.


    " If the E-mail format is not valid, add it to failed-consultant and reported-consultant
    IF lv_valid_flag = 0.
      APPEND VALUE #( %tky = user-%tky ) TO failed-user_s.
      APPEND VALUE #( %tky               = user-%tky
                      %state_area        = 'VALIDATE_EMAIL'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Invalid email address'
                      ) )
                     TO reported-user_s.

  ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateNom.
  READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
    ENTITY user_s
    FIELDS ( nom ) WITH CORRESPONDING #( keys )
    RESULT DATA(user_ss).

    LOOP AT user_ss INTO DATA(user).

      IF user-nom = ''.
        APPEND VALUE #( %tky = user-%tky ) TO failed-user_s.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Nom incorrecte'
                    ) )
                    TO reported-user_s.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validatePrenom.
  READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
    ENTITY user_s
    FIELDS ( prenom ) WITH CORRESPONDING #( keys )
    RESULT DATA(user_ss).

    LOOP AT user_ss INTO DATA(user).

      IF user-prenom = ''.
        APPEND VALUE #( %tky = user-%tky ) TO failed-user_s.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Prenom incorrecte'
                    ) )
                    TO reported-user_s.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateTelephone.
            READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
    ENTITY user_s
    FIELDS ( telephone ) WITH CORRESPONDING #( keys )
    RESULT DATA(user_ss).

    LOOP AT user_ss INTO DATA(user).

      IF user-telephone = ''.
        APPEND VALUE #( %tky = user-%tky ) TO failed-user_s.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Numéro telephone incorrecte'
                    ) )
                    TO reported-user_s.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDateNaissance.

    DATA: lv_valid_flag TYPE abap_bool.

    READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
      ENTITY user_s
        FIELDS ( datenaissance ) WITH CORRESPONDING #( keys )
      RESULT DATA(user_ss).

    LOOP AT user_ss INTO DATA(user).

* Initialize the flag
    lv_valid_flag = abap_true.

* Check if the date naissance is blank
    IF user-datenaissance IS INITIAL OR user-datenaissance CO '0000-00-00'.
      lv_valid_flag = abap_false.
    ENDIF.

* Add the user to failed-user_s with appropriate message if the date is incorrect
    IF lv_valid_flag = abap_false.
      APPEND VALUE #( %tky = user-%tky ) TO failed-user_s.
      APPEND VALUE #( %tky               = keys[ 1 ]-%tky
                      %state_area        = 'VALIDATE_DATES'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Date Naissance incorrecte'
                      ) )
                     TO reported-user_s.


      ELSEIF user-datenaissance > cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = user-%tky ) TO failed-user_s.
        APPEND VALUE #( %tky               = user-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Naissance incorrecte'
                        ) )
                       TO reported-user_s.
     ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD CalculateUserKey.
   READ ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
      ENTITY User_S
        FIELDS ( userid ) WITH CORRESPONDING #( keys )
      RESULT DATA(users).

    " remove lines where CongeID is already filled.
    DELETE users WHERE userid IS NOT INITIAL.

    " anything left ?
    CHECK users IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  ZI_USER_Stagiaire
        FIELDS MAX( userid )
        INTO @DATA(max_userid).

    " Set the travel ID
    MODIFY ENTITIES OF ZI_USER_Stagiaire IN LOCAL MODE
    ENTITY User_S
      UPDATE
        FROM VALUE #( FOR user IN users INDEX INTO i (
          %tky              = user-%tky
          userid         = max_userid + i
          %control-userid = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

ENDCLASS.

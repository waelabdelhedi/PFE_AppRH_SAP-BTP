CLASS lhc_zi_certif_form DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateCertifKey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_CERTIF_FORM~CalculateCertifKey.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_CERTIF_FORM~validateDates.

    METHODS validateDescription FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_CERTIF_FORM~validateDescription.

    METHODS validateliencertificat FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_CERTIF_FORM~validateliencertificat.

    METHODS validateNom FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_CERTIF_FORM~validateNom.

    METHODS validateOrganisme FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_CERTIF_FORM~validateOrganisme.

ENDCLASS.

CLASS lhc_zi_certif_form IMPLEMENTATION.

METHOD CalculateCertifKey.
  READ ENTITIES OF zi_certif_form IN LOCAL MODE
      ENTITY zi_certif_form
        FIELDS ( certifid ) WITH CORRESPONDING #( keys )
      RESULT DATA(certifs).

    " remove lines where CongeID is already filled.
    DELETE certifs WHERE certifid IS NOT INITIAL.

    " anything left ?
    CHECK certifs IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zpfe_certif
        FIELDS MAX( certifid )
        INTO @DATA(max_certifid).

    " Set the travel ID
    MODIFY ENTITIES OF zi_certif_form IN LOCAL MODE
    ENTITY zi_certif_form
      UPDATE
        FROM VALUE #( FOR certif IN certifs INDEX INTO i (
          %tky              = certif-%tky
          certifid         = max_certifid + i
          %control-certifid = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateDates.
   READ ENTITIES OF zi_certif_form IN LOCAL MODE
      ENTITY zi_certif_form
        FIELDS ( certifid dateobtention dateexpiration ) WITH CORRESPONDING #( keys )
      RESULT DATA(certifs).

    LOOP AT certifs INTO DATA(certif).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = certif-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-zi_certif_form.

      IF certif-dateexpiration < certif-dateobtention.
        APPEND VALUE #( %tky = certif-%tky ) TO failed-zi_certif_form.
        APPEND VALUE #( %tky               = certif-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date incorrecte'
                        ) )
                    TO reported-zi_certif_form.

      ELSEIF certif-dateobtention < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = certif-%tky ) TO failed-zi_certif_form.
        APPEND VALUE #( %tky               = certif-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Obtention incorrecte'
                        ) )
                       TO reported-zi_certif_form.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDescription.
  READ ENTITIES OF zi_certif_form IN LOCAL MODE
    ENTITY zi_certif_form
    FIELDS ( description ) WITH CORRESPONDING #( keys )
    RESULT DATA(certifs).

    LOOP AT certifs INTO DATA(certif).

      IF certif-description = ''.
        APPEND VALUE #( %tky = certif-%tky ) TO failed-zi_certif_form.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Description incorrecte'
                    ) )
                    TO reported-zi_certif_form.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateliencertificat.
  DATA: lv_entered_url TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Initialize the flag
  lv_valid_flag = abap_false.

  " Read entities and loop through certif entities
    READ ENTITIES OF zi_certif_form IN LOCAL MODE
    ENTITY zi_certif_form
    FIELDS ( liencertificat ) WITH CORRESPONDING #( keys )
    RESULT DATA(certifs).

  LOOP AT certifs INTO DATA(certif).
    lv_entered_url = certif-liencertificat.  " Get the URL to validate

    " Validate the URL using regular expression
    FIND REGEX '^https?://.*$' IN lv_entered_url MATCH COUNT lv_valid_flag.

    " If the URL format is not valid, add it to failed-certif and reported-conge
    IF lv_valid_flag = 0.
      APPEND VALUE #( %tky = certif-%tky ) TO failed-zi_certif_form.
      APPEND VALUE #( %tky               = certif-%tky
                      %state_area        = 'VALIDATE_URL'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Invalid URL link. Please enter a valid URL link.'
                      ) )
                     TO reported-zi_certif_form.

    ENDIF.
  ENDLOOP.
  ENDMETHOD.

  METHOD validateNom.
  READ ENTITIES OF zi_certif_form IN LOCAL MODE
    ENTITY zi_certif_form
    FIELDS ( nom ) WITH CORRESPONDING #( keys )
    RESULT DATA(certifs).

    LOOP AT certifs INTO DATA(certif).

      IF certif-nom = ''.
        APPEND VALUE #( %tky = certif-%tky ) TO failed-zi_certif_form.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Nom certificat incorrecte'
                    ) )
                    TO reported-zi_certif_form.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateorganisme.
      READ ENTITIES OF zi_certif_form IN LOCAL MODE
    ENTITY zi_certif_form
    FIELDS ( organisme ) WITH CORRESPONDING #( keys )
    RESULT DATA(certifs).

    LOOP AT certifs INTO DATA(certif).

      IF certif-organisme = ''.
        APPEND VALUE #( %tky = certif-%tky ) TO failed-zi_certif_form.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Organisme incorrecte'
                    ) )
                    TO reported-zi_certif_form.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

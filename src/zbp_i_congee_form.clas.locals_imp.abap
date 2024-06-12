CLASS lhc_zi_congee_form DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateCongeKey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_CONGEE_FORM~CalculateCongeKey.

    METHODS validateDates FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_CONGEE_FORM~validateDates.

    METHODS validateType FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_CONGEE_FORM~validateType.

ENDCLASS.

CLASS lhc_zi_congee_form IMPLEMENTATION.

METHOD CalculateCongeKey.
  READ ENTITIES OF zi_congee_form IN LOCAL MODE
      ENTITY zi_congee_form
        FIELDS ( congeid ) WITH CORRESPONDING #( keys )
      RESULT DATA(conges).


    DELETE conges WHERE congeid IS NOT INITIAL.


    CHECK conges IS NOT INITIAL.


    SELECT SINGLE
        FROM  zpfe_congee
        FIELDS MAX( congeid )
        INTO @DATA(max_congeid).


    MODIFY ENTITIES OF zi_congee_form IN LOCAL MODE
    ENTITY zi_congee_form
      UPDATE
        FROM VALUE #( FOR conge IN conges INDEX INTO i (
          %tky              = conge-%tky
          congeid         = max_congeid + i
          %control-congeid = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateDates.
    " Read relevant conge instance data
    READ ENTITIES OF zi_congee_form IN LOCAL MODE
      ENTITY zi_congee_form
        FIELDS ( congeid datedebut datefin ) WITH CORRESPONDING #( keys )
      RESULT DATA(conges).

    LOOP AT conges INTO DATA(conge).
      " Clear state messages that might exist
      APPEND VALUE #(  %tky        = conge-%tky
                       %state_area = 'VALIDATE_DATES' )
        TO reported-zi_congee_form.

      IF conge-datefin < conge-datedebut.
        APPEND VALUE #( %tky = conge-%tky ) TO failed-zi_congee_form.
        APPEND VALUE #( %tky               = conge-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date incorrecte'
                        ) )
                    TO reported-zi_congee_form.

      ELSEIF conge-datedebut < cl_abap_context_info=>get_system_date( ).
        APPEND VALUE #( %tky               = conge-%tky ) TO failed-zi_congee_form.
        APPEND VALUE #( %tky               = conge-%tky
                        %state_area        = 'VALIDATE_DATES'
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = 'Date Début incorrecte'
                        ) )
                       TO reported-zi_congee_form.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateType.
  READ ENTITIES OF zi_congee_form IN LOCAL MODE
    ENTITY zi_congee_form
    FIELDS ( type ) WITH CORRESPONDING #( keys )
    RESULT DATA(conges).

  DATA: lt_valid_values TYPE TABLE OF ZPFE_TYPECONGE,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( type = 'Maladie' ) ( type = 'Payé' ) ).

  LOOP AT conges INTO DATA(conge).
    lv_entered_value = conge-type.  " Get the value to validate

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
      APPEND VALUE #( %tky = conge-%tky ) TO failed-zi_congee_form.
      APPEND VALUE #( %tky               = conge-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Type incorrecte'
                      ) )
                     TO reported-zi_congee_form.
    ENDIF.
  ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

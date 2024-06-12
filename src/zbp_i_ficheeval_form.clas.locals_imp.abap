CLASS lhc_zi_ficheeval_form DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS CalculateFicheEvaluationKey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZI_FicheEval_Form~CalculateFicheEvaluationKey.

    METHODS validateAmeliorationPersoEtPro FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateAmeliorationPersoEtPro.

    METHODS validateClarteDuCours FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateClarteDuCours.

    METHODS validateContenu FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateContenu.

    METHODS validateDisponibilite FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateDisponibilite.

    METHODS validateDuree FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateDuree.

    METHODS validateLogistique FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateLogistique.

    METHODS validateMaitriseDuSujet FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateMaitriseDuSujet.

    METHODS validateMethodePedagogique FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateMethodePedagogique.

    METHODS validateRapport FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateRapport.

    METHODS validateRythme FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateRythme.

    METHODS validateSujetFormation FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateSujetFormation.

    METHODS validateSupportPedagogique FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateSupportPedagogique.

    METHODS validateUtilite FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZI_FicheEval_Form~validateUtilite.

ENDCLASS.

CLASS lhc_zi_ficheeval_form IMPLEMENTATION.

   METHOD CalculateFicheEvaluationKey.
  READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY ZI_FicheEval_Form
    FIELDS ( ficheevaluationid ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

    " remove lines where CongeID is already filled.
    DELETE fichesevaluations WHERE FicheEvaluationId IS NOT INITIAL.

    " anything left ?
    CHECK fichesevaluations IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zpfe_evaluation
        FIELDS MAX( ficheevaluationid )
        INTO @DATA(max_ficheevaluationid).

    " Set the travel ID
    MODIFY ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
      UPDATE
        FROM VALUE #( FOR ficheevaluation IN fichesevaluations INDEX INTO i (
          %tky              = ficheevaluation-%tky
          FicheEvaluationId         = max_ficheevaluationid + i
          %control-FicheEvaluationId = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

  METHOD validateAmeliorationPersoEtPro.
  READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( amelioration ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-amelioration.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Amélioration personnel/professionnel incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
  ENDLOOP.

  ENDMETHOD.

  METHOD validateClarteDuCours.
    READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY ZI_FicheEval_Form
    FIELDS ( clarte_du_cours ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-clarte_du_cours.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Clarte du cours incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateContenu.
    READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( contenu ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-contenu.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Contenu conforme aux objectifs incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDisponibilite.
    READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( disponibilite ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-disponibilite.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Disponibilite incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateDuree.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( duree ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-Duree.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Duree incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateLogistique.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( logistique ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-Logistique.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Logistique incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateMaitriseDuSujet.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( maitrise_du_sujet ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-maitrise_du_sujet.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Maitrise du sujet incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateMethodePedagogique.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( methode_pedagogique ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-methode_pedagogique.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Methode pedagogique incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateRapport.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( rapport_theorie_pratique ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-rapport_theorie_pratique.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Rapport theorie et pratique incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateRythme.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( rythme ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-rythme.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Rythme incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateSujetFormation.

READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY ZI_FicheEval_Form
    FIELDS ( sujetformation ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

 DATA:  lv_entered_value TYPE string.

   DATA lt_valid_values  TYPE SORTED TABLE OF ZI_FORMATION WITH UNIQUE KEY Sujet.

lt_valid_values = CORRESPONDING #( fichesevaluations DISCARDING DUPLICATES MAPPING sujet = sujetformation EXCEPT * ).
    DELETE lt_valid_values WHERE sujet IS INITIAL.



    SELECT FROM ZI_FORMATION FIELDS Sujet
      FOR ALL ENTRIES IN @lt_valid_values
      WHERE sujet = @lt_valid_values-sujet
      INTO TABLE @DATA(lt_valid_values_db).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-sujetformation.  " Get the value to validate

 " Check if the entered value is empty


  IF lv_entered_value IS INITIAL.
        APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_SUJET'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Sujet Formation incorrecte : Le sujet est vide'
                      ) )
                     TO reported-zi_ficheeval_form.
      CONTINUE.
    ENDIF.

         IF NOT line_exists( lt_valid_values_db[ sujet = lv_entered_value  ] ).
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_SUJET'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Sujet Formation incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.

    ENDIF.
  ENDLOOP.
ENDMETHOD.

  METHOD validateSupportPedagogique.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( support_pedagogique ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-support_pedagogique.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Support pedagogique incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateUtilite.
      READ ENTITIES OF zi_ficheeval_form IN LOCAL MODE
    ENTITY zi_ficheeval_form
    FIELDS ( utilite_en_travail ) WITH CORRESPONDING #( keys )
    RESULT DATA(fichesevaluations).

  DATA: lt_valid_values TYPE TABLE OF zpfe_echnotation,
        lv_entered_value TYPE string,
        lv_valid_flag TYPE abap_bool.

  " Define valid values
  lt_valid_values = VALUE #( ( echellenotation = '1 : Très insatisfaisant' ) ( echellenotation = '2 : Insatisfaisant' ) ( echellenotation = '3 : Satisfaisant' ) ( echellenotation = '4 : Bien' ) ( echellenotation = '5 : Excellent' ) ).

  LOOP AT fichesevaluations INTO DATA(ficheevaluation).
    lv_entered_value = ficheevaluation-utilite_en_travail.  " Get the value to validate

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
      APPEND VALUE #( %tky = ficheevaluation-%tky ) TO failed-zi_ficheeval_form.
      APPEND VALUE #( %tky               = ficheevaluation-%tky
                      %state_area        = 'VALIDATE_TYPE'
                      %msg = new_message_with_text(
                      severity = if_abap_behv_message=>severity-error
                      text = 'Utilite en situation de travail incorrecte'
                      ) )
                     TO reported-zi_ficheeval_form.
    ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

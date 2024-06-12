CLASS lhc_ZR_LT_NOTEFRAIS DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

 METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Notefrais RESULT result.



    METHODS validatemontant FOR VALIDATE ON SAVE
      IMPORTING keys FOR Notefrais~validatemontant.

    METHODS validatemotif FOR VALIDATE ON SAVE
      IMPORTING keys FOR Notefrais~validatemotif.
    METHODS calculatenotefraiskey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Notefrais~calculatenotefraiskey.

ENDCLASS.

CLASS lhc_ZR_LT_NOTEFRAIS IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.



  METHOD validateMontant.
    READ ENTITIES OF zr_lt_notefrais IN LOCAL MODE
    ENTITY Notefrais
    FIELDS ( Montant ) WITH CORRESPONDING #( keys )
    RESULT DATA(notesfrais).

    LOOP AT notesfrais INTO DATA(notefrais).

      IF notefrais-Montant = ''.
        APPEND VALUE #( %tky = notefrais-%tky ) TO failed-Notefrais.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Montant incorrecte'
                    ) )
                    TO reported-Notefrais.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD validateMotif.
  READ ENTITIES OF zr_lt_notefrais IN LOCAL MODE
    ENTITY Notefrais
    FIELDS ( Motif ) WITH CORRESPONDING #( keys )
    RESULT DATA(notesfrais).

    LOOP AT notesfrais INTO DATA(notefrais).

      IF notefrais-Motif = ''.
        APPEND VALUE #( %tky = notefrais-%tky ) TO failed-Notefrais.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Motif incorrecte'
                    ) )
                    TO reported-Notefrais.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD CalculateNoteFraisKey.
  READ ENTITIES OF zr_lt_notefrais IN LOCAL MODE
      ENTITY Notefrais
        FIELDS ( NotefraisId ) WITH CORRESPONDING #( keys )
      RESULT DATA(notesfrais).

    " remove lines where CongeID is already filled.
    DELETE notesfrais WHERE NotefraisId IS NOT INITIAL.

    " anything left ?
    CHECK notesfrais IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zpfe_nfrais
        FIELDS MAX( NotefraisId )
        INTO @DATA(max_NotefraisId).

    " Set the travel ID
    MODIFY ENTITIES OF zr_lt_notefrais IN LOCAL MODE
    ENTITY Notefrais
      UPDATE
        FROM VALUE #( FOR notefrais IN notesfrais INDEX INTO i (
          %tky              = notefrais-%tky
          NotefraisId         = max_NotefraisId + i
          %control-NotefraisId = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

ENDCLASS.

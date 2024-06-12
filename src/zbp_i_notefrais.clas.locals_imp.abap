CLASS lhc_Notefrais DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Notefrais RESULT result.
    METHODS calculatenotefraiskey FOR DETERMINE ON MODIFY
      IMPORTING keys FOR notefrais~calculatenotefraiskey.

    METHODS validatemontant FOR VALIDATE ON SAVE
      IMPORTING keys FOR notefrais~validatemontant.

    METHODS validatemotif FOR VALIDATE ON SAVE
      IMPORTING keys FOR notefrais~validatemotif.

ENDCLASS.

CLASS lhc_Notefrais IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

METHOD validateMontant.
    READ ENTITIES OF zi_notefrais IN LOCAL MODE
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
  READ ENTITIES OF zi_notefrais IN LOCAL MODE
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
  READ ENTITIES OF zi_notefrais IN LOCAL MODE
      ENTITY Notefrais
        FIELDS ( notefraisid ) WITH CORRESPONDING #( keys )
      RESULT DATA(notesfrais).

    " remove lines where CongeID is already filled.
    DELETE notesfrais WHERE notefraisid IS NOT INITIAL.

    " anything left ?
    CHECK notesfrais IS NOT INITIAL.

    " Select max travel ID
    SELECT SINGLE
        FROM  zpfe_nfrais
        FIELDS MAX( notefraisid )
        INTO @DATA(max_notefraisid).

    " Set the travel ID
    MODIFY ENTITIES OF zi_notefrais IN LOCAL MODE
    ENTITY Notefrais
      UPDATE
        FROM VALUE #( FOR notefrais IN notesfrais INDEX INTO i (
          %tky              = notefrais-%tky
          notefraisid         = max_notefraisid + i
          %control-NotefraisId = if_abap_behv=>mk-on ) )
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).
  ENDMETHOD.

ENDCLASS.

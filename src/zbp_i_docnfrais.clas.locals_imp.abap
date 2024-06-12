CLASS lhc_docnotefrais DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateAttachment FOR VALIDATE ON SAVE
      IMPORTING keys FOR Docnotefrais~validateAttachment.

ENDCLASS.

CLASS lhc_docnotefrais IMPLEMENTATION.

  METHOD validateAttachment.
    READ ENTITIES OF zi_notefrais IN LOCAL MODE
    ENTITY Docnotefrais
    FIELDS ( attachment ) WITH CORRESPONDING #( keys )
    RESULT DATA(notesfrais).

    LOOP AT notesfrais INTO DATA(notefrais).

      IF notefrais-attachment = ''.
        APPEND VALUE #( %tky = notefrais-%tky ) TO failed-Docnotefrais.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'Document incorrecte'
                    ) )
                    TO reported-Docnotefrais.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

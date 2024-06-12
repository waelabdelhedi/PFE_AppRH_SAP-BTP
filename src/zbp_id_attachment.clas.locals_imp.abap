CLASS lhc_Attachments DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

*    METHODS calculattachment_id FOR DETERMINE ON MODIFY
*      IMPORTING keys FOR cv~calculattachment_id.

 METHODS validateAttachment FOR VALIDATE ON SAVE
      IMPORTING keys FOR CV~validateAttachment.

ENDCLASS.

CLASS lhc_Attachments IMPLEMENTATION.

*  METHOD calculattachment_id.
*   DATA max_attachmentid TYPE ZELEMENT_AW.
*
*"DATA max_travelid TYPE  .
*"data max_travelid type int2 .
*    DATA update TYPE TABLE FOR UPDATE ZI_STUDENTT\\Attachments.
*
*    " Read all travels for the requested bookings.
*    " If multiple bookings of the same travel are requested, the travel is returned only once.
*    READ ENTITIES OF ZI_STUDENTT IN LOCAL MODE
*    ENTITY Attachments BY \_student
*      FIELDS ( uuid )
*      WITH CORRESPONDING #( keys )
*      RESULT DATA(attachments).
*
*    " Process all affected Travels. Read respective bookings, determine the max-id and update the bookings without ID.
*    LOOP AT attachments INTO DATA(attachment).
*      READ ENTITIES OF ZI_STUDENTT IN LOCAL MODE
*        ENTITY Student BY \_Attachment
*          FIELDS ( id_attachment )
*        WITH VALUE #( ( %tky = attachment-%tky ) )
*        RESULT DATA(attachmentss).
*
*      " Find max used BookingID in all bookings of this travel
*      max_attachmentid = '0000'.
*      LOOP AT attachmentss INTO DATA(attachmentt).
*        IF attachmentt-id_attachment > max_attachmentid.
*          max_attachmentid = attachmentt-id_attachment.
*        ENDIF.
*      ENDLOOP.
*
*       "Provide a booking ID for all bookings that have none.
*      LOOP AT attachmentss INTO attachmentt WHERE id_attachment IS INITIAL.
*        max_attachmentid += 1.
*       APPEND VALUE #( %tky      = attachmentt-%tky
*                        id_attachment = max_attachmentid
*                     ) TO update.
*       ENDLOOP.
*    ENDLOOP.
*
*
*
*    MODIFY ENTITIES OF ZI_STUDENTT IN LOCAL MODE
*    ENTITY Attachments
*     UPDATE FIELDS ( id_attachment ) WITH update
*    REPORTED DATA(update_reported).
*
*    reported = CORRESPONDING #( DEEP update_reported ).
*  ENDMETHOD.

METHOD validateAttachment.
    READ ENTITIES OF zi_studentt IN LOCAL MODE
    ENTITY cv
    FIELDS ( attachment ) WITH CORRESPONDING #( keys )
    RESULT DATA(demandesemplois).

    LOOP AT demandesemplois INTO DATA(demandeemploi).

      IF demandeemploi-attachment = ''.
        APPEND VALUE #( %tky = demandeemploi-%tky ) TO failed-cv.

        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                      %msg = new_message_with_text(
                    severity = if_abap_behv_message=>severity-error
                    text = 'CV incorrecte'
                    ) )
                    TO reported-cv.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

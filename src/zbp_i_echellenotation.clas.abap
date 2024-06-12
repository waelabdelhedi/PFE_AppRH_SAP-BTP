CLASS zbp_i_echellenotation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zbp_i_echellenotation IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_echnotation.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( echellenotation = '1 : Très insatisfaisant' )
      ( echellenotation = '2 : Insatisfaisant' )
      ( echellenotation = '3 : Satisfaisant' )
      ( echellenotation = '4 : Bien' )
      ( echellenotation = '5 : Excellent' )
     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_echnotation.

*   insert the new table entries
    INSERT zpfe_echnotation FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_echnotation entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

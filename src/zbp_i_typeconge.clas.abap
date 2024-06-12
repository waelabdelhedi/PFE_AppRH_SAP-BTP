CLASS zbp_i_typeconge DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBP_I_TYPECONGE IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_typeconge.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( type = 'Maladie' )
      ( type = 'Payé' )
     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_typeconge.

*   insert the new table entries
    INSERT zpfe_typeconge FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_typeconge entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

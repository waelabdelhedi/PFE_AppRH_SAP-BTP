CLASS zbp_i_departement DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBP_I_DEPARTEMENT IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_departement.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( departement = 'RPA' )
      ( departement = 'Opencell' )
      ( departement = 'SAP' )
     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_departement.

*   insert the new table entries
    INSERT zpfe_departement FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_departement entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

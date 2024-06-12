CLASS zbp_i_niveauacces DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zbp_i_niveauacces IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_niveauacces.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( niveauacces = 'Général ' )
      ( niveauacces = 'De base (Accès limité)' )
      ( niveauacces = 'Aucun accès' )
     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_niveauacces.

*   insert the new table entries
    INSERT zpfe_niveauacces FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_niveauacces entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

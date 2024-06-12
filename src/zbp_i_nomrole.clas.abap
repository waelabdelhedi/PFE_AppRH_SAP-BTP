CLASS zbp_i_nomrole DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zbp_i_nomrole IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_nomrole.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( nomrole = 'Administrateur' )
      ( nomrole = 'Utilisateur standard' )
     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_nomrole.

*   insert the new table entries
    INSERT zpfe_nomrole FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_nomrole entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

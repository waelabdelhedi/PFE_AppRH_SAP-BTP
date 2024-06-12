CLASS zbp_i_niveau_consultant DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBP_I_NIVEAU_CONSULTANT IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_niveau_cons.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( niveau = 'Junior' )
      ( niveau = 'Confirmé' )
      ( niveau = 'Senior' )


     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_niveau_cons.

*   insert the new table entries
    INSERT zpfe_niveau_cons FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_niveau_cons entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

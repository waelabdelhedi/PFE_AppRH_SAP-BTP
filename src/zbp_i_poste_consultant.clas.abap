CLASS zbp_i_poste_consultant DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
        INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBP_I_POSTE_CONSULTANT IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_poste_cons.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( poste = 'Consultant Technique' )
      ( poste = 'Consultant Fonctionnel' )
      ( poste = 'Consultant TechnicoFonctionnel' )


     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_poste_cons.

*   insert the new table entries
    INSERT zpfe_poste_cons FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_poste_cons entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

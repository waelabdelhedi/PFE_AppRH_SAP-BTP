CLASS zbp_i_posterole DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
          INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zbp_i_posterole IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_posterole.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( posterole = 'Consultant Technique' )
      ( posterole = 'Consultant Fonctionnel' )
      ( posterole = 'Consultant TechnicoFonctionnel' )
      ( posterole = 'Gérant' )
      ( posterole = 'Manager' )
      ( posterole = 'Chef de projet SI' )
      ( posterole = 'Responsable Ressources humaines' )
      ( posterole = 'Responsable Sécurité SI' )
      ( posterole = 'Responsable Formation' )
      ( posterole = 'Responsable Management Qualité' )
      ( posterole = 'Stagiaire' )

     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_posterole.

*   insert the new table entries
    INSERT zpfe_posterole FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_posterole entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

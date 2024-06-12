CLASS zbp_i_poste DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
      INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBP_I_POSTE IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_poste.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( poste = 'Gérant' )
      ( poste = 'Manager' )
      ( poste = 'Chef de projet SI' )
      ( poste = 'Responsable Ressources humaines' )
      ( poste = 'Responsable Sécurité SI' )
      ( poste = 'Responsable Formation' )
      ( poste = 'Responsable Management Qualité' )

     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_poste.

*   insert the new table entries
    INSERT zpfe_poste FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_poste entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

CLASS zbp_i_mod_forma DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZBP_I_MOD_FORMA IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.

    DATA itab TYPE TABLE OF zpfe_mod_forma.

*   fill internal travel table (itab)
    itab = VALUE #(
      ( modalite = 'Sur site' )
      ( modalite = 'En ligne' )
     ).

*   delete existing entries in the database table
    DELETE FROM zpfe_mod_forma.

*   insert the new table entries
    INSERT zpfe_mod_forma FROM TABLE @itab.

*   output the result as a console message
    out->write( |{ sy-dbcnt } zpfe_mod_forma entries inserted successfully!| ).

  ENDMETHOD.
ENDCLASS.

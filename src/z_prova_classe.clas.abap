CLASS z_prova_classe DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_prova_classe IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  out->write( 'Ciao!' ).
  ENDMETHOD.
ENDCLASS.

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

  seleCT *
  from /dmo/carrier
  into tABLE @data(lt_data)
  up to 10 rOWS.

    out->write( lt_data ).
  ENDMETHOD.
ENDCLASS.

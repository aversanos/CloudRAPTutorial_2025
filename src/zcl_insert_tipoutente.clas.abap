CLASS zcl_insert_tipoutente DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_tipoutente IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_tipo TYPE TABLE OF ztipo_utente_nn,
          lv_max TYPE ztipo_utente_nn-id.

    select max( id )
    from ztipo_utente_nn
    into @lv_max.

    lt_tipo = VALUE #( (
    id = lv_max + 1
    descrizione = 'Bambino bello!'
    limitazioni = 'Tra i 0 e 11 anni!'
    prezzo      = '8.00'
    valuta = 'EUR'  ) ).

    INSERT ztipo_utente_nn FROM TABLE @lt_tipo.
    IF sy-subrc IS INITIAL.
      COMMIT WORK AND WAIT.
      out->write( 'Record inserito!' ).
    ELSE.
      ROLLBACK WORK.
      out->write( 'Record inserito!' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.

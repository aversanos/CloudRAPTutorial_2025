CLASS zcl_sa_estrazione_flight DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS _extract_all
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
    METHODS _count
      IMPORTING
        out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_sa_estrazione_flight IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    _extract_all( out ).
    _count( out ).
  ENDMETHOD.

  METHOD _extract_all.
    DATA: lt_flight TYPE STANDARD TABLE OF /dmo/flight.

    SELECT *
    FROM /dmo/flight
    INTO TABLE @lt_flight.

    out->write(
  EXPORTING
    data   = lt_flight ).

  ENDMETHOD.

  METHOD _count.

    SELECT carrier_id,
           COUNT( DISTINCT conNECTION_id ) AS counter
           FROM /dmo/flight
           GROUP BY carrier_id
           ORDER BY carrier_id
           INTO TABLE @DATA(lt_flight_count).

    out->write( lt_flight_count ).



  ENDMETHOD.


ENDCLASS.

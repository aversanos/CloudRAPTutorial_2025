CLASS lhc_zrbigliettosa2 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZrBigliettoSa2 RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE ZrBigliettoSa2.

ENDCLASS.

CLASS lhc_zrbigliettosa2 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.

    DATA: lv_max TYPE zbiglietto_sa2-id.

    WITH +big AS (
        SELECT MAX( id ) AS max_id FROM zbiglietto_sa2
        UNION
        SELECT MAX( id ) AS max_id FROM zbiglietto_sa2_d
    )
        SELECT MAX( big~max_id )
        FROM +big AS big
        INTO @lv_max.

  LOOP AT entities INTO DATA(ls_entity).
    IF ls_entity-id IS INITIAL.
*      TRY.
*          cl_numberrange_runtime=>number_get(
*            EXPORTING
*              ignore_buffer     = abap_true
*              nr_range_nr       = '01'
*              object            = 'ZID_SABIG'
*      IMPORTING
*        number            = DATA(lv_max) ).
*        CATCH cx_nr_object_not_found.
*        CATCH cx_number_ranges.
*      ENDTRY.
        lv_max += 1.
      ls_entity-id = lv_max.
    ENDIF.

    APPEND VALUE #( %cid = ls_entity-%cid
                    %is_draft = ls_entity-%is_draft
                    id = ls_entity-id ) TO mapped-zrbigliettosa2.
  ENDLOOP.



ENDMETHOD.

ENDCLASS.

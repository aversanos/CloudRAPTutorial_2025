CLASS lhc_zrbigliettosa2 DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.
    TYPES: ty_result_zrbigliettosa2 TYPE STRUCTURE FOR INSTANCE FEATURES RESULT zr_biglietto_sa2\\zrbigliettosa2.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR ZrBigliettoSa2 RESULT result.
    METHODS CheckStatus FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZrBigliettoSa2~CheckStatus.
    METHODS GetDefaultsForCreate FOR READ
      IMPORTING keys FOR FUNCTION ZrBigliettoSa2~GetDefaultsForCreate RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ZrBigliettoSa2 RESULT result.
    METHODS onsave FOR DETERMINE ON SAVE
      IMPORTING keys FOR zrbigliettosa2~onsave.
    METHODS customdelete FOR MODIFY
      IMPORTING keys FOR ACTION zrbigliettosa2~customdelete RESULT result.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE ZrBigliettoSa2.

ENDCLASS.

CLASS lhc_zrbigliettosa2 IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD earlynumbering_create.
*    DATA lv_max TYPE zbiglietto_sa2-id.

*    WITH +big AS (
*        SELECT MAX( id ) AS max_id FROM zbiglietto_sa2
*        UNION
*        SELECT MAX( id ) AS max_id FROM zbiglietto_sa2_d )
*        SELECT MAX( big~max_id ) FROM +big AS big
*          INTO @lv_max.

    LOOP AT entities INTO DATA(ls_entity).
      IF ls_entity-id IS INITIAL.
        TRY.
            cl_numberrange_runtime=>number_get(
              EXPORTING
*              ignore_buffer     = abap_true
                nr_range_nr       = '01'
                object            = 'ZID_SABIG'
        IMPORTING
          number            = DATA(lv_max) ).
          CATCH cx_nr_object_not_found.
          CATCH cx_number_ranges.
        ENDTRY.
*        lv_max += 1.
        ls_entity-id = lv_max.
      ENDIF.

      APPEND VALUE #( %cid      = ls_entity-%cid
                      %is_draft = ls_entity-%is_draft
                      id        = ls_entity-id ) TO mapped-zrbigliettosa2.
    ENDLOOP.



  ENDMETHOD.

  METHOD CheckStatus.
    READ ENTITIES OF zr_biglietto_sa2
    IN LOCAL MODE
    ENTITY ZrBigliettoSa2
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_biglietto).
    LOOP AT lt_biglietto INTO DATA(ls_biglietto)
                              WHERE Status <> 'BOZZA'
                              AND Status <> 'FINALE'
                              AND Status <> 'CANC'.
      APPEND VALUE #( %tky = ls_biglietto-%tky ) TO failed-zrbigliettosa2.
      APPEND VALUE #( %tky = ls_biglietto-%tky
                      %msg = NEW zcx_error_biglietti_sa(
                      textid = zcx_error_biglietti_sa=>null_capacity
                      iv_stato = ls_biglietto-Status
                      severity = if_abap_behv_message=>severity-warning )
                      %element-Status = if_abap_behv=>mk-on
                      ) TO reported-zrbigliettosa2.
    ENDLOOP.

  ENDMETHOD.

  METHOD GetDefaultsForCreate.
    result = VALUE #( FOR key IN keys (
             %cid = key-%cid
             %param-Status = 'BOZZA'
              ) ).
  ENDMETHOD.

  METHOD get_instance_features.
    DATA: ls_result LIKE LINE OF result.
    READ ENTITIES OF zr_biglietto_sa2
    IN LOCAL MODE
    ENTITY ZrBigliettoSa2
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(et_biglietto).

    LOOP AT et_biglietto REFERENCE INTO DATA(lr_biglietto).
      CLEAR ls_result.
      ls_result-%tky = lr_biglietto->%tky.
      ls_result-%field-Status = if_abap_behv=>fc-f-read_only.
      ls_result-%action-CustomDelete = COND #(
      WHEN  lr_biglietto->Status = 'FINALE'
      THEN if_abap_behv=>fc-o-enabled
      ELSE if_abap_behv=>fc-o-disabled ).

      APPEND ls_result TO result.
    ENDLOOP.

*    result = VALUE #( FOR biglietto IN et_biglietto (
*        %tky =   biglietto-%tky
*        %field-Status = if_abap_behv=>fc-f-read_only
*          ) ).
  ENDMETHOD.

  METHOD onSave.
    DATA: lt_update TYPE TABLE FOR UPDATE zr_biglietto_sa2.

    READ ENTITIES OF zr_biglietto_sa2
    IN LOCAL MODE
    ENTITY ZrBigliettoSa2
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(et_biglietto).


    lt_update = VALUE #( FOR biglietto IN et_biglietto WHERE ( Status = 'BOZZA' )
                    ( %tky = biglietto-%tky
                     Status = 'FINALE'
                     %control-Status = if_abap_behv=>mk-on ) ).

    MODIFY ENTITIES OF zr_biglietto_sa2
    IN LOCAL MODE
    ENTITY ZrBigliettoSa2
    UPDATE FROM lt_update.

  ENDMETHOD.

  METHOD CustomDelete.
    DATA: lt_update TYPE TABLE FOR UPDATE zr_biglietto_sa2.
    READ ENTITIES OF zr_biglietto_sa2
    IN LOCAL MODE
    ENTITY ZrBigliettoSa2
    FIELDS ( Status )
    WITH CORRESPONDING #( keys )
    RESULT DATA(et_biglietto).

    lt_update = VALUE #( FOR key IN keys
                    ( %tky = key-%tky
                     Status = 'CANC'
                     %control-Status = if_abap_behv=>mk-on ) ).

    MODIFY ENTITIES OF zr_biglietto_sa2
    IN LOCAL MODE
    ENTITY ZrBigliettoSa2
    UPDATE FROM lt_update.

    READ ENTITIES OF zr_biglietto_sa2
    IN LOCAL MODE
    ENTITY ZrBigliettoSa2
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(et_biglietto2).

    result = VALUE #( FOR line IN et_biglietto2 ( %tky   = line-%tky
                                                              %param = line ) ).

  ENDMETHOD.

ENDCLASS.

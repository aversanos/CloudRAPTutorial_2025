@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Esercizio 3 cds view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_BIGLIETTO_SA
  as select from zbiglietto_sa as biglietto
{
  key biglietto.id         as Id,
      @Semantics.user.createdBy: true
      biglietto.created_by as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      biglietto.created_at as CreatedAt,
      @Semantics.user.lastChangedBy: true
      biglietto.changed_by as ChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      biglietto.changed_at as ChangedAt,
      
      biglietto.nome as Nome,
      biglietto.cognome as Cognome,
      
      @Consumption.hidden: true
      case when created_at = changed_at then ' '
      else 'X'
      end        as Changed,
      
      cast( 'ID'  as abap.char(2) ) as id_text
}

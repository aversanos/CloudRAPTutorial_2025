@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Esercizio 3 cds projection view'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_BIGLIETTO_SA
  provider contract transactional_query
  as projection on ZI_BIGLIETTO_SA as biglietto
{
  key biglietto.Id,
      biglietto.CreatedBy,
      biglietto.CreatedAt,
      biglietto.ChangedBy,
      biglietto.ChangedAt,
      biglietto.Changed
}

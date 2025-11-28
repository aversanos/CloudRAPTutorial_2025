@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZBIGLIETTO_SA2'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_BIGLIETTO_SA2
  as select from zbiglietto_sa2
  composition [0..*] of ZR_COMPONENTI_SA as _Componenti
{
  key id as ID,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  changed_by as ChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  changed_at as ChangedAt,
  nome as Nome,
  cognome as Cognome,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchanged as Locallastchanged,
  status as Status,
  _Componenti
}

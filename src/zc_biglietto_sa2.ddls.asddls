@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Create tickets'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZBIGLIETTO_SA2'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BIGLIETTO_SA2
  provider contract transactional_query
  as projection on ZR_BIGLIETTO_SA2
  association [1..1] to ZR_BIGLIETTO_SA2 as _BaseEntity on $projection.ID = _BaseEntity.ID
{
  key ID,
  @Semantics: {
    user.createdBy: true
  }
  CreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatedAt,
  @Semantics: {
    user.lastChangedBy: true
  }
  ChangedBy,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  ChangedAt,
  Nome,
  Cognome,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  Locallastchanged,
  _BaseEntity
}

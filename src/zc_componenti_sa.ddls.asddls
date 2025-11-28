@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: 'Aiuto'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZCOMPONENTI_SA'
}
@AccessControl.authorizationCheck: #MANDATORY
define view entity ZC_COMPONENTI_SA
  as projection on ZR_COMPONENTI_SA
  association [1..1] to ZR_COMPONENTI_SA as _BaseEntity on $projection.ID = _BaseEntity.ID and $projection.Counter = _BaseEntity.Counter
{
  key ID,
  key Counter,
  UserType,
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
//  @Semantics: {
//    systemDateTime.localInstanceLastChangedAt: true
//  }
//  Locallastchanged,
  _BaseEntity,
  _Biglietto : redirected to parent ZC_BIGLIETTO_SA2
}

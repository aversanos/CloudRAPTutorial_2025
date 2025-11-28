@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZCOMPONENTI_SA'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZR_COMPONENTI_SA
  as select from zcomponenti_sa as Componenti
  association        to parent ZR_BIGLIETTO_SA2 as _Biglietto  on $projection.ID = _Biglietto.ID
//  association [1..1] to ztipo_utente_nn         as _TipoUtente on $projection.UserType = _TipoUtente.id

{
  key id               as ID,
  key counter          as Counter,
      user_type        as UserType,
      @Semantics.user.createdBy: true
      created_by       as CreatedBy,
      @Semantics.systemDateTime.createdAt: true
      created_at       as CreatedAt,
      @Semantics.user.lastChangedBy: true
      changed_by       as ChangedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      changed_at       as ChangedAt,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
//      locallastchanged as Locallastchanged,
      _Biglietto
//      _TipoUtente
}

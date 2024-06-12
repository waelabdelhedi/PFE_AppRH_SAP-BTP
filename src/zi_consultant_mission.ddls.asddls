@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Consultant_Mission'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_CONSULTANT_MISSION
  as select from zpfe_consultant
  association        to parent ZI_MISSION as _mission on $projection.keyparent = _mission.uuid

  association [1..1] to ZI_USER_Stagiaire as _user    on $projection.prenom = _user.prenom

{

  key uuid,
      keyparent,
      nom,
      @ObjectModel.text.association: '_user'
      prenom,
      email,
      tauxjournalier,
      lastchangedat,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      _mission,
      _user

}

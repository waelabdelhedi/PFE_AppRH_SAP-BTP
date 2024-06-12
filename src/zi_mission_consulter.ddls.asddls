@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Mission (Consulter)'
define root view entity ZI_MISSION_CONSULTER as select from zpfe_mission
composition  [0..*] of  ZI_CONSULTANTMISSION_CONSULTER as _Consultant
{
    
     key uuid,
      missionid,
      titre,
      description,
      datedebut,
      datefin,
      locallastchangedat,
      lastchangedat,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      _Consultant
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Mission'
define root view entity ZI_MISSION as select from zpfe_mission     
composition  [0..*] of  ZI_CONSULTANT_MISSION as _Consultant
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

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Consultant Mission (Consulter)'
define view entity ZI_CONSULTANTMISSION_CONSULTER as select from zpfe_consultant
association to parent ZI_MISSION_CONSULTER as _mission on $projection.keyparent = _mission.uuid
association [1..1 ] to ZI_USER_Stagiaire as _user on $projection.prenom = _user.prenom

{
    
      key uuid,   
      keyparent,            
      prenom,
      nom,
      @ObjectModel.text.association: '_user' 
      email,
      telephone,
      poste,
      niveau,
      tauxjournalier,
      departement,
      lastchangedat,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      _mission,_user
}

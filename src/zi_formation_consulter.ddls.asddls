@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Formation (Consulter)'
define root view entity ZI_FORMATION_Consulter as select from zpfe_formation
//composition of target_data_source_name as _association_name
{
    
      key uuid as Uuid,
      formationid  as FormationId,
      sujet as Sujet, 
      formateur as Formateur,
      modalite as Modalite,
      datedebut as DateDebut,
      datefin as DateFin,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at
}

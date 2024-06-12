@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Formulaire Formation'
define root view entity ZI_FORMATION_Form as select from zpfe_formation
{
    
      key uuid as Uuid,
      formationid as FormationId,
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

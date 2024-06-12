@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Formulaire Conge'
define root view entity ZI_CONGEE_FORM as select from zpfe_congee
{
    
     key mykey as MyKey,
      congeid as CongeId,
      type as Type,
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

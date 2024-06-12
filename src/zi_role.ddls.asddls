@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Role'
define root view entity ZI_ROLE as select from zpfe_role
{
    
    key uuid,
      roleid,
      nom,
      poste,
      nomrole,
      niveauacces,
      @Semantics.user.createdBy: true
      created_by,  
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at 
      }

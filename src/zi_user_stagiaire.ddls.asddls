@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for User_Stagiaire'
define root view entity ZI_USER_Stagiaire as select from zpfe_user_s
composition  [0..*] of  ZI_STAGIAIRE as _Stagiaire
composition  [0..*] of  ZI_ADMIN as _Admin
composition  [0..*] of  ZI_CONSULTANT as _Consultant




{
    
      key uuid,
      userid,
     // 
      
      nom,
      @ObjectModel.text.element: ['nom'] 
      prenom,
      datenaissance,
      adresse,
      email,
      telephone,
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
      _Stagiaire,
      _Admin,
      _Consultant
}

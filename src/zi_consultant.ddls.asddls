@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Consultant'
define view entity ZI_CONSULTANT
  as select from zpfe_consultant
  association to parent ZI_USER_Stagiaire as _userS on $projection.keyparent = _userS.uuid
 
  

{

  key uuid,

      //specialisation,
      datedebut,
      keyparent,

      mimetype,
      filename,
      @EndUserText.label: 'cv'
      @Semantics.largeObject:{
          mimeType: 'mimetype',
          fileName: 'filename',
          contentDispositionPreference: #INLINE
      }
      cv,
      tauxjournalier,
      poste,
      //descriptionposte,
      niveau,
      departement,
      mission,
      lastchangedat,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      _userS
      
}

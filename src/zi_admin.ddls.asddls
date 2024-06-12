@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Administrateur'
define view entity ZI_ADMIN
  as select from zpfe_admin
association to parent ZI_USER_Stagiaire as _userS on $projection.keyparent = _userS.uuid

{
  key uuid,
      keyparent,
      poste,
      datedebut,
      lastchangedat,
      mimetype,
      filename,
      @EndUserText.label: 'cv'
      @Semantics.largeObject:{
          mimeType: 'mimetype',
          fileName: 'filename',
          contentDispositionPreference: #INLINE
      }
      cv,
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

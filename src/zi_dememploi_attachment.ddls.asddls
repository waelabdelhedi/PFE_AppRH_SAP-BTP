@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for CV Demande Emploi'          
define view entity ZI_DEMEMPLOI_ATTACHMENT
  as select from zpfe_cv_dememp
  // association to parent ZR_LT_DEMANDECF as _demandeEmploi on $projection.Keyparent = _demandeEmploi.Uuid
  
{
  key uuid as Uuid,
      keyparent as Keyparent,
      //@EndUserText.label: 'cv'
      @Semantics.largeObject:{
          mimeType: 'mimetype',
          fileName: 'filename',
          contentDispositionPreference: #INLINE
      }
      cv as Cv,
     // @Semantics.mimeType: true
      mimetype as Mimetype,
      filename as Filename,    
      
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
   //_demandeEmploi
   
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Attachment'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_ATTACHMENT_V2 as select from zpfe_attachment
association to parent ZI_STUDENTT as _DemandeEmploi on $projection.keyparent = _DemandeEmploi.uuid   
{

  key uuid ,
  id_attachment ,
  keyparent    ,
  comments    ,
      @EndUserText.label: 'Attachments'
    @Semantics.largeObject:{
        mimeType: 'mimetype',
        fileName: 'filename',
        contentDispositionPreference: #INLINE
    }
  attachment   ,
  mimetype    ,
  filename   ,
  lastchangedat,
  _DemandeEmploi
}

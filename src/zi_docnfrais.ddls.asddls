@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Doc Note Frais (Form)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_docnfrais as select from zpfe_docnfrais
association to parent ZI_NoteFrais as _notefrais on $projection.keyparent = _notefrais.uuid   

{
      key uuid ,
 // id_attachment ,
  keyparent    ,
  //comments    ,
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
  _notefrais
}

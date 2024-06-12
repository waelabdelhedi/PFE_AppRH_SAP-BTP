@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Doc Note Frais (M)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_docnfrais_M as select from zpfe_docnfrais
association to parent ZR_LT_NOTEFRAIS as _notefrais on $projection.keyparent = _notefrais.Uuid   

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

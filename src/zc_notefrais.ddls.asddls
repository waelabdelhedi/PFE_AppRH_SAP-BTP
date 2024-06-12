@AbapCatalog.viewEnhancementCategory: [#NONE]
@EndUserText.label: 'Projection View for Note Frais (Form)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZC_NoteFrais
  provider contract transactional_query as projection on ZI_NoteFrais
{
@EndUserText.label: 'Uuid'
     key uuid,
     @EndUserText.label: 'NoteFraisId'
      notefraisid,
      @EndUserText.label: 'Motif'
      motif,
      @EndUserText.label: 'Montant'
      montant,
      created_by,
      created_at,
      @UI.hidden: true     
      locallastchangedat,
      @UI.hidden: true      
      lastchangedat,
     _docnfrais : redirected to composition child ZC_docnfrais
      
}

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cosumption View for Student'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZC_STUDENTT
  provider contract transactional_query
  as projection on ZI_STUDENTT as DemandeEmploi
{

      @EndUserText.label: 'Uuid'
      key uuid,
     @EndUserText.label: 'Dememp ID'
      id,
      @EndUserText.label: 'Poste Souhaite'
      postesouhaite,
      @EndUserText.label: 'Specialisation'
      specialisation,
      @EndUserText.label: 'Experience'
      experience,
      @EndUserText.label: 'Disponibilite'
      disponibilite,
      @UI.hidden: true
      lastchangedat,
      @UI.hidden: true
      locallastchangedat,
    
     _CV : redirected to composition child ZC_ATTACHMENT_V2
}

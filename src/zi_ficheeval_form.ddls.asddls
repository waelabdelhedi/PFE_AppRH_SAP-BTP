@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_FicheEval_Form'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_FicheEval_Form as select from zpfe_evaluation
{
   key uuid,
   ficheevaluationid,
   sujetformation ,
   contenu ,
   rapport_theorie_pratique ,
   duree ,
   rythme ,
   support_pedagogique,
   logistique,
   clarte_du_cours,
   maitrise_du_sujet,
   disponibilite,
   methode_pedagogique,
   utilite_en_travail,
   amelioration ,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at as Created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at
}

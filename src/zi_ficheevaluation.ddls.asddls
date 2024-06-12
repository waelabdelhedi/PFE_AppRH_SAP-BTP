@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Fiche Evaluation'
define root view entity ZI_FicheEvaluation as select from zpfe_evaluation
association to ZI_ECHELLENOTATION as _ECHELLENOTATION on $projection.SupportPedagogique = _ECHELLENOTATION.EchelleNotation
{
    
   key uuid                    as Uuid,
      ficheevaluationid        as FicheEvaluationId,
      sujetformation           as SujetFormation,
      contenu                  as ContenuConformeAuxObjectifs,
      rapport_theorie_pratique as RapportTheoriePratique,
      duree                    as Duree,
      rythme                   as Rythme,
      support_pedagogique      as SupportPedagogique,
      logistique               as Logistique,
      clarte_du_cours          as ClarteDuCours,
      maitrise_du_sujet        as MaitriseDuSujet,
      disponibilite            as Disponibilite,
      methode_pedagogique      as MethodePedagogique,
      utilite_en_travail       as UtiliteEnSituationDeTravail,
      amelioration             as AmeliorationPersoEtPro,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      _ECHELLENOTATION
      
}

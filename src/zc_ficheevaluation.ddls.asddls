@EndUserText.label: 'Projection View for Fiche Evaluation'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
    typeNamePlural: 'Evaluation des formations',
        title: {
      type: #STANDARD,
      label: 'Evaluation des formations',
      value: 'SujetFormation'
    }
  }
}
define root view entity ZC_FicheEvaluation
  provider contract transactional_query
  as projection on ZI_FicheEvaluation
{
      @UI.facet : [ { id:              'idIdentification',
             purpose:         #STANDARD,
             type:            #IDENTIFICATION_REFERENCE,
             label:           'Formulaire Fiche Evaluation',
             position:        10
             } ]

      @UI.identification: [ { position: 10, label: 'Uuid' } ]
      @UI.hidden: true
  key Uuid,
     // @UI : { lineItem : [ { position : 15, importance: #MEDIUM, label: 'FicheEvaluationId'} ],
      @UI.identification: [ { position: 15, label: 'FicheEvaluationId' } ] 
      //@UI.hidden: true
      FicheEvaluationId,
      @UI.identification: [ { position: 20,  label : 'Sujet Formation'   }]
      @UI.lineItem: [ { position : 20, importance: #MEDIUM , label: 'Sujet Formation' }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_FORMATION', element: 'Sujet' }  }]
      SujetFormation,
      @UI.lineItem: [ { position : 30, importance: #MEDIUM , label: 'Contenu conforme aux objectifs' }]
      @UI.identification: [ { position: 30,  label : 'Contenu conforme aux objectifs'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      ContenuConformeAuxObjectifs,
      @UI.lineItem: [ { position : 40, importance: #MEDIUM , label: 'Rapport theorie et pratique' }]
      @UI.identification: [ { position: 40,  label : 'Rapport theorie et pratique'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      RapportTheoriePratique,
      @UI.lineItem: [ { position : 50, importance: #MEDIUM , label: 'Duree' }]
      @UI.identification: [ { position: 50,  label : 'Duree'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      Duree,
      @UI.lineItem: [ { position : 60, importance: #MEDIUM , label: 'Rythme' }]
      @UI.identification: [ { position: 60,  label : 'Rythme'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      Rythme,
      @UI.lineItem: [ { position : 70, importance: #MEDIUM , label: 'Support pedagogique' }]
      @UI.identification: [ { position: 70,  label : 'Support pedagogique'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      SupportPedagogique,
      @UI.lineItem: [ { position : 80, importance: #MEDIUM , label: 'Logistique' }]
      @UI.identification: [ { position: 80,  label : 'Logistique'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      Logistique,
      @UI.lineItem: [ { position : 90, importance: #MEDIUM , label: 'Clarte du cours' }]
      @UI.identification: [ { position: 90,  label : 'Clarte du cours'   }]    
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      ClarteDuCours,
      @UI.lineItem: [ { position : 100, importance: #MEDIUM , label: 'Maitrise du sujet' }]     
      @UI.identification: [ { position: 100,  label : 'Maitrise du sujet'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      MaitriseDuSujet,
      @UI.lineItem: [ { position : 110, importance: #MEDIUM , label: 'Disponibilite' }]
      @UI.identification: [ { position: 110,  label : 'Disponibilite'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      Disponibilite,
      @UI.lineItem: [ { position : 120, importance: #MEDIUM , label: 'Methode pedagogique' }]
      @UI.identification: [ { position: 120,  label : 'Methode pedagogique'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      MethodePedagogique,
      @UI.lineItem: [ { position : 130, importance: #MEDIUM , label: 'Utilite en situation de travail' }]
      @UI.identification: [ { position: 130,  label : 'Utilite en situation de travail'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      UtiliteEnSituationDeTravail,
      @UI.lineItem: [ { position : 140, importance: #MEDIUM , label: 'Amélioration personnel/professionnel' }]
      @UI.identification: [ { position: 140,  label : 'Amélioration personnel/professionnel'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      AmeliorationPersoEtPro,
      @UI.lineItem: [ { position : 150, importance: #MEDIUM , label: 'Created_by' }]
      @UI: { identification: [ { position: 150, label: 'Created_by' } ]}
      created_by,
      @UI.lineItem: [ { position : 160, importance: #MEDIUM , label: 'Created_at' }]
      @UI: { identification: [ { position: 160, label: 'Created_at' } ]}
      created_at,
      @UI.lineItem: [ { position : 170, importance: #MEDIUM , label: 'Last_changed_by' }]
      @UI: { identification: [ { position: 170, label: 'Last_changed_by' } ]}
      last_changed_by,
      @UI.lineItem: [ { position : 180, importance: #MEDIUM , label: 'Last_changed_at' }]
      @UI: { identification: [ { position: 180, label: 'Last_changed_at' } ]}
      last_changed_at,
      _ECHELLENOTATION
}

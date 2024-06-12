@EndUserText.label: 'ZC_FicheEval_Form'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@UI: {
  headerInfo: {
    typeNamePlural: 'Formulaire Fiche Evaluation',
    title: {
      type: #STANDARD,
      label: 'Conge',
      value: 'sujetformation'
    }
  }
}
define root view entity ZC_FicheEval_Form
  provider contract transactional_query as projection on ZI_FicheEval_Form
{
     @UI.facet : [ { id:              'idIdentification',
                 purpose:         #STANDARD,
                 type:            #IDENTIFICATION_REFERENCE,
                 label:           'Formulaire Fiche Evaluation',
                 position:        10
                 } ]

      
      @UI: { identification: [ { position: 10, label: 'Uuid' } ]}
      @UI.hidden: true
  key uuid,
        @UI: { identification: [ { position: 15, label: 'FicheEvaluationId' } ]}
        @UI.hidden: true
      ficheevaluationid,
           @UI.identification: [ { position: 20,  label : 'Sujet Formation'   }]
           @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_FORMATION', element: 'Sujet' }  }]
           sujetformation,
           @UI.identification: [ { position: 30,  label : 'Contenu conforme aux objectifs'   }]
           @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      contenu,
          @UI.identification: [ { position: 40,  label : 'Rapport theorie et pratique'   }]
        @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      rapport_theorie_pratique,
         @UI.identification: [ { position: 50,  label : 'Duree'   }]
         @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
           
      duree,
          @UI.identification: [ { position: 60,  label : 'Rythme'   }]
          @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }] 
      rythme,
         @UI.identification: [ { position: 70,  label : 'Support pedagogique'   }]
     @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      support_pedagogique,
      @UI.identification: [ { position: 80,  label : 'Logistique'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      logistique,
            @UI.identification: [ { position: 90,  label : 'Clarte du cours'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      clarte_du_cours,
            @UI.identification: [ { position: 100,  label : 'Maitrise du sujet'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      maitrise_du_sujet,
      @UI.identification: [ { position: 110,  label : 'Disponibilite'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      disponibilite,
       @UI.identification: [ { position: 120,  label : 'Methode pedagogique'   }]
       @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      methode_pedagogique, 
      @UI.identification: [ { position: 130,  label : 'Utilite en situation de travail'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      utilite_en_travail,
      @UI.identification: [ { position: 140,  label : 'Amélioration personnel/professionnel'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_ECHELLENOTATION', element: 'EchelleNotation' }  }]
      amelioration,
      @UI: { identification: [ { position: 150, label: 'Created_by' } ]}
      
      created_by,
      @UI: { identification: [ { position: 160, label: 'Created_at' } ]}
      Created_at,
      @UI: { identification: [ { position: 170, label: 'last_changed_by' } ]}
      @UI.hidden: true
      last_changed_by,
      @UI: { identification: [ { position: 180, label: 'last_changed_at' } ]}
      @UI.hidden: true
      last_changed_at
}

@EndUserText.label: 'Projection View for Consultant'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
  headerInfo: {
    typeName: 'Consultant Details',
    typeNamePlural: 'Consultant Details',
    title: {
      type: #STANDARD,
      label: 'Consultant Details', value:'departement'},
      description:{ type: #STANDARD, label: 'Consultant Details', value:'poste'
    }
  }
}
define view entity ZC_CONSULTANT as projection on ZI_CONSULTANT
{
      @UI.facet: [ { id:              'Consultant',
                 purpose:         #STANDARD,
                 type:            #IDENTIFICATION_REFERENCE,
                 label:           'Consultant Details',
                 position:        10 } ]

   @UI.identification: [ { position: 10,  label : 'UuidConsultant'   }]
   @UI.hidden: true
     key uuid,
   @UI.identification: [ { position: 15, label : 'KeyParent' }]
   @UI.hidden: true
      keyparent,
//         @UI : { lineItem : [ { position : 20, importance: #HIGH , label: 'specialisation' }], identification: [ { position: 20,  label : 'specialisation'   }]}
//      specialisation,
            @UI : { lineItem : [ { position : 20, importance: #HIGH , label: 'Date debut' }], identification: [ { position: 20,  label : 'Date debut'   }]}
      datedebut, 
     
      mimetype,
       
      filename,
         @UI : { lineItem : [ { position : 30, importance: #HIGH , label: 'CV' }], identification: [ { position: 30,  label : 'CV'   }]}
      cv,
//         @UI : { lineItem : [ { position : 50, importance: #HIGH , label: 'tauxjournalier' }], identification: [ { position: 50,  label : 'tauxjournalier'   }]}
//      tauxjournalier,
     @UI : { lineItem : [ { position : 40, importance: #HIGH , label: 'Poste' }], identification: [ { position: 40,  label : 'Poste'   }]}
     @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_POSTE_CONSULTANT', element: 'poste' }  }]                                      
      poste,
//         @UI : { lineItem : [ { position : 70, importance: #HIGH , label: 'descriptionposte' }], identification: [ { position: 70,  label : 'descriptionposte'   }]}
//      descriptionposte,
         @UI : { lineItem : [ { position : 50, importance: #HIGH , label: 'Niveau' }], identification: [ { position: 50,  label : 'Niveau'   }]}
         @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_NIVEAU_CONSULTANT', element: 'niveau' }  }]                                              
      niveau,
      @UI : { lineItem : [ { position : 60, importance: #HIGH , label: 'Departement' }], identification: [ { position: 60,  label : 'Departement'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_DEPARTEMENT', element: 'departement' }  }]                                      
      departement,
      @UI : { lineItem : [ { position : 70, importance: #HIGH , label: 'Mission' }], identification: [ { position: 70,  label : 'Mission'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_MISSION_CONSULTER', element: 'titre' }  }]                                      
      mission,
      lastchangedat ,
      _userS : redirected to parent ZC_USER_Stagiaire
         
}

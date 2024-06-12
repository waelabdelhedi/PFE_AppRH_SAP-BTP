@EndUserText.label: 'Projection View for Consultant_Mission'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
  headerInfo: {
    typeName: 'Consultant Details',
    typeNamePlural: 'Consultant Details',
    title: {
      type: #STANDARD,
      label: 'Consultant Details',value: 'prenom'},
      description:{ type: #STANDARD, label: 'Consultant Details'
    }
  }
}
define view entity ZC_CONSULTANT_MISSION as projection on ZI_CONSULTANT_MISSION
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
      @UI: { lineItem : [ { position : 30, importance: #HIGH , label: 'Nom' } ]}                             
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_USER_Stagiaire', element: 'nom' }  }]                                   
      nom,    
      @UI: { lineItem : [ { position : 40, importance: #HIGH , label: 'Prenom' }], identification: [ { position: 40, label: 'Nom & Prenom' } ]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_USER_Stagiaire', element: 'prenom' }  }]                                              
      prenom,
      @UI: { lineItem : [ { position :50, importance: #HIGH , label: 'Email' } ], identification: [ { position: 50, label: 'Email' } ]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_USER_Stagiaire', element: 'email' }  }]                                      
      email,
      @UI : { lineItem : [ { position : 100, importance: #HIGH , label: 'Taux Journalier' }], identification: [ { position: 100,  label : 'Taux Journalier'   }]}
      tauxjournalier,
      lastchangedat ,
      
      _mission : redirected to parent ZC_MISSION   ,
      _user
      
}

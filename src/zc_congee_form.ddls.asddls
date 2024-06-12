@EndUserText.label: 'Projection View for Formulaire Conge'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
 //  typeName: 'Conge',
    typeNamePlural: 'Formulaire Conge',
    title: {
      type: #STANDARD,
      label: 'Conge',
      value: 'Type'
    }
  }
}
define root view entity ZC_CONGEE_FORM
  provider contract transactional_query as projection on ZI_CONGEE_FORM
{
    @UI.facet: [ { id:              'idIdentification',
                purpose:         #STANDARD,
                type:            #IDENTIFICATION_REFERENCE,
                label:           'Formulaire demande de conge',
                position:        10 } ]
                
                


      @UI: { identification: [ { position: 10, label: 'Uuid' } ]}
      @UI.hidden: true
  key MyKey,
      @UI: { identification: [ { position: 20, label: 'CongeId' } ]}
      @UI.hidden: true
      CongeId,
      @UI: { identification: [ { position: 30, label: 'Type' } ]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_TYPE_CONGE', element: 'Type' }  }]                                      
      Type,  
      @UI: { identification: [ { position: 40, label: 'Date debut' } ]}
      DateDebut,
      @UI: { identification: [ { position: 50, label: 'Date fin' } ]}
      DateFin,
      @UI: { identification: [ { position: 60, label: 'Created_by' } ]}
     
      created_by,
      @UI: { identification: [ { position: 70, label: 'Created_at' } ]}
      
      created_at,
      @UI: { identification: [ { position: 80, label: 'Last_changed_by' } ]}
      @UI.hidden: true
      last_changed_by,
      @UI: { identification: [ { position: 90, label: 'Last_changed_at' } ]}
      @UI.hidden: true
      last_changed_at
}

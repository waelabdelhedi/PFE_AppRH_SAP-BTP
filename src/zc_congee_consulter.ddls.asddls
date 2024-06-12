@EndUserText.label: 'Projection View for Conge (Consulter)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
    typeName: 'Congés',
    typeNamePlural: 'Congés',
    title: {
      type: #STANDARD,
      label: 'Conges',
      value: 'type'
    }
  }
}
define root view entity ZC_CONGEE_CONSULTER
  provider contract transactional_query as projection on ZI_CONGEE_CONSULTER
{
    @UI.facet: [ { id:              'Conge',
                purpose:         #STANDARD,
                type:            #IDENTIFICATION_REFERENCE,
                label:           'Conge',
                position:        10 } ]
                
                


      @UI: { identification: [ { position: 10, label: 'Uuid' } ]}
      @UI.hidden: true
  key mykey,
      @UI.identification: [ { position: 20, label: 'CongeId' } ]
      congeid as CongeId,
      @UI.lineItem: [ { position : 30, importance: #MEDIUM , label: 'Type' }]
      @UI: { identification: [ { position: 30, label: 'Type' } ]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_TYPE_CONGE', element: 'Type' }  }]                                      
      type,  
      @UI.lineItem: [ { position : 40, importance: #MEDIUM , label: 'Date debut' }]
      @UI: { identification: [ { position: 40, label: 'Date debut' } ]}
      datedebut,
      @UI.lineItem: [ { position : 50, importance: #MEDIUM , label: 'Date fin' }]
      @UI: { identification: [ { position: 50, label: 'Date fin' } ]}
      datefin,
      @UI.lineItem: [ { position : 60, importance: #MEDIUM , label: 'Created_by' }]
      @UI: { identification: [ { position: 60, label: 'Created_by' } ]}
      created_by,
      @UI.lineItem: [ { position : 70, importance: #MEDIUM , label: 'Created_at' }]
      @UI: { identification: [ { position: 70, label: 'Created_at' } ]}
      created_at,
      @UI: { identification: [ { position: 80, label: 'Last_changed_by' } ]}
      last_changed_by,
      @UI: { identification: [ { position: 90, label: 'Last_changed_at' } ]}
      last_changed_at
}

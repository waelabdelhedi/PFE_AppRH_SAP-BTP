@EndUserText.label: 'Projection View for Formation (Consulter)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
    typeName: 'Formations',
    typeNamePlural: 'Formations',
    title: {
      type: #STANDARD,
      label: 'Formations',
      value: 'Sujet'
    }
  }
}
define root view entity ZC_FORMATION_CONSULTER
  provider contract transactional_query as projection on ZI_FORMATION_Consulter
{
    @UI.facet: [ { id:              'Formation',
                purpose:         #STANDARD,
                type:            #IDENTIFICATION_REFERENCE,
                label:           'Formation',
                position:        10 } ]
                
                


      @UI: { identification: [ { position: 10, label: 'Uuid' } ]}
      @UI.hidden: true
  key Uuid,
     // @UI.lineItem: [ { position : 20, importance: #MEDIUM , label: 'FormationId' }]
      @UI: { identification: [ { position: 20, label: 'FormationId' } ]}
      // @UI.hidden: true
      FormationId,
      @UI.lineItem: [ { position : 30, importance: #MEDIUM , label: 'Sujet' }]
      @UI: { identification: [ { position: 30, label: 'Sujet' } ]}
      Sujet,
      @UI.lineItem: [ { position : 40, importance: #MEDIUM , label: 'Formateur' }]
      @UI: { identification: [ { position: 40, label: 'Formateur' } ]}
      Formateur,
      @UI.lineItem: [ { position : 50, importance: #MEDIUM , label: 'Modalite' }]
      @UI: { identification: [ { position: 50, label: 'Modalite' } ]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_MOD_FORMA', element: 'Modalite' }  }]     
      Modalite,
      @UI.lineItem: [ { position : 60, importance: #MEDIUM , label: 'Date debut' }]
      @UI: { identification: [ { position: 60, label: 'Date debut' } ]}
      DateDebut,
      @UI.lineItem: [ { position : 70, importance: #MEDIUM , label: 'Date fin' }]
      @UI: { identification: [ { position: 70, label: 'Date fin' } ]}
      DateFin,
      @UI.lineItem: [ { position : 80, importance: #MEDIUM , label: 'Created_by' }]
      @UI: { identification: [ { position: 80, label: 'Created_by' } ]}
      created_by,
      @UI.lineItem: [ { position : 90, importance: #MEDIUM , label: 'Created_at' }]
      @UI: { identification: [ { position: 90, label: 'Created_at' } ]}
      created_at,
      @UI: { identification: [ { position: 100, label: 'Last_changed_by' } ]}
      last_changed_by,
      @UI: { identification: [ { position: 110, label: 'Last_changed_at' } ]}
      last_changed_at
}

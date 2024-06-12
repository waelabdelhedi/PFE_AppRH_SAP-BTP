@EndUserText.label: 'Projection View for Mission (Consulter)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
    typeName: 'Missions',
    typeNamePlural: 'Missions',
    title: {
      type: #STANDARD,
      label: 'Missions',
      value: 'titre'
    }
  }
}
define root view entity ZC_MISSION_CONSULTER
  provider contract transactional_query as projection on ZI_MISSION_CONSULTER
{
  @UI.facet: [ { id:              'Mission',
                purpose:         #STANDARD,
                type:            #IDENTIFICATION_REFERENCE,
                label:           'Mission',
                position:        10 },
                { id:              'Consultant',
                 purpose:         #STANDARD,
                 type:            #LINEITEM_REFERENCE,
                 label:           'Consultant Details',
                 position:        20,
                 targetElement: '_Consultant'   } 
] 
                
                


      @UI: { identification: [ { position: 10, label: 'Uuid' } ]}
      @UI.hidden: true
  key uuid,
      //@UI.lineItem: [ { position : 20, importance: #MEDIUM , label: 'MissionId' }]
      @UI: { identification: [ { position: 20, label: 'MissionId' } ]}
      
      missionid,
      @UI.lineItem: [ { position : 30, importance: #MEDIUM , label: 'Titre' }]
      @UI: { identification: [ { position: 30, label: 'Titre' } ]}
      titre,
      @UI.lineItem: [ { position : 40, importance: #MEDIUM , label: 'Description' }]
      @UI: { identification: [ { position: 40, label: 'Description' } ]}
      description,
      @UI.lineItem: [ { position : 50, importance: #MEDIUM , label: 'Date debut' }]
      @UI: { identification: [ { position: 50, label: 'Date debut' } ]}
      datedebut,
      @UI.lineItem: [ { position : 60, importance: #MEDIUM , label: 'Date fin' }]
      @UI: { identification: [ { position: 60, label: 'Date fin' } ]}
      datefin,
      @UI: { identification: [ { position: 70, label: 'Created_by' } ]}
      created_by,
      @UI: { identification: [ { position: 80, label: 'Created_at' } ]}
      created_at,
      @UI: { identification: [ { position: 90, label: 'Last_changed_by' } ]}
      last_changed_by,
      @UI: { identification: [ { position: 100, label: 'Last_changed_at' } ]}
      last_changed_at,
      @UI.hidden: true
      lastchangedat,
      @UI.hidden: true
      locallastchangedat,
      _Consultant : redirected to composition child ZC_CONSULTANTMISSION_CONSULTER  
}

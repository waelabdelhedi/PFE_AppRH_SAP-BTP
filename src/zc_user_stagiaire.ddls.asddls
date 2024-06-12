@EndUserText.label: 'Projection View for User_Stagiaire'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
    typeName: 'Users',
    typeNamePlural: 'Users',
    title: {
      type: #STANDARD,
      label: 'Users',
      value: 'prenom'   
    }
  }
}
define root view entity ZC_USER_Stagiaire provider contract transactional_query as projection on ZI_USER_Stagiaire as user_s
{
    @UI.facet: [ { id:              'User',
             purpose:         #STANDARD,
             type:            #IDENTIFICATION_REFERENCE,
             label:           'User',
             position:        10 },
            { id : 'Stagiaire',
            purpose : #STANDARD,
            type: #LINEITEM_REFERENCE,
            label: 'Stagiaire Details',
            position: 20,
            targetElement: '_Stagiaire'     },
            { id:          'Administrateur',
                 purpose:         #STANDARD,
                 type:            #LINEITEM_REFERENCE,
                 label:           'Administrateur Details',
                 position:        30,
                 targetElement: '_Admin'  },
                 {id : 'Consultant',
            purpose : #STANDARD,
            type: #LINEITEM_REFERENCE,
            label: 'Consultant Details',
            position: 40,
            targetElement: '_Consultant'     }
                ]


      @UI.identification: [ { position: 10,  label : 'UuidUser'   }]
      @UI.hidden: true
  key uuid,
      @UI.identification: [ { position: 20, label: 'UserId' } ]
      //@UI.hidden: true
      userid as UserId,
      //@UI: { lineItem : [ { position : 30, importance: #HIGH , label: 'Nom' } ]}
      @UI.identification: [ { position: 30, label: 'Nom' } ]
      nom,
      @UI: { lineItem : [ { position : 40, importance: #HIGH , label: 'Nom & Prenom' }], identification: [ { position: 40, label: 'Prenom' } ]}
      prenom,
      @UI: { lineItem : [ { position :50, importance: #HIGH , label: 'Date naissance' }], identification: [ { position: 50, label: 'Date naissance' } ]}
      datenaissance,
      @UI: { lineItem : [ { position :60, importance: #HIGH ,  label: 'Adresse' } ], identification: [ { position: 60, label: 'Adresse' } ]}
      adresse,
      @UI: { lineItem : [ { position :70, importance: #HIGH , label: 'Email' } ], identification: [ { position: 70, label: 'Email' } ]}
      email,
      @UI: { lineItem : [ { position :80, importance: #HIGH , label: 'Telephone'}], identification: [ { position: 80, label: 'Telephone' } ]}
      telephone,
      @UI.hidden: true
      lastchangedat,
      @UI.hidden: true
      locallastchangedat,
      @UI: { identification: [ { position: 90, label: 'Created_by' } ]}
      created_by,
      @UI: { identification: [ { position: 100, label: 'Created_at' } ]}
      created_at,
      @UI: { identification: [ { position: 110, label: 'Last_changed_by' } ]}
      last_changed_by,
      @UI: { identification: [ { position: 120, label: 'Last_changed_at' } ]}
      last_changed_at,
      _Stagiaire : redirected to composition child ZC_STAGIAIRE,
      _Admin : redirected to composition child ZC_ADMIN,
      _Consultant : redirected to composition child ZC_CONSULTANT      
}

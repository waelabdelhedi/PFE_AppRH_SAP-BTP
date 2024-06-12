@EndUserText.label: 'Projection View for Formulaire Certif'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
//    typeName: 'Certification',
    typeNamePlural: 'Formulaire Certification',
    title: {
      type: #STANDARD,
      label: 'Certification',
      value: 'Nom'
    }
  }
}
define root view entity ZC_CERTIF_FORM
  provider contract transactional_query as projection on ZI_CERTIF_FORM
{
    @UI.facet: [ { id:              'idIdentification',
                purpose:         #STANDARD,
                type:            #IDENTIFICATION_REFERENCE,
                label:           'Formulaire demande de certification',
                position:        10 } ]
                
                


      @UI: { identification: [ { position: 10, label: 'UuidCertif' } ]}
      @UI.hidden: true
  key UuidCertif,
      @UI: { identification: [ { position: 20, label: 'CertifId' } ]}
      @UI.hidden: true
      CertifId,
      @UI: { identification: [ { position: 30, label: 'Nom' } ]}
      Nom,
      @UI: { identification: [ { position: 40, label: 'Organisme' } ]}
      Organisme,
      @UI: { identification: [ { position: 50, label: 'Date obtention' } ]}
      DateObtention,
      @UI: { identification: [ { position: 60, label: 'Date expiration' } ]}
      DateExpiration,
      @UI: { identification: [ { position: 70, label: 'Description' } ]}
      Description,
      @UI: { identification: [ { position: 80, label: 'Lien certificat' } ]}
      LienCertificat,
     // @UI.lineItem: [ { position : 90, importance: #MEDIUM , label: 'Created_by' }]
      @UI: { identification: [ { position: 90, label: 'Created_by' } ]}     
      @UI.hidden: true
      created_by,
      //@UI.lineItem: [ { position : 100, importance: #MEDIUM , label: 'Created_at' }]
      @UI: { identification: [ { position: 100, label: 'Created_at' } ]} 
       
      created_at,
      @UI: { identification: [ { position: 110, label: 'Last_changed_by' } ]}    
     
      last_changed_by,
      @UI: { identification: [ { position: 120, label: 'Last_changed_at' } ]}
      @UI.hidden: true
      last_changed_at
}

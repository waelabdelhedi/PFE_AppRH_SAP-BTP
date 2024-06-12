@EndUserText.label: 'Projection View for Certification'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
 //   typeName: 'Certification',
    typeNamePlural: 'Certifications',
    title: {
      type: #STANDARD,
      label: 'Certification',
      value: 'nom'
    }
  }
}
define root view entity ZC_CERTIF
  provider contract transactional_query as projection on ZI_CERTIF
{
    
@UI.facet: [ { id:              'Certification',
                purpose:         #STANDARD,
                type:            #IDENTIFICATION_REFERENCE,
                label:           'Certification',
                position:        10 } ]
                
                

      @UI: { identification: [ { position: 10, label: 'UuidCertif' } ]}
      @UI.hidden: true
  key uuidcertif,
      //@UI.lineItem: [ { position : 20, importance: #MEDIUM , label: 'CertifId' }]
      @UI: { identification: [ { position: 20, label: 'CertifId' } ]}
      certifid as CertifId,
      @UI.lineItem: [ { position : 30, importance: #MEDIUM , label: 'Nom' }]
      @UI: { identification: [ { position: 30, label: 'Nom' } ]}
      nom,
      @UI.lineItem: [ { position : 40, importance: #MEDIUM , label: 'Organisme' }]
      @UI: { identification: [ { position: 40, label: 'Organisme' } ]}
      organisme,
      @UI.lineItem: [ { position : 50, importance: #MEDIUM , label: 'Date obtention' }]
      @UI: { identification: [ { position: 50, label: 'Date obtention' } ]}
      dateobtention,
      @UI.lineItem: [ { position : 60, importance: #MEDIUM , label: 'Date expiration' }]
      @UI: { identification: [ { position: 60, label: 'Date expiration' } ]}
      dateexpiration,
      @UI.lineItem: [ { position : 70, importance: #MEDIUM , label: 'Description' }]
      @UI: { identification: [ { position: 70, label: 'Description' } ]}
      description,
      @UI.lineItem: [ { position : 80, importance: #MEDIUM , label: 'Lien certificat' }]
      @UI: { identification: [ { position: 80, label: 'Lien certificat' } ]}
      liencertificat,
      @UI.lineItem: [ { position : 90, importance: #MEDIUM , label: 'Created_by' }]
      @UI: { identification: [ { position: 90, label: 'Created_by' } ]}
      created_by,
      @UI.lineItem: [ { position : 100, importance: #MEDIUM , label: 'Created_at' }]
      @UI: { identification: [ { position: 100, label: 'Created_at' } ]}
      created_at,
      @UI: { identification: [ { position: 110, label: 'Last_changed_by' } ]}
      last_changed_by,
      @UI: { identification: [ { position: 120, label: 'Last_changed_at' } ]}
      last_changed_at
      }

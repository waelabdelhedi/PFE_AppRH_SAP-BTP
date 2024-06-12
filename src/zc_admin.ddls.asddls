@EndUserText.label: 'Projection View for Administrateur'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
  headerInfo: {
    typeName: 'Administrateur Details',
    typeNamePlural: 'Administrateur Details',
    title: {
      type: #STANDARD,
      label: 'Administrateur Details',
      value:'poste'
      }      
    }
  }

define view entity ZC_ADMIN
  as projection on ZI_ADMIN
{
      @UI.facet: [ { id:          'Administrateur',
              purpose:         #STANDARD,
              type:            #IDENTIFICATION_REFERENCE,
              label:           'Administrateur Details',
              position:        10 } ]

      @UI.identification: [ { position: 10,  label : 'UuidAdministrateur'   }]
      @UI.hidden: true
  key uuid,
      @UI.identification: [ { position: 15, label : 'KeyParent' }]
      @UI.hidden: true
      keyparent,
      @UI : { lineItem : [ { position : 20, importance: #HIGH , label: 'Poste' }], identification: [ { position: 20,  label : 'Poste'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_POSTE', element: 'Poste' }  }]                                        
      poste,
      @UI : { lineItem : [ { position : 30, importance: #HIGH , label: 'Date debut' }], identification: [ { position: 30,  label : 'Date debut'   }]}
      datedebut,
      mimetype,
      filename,
      @UI : { lineItem : [ { position : 40, importance: #HIGH , label: 'CV' }], identification: [ { position: 40,  label : 'CV'   }]}
      cv,
      lastchangedat,
      _userS : redirected to parent ZC_USER_Stagiaire
}

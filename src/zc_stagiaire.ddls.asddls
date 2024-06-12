@EndUserText.label: 'Projection View for Stagiaire'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
  headerInfo: {
    typeName: 'Stagiaire Details',
    typeNamePlural: 'Stagiaire Details',
    title: {
      type: #STANDARD,
      label: 'Stagiaire Details', 
      value:'departement'},
      description:{ type: #STANDARD, label: 'Stagiaire Details', value:'ecole'
    }
  }
}
define view entity ZC_STAGIAIRE
  as projection on ZI_STAGIAIRE
{
      @UI.facet: [ { id:          'Stagiaire',
                  purpose:         #STANDARD,
                  type:            #IDENTIFICATION_REFERENCE,
                  label:           'Stagiaire Details',
                  position:        10 } ]

      @UI.identification: [ { position: 10,  label : 'UuidStagiaire'   }]
      @UI.hidden: true
  key uuid,
      @UI.identification: [ { position: 15, label : 'KeyParent' }]
      @UI.hidden: true
      keyparent,
      @UI : { lineItem : [ { position : 20, importance: #HIGH , label: 'Duree' }], identification: [ { position: 20,  label : 'Duree'   }]}
      duree,
      @UI : { lineItem : [ { position : 30, importance: #HIGH , label: 'Date debut' }], identification: [ { position: 30,  label : 'Date debut'   }]}
      datedebut,
      @UI : { lineItem : [ { position : 40, importance: #HIGH , label: 'Date fin' }], identification: [ { position: 40,  label : 'Date fin'   }]}
      datefin,
      @UI : { lineItem : [ { position : 50, importance: #HIGH , label: 'Ecole' }], identification: [ { position: 50,  label : 'Ecole'   }]}
      ecole,
      @UI : { lineItem : [ { position : 60, importance: #HIGH , label: 'Departement' }], identification: [ { position: 60,  label : 'Departement'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_DEPARTEMENT', element: 'departement' }  }]                                      
      departement,
      mimetype,
      filename,
      @UI : { lineItem : [ { position : 70, importance: #HIGH , label: 'CV' }], identification: [ { position: 70,  label : 'CV'   }]}
      cv,
      lastchangedat,
      _userS : redirected to parent ZC_USER_Stagiaire
}

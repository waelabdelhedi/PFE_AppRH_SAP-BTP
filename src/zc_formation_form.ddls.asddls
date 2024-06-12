@EndUserText.label: 'Projection View for Formulaire Formation'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@UI: {
  headerInfo: {
//    typeName: 'Formulaire Formation'
    typeNamePlural: 'Formulaire Formation',
    title: {
      type: #STANDARD,
      label: 'Formulaire Formation',
      value: 'Sujet'
    }
  }
}


define root view entity ZC_FORMATION_Form
  provider contract transactional_query
  as projection on ZI_FORMATION_Form
{
      @UI.facet : [ { id:              'idIdentification',
                 purpose:         #STANDARD,
                 type:            #IDENTIFICATION_REFERENCE,
                 label:           'Formulaire demande de formation',
                 position:        10
                 } ]

          //  @UI : { lineItem : [ { position : 10, importance: #MEDIUM, label: 'Uuid' } ],
      @UI: { identification: [ { position: 10, label: 'Uuid' } ]}
      @UI.hidden: true
  key Uuid,
         //   @UI : { lineItem : [ { position : 15, importance: #MEDIUM, label: 'FormationId'} ],
        @UI: { identification: [ { position: 15, label: 'FormationId' } ]}
        @UI.hidden: true
      FormationId,
        //    @UI.lineItem: [ { position : 20, importance: #MEDIUM , label: 'Sujet' }]
           @UI.identification: [ { position: 20,  label : 'Sujet'   }]
      Sujet,
          // @UI.lineItem: [ { position : 30, importance: #MEDIUM , label: 'Formateur' }]
          @UI.identification: [ { position: 30,  label : 'Formateur'   }]
        //@UI.hidden: true
      Formateur,
        // @UI.lineItem: [ { position : 40, importance: #MEDIUM , label: 'Modalite' }]
         @UI.identification: [ { position: 40,  label : 'Modalite'   }]
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_MOD_FORMA', element: 'Modalite' }  }]
           // @UI.hidden: true
      Modalite,
        // @UI.lineItem: [ { position : 50, importance: #MEDIUM , label: 'DateDebut' }]
          @UI.identification: [ { position: 50,  label : 'Date debut'   }]
          //  @UI.hidden: true   
      DateDebut,
        // @UI.lineItem: [ { position : 60, importance: #MEDIUM , label: 'DateFin' }]
         @UI.identification: [ { position: 60,  label : 'Date fin'   }]
     // @UI.hidden: true
      DateFin,
      @UI: { identification: [ { position: 60, label: 'Created_by' } ]}
      
      created_by,
      @UI: { identification: [ { position: 70, label: 'Created_at' } ]}
     
      created_at,
      @UI: { identification: [ { position: 80, label: 'last_changed_by' } ]}
      @UI.hidden: true
      last_changed_by,
      @UI: { identification: [ { position: 90, label: 'last_changed_at' } ]}
      @UI.hidden: true
      last_changed_at
}

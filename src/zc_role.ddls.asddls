@EndUserText.label: 'Projection View for Role'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
  headerInfo: {
    typeName: ' Roles',
    typeNamePlural: ' Roles',
    title: {
      type: #STANDARD,
      label: ' Roles',value:'nomrole'},
      description:{ type: #STANDARD, label: ' Roles', value:'nom'
    }
  }
}
define root view entity ZC_ROLE
  provider contract transactional_query as projection on ZI_ROLE    
{
          @UI.facet: [ { id:              'Role',
                 purpose:         #STANDARD,
                 type:            #IDENTIFICATION_REFERENCE,
                 label:           'Role Details',
                 position:        10 } ]
     

   @UI.identification: [ { position: 10,  label : 'UuidRole'   }]
   @UI.hidden: true
     key uuid,
      @UI : { lineItem : [ { position : 15, importance: #HIGH, label: 'RoleId'} ],
      identification: [ { position: 15, label : 'RoleId' }]}
      @UI.hidden: true
      roleid,
      @UI : { lineItem : [ { position : 20, importance: #HIGH , label: 'Nom' }], identification: [ { position: 20,  label : 'Nom'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_USER_Stagiaire', element: 'nom' }  }] 
      nom,
//      @UI : { lineItem : [ { position : 30, importance: #HIGH , label: 'Prenom' }], identification: [ { position: 30,  label : 'Prenom'   }]}
//      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_USER_Stagiaire', element: 'prenom' }  }] 
//      prenom,
      @UI : { lineItem : [ { position : 40, importance: #HIGH , label: 'Poste' }], identification: [ { position: 40,  label : 'Poste'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_PosteRole', element: 'Poste' }  }] 
      poste,
      @UI : { lineItem : [ { position : 50, importance: #HIGH , label: 'Role' }], identification: [ { position: 50,  label : 'Role'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_NomRole', element: 'Role' }  }]     
      nomrole,
      @UI : { lineItem : [ { position : 60, importance: #HIGH , label: 'Niveau Acces' }], identification: [ { position: 60,  label : 'Niveau Acces'   }]}
      @Consumption.valueHelpDefinition: [{ entity: { name:'ZI_NiveauAcces', element: 'Niveauacces' }  }]     
      niveauacces,
      @UI: { identification: [ { position: 70, label: 'Created_by' } ]}
      created_by,
      @UI: { identification: [ { position: 80, label: 'Created_at' } ]}
      created_at,
      @UI: { identification: [ { position: 90, label: 'Last_changed_by' } ]}
      last_changed_by,
      @UI: { identification: [ { position: 100, label: 'Last_changed_at' } ]}
      last_changed_at
}

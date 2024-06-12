@EndUserText.label: 'Projection View for CV Demande Emploi'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
  headerInfo: {
    typeName: 'CV',
    typeNamePlural: 'CV',
    title: {
      type: #STANDARD,
      label: 'CV'},
      description:{ type: #STANDARD, label: 'CV'
    }
  }
}
define view entity ZC_DEMEMPLOI_ATTACHMENT
 // provider contract transactional_query
  /*provider contract transactional_query*/ as projection on ZI_DEMEMPLOI_ATTACHMENT
{
    @UI.facet: [ { id:          'Cv',
                   purpose:         #STANDARD,
                   type:            #IDENTIFICATION_REFERENCE,
                   label:           'ZC_DEMEMPLOI_ATTACHMENT',
                   position:        10 } ]

   @UI : { lineItem : [ { position : 10, importance: #MEDIUM , label: 'Uuid' }], identification: [ { position: 10,  label : 'Uuid'   }]}
  key Uuid,
       @UI : { lineItem : [ { position : 15, importance: #MEDIUM, label: 'Keyparent'} ],
      identification: [ { position: 15, label : 'Keyparent' }]}
      Keyparent,
       //@UI.hidden: true
      
      Mimetype,
        //@UI.hidden: true
      
      Filename,
        // @UI : { lineItem : [ { position : 20, importance: #MEDIUM , label: 'Doc' }], identification: [ { position: 20,  label : 'Doc'   }]}
        @UI : { fieldGroup:     [ { position: 20, qualifier: 'Upload' , label: 'Doc'} ]}
      Cv,
     // @UI.hidden: true
      LocalLastChangedAt   
      
      
      
      
      
          //  _demandeEmploi : redirected to parent ZC_LT_DEMANDECF
      
}

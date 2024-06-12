@EndUserText.label: 'Attachment'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
     headerInfo: { typeName: 'CV Details',
                     typeNamePlural: 'CV Details'
                     //title: {  type: #STANDARD, label: 'CV Details' },
                  //   description:{ type: #STANDARD, label: 'CV Details'}
                     }
                     }
define view entity ZC_ATTACHMENT_V2 as projection on ZI_ATTACHMENT_V2
{
      @UI.facet: [ {  id : 'Attachment',
               purpose : #STANDARD,
               type: #IDENTIFICATION_REFERENCE,
               label: 'CV Details',
               position: 10
               } ]

      @UI.identification: [ { position: 10,  label : 'Uuid'   }]
      @UI.hidden: true
  key uuid,

      @UI.identification: [ { position: 15, label : 'keyparent' }]
      @UI.hidden: true
      keyparent,

//      @UI : { lineItem : [ { position : 20, importance: #HIGH} ],
//            identification: [ { position: 20, label : 'id_attachment' }]}
//     id_attachment,
//      @UI : { lineItem : [ { position : 30, importance: #HIGH} ],
//          identification: [ { position: 30, label : 'comments' }]}
//      comments,
      @UI : { lineItem : [ { position : 20, importance: #HIGH, label : 'CV'} ],
      identification: [ { position: 20, label : 'CV'}]}
      attachment,

      mimetype,

      filename ,
      
      lastchangedat,
      
      _DemandeEmploi : redirected to parent ZC_STUDENTT
            
}

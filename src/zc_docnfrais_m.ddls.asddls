@EndUserText.label: 'Projection View for Doc Note Frais (M)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

@UI: {
     headerInfo: { typeName: 'Document Details',
                     typeNamePlural: 'Document Details'
//                     title: {  type: #STANDARD, label: 'CV Details' },
//                     description:{ type: #STANDARD, label: 'CV Details'}
                     }
                     }
                     
define view entity ZC_docnfrais_M as projection on ZI_docnfrais_M
{
      @UI.facet: [ {  id : 'Attachment',
               purpose : #STANDARD,
               type: #IDENTIFICATION_REFERENCE,
               label: 'Document Details',
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
      @UI : { lineItem : [ { position : 20, importance: #HIGH, label : 'Document'} ],
      identification: [ { position: 20, label : 'Document'}]}
      attachment,

      mimetype,

      filename ,
      
      lastchangedat,
      
      _notefrais : redirected to parent ZC_LT_NOTEFRAIS
}

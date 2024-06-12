@EndUserText.label: 'Projection View for Note Frais (Consulter)'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true

//@UI: {
//  headerInfo: {
//    typeName: 'Note de frais',
//    typeNamePlural: 'Les notes de frais', 
//    title: {
//      type: #STANDARD,
//      label: 'Note Frais Details'},
//      description:{ type: #STANDARD, label: 'Note Frais Details', value: 'motif'
//    }
//  }
//}
@UI: {
     headerInfo: { typeName: 'Note de frais',
                     typeNamePlural: 'Notes de frais',
                     title: {  type: #STANDARD, label: 'Note de frais', value: 'Motif' }
                     }
                     }
define root view entity ZC_LT_NOTEFRAIS_CONSULTER
  provider contract transactional_query as projection on ZR_LT_NOTEFRAIS_CONSULTER
{
     @UI.facet: [ { id:          'idIdentification',
                  purpose:         #STANDARD,
                  type:            #IDENTIFICATION_REFERENCE,
                  label:           'Note de frais',
                  position:        10 },
                                             { id : 'StudentData',
           purpose : #STANDARD,
           type: #LINEITEM_REFERENCE,
           label: 'Document Details',
           position: 20,
           targetElement: '_docnfrais'     } ]

      @UI.identification: [ { position: 10,  label : 'Uuid'   }]
      @UI.hidden: true
  key Uuid,
      @UI : { lineItem : [ { position : 15, importance: #MEDIUM, label: 'NoteFraisId'} ],
      identification: [ { position: 15, label : 'NoteFraisId' }]}
      @UI.hidden: true
      NotefraisId,
      @UI : { lineItem : [ { position : 20, importance: #MEDIUM , label: 'Motif' }], identification: [ { position: 20,  label : 'Motif'   }]}
      Motif,

      //      Mimetype,
      //
      //      Filename,
      @UI : { lineItem : [ { position : 30, importance: #MEDIUM , label: 'Montant' }], identification: [ { position: 30,  label : 'Montant'   }]}
      Montant,
//      @UI : { lineItem : [ { position : 40, importance: #MEDIUM , label: 'DateNoteFrais' }], identification: [ { position: 40,  label : 'DateNoteFrais'   }]}
//      @UI.hidden: true
//      DateNoteFrais,
      //        @UI : { lineItem : [ { position : 50, importance: #MEDIUM , label: 'Document' }], identification: [ { position: 50,  label : 'Document'   }]}
      //      Document,
             @UI : { lineItem : [ { position : 40, importance: #MEDIUM , label: 'Created_by' }], identification: [ { position: 40, label: 'Created_by' } ]}
            created_by, 
             @UI : { lineItem : [ { position : 50, importance: #MEDIUM , label: 'Created_at' }], identification: [ { position: 50, label: 'Created_at' } ]}
            Created_at,
      //      @UI: { identification: [ { position: 70, label: 'last_changed_by' } ]}
      //      last_changed_by,
//             @UI : { lineItem : [ { position : 60, importance: #MEDIUM , label: 'Last_changed_at' }], identification: [ { position: 60, label: 'Last_changed_at' } ]}
//            Last_changed_at,
      //      @UI.hidden: true
      //      lastchangedat,
//      @UI.hidden: true
//      LocalLastChanged
_docnfrais : redirected to composition child ZC_docnfrais_consulter
}

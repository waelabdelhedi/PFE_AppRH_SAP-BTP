@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Conge (Consulter)'
define root view entity ZI_CONGEE_CONSULTER as select from zpfe_congee
//composition of target_data_source_name as _association_name
{
    
 //   @EndUserText.label: 'mykey'
     key mykey,
// @EndUserText.label: 'congeid'
      congeid,
    //@EndUserText.label: 'type'
   // @ObjectModel.text.element: ['type']
      type,
     // @EndUserText.label: 'datedebut'
      datedebut,
   // @EndUserText.label: 'datefin'
      datefin,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at
      
      
      }

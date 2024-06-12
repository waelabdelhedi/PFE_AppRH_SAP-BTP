@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Certif (Consulter)'
define root view entity ZI_CERTIF_CONSULTER as select from zpfe_certif
//composition of target_data_source_name as _association_name
{
    
  key uuidcertif,
      certifid,
      nom,
      organisme,
      dateobtention,
      dateexpiration,
      description,
      liencertificat,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at
      }

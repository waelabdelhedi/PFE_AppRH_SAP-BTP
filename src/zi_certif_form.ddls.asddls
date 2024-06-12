@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Formulaire Certif'
define root view entity ZI_CERTIF_FORM as select from zpfe_certif
//composition of target_data_source_name as _association_name
{
    
 key uuidcertif as UuidCertif,
      certifid as CertifId,
      nom as Nom,
      organisme as Organisme,
      dateobtention as DateObtention,
      dateexpiration as DateExpiration,
      description as Description,
      liencertificat as LienCertificat,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at
      }

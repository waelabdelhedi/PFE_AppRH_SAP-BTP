@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Note Frais'
define root view entity ZR_LT_NOTEFRAIS as select from zpfe_nfrais
 composition [0..*] of ZI_docnfrais_M as _docnfrais 
{
    
      key uuid as Uuid,
      notefraisid as NotefraisId,
      motif as Motif,
      montant as Montant,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at as Created_at,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at as Last_changed_at,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      locallastchangedat,
      lastchangedat,
      _docnfrais
}

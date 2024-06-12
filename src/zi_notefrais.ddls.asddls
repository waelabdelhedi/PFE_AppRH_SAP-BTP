@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Note Frais (Form)'
define root view entity ZI_NoteFrais
  as select from zpfe_nfrais
  composition [0..*] of ZI_docnfrais as _docnfrais
{
  key uuid,
      notefraisid,
      motif,
      montant,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,
      locallastchangedat,
      lastchangedat,
      _docnfrais
}

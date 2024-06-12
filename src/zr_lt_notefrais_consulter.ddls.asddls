@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View for Note Frais (Consulter)'
define root view entity ZR_LT_NOTEFRAIS_CONSULTER as select from zpfe_nfrais
 composition [0..*] of ZI_docnfrais_consulter as _docnfrais 
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
      locallastchangedat,
      lastchangedat,
      _docnfrais
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STUDENT'
define root view entity ZI_STUDENTT as select from zpfe_dememp
composition [0..*] of ZI_ATTACHMENT_V2 as _CV
{

  key uuid         ,
  id             ,
  postesouhaite              ,
  specialisation            ,
  experience,
  disponibilite,
  locallastchangedat,
  lastchangedat ,
  _CV
  
}

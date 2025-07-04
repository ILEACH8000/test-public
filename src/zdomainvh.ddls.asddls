@AbapCatalog.sqlViewName: 'ZDOMAINVH_V'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ドメインテキストビュー'
define view ZDOMAINVH 
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                      p_domain_name : 'Z_ITEMTYPE') as Values
    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                      p_domain_name : 'Z_ITEMTYPE') as Texts
      on  Texts.domain_name    = Values.domain_name
      and Texts.value_position = Values.value_position
      and Texts.language       = $session.system_language
{
  key Values.value_low as Staging,
      Texts.text       as Description,
      dats_is_valid ( '20231111' ) as aaa,
      dats_is_valid ( '20231211' ) as bbb,
      dats_add_days ('20250101',7,'FAIL') as add_7_days,
//      dats_days_between('20231101', $session.system_date) as duration
      dats_days_between('20231101', '20250101') as duration,
      $session.system_date as zdate
}

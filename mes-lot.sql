select distinct planname
  from (
/* Find all the lots and show one of the lot attributes: LotClass */
  select l.productname, l.planname, lp.valdata, count(1),min(startdate)
          from fwlot l
          left join fwlot_pn2m lp
            on l.sysid = lp.fromid
           and lp.keydata = 'LotClass'
         where productname like '%#G8R2M1'
           and lottype = 'Fab'
         group by l.productname, l.planname, lp.valdata
         )

/*
 * Find the lots and associated attributes:
 *  1 - LotClass
 *  2 - Location
 *  3 - CustomerWaferPartNo (Material used by the lot)
 */
select upper(planname), upper(productname),lc.valdata as location, lw.valdata as wafernamne, case when instr(productname, '#' ) = 0 then 'NONE' else  upper(substr(productname, instr(productname, '#' ))) end as suffix , count(1), min(startdate), max(startdate)
  from fwlot l
  join fwlot_pn2m lp on l.sysid=lp.fromid and lp.keydata='LotClass'
  join fwlot_pn2m lc on l.sysid=lc.fromid and lc.keydata='Location'
  join fwlot_pn2m lw on l.sysid=lw.fromid and lw.keydata='CustomerWaferPartNo'
 where startdate > '20160401'
   and lottype = 'Fab' 
   and lp.valdata='Production'
 group by upper(planname), upper(productname),lc.valdata, lw.valdata ,case when instr(productname, '#' ) = 0 then 'NONE' else  upper(substr(productname, instr(productname, '#' ))) end
/* All the wafer service lots that is started recently after 20170401 */
select * from fwlot where lottype <> 'Fab' and startdate > '20170401';
/* Find all the lot extended attributes for one lot */
select * from fwlot_pn2m where fromid = '00000e31.ac1415d2.58e472eb.00004502.4392165'
/* Find a lot by its sysid, primary key, which is also used as foreighn key in lot attributes */
select * from fwlot where sysid = '00000e31.ac1415d2.58e472eb.00004502.4392165'
/* Find all the lot extended attributes for one lot */
select * from fwlot_pn2m where fromid = '00000e31.ac1415d2.58e5bfbf.00004502.4677942'
/* Checking the location from one lot */
select l.appid,lp.valdata as location
from fwlot l
join fwlot_pn2m lp on l.sysid=lp.fromid and lp.keydata= 'Location'
where l.appid='SFG0477'


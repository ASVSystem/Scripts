SELECT distinct --v.NR_ATENDIMENTO,
    v.nr_prescricao,
    v.cd_item cd_material,
	v.DS_ITEM,
	v.qt_prescrita total_prescrito,
    v.qt_checados total_checado,
	sum(v.qt_devolvida) total_devolvido,
   obter_valor_dominio(46,d.CD_MOTIVO_DEVOLUCAO) motivo_devolucao
  

from prescr_medica p
  join PRESCR_MATERIAL_SIT_V v
 ON p.NR_PRESCRICAO = v.NR_PRESCRICAO
  JOIN ITEM_DEVOLUCAO_MATERIAL_PAC d
 ON v.CD_ITEM = d.CD_MATERIAL
 AND v.nr_prescricao = d.NR_PRESCRICAO

      
where p.dt_prescricao between to_date('21/05/2020 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('22/05/2020 23:59:59','dd/mm/yyyy hh24:mi:ss')
and v.CD_SETOR_ATENDIMENTO = 32
AND p.NR_PRESCRICAO = 2272797
--AND v.CD_ITEM =  4802
--1719

GROUP BY v.nr_prescricao,
    v.cd_item,
	v.DS_ITEM,
 	v.qt_prescrita,
	v.qt_checados,
   obter_valor_dominio(46,d.CD_MOTIVO_DEVOLUCAO)

ORDER BY v.nr_prescricao, v.ds_item

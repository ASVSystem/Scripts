SELECT COUNT(*) qt_itens,
substr(obter_valor_dominio(2116,d.ie_status_lote),1,120) ds_status_lote,
substr(obter_nome_setor(a.cd_setor_atendimento),1,120) ds_setor_atendimento,
OBTER_DESC_MES_ANO(d.dt_atend_lote,'ABM2' )MES_REFERENCIA


FROM	material b,
	
 prescr_material p,
 material_atend_paciente a,
 ap_lote d
WHERE 	d.DT_ATEND_LOTE between to_date('01/01/2019 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
	AND	to_date('30/08/2019 23:59:59','dd/mm/yyyy hh24:mi:ss')
and a.CD_LOCAL_ESTOQUE = 18
and d.IE_STATUS_LOTE not in ('C','CA','CO','S') 
and a.cd_material   = b.cd_material
--and a.nr_prescricao  = 1756080
and a.nr_prescricao  = d.NR_PRESCRICAO
and a.nr_prescricao  = p.nr_prescricao (+)
and a.nr_sequencia_prescricao = p.nr_sequencia (+)
--and nvl(a.nr_seq_lote_ap,0) = 4232796
and d.nr_sequencia   = a.nr_seq_lote_ap
and d.dt_atend_farmacia is not null

group by substr(obter_valor_dominio(2116,d.ie_status_lote),1,120), substr(obter_nome_setor(a.cd_setor_atendimento),1,120), OBTER_DESC_MES_ANO(d.dt_atend_lote,'ABM2' )
ORDER BY ds_setor_atendimento
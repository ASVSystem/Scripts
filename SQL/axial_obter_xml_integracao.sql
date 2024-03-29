select x.DS_XML

from LOG_INTEGRACAO_XML x
join LOG_INTEGRACAO i
on x.NR_SEQ_LOG = i.NR_SEQUENCIA

where x.DT_ATUALIZACAO between to_date('03/05/2019 00:00:00', 'DD/MM/YYYY HH24:MI:SS') 
	AND	to_date('03/05/2019 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
and i.NR_SEQ_INFORMACAO = 186
and i.IE_STATUS = 'P'
and x.IE_ENVIO_RETORNO = 'E'
and i.NR_SEQUENCIA = 2660945
order by x.DT_ATUALIZACAO




select obter_nm_arquivo_synapse(nr_prescricao),
verifica_se_integra_sinapse(nr_prescricao)
from PRESCR_MEDICA
where NR_PRESCRICAO = 1402450

-- 1401261 prescr integrada
1402268





select *
--NR_SEQUENCIA, SUBSTR(obter_dados_inf_integracao(nr_seq_informacao,''),1,255)
from LOG_INTEGRACAO
where NR_SEQ_INFORMACAO = 186

and DT_ATUALIZACAO between to_date('01/05/2019 00:00:00', 'DD/MM/YYYY HH24:MI:SS') 
	AND	to_date('25/05/2019 23:59:59', 'DD/MM/YYYY HH24:MI:SS') 
and NR_SEQUENCIA = 2662600



select * from
(SELECT CONVERT_LONG_TO_VARCHAR2('ds_xml','log_integracao_xml','NM_USUARIO = ''Tasy''') DS_XML FROM DUAL)
where ds_xml like '%NR_ATENDIMENTO%'



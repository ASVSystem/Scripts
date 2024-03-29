
SELECT count(*) QT_LOTE ,
 ds_status_lote STATUS_LOTE,
 ds_setor_atendimento,
 OBTER_DESC_MES_ANO(dt_atend_lote,'ABM2' )MES_REFERENCIA
 
FROM	(
SELECT a.nr_sequencia NR_SEQUENCIA,
	  a.nr_prescricao NR_PRESCRICAO,
	  p.nr_atendimento,
	  a.nr_seq_turno,
	  a.cd_local_estoque,
	  a.ie_status_lote ie_status_lote,
	  a.nr_seq_lote_sup,
	  a.dt_atend_lote dt_atend_lote,
	  a.dt_limite_atend dt_limite_atend,
	  a.dt_limite_disp_farm dt_limite_disp_farm,
	  a.dt_limite_entrega_setor dt_limite_entrega_setor,
	  a.dt_limite_receb_setor dt_limite_receb_setor,
	  a.dt_geracao_lote dt_geracao_lote,
	  a.dt_prim_horario dt_prim_horario,
	  a.dt_impressao dt_impressao,
	  a.ds_maquina_imp_aqui,
	  a.dt_impressao_aqui,
	  a.cd_setor_atendimento,
	  nvl(a.ie_reaprazado,'N') ie_reaprazado_grid,
	  substr(obter_desc_turno_disp(a.nr_seq_turno),1,255) ds_turno,
	  substr(obter_desc_classif_lote_disp(a.nr_seq_classif),1,80) ds_classificacao,
	  substr(obter_nome_pessoa_fisica(p.cd_pessoa_fisica, null),1,100) nm_paciente,
	  substr(obter_nome_setor(a.cd_setor_atendimento),1,120) ds_setor_atendimento,
	  a.dt_atend_lote dt_atend_lote_1,
	  substr(obter_valor_dominio(2116,a.ie_status_lote),1,120) ds_status_lote,
	  a.dt_prim_horario dt_prim_horario_h,
	  substr(obter_desc_local_estoque(a.cd_local_estoque),1,60) ds_local_estoque,
	  substr(obter_mot_cancel_lote_prescr(a.nr_seq_motivo_cancel),1,255) ds_motivo,
	  substr(obter_unidade_atendimento(p.nr_atendimento,'A', 'U'),1,255) ds_leito,
	  a.dt_limite_inicio_atend dt_limite_inicio_atend_1,
	  a.nr_seq_classif
FROM	atendimento_paciente p,
	 ap_lote a
WHERE obter_atendimento_prescr(a.nr_prescricao) = p.nr_atendimento(+) 
	AND	a.cd_local_estoque = 18 
	AND	a.ie_status_lote not in('C','CA','CO','S') 
	AND	a.dt_atend_lote between to_date('01/01/2019 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
	AND	to_date('31/08/2019 23:59:59','dd/mm/yyyy hh24:mi:ss')
ORDER BY a.dt_prim_horario,
	 nr_prescricao,
	 nr_sequencia )
group by  ds_setor_atendimento, ds_status_lote, OBTER_DESC_MES_ANO(dt_atend_lote,'ABM2' )
order by ds_setor_atendimento 





--SELECT * FROM ap_lote
--where NR_SEQUENCIA = 2743343
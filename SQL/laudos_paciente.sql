SELECT distinct  '' nome_executante, 
	 decode(prescr_proc.ie_urgencia,'S',Wheb_mensagem_pck.get_Texto(301323),'N','','') ie_urgencia,
	 '' dt_alta,
	 substr(obter_valor_dominio(12,	atend_pac.ie_tipo_atendimento),	1,	255) ds_tipo_atendimento,
	 substr(obter_valor_dominio(1372,prescr_proc.ie_lado),1,255) ds_lado,
	 prescr_med.cd_pessoa_fisica,
	 substr(obter_nome_pf(prescr_med.cd_pessoa_fisica),1,255) nm_pessoa_fisica,
	substr(obter_prontuario_pf(prescr_med.cd_estabelecimento,pes_fis.cd_pessoa_fisica),1,255) nr_prontuario,
	 proc_pac.cd_setor_atendimento,
	 laudo_pac.cd_setor_execucao,
	 prescr_med.nr_atendimento,
	 prescr_proc.nr_prescricao,
	 prescr_proc.cd_procedimento,
	 substr(nvl(obter_desc_proc_interno(prescr_proc.nr_seq_proc_interno),obter_desc_procedimento(prescr_proc.cd_procedimento,prescr_proc.ie_origem_proced)),1,255) ds_exame,
	 laudo_pac.nr_sequencia nr_laudo,
	 laudo_pac.nm_usuario_aprovacao,
	 laudo_pac.dt_impressao,
	 laudo_pac.dt_integracao,
	 substr(obter_valor_dominio(1226,prescr_proc.ie_status_execucao),1,	255) ds_status,
	 prescr_proc.ie_status_execucao,
	 substr(obter_nome_pessoa_fisica(laudo_pac.cd_medico_resp,null),1,255) nome_medico_resp,laudo_pac.dt_laudo, substr(obter_pessoa_fisica_usuario(laudo_pac.nm_usuario_aprovacao,'N'),1,255) nome_usuario_aprovacao,
	 laudo_pac.dt_aprovacao,
	 substr(obter_pessoa_fisica_usuario(laudo_pac.nm_usuario_seg_aprov,'N'),1,255) nome_usuario_seg_aprov,laudo_pac.dt_seg_aprovacao,substr(obter_pessoa_fisica_usuario(laudo_pac.nm_usuario_digitacao,'N'),1,255) nome_usuario_digitacao,
	 laudo_pac.dt_inicio_digitacao,
	 laudo_pac.cd_resp_seg_aprov,
	--------------------------
	 (SELECT decode(count(*),0,obter_desc_expressao(872188),obter_desc_expressao(872184)) 
FROM	atend_exame_trazido t
WHERE nr_atendimento = prescr_med.nr_atendimento 
	AND	t.ie_importado_pacs = 'S') ie_importado_pacs

FROM	prescr_procedimento prescr_proc inner join prescr_medica prescr_med  on prescr_proc.nr_prescricao = prescr_med.nr_prescricao left join procedimento_paciente proc_pac  on prescr_proc.nr_prescricao = proc_pac.nr_prescricao  
	AND	prescr_proc.nr_sequencia = proc_pac.nr_sequencia_prescricao left join lista_central_exame lst_cent  on prescr_proc.nr_prescricao = lst_cent.nr_prescricao  
	AND	prescr_proc.nr_sequencia = lst_cent.nr_sequencia_prescricao left join lista_central_medico lst_cent_med  on lst_cent_med.nr_sequencia = lst_cent.nr_seq_lista_medico left join laudo_paciente laudo_pac  on proc_pac.nr_laudo = laudo_pac.nr_sequencia left join laudo_paciente_compl laudo_pac_compl  on laudo_pac.nr_sequencia = laudo_pac_compl.nr_seq_laudo left join atendimento_paciente atend_pac  on prescr_med.nr_atendimento = atend_pac.nr_atendimento inner join atend_categoria_convenio atend_cat_conv  on atend_pac.nr_atendimento = atend_cat_conv.nr_atendimento inner join pessoa_fisica pes_fis  on atend_pac.cd_pessoa_fisica = pes_fis.cd_pessoa_fisica inner join procedimento proc  on prescr_proc.cd_procedimento = proc.cd_procedimento  
	AND	prescr_proc.ie_origem_proced = proc.ie_origem_proced left join conta_paciente conta_pac  on proc_pac.nr_interno_conta = conta_pac.nr_interno_conta left join agenda_paciente agenda_pac  on prescr_proc.nr_seq_agenda = agenda_pac.nr_sequencia left join prescr_proc_ditado prescr_proc_dit  on prescr_proc.nr_seq_interno = prescr_proc_dit.nr_seq_prescr_proc left join solicitacao_exame_compl exc on exc.nr_prescricao = prescr_proc.nr_prescricao  
	AND	exc.nr_seq_prescr = prescr_proc.nr_sequencia 
	AND	exc.nr_atendimento = prescr_med.nr_atendimento left join lista_equipe_med_exec lst_esp on lst_esp.nr_prescricao = prescr_proc.nr_prescricao  
	AND	lst_esp.nr_seq_prescricao = prescr_proc.nr_sequencia left join radiacao_efetiva_proced rad_efec_proc on prescr_proc.nr_prescricao = rad_efec_proc.nr_prescricao  
	AND	prescr_proc.nr_sequencia = rad_efec_proc.nr_seq_prescricao
WHERE proc_pac.qt_procedimento > 0 
	AND	nvl(conta_pac.ie_cancelamento,'N') = 'N' 
	AND	coalesce(atend_cat_conv.nr_seq_interno,0) = coalesce(obter_atecaco_atendimento(atend_cat_conv.nr_atendimento),0) 
	AND	prescr_proc.dt_suspensao is null 
	AND	atend_pac.dt_cancelamento is null 
	AND	((prescr_proc_dit.nr_sequencia is null) OR (prescr_proc_dit.nr_sequencia in (SELECT max(nr_sequencia)
FROM	prescr_proc_ditado

WHERE prescr_proc.nr_seq_interno = prescr_proc_ditado.nr_seq_prescr_proc))) 
	AND	prescr_proc.ie_status_execucao in ('20','30','40') 
	AND	prescr_proc.dt_baixa between to_date('01/04/2019 00:00:00', 'DD/MM/YYYY HH24:MI:SS') 
	AND	to_date('01/04/2019 23:59:59', 'DD/MM/YYYY HH24:MI:SS') 
	AND	proc_pac.cd_setor_atendimento in (43,47)
ORDER BY NR_ATENDIMENTO asc 
SELECT a.*,
	  SUBSTR(a.ds_observacao,1,255) ds_observacao_grid,
	       SUBSTR(a.ds_obs_enfermagem,1,255) ds_obs_enf,
	  NVL(a.dt_liberacao,a.dt_liberacao_medico) dt_liberacao_prescr,
	  SUBSTR(obter_nome_pf(m.cd_pessoa_fisica),1,255) nm_medico,
	  SUBSTR(obter_valor_dominio(9,a.ie_origem_inf),1,100) ds_origem_inf,
	  SUBSTR(obter_funcao_usuario_orig(a.nm_usuario_original),1,240)     ds_funcao_prescritor,
	  SUBSTR(obter_itens_prescr(a.nr_prescricao, a.DS_ITENS_PRESCR),1,255) ds_item,
	  SUBSTR(obter_nome_pf(p.cd_pessoa_fisica),1,60) nm_paciente,
	  SUBSTR(obter_nome_pf(a.cd_farmac_lib),1,60) nm_farmaceutico,
	  SUBSTR(obter_desc_status_farm(nr_seq_status_farm),1,100) ds_status_farm,
	  s.ds_setor_atendimento,
	  obter_se_prioridade_revisao(nr_prescricao) ie_urgente,
	   s.ds_ocup_hosp,
	   SUBSTR(obter_se_atend_reconciliacao(a.nr_atendimento),1,1) ie_reconciliacao,
	   SUBSTR(obter_dados_pac_setor_prescr(nr_prescricao,'O'),1,255) ds_obs_quimio,
	   SUBSTR(obter_valor_dominio(136,a.ie_motivo_prescricao),1,100)     ds_motivo_prescricao,
	   SUBSTR(Obter_Unidade_Atendimento(nr_atendimento,'A','U'),1,100)  ds_unidade,
	   obter_se_prioridade_revisao(nr_prescricao) ie_prioridade_revisao,
	   a.nm_usuario nm_usuario_grid,
	   a.nm_usuario_original nm_usuario_original_grid,
	   TO_CHAR(a.dt_inicio_analise_farm,'dd/mm/yyyy hh24:mi:ss') dt_inicio_anal_farm,
	   NVL(a.ie_prescricao_identica,'N') ie_copia_identica,
	   NVL(a.ie_prescr_farm,'N') ie_prescr_farm_grid,
	   obter_prescr_interv_farmacia(a.nr_prescricao) nr_prescr_intervencao,
	   obter_prescr_interv_farm_lib(a.nr_prescricao) ie_prescr_interv_lib,
	  nm_usuario_analise_farm nm_usuario_farm,
	  obter_prim_prescr_mat_hor_nd(a.nr_prescricao, 'S', null) DT_PRIM_PRESC_MAT_HOR_OBTER,
	   SUBSTR(Obter_Dados_Atendimento(a.nr_atendimento,'DE'),1,255) dt_atendimento_s,
	  SUBSTR(Obter_Dados_Atendimento(a.nr_atendimento,'DAM'),1,255) dt_alta_medico,
	   SUBSTR(obter_reconciliacao_atend(a.nr_atendimento),1,1) ie_forma_reconciliacao_s,
	   s.cd_classif_setor,
	  SUBSTR(obter_disp_pac_atend(a.nr_atendimento),1,255) ds_dispositivo,
	  obter_prontuario_paciente(a.cd_pessoa_fisica) nr_prontuario,
	  TO_CHAR(dt_inicio_prescr,'dd/mm/yyyy hh24:mi:ss') dt_inicio_validade,
	  TO_CHAR(dt_validade_prescr,'dd/mm/yyyy hh24:mi:ss') dt_fim_validade,
	  /*a.qt_peso qt_peso,
	 retirado jonathas OS 464636*/  a.qt_altura_cm qt_altura,
	  /*a.qt_creatinina qt_creatinina retirado jonathas OS 464636*/  TO_CHAR(obter_data_assinatura_digital(a.nr_seq_assinatura_farm),'dd/mm/yyyy hh24:mi:ss') dt_assinatura,
	  SUBSTR(a.ds_justificativa,1,255) ds_justificativa2,
	  SUBSTR(obter_valor_dominio(1962,IE_HEMODIALISE),1,90) ds_hemo,
	  Obter_Sexo_PF(a.cd_pessoa_fisica,'D') ds_sexo,
	  SUBSTR(obter_idade(p.dt_nascimento, SYSDATE, 'S'),1,25) qt_idade,
	    SUBSTR(obter_se_medic_possui_obj_uso(a.nr_prescricao,''),1,5) ie_objetivo_uso,
	  a.DT_LIBERACAO_MEDICO dt_lib_medico,
	  SUBSTR(obter_nome_pf(a.cd_farmac_lib_parc),1,150) nm_farmaceutico_parc,
	   TO_CHAR(dt_inicio_prescr,'dd/mm/yyyy hh24:mi:ss') dt_ini_prescr_apraza,
	  SUBSTR(Obter_Legenda_Idade(a.cd_pessoa_fisica),1,10) ds_cor_legenda_urgente,
	   SUBSTR(obter_nome_pf(a.cd_prescritor),1,60) nm_prescritor,
	  obter_se_verifica_alergico(a.nr_prescricao, a.nm_usuario, a.cd_estabelecimento) ie_alergico,
	  nvl(a.ie_prescricao_duplicada,'N') ie_prescr_duplicada,
	  SUBSTR(obter_prescr_medica_complem(a.nr_prescricao),1,1) IE_LIBERACAO_CPOE
FROM	setor_atendimento s,
	 pessoa_fisica m,
	 pessoa_fisica p,
	  prescr_medica a
WHERE dt_liberacao IS NOT NULL 
	AND	a.cd_pessoa_fisica = p.cd_pessoa_fisica 
	AND	a.cd_medico = m.cd_pessoa_fisica 
	AND	a.cd_setor_atendimento = s.cd_setor_atendimento (+) 
	AND	 a.dt_suspensao IS NULL 
	AND	Obter_itens_prescr_filtro('1, 2, 3, 4', A.NR_PRESCRICAO) = 'S' 
	AND	a.cd_setor_atendimento = 32 
	AND	cd_classif_setor in (1,2,3,4,5) 
	AND	exists (SELECT 1
FROM	prescr_material b
WHERE a.nr_prescricao = b.nr_prescricao) 
	AND	obter_se_medico(a.cd_prescritor,'M') = 'S' 
	AND	(a.dt_prescricao between TO_DATE('28/10/2019 07:00:00', 'dd/MM/yyyy hh24:mi:ss') 
	AND	TO_DATE('28/10/2019 16:00:00' , 'dd/MM/yyyy hh24:mi:ss'))
ORDER BY obter_prim_prescr_mat_hor(a.nr_prescricao) 
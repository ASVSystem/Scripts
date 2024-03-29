SELECT TO_CHAR(a.ds_ocupacao) ds_ocupacao,
	 a.cd_unidade,
	  a.ie_status_unidade,
	  a.ie_sexo,
	  a.ie_temporario,
	  cd_setor_atendimento,
	  cd_unidade_basica,
	  cd_unidade_compl,
	  (SELECT NVL(MAX(b.ie_paciente_isolado),'N') 
FROM	atendimento_paciente b 
WHERE b.nr_atendimento = a.nr_atendimento) ie_paciente_isolado,  
a.nr_seq_interno,  a.ie_radioterapia,  a.ie_tipo_reserva, TO_NUMBER(obter_status_leito_ocupacao(  (SUBSTR(Obter_Status_Isolamento_Ocup(1, nr_atendimento, ie_acompanhante, 'avictor'),1,1)),  SUBSTR(obter_classif_etaria(1,cd_pessoa_fisica,'C'),1,3),  DECODE(a.cd_pessoa_fisica, NULL, a.ie_sexo_paciente, a.ie_sexo),  ie_status_unidade, ie_temporario,  dt_alta_medico, 'S',  nr_atend_alta, ie_radiacao,  ie_interditado_radiacao,  DECODE('N','S',a.dt_previsto_alta,NULL),  obter_se_alta_tesouraria2(a.nr_atendimento, a.cd_setor_atendimento, a.cd_unidade_basica, a.cd_unidade_compl), NULL, a.nr_seq_interno)) nr_status, verificar_se_detento(a.cd_pessoa_fisica) ie_detento, a.ie_reserva_pa, to_char(a.dt_inicio_higienizacao,'dd/MM/yyyy HH:mi:ss') dt_inicio_higienizacao, SUBSTR(obter_valor_dominio(1267,a.ie_probabilidade_alta),1,40) ds_probabilidade, a.ie_probabilidade_alta, a.dt_previsto_alta, DECODE(a.cd_pessoa_fisica,NULL,'', '<html> <b>' || OBTER_TEXTO_TASY(315886,null) ||'</b> '|| a.nm_pessoa_fisica ||' <br />'|| CHR(10) || CHR(13) || ' <b>' || OBTER_TEXTO_TASY(445864,null) ||'</b> '|| SUBSTR(obter_idade_pf(a.cd_pessoa_fisica,SYSDATE,'C'),1,255)||' <br />'|| CHR(10) || CHR(13) || ' <b>' || OBTER_TEXTO_TASY(307589,null) ||'</b> '|| SUBSTR(obter_medico_resp_atend  (a.nr_atendimento,'N'),1,255)||' <br />'|| CHR(10) || CHR(13) || ' <b>' || OBTER_TEXTO_TASY(286493,null) ||'</b> '|| a.ds_convenio||' <br />'|| CHR(10) || CHR(13) || ' <b>' || OBTER_TEXTO_TASY(445871,null) ||'</b> '|| SUBSTR(obter_desc_tipo_acomodacao(obter_tipo_acomodacao(a.nr_atendimento)),1,255)||' <br />' || CHR(10) || CHR(13) || DECODE(a.IE_PROBABILIDADE_ALTA, 'C',' <b>' || OBTER_TEXTO_TASY(445875,null) ||'</b> ' || to_char(a.DT_PREVISTO_ALTA,'dd/MM/yyyy HH:mm:ss'), '')|| DECODE(a.IE_PROBABILIDADE_ALTA, 'A',' <b>' || OBTER_TEXTO_TASY(445875,null) ||'</b> ' || to_char(a.DT_PREVISTO_ALTA,'dd/MM/yyyy HH:mm:ss'), '')||'</html>') ds_hint, obter_dados_pausa_leito(a.nr_seq_interno, 'D') ds_motivo_pausa_leito, qt_tempo_prev_higien, a.nr_atendimento

FROM	ocupacao_unidade_v a
WHERE 1 = 1 
	AND	a.cd_setor_atendimento = 37
ORDER BY ds_ocupacao   ,
	 nr_seq_apresent,
	 cd_unidade_basica,
	 cd_unidade_compl 
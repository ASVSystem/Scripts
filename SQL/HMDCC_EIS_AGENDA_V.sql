CREATE OR REPLACE VIEW TASY.HMDCC_EIS_AGENDA_V
AS SELECT 	a.dt_referencia ,
	a.CD_TIPO_AGENDA         ,
	a.CD_AGENDA              ,
	a.IE_STATUS_AGENDA       ,
  	LPAD(TO_CHAR(a.hr_inicio),2,'0') HR_INICIO,
  	LPAD(TO_CHAR(a.hr_inicio),2,'0') hr_inicio_char,
	a.CD_MOTIVO_CANC         ,
	a.CD_MEDICO              ,
	a.CD_CONVENIO            ,
	a.QT_MIN_DURACAO         ,
	1 QT_AGENDA              ,
	a.IE_CARATER_CIRURGIA    ,
	a.CD_SETOR_ATENDIMENTO,
	a.NM_USUARIO_AGENDA    ,
	a.CD_PROC_PRINC||' - '||SUBSTR(Obter_Descricao_Procedimento(a.CD_PROC_PRINC,a.IE_ORIGEM_PROC_PRINC),1,50) ds_cod_proced,
	SUBSTR(Obter_Descricao_Procedimento(a.CD_PROC_PRINC,a.IE_ORIGEM_PROC_PRINC),1,150) ds_procedimento_princ,
	a.CD_PROC_PRINC         , 
	a.IE_ORIGEM_PROC_PRINC,
	a.CD_PROC_ADIC||' - '||SUBSTR(Obter_Descricao_Procedimento(a.CD_PROC_ADIC,a.IE_ORIGEM_PROC_ADIC),1,50) ds_cod_proc_adic,
	SUBSTR(Obter_Descricao_Procedimento(a.CD_PROC_ADIC,a.IE_ORIGEM_PROC_ADIC),1,150) ds_procedimento_adic,
	a.CD_PROC_ADIC         ,  
	a.IE_ORIGEM_PROC_ADIC   ,
	SUBSTR(obter_desc_clas_agenda_cons(a.IE_CLASSIF_AGENDA),1,150) ds_classif_agenda,
	a.IE_CLASSIF_AGENDA      ,
	SUBSTR(OBTER_NOME_SETOR(a.CD_SETOR_EXECUCAO),1,150) ds_setor_execucao,
	a.CD_SETOR_EXECUCAO      ,
	a.hr_inicio ds_inicio,
	LPAD(TO_CHAR(a.hr_inicio),2,'0') ds_inicio_char,
	obter_descricao_padrao('AGENDA','DS_AGENDA',A.CD_AGENDA) ds_agenda,
	obter_nome_convenio(a.cd_convenio) ds_convenio,
	SUBSTR(obter_motivo_canc_agecons(a.cd_motivo_canc,'D'),1,255) ds_motivo_cancelamento,
	SUBSTR(obter_motivo_canc_agecir(a.cd_motivo_canc,'D'),1,255) ds_motivo_cancel_cirur,
/*	obter_valor_dominio(1011, a.cd_motivo_canc) ds_motivo_cancelamento,*/
	obter_nome_pessoa_fisica(a.cd_medico, NULL) nm_medico,
	obter_valor_dominio(83, a.ie_status_agenda) ds_status,
	obter_valor_dominio(34, a.cd_tipo_agenda) ds_tipo_agenda  ,
	SUBSTR(obter_valor_dominio(1016, a.ie_carater_cirurgia),1,15) ds_carater_cirurgia,
	obter_nome_setor(a.cd_setor_atendimento) ds_setor_atendimento,
	SUBSTR(obter_nome_setor(a.cd_setor_exclusivo),1,100) ds_setor_exclusivo,
	Obter_Tipo_Convenio(A.CD_CONVENIO) cd_tipo_convenio,
	SUBSTR(obter_valor_dominio(11, Obter_Tipo_Convenio(A.CD_CONVENIO)),1,100) ds_tipo_convenio,
	SUBSTR(Obter_Desc_Sala_Consulta(a.nr_seq_sala),1,150) ds_sala,
	SUBSTR(obter_desc_classif_agenda_pac(a.nr_seq_classif_agenda),1,80) ds_classificacao,
	a.nr_seq_classif_agenda,
	a.ie_tipo_proc_agenda,
	A.NR_SEQ_SALA,
	a.nm_usuario_original,
	SUBSTR(obter_descricao_padrao('TIPO_INDICACAO', 'DS_INDICACAO', a.NR_SEQ_INDICACAO),1,100) ds_tipo_indicacao,
	a.NR_SEQ_INDICACAO,
	obter_intervalo_minutos(a.qt_aguardando) ds_min_espera,
	obter_intervalo_minutos(a.qt_consulta) ds_min_consulta,
	SUBSTR(obter_desc_proc_interno(a.nr_seq_proc_interno),1,200) ds_proc_interno,
	SUBSTR(obter_desc_int_proc(a.cd_proc_princ, a.ie_origem_proc_princ),1,200) ds_proced_princ_int,
	SUBSTR(obter_desc_int_proc(a.cd_proc_adic, a.ie_origem_proc_adic),1,200) ds_proced_adic_int,
	SUBSTR(obter_valor_dominio(1372, a.ie_lado),1,200) ds_lado,
	a.ie_lado,
	SUBSTR(obter_nome_estabelecimento(a.cd_estabelecimento),1,80) ds_estabelecimento,
	SUBSTR(obter_especialidade_medico(a.cd_medico,'D'),1,80) ds_especialidade,
	DECODE(a.ie_status_agenda,'C',a.QT_MIN_DURACAO,0) qt_min_duracao_canc,
	DECODE(a.ie_status_agenda,'C',1,0) qt_cancelada,
	DECODE(a.ie_status_agenda,'E',1,0) qt_executada,
	DECODE(a.ie_status_agenda,'L',1,0) qt_livre,
	DECODE(a.ie_status_agenda,'A',1,0) qt_aguardando,
	DECODE(a.ie_status_agenda,'N',1,0) qt_normal,
	DECODE(a.ie_status_agenda,'AD',1,0) qt_atendido,
	DECODE(a.ie_status_agenda,'F',1,0) qt_falta_just,
	DECODE(a.ie_status_agenda,'O',1,0) qt_em_atendimento,
	DECODE(a.ie_status_agenda,'I',1,0) qt_falt_n_just,
	DECODE(obter_dados_cirurgia(a.nr_cirurgia,'DT'),NULL,0,1) qt_finalizada,
	obter_empresa_estab(a.cd_estabelecimento) cd_empresa,
	a.qt_atendimento,
	a.cd_procedencia,
	SUBSTR(NVL(obter_desc_procedencia(a.cd_procedencia),Obter_Desc_Expressao(622834)),1,100) ds_procedencia,
  	SUBSTR(NVL(sus_obter_complexidade_proced(a.cd_proc_adic, a.ie_origem_proc_adic, 'D'), Obter_Desc_Expressao(327119)),1,255) ds_complexidade,
	ROUND(((a.dt_chegada - a.dt_agendamento) * 1440),0) qt_tempo_chegada,
	ROUND(((a.dt_atendimento - a.dt_chegada) * 1440),0) qt_tempo_espera,
	ROUND(((a.dt_atendimento - a.dt_atendido) * 1440),0) qt_tempo_atendimento,
	ROUND(((a.dt_em_exame - a.dt_atendido) * 1440),0) qt_tempo_espera_exame,
	ROUND(((a.dt_executada - a.dt_em_exame) * 1440),0) qt_tempo_em_exame,
	ROUND(((a.dt_executada - a.dt_agendamento) * 1440),0) qt_tempo_exec,
	a.cd_setor_exclusivo,
	a.nr_seq_motivo_trans,
	SUBSTR(obter_desc_motivo_transf(a.nr_seq_motivo_trans),1,255) ds_motivo_trans,
	a.cd_medico_exec,
	SUBSTR(obter_nome_pf(a.cd_medico_exec),1,100) nm_medico_exec,
	a.qt_procedimento,
	a.ie_tipo_atendimento,
	SUBSTR(obter_valor_dominio(12,a.ie_tipo_atendimento),1,100) ds_tipo_atendimento,
	a.ie_forma_agendamento,
	obter_valor_dominio(2441, a.ie_forma_agendamento) ds_forma_agendamento,
	SUBSTR(obter_especialidade_medico(a.cd_medico,NULL),1,5) cd_especialidade,
	a.nm_usuario_confirm,
	a.nr_seq_motivo_bloqueio,
	SUBSTR(obter_valor_dominio(1007,a.nr_seq_motivo_bloqueio),1,255) ds_motivo_bloqueio,
	SUBSTR(obter_dados_usuario_opcao(a.nm_usuario_agenda,'CE'),1,255) cd_estab_usuario,
	SUBSTR(obter_nome_estabelecimento(obter_dados_usuario_opcao(a.nm_usuario_agenda,'CE')),1,255) ds_estab_usuario,
	TO_CHAR(a.dt_inicio_agendamento,'hh24') hr_agendamento,
	a.ie_clinica,
	SUBSTR(obter_valor_dominio(17,a.ie_clinica),1,100) ds_clinica,
	a.cd_medico_req,
	SUBSTR(obter_nome_medico(a.cd_medico_req,'N'),1,255) nm_medico_req,
	a.ie_classif_tasy,
	SUBSTR(obter_valor_dominio(1006,a.ie_classif_tasy),1,255) ds_classif_tasy,
	a.ie_clinica_agenda,
	SUBSTR(obter_valor_dominio(17,a.ie_clinica_agenda),1,100) ds_clinica_agenda,
	a.nr_seq_proc_interno,
	a.nm_usuario_cancelamento,
	a.nr_seq_area_atuacao,
	SUBSTR(obter_desc_area_atuacao_medica(a.nr_seq_area_atuacao),1,255) ds_area_atuacao,
	TO_CHAR(a.dt_confirmacao,'hh24') hr_confirmacao,
	TO_CHAR(a.dt_agendamento,'hh24') hr_marcacao,	
	TRUNC(a.dt_confirmacao,'dd') dt_ref_confirmacao,
	TO_CHAR(a.dt_cancelamento,'hh24') hr_cancelamento,
	TRUNC(a.dt_cancelamento,'dd') dt_ref_cancelamento,
	SUBSTR(obter_dados_usuario_opcao(a.nm_usuario_cancelamento,'CE'),1,255) cd_estab_usuario_canc,
	SUBSTR(obter_nome_estabelecimento(obter_dados_usuario_opcao(a.nm_usuario_cancelamento,'CE')),1,255) ds_estab_usuario_canc,
	SUBSTR(obter_dados_usuario_opcao(a.nm_usuario_original,'CE'),1,255) cd_estab_usuario_orig,
	SUBSTR(obter_nome_estabelecimento(obter_dados_usuario_opcao(a.nm_usuario_original,'CE')),1,255) ds_estab_usuario_orig,
	SUBSTR(obter_dados_usuario_opcao(a.nm_usuario_confirm,'CE'),1,255) cd_estab_usuario_confirm,
	SUBSTR(obter_nome_estabelecimento(obter_dados_usuario_opcao(a.nm_usuario_confirm,'CE')),1,255) ds_estab_usuario_confirm,
	a.cd_especialidade_agenda,
	SUBSTR(obter_nome_especialidade(a.cd_especialidade_agenda),1,255) ds_especialidade_agenda,
	ageserv_obter_modelo_agend(a.nr_seq_rp_mod_item,'C') nr_seq_modelo,
	SUBSTR(ageserv_obter_modelo_agend(a.nr_seq_rp_mod_item,'D'),1,255) ds_modelo,
	a.ie_atrasado,
	a.nr_seq_motivo_atraso,
	SUBSTR(obter_motivo_atraso_pac(a.nr_seq_motivo_atraso,a.cd_estabelecimento),1,255) ds_motivo_atraso,
	
	SUBSTR(obter_desc_clas_curta_cons(a.IE_CLASSIF_AGENDA),1,7) ds_classif_curta,
	a.cd_categoria,
	SUBSTR(obter_categoria_convenio(a.cd_convenio,a.cd_categoria),1,255) ds_categoria,
	a.ie_clinica_pac,
	SUBSTR(obter_valor_dominio(17,a.ie_clinica_pac),1,255) ds_clinica_pac,
	SUBSTR(DECODE(OBTER_PORTE_PROCEDIMENTO(a.cd_proc_princ,a.ie_origem_proc_princ,a.nr_seq_proc_interno),'P',Obter_Desc_Expressao(489957),'M',Obter_Desc_Expressao(293174),'G', Obter_Desc_Expressao(489958),'E', Obter_Desc_Expressao(289428),'S',Obter_Desc_Expressao(298957),Obter_Desc_Expressao(327119)),1,200) ds_porte,
	SUBSTR(OBTER_PORTE_PROCEDIMENTO(a.cd_proc_princ,a.ie_origem_proc_princ,a.nr_seq_proc_interno),1,200) ie_porte,
	a.cd_turno,
	SUBSTR(DECODE(a.cd_turno,'0',Obter_Desc_Expressao(487774),'1',Obter_Desc_Expressao(487775),Obter_Desc_Expressao(308326)),1,50) ds_turno,
	a.nr_seq_origem,
	SUBSTR(Obter_desc_origem_conv(a.nr_seq_origem),1,60) ds_origem_conv,
	SUBSTR(obter_grupo_classif(a.ie_classif_agenda,'C'),1,255) nr_seq_grupo_classif,
	SUBSTR(obter_grupo_classif(a.ie_classif_agenda,'D'),1,255) ds_grupo_classif,
	a.nr_seq_forma_confirmacao,
	SUBSTR(obter_desc_forma_conf(a.nr_seq_forma_confirmacao),1,90) ds_forma_confirmacao,
	SUBSTR(Obter_Nome_Usuario(a.nm_usuario_original),1,255) ds_usuario_original,
	SUBSTR(Obter_Nome_Usuario(a.nm_usuario_agenda),1,255) ds_usuario_agenda,
	SUBSTR(Obter_Nome_Usuario(a.nm_usuario_confirm),1,255) ds_usuario_confirm,
	SUBSTR(Obter_Dados_Usuario_Opcao(a.nm_usuario_cancelamento,'LA'),1,255) ds_login_alternativo,
	SUBSTR(Obter_Dados_Usuario_Opcao(a.nm_usuario_confirm,'LA'),1,255) ds_login_alt_confirm,
	SUBSTR(Obter_Dados_Usuario_Opcao(a.nm_usuario_original,'LA'),1,255) ds_login_alt_orig,
	a.dt_copia_trans,
	SUBSTR(obter_valor_dominio(1227, a.ie_autorizacao),1,255) ds_autorizacao,
	a.ie_autorizacao ie_autorizacao,
	obter_cod_dia_semana(a.dt_referencia) ie_dia_semana,
	SUBSTR(obter_valor_dominio(35,obter_cod_dia_semana(a.dt_referencia)),1,150) ds_dia_semana,
	obter_dados_motivo_cancel(a.cd_motivo_canc,'G') DS_GRUPO_MOTIVO_CANCEL,
	obter_dados_motivo_cancel(a.cd_motivo_canc,'CG') cd_grupo_motivo_cancel,
	SUBSTR(obter_desc_status_pac_ag(a.nr_seq_status_pac),1,100) DS_STATUS_PACIENTE,
	a.nr_seq_status_pac,
	SUBSTR(obter_grupo_procedimento(a.CD_PROC_PRINC,a.IE_ORIGEM_PROC_PRINC,'C'),1,50) CD_GRUPO_PROC_PRINC,
	SUBSTR(obter_grupo_procedimento(a.CD_PROC_PRINC,a.IE_ORIGEM_PROC_PRINC,'D'),1,50) DS_GRUPO_PROC_PRINC,
	SUBSTR(obter_desc_agenda_motivo(a.nr_seq_motivo_bloqueio),1,255) DS_MOT_BLOQ_CONS,
	to_number(LPAD(TO_CHAR(a.hr_inicio),2,'0')) hr_inicio_number,
  	p.cd_tipo_acomodacao,
  	obter_desc_tipo_acomodacao(p.cd_tipo_acomodacao) ds_tipo_acomodacao

FROM	agenda_paciente p
left join eis_agenda a
ON a.cd_agenda = p.cd_agenda

WHERE 
--TRUNC(a.DT_REFERENCIA) = '07/09/2021'
 TRUNC(p.dt_agenda) = TRUNC(a.dt_referencia)
AND p.cd_pessoa_fisica = a.cd_pessoa_fisica
AND a.ie_status_agenda NOT IN ('L','C')
AND a.cd_tipo_agenda = 1
AND p.nr_seq_proc_interno = a.nr_seq_proc_interno
--AND p.CD_PESSOA_FISICA = '281630'

--ORDER BY   hr_inicio, cd_agenda

----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO ALEVICTOR;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO DANIELF;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO DANISANTOS;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO GHAS;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_ALESSANDER;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_BRUNOSOUZA;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_DANIELLE;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_INT;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_LEANDRO;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_LUCASBOMTEMPO;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_LUCASLEAL;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO VETORRH;



----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO ALEVICTOR;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO DANIELF;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO DANISANTOS;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO GHAS;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_ALESSANDER;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_BRUNOSOUZA;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_DANIELLE;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_INT;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_LEANDRO;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_LUCASBOMTEMPO;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO USR_LUCASLEAL;
----GRANT SELECT ON TASY.HMDCC_EIS_AGENDA_V TO VETORRH;
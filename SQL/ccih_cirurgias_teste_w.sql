--CREATE OR REPLACE VIEW TASY.HMDCC_CCIH_CIRURGIA_V
--AS 
SELECT DISTINCT c.nr_cirurgia,
	c.nr_atendimento	nr_atendimento,
	c.dt_inicio_real dt_cirurgia,
(SELECT max(t.dt_inicio) FROM TEMPO_CIRURGICO_CIRURGIA t WHERE t.nr_seq_tempo  IN (3,15,21) AND t.nr_cirurgia = c.nr_cirurgia ) inicio_real_cirurgia,
   substr(OBTER_DADOS_PF(a.cd_pessoa_fisica,'NP'),1,30)	nr_prontuario,
   a.cd_pessoa_fisica,
	obter_nome_pf(c.cd_pessoa_fisica)nm_paciente,
  -- Obter os números do complemento PF
	OBTER_DADOS_PF(c.cd_pessoa_fisica,'TCD')||'/ '||(SELECT LISTAGG('('||p.nr_ddd_telefone||') '||p.nr_telefone,'/ ') WITHIN GROUP (ORDER BY p.nr_telefone) ds_proc FROM compl_pessoa_fisica p WHERE p.cd_pessoa_fisica = c.cd_pessoa_fisica AND p.nr_telefone IS NOT null) nr_telefone,

	obter_desc_proc_interno(z.nr_seq_proc_interno)ds_procedimento,
	
(SELECT t.cd_topografia FROM NISS_TOPOGRAFIA t, niss_procedimento np WHERE t.NR_SEQUENCIA = np.NR_SEQ_TOPOGRAFIA AND np.nr_sequencia = c.nr_seq_proced_niss ) categoria_nhsn,
 
(SELECT hmdcc_obter_procedimento_nis(pi.nr_seq_proced_niss, 'C')
	FROM prescr_procedimento x, proc_interno pi WHERE pi.nr_sequencia = x.nr_seq_proc_interno AND x.nr_prescricao = c.nr_prescricao 
	AND x.nr_sequencia = z.nr_sequencia) procedimento_nhsn,
 
CASE WHEN (SELECT count(*) FROM material_atend_paciente x WHERE obter_dados_material(x.cd_material,'FA') =113 and x.nr_cirurgia = c.nr_cirurgia HAVING count(*) >0) > 0 THEN 'S'
   ELSE 'N' END   ie_protese,
	c.ie_video ie_video,  --- Sim ou Não (equipamento vídeo)
	
	--/AGRUPAR OS MATERIAIS OPME DO PACIENTE/CIRURGIA DA PLANILHA IMPLANTES), N/I = Não é implante
(SELECT LISTAGG(CASE WHEN obter_dados_material(x.cd_material, 'FA') =113 THEN substr(OBTER_DESC_MATERIAL(x.cd_material),1,255)
	ELSE substr('N/I',1,3) END,  '; ') WITHIN GROUP (ORDER BY 1) material_opme 
	FROM material_atend_paciente x WHERE x.nr_cirurgia = c.nr_cirurgia --AND x.cd_acao = 1 
	AND obter_dados_material(x.cd_material,'CGRU') IN ('13','15')) material_opme,
	    
	c.qt_ric IRIC,--	iric,
	c.ie_asa_estado_paciente	ie_asa,
(SELECT obter_min_entre_datas(max(t.DT_INICIO),max(t.DT_FIM),null) FROM TEMPO_CIRURGICO_CIRURGIA t WHERE t.nr_seq_tempo IN (3,15,21) AND t.nr_cirurgia = c.nr_cirurgia )	dur_proc, --Duração real em minutos
	substr(tasy.obter_desc_tipo_cirurgia(c.cd_tipo_cirurgia) ,1,255)	grau_contaminacao,
 	substr(tasy.obter_nome_medico(CD_MEDICO_CIRURGIAO,'N'),1,200) nm_cirurgiao,
 	tasy.obter_especialidade_medico(c.cd_medico_cirurgiao,'D') ds_especialidade_medica,
	substr(tasy.obter_nome_medico(CD_MEDICO_ANESTESISTA,'N'),1,200) nm_anestesista,
	substr(tasy.obter_valor_dominio(36,c.cd_tipo_anestesia),1,150) tipo_anestesia,
	substr(decode(c.ie_carater_cirurgia,'E','Eletiva','U','Urgência','A','Ambulatorial','M','Emergência'),1,30) ds_carater,
 	---Trazer dos antibióticos em uso na unidade de origem (Avaliação - 1ª pausa cirurgia)
  
    initcap(substr((SELECT LISTAGG( SUBSTR(mr.ds_resultado,1,50),',' ) WITHIN GROUP (ORDER BY nr_seq_tipo_avaliacao) ie_checklist 
	  FROM med_avaliacao_paciente ma, med_avaliacao_result mr WHERE ma.nr_cirurgia = c.nr_cirurgia AND ma.ie_situacao = 'A'AND mr.nr_seq_avaliacao = ma.nr_sequencia AND ma.nr_seq_tipo_avaliacao = 295 AND mr.nr_seq_item IN (8065) AND ma.dt_liberacao IS NOT null
	),1,50)) nome_atb_unidade_origem  ,
	
	(SELECT max(to_date(to_char(mr.dt_atualizacao,'dd/mm/yyyy')||' '||mr.ds_resultado||':00', 'dd/mm/yyyy hh24:mi:ss')) hora_atb_prof 
	  FROM med_avaliacao_paciente ma, med_avaliacao_result mr 
	  WHERE ma.nr_cirurgia = c.nr_cirurgia AND ma.ie_situacao = 'A'AND mr.nr_seq_avaliacao = ma.nr_sequencia AND ma.nr_seq_tipo_avaliacao = 295 AND mr.nr_seq_item IN (8066) AND ma.dt_liberacao IS NOT NULL
	)  hora_atb_unidade,
    
    ---Trazer o antibiótico profilático (Avaliação - 1ª pausa cirurgia)
  
	
    initcap(substr((SELECT LISTAGG( SUBSTR(mr.ds_resultado,1,50),',' ) WITHIN GROUP (ORDER BY nr_seq_tipo_avaliacao) ie_checklist 
	  FROM med_avaliacao_paciente ma, med_avaliacao_result mr WHERE ma.nr_cirurgia = c.nr_cirurgia AND ma.ie_situacao = 'A'AND mr.nr_seq_avaliacao = ma.nr_sequencia AND ma.nr_seq_tipo_avaliacao = 295 AND mr.nr_seq_item IN (7806,7807) AND ma.dt_liberacao IS NOT null
	),7,50)) nome_atb_profilatico  ,
        ---Trazer atb_profilatico (Avaliação - 1ª pausa cirurgia)
   
   (SELECT max(to_date(to_char(mr.dt_atualizacao,'dd/mm/yyyy')||' '||mr.ds_resultado||':00', 'dd/mm/yyyy hh24:mi:ss')) hora_atb_prof 
	  FROM med_avaliacao_paciente ma, med_avaliacao_result mr 
	  WHERE ma.nr_cirurgia = c.nr_cirurgia AND ma.ie_situacao = 'A'AND mr.nr_seq_avaliacao = ma.nr_sequencia AND ma.nr_seq_tipo_avaliacao = 295 AND mr.nr_seq_item IN (7807) AND ma.dt_liberacao IS NOT NULL
	)  hora_atb_profilatico,
		
		
  	substr(obter_dif_data(
    (SELECT max(to_date(to_char(mr.dt_atualizacao,'dd/mm/yyyy')||' '||mr.ds_resultado||':00', 'dd/mm/yyyy hh24:mi:ss')) hora_atb_prof 
	  FROM med_avaliacao_paciente ma, med_avaliacao_result mr 
	  WHERE ma.nr_cirurgia = c.nr_cirurgia AND ma.ie_situacao = 'A'AND mr.nr_seq_avaliacao = ma.nr_sequencia AND ma.nr_seq_tipo_avaliacao = 295 AND mr.nr_seq_item IN (7807) AND ma.dt_liberacao IS NOT NULL
	 ), (SELECT e.dt_registro FROM tasy.evento_cirurgia_paciente e
        WHERE e.ie_situacao = 'A' AND e.nr_seq_evento = 5 AND e.nr_cirurgia = c.nr_cirurgia),'CIR'
    ),1,8) tempo_atb_antes_incisao, --tempo em minutos 
	
	
   (    SELECT  max(ap.dt_entrada)
        FROM tasy.atendimento_paciente ap 
        WHERE ap.cd_pessoa_fisica = a.cd_pessoa_fisica
        AND ap.ie_tipo_atendimento = 8 
        AND tasy.OBTER_DADOS_AGENDA_CONSULTA(ap.nr_atendimento,'C') = '1º Pós Operatório'
        AND ap.dt_entrada > (SELECT max(t.dt_inicio) FROM TEMPO_CIRURGICO_CIRURGIA t WHERE t.nr_seq_tempo IN (3,15,21) AND t.nr_cirurgia = c.nr_cirurgia ) 
    ) dt_egresso,   --Pegar data da entrada do próximo atendimento
   

	
	NULL ds_ssi, --Infecção Sitio Cirúrgico ISC(ANVISA)
	NULL ds_orcav, --Orgão Cavidade
	NULL dt_1_Cont_fonada_60,
	NULL ie_sucesso1_cont_60,
	NULL ds_contato1_cont_60,
	NULL ds_ssi1_cont_60, --Infecção Sitio Cirúrgico
	NULL sitio_orcav1_cont_60,
	NULL dt_2_Cont_fonada_60,
	NULL ie_sucesso2_cont_60,
	NULL ds_contato2_cont_60,
	NULL ds_ssi2_cont_60,
	NULL sitio_orcav2_cont_60,
	NULL dt_3_Cont_fonada_60,
	NULL ie_sucesso3_cont_60,
	NULL ds_contato3_cont_60,
	NULL ds_ssi3_cont_60,
	NULL sitio_orcav3_cont_60,
	NULL dt_1_Cont_fonada_90,
	NULL ie_sucesso1_cont_90,
	NULL ds_contato1_cont_90,
	NULL ds_ssi1_cont_90,
	NULL sitio_orcav1_cont_90,
	NULL dt_2_Cont_fonada_90,
	NULL ie_sucesso2_cont_90,
	NULL ds_contato2_cont_90,
	NULL ds_ssi2_cont_90,
	NULL sitio_orcav2_cont_90,
	NULL dt_3_Cont_fonada_90,
	NULL ie_sucesso3_cont_90,
	NULL ds_contato3_cont_90,
	NULL ds_ssi3_cont_90,
	NULL sitio_orcav3_cont_90,
		
  CASE WHEN (SELECT LISTAGG( SUBSTR(nr_seq_tipo_avaliacao,1,16),',' ) WITHIN GROUP (ORDER BY nr_seq_tipo_avaliacao) ie_checklist 
	  FROM med_avaliacao_paciente ma WHERE ma.nr_cirurgia = c.nr_cirurgia AND ma.ie_situacao = 'A' AND ma.dt_liberacao IS NOT null
	 ) LIKE '%293,295,299,300%' THEN 'S' ELSE 'N' END	ie_checklist, --Chack list cirurgia segura
	NULL  ie_sacih --Registro no SACIH
	
	

FROM tasy.atendimento_paciente a

JOIN tasy.cirurgia c 
ON a.nr_atendimento = c.nr_atendimento

JOIN tasy.material_atend_paciente p
ON  p.nr_cirurgia = c.nr_cirurgia

JOIN PRESCR_PROCEDIMENTO z
ON c.nr_prescricao = z.nr_prescricao
--AND c.NR_SEQ_PROC_INTERNO = z.NR_SEQ_PROC_INTERNO

WHERE  c.IE_STATUS_CIRURGIA = 2
AND p.cd_acao = 1
--AND a.IE_TIPO_ATENDIMENTO = 1
AND p.NR_CIRURGIA IS NOT NULL
AND c.dt_inicio_real between '01/03/2021' AND fim_dia('31/03/2021')
--AND c.NR_ATENDIMENTO = 310797
--AND c.NR_CIRURGIA = 33666

ORDER BY inicio_real_cirurgia
-- cd_material 8660











	--tasy.hmdcc_obter_procedimento_nis(c.nr_seq_proced_niss, 'C') procedimento_nhsn, --(nis)Quando não possuir código apresentar em branco
	
	---Procedimentos Adicionais
-- 	(SELECT obter_desc_proc_interno(x.nr_seq_proc_interno)
--		FROM prescr_procedimento x WHERE x.nr_sequencia != 1 AND x.nr_prescricao = c.nr_prescricao AND x.nr_sequencia = z.nr_sequencia) procedimentos_adicionais,

--	(SELECT LISTAGG(obter_desc_proc_interno(x.nr_seq_proc_interno), '; ') WITHIN GROUP (ORDER BY 1) proc_adicional
--		FROM prescr_procedimento x WHERE x.nr_sequencia != 1 AND x.nr_prescricao = c.nr_prescricao AND x.nr_sequencia = z.nr_sequencia) procedimentos_adicionais,
-- 	(	SELECT SUBSTR(obter_valor_dominio(802,decode(ap.IE_CARATER_INTER_SUS,'01','1','5','5','20','20','27','27','02','02')),1,20) carater
--		FROM tasy.atendimento_paciente ap 
--		WHERE ap.cd_pessoa_fisica = a.cd_pessoa_fisica
--	   AND ap.ie_tipo_atendimento = 8
--		AND tasy.OBTER_DADOS_AGENDA_CONSULTA(ap.nr_atendimento,'C') = '1º Pós Operatório'
--		GROUP BY ap.ie_carater_inter_sus
--	 ) carater_atendimento, --Carater Atendimento Entrada Única

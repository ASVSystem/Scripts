--CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_SAPS3_V
--AS

SELECT distinct v.NR_ATENDIMENTO 		visit_id,
	   to_char(max(u.DT_ENTRADA_UNIDADE), 'yyyy-mm-dd"T"hh24:mi:ss')		unitadmissiondatetime,
	   e.NR_SEQUENCIA		 	saps3_id,
	   t.DS_LABEL_GRID 			saps3_code,
	   decode(e.DS_RESULTADO,'N',0,'S',1) 			saps3_value,
	   to_char(e.DT_ATUALIZACAO, 'yyyy-mm-dd"T"hh24:mi:ss') 		updatetimestamp

FROM    ehr_reg_elemento e
        JOIN   EHR_TEMPLATE_CONTEUDO t
      	ON e.NR_SEQ_TEMP_CONTEUDO = t.NR_SEQUENCIA
        join EHR_REG_TEMPLATE r
        on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
      	JOIN EHR_REGISTRO v
      	ON t.NR_SEQ_TEMPLATE = v.NR_SEQ_TEMPL
      	and r.NR_SEQ_REG = v.NR_SEQUENCIA
		JOIN atend_paciente_unidade u
        ON v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO        
        JOIN SETOR_ATENDIMENTO s
        ON u.CD_SETOR_ATENDIMENTO = s.CD_SETOR_ATENDIMENTO
        

WHERE  nvl(s.ie_epimed, 'N')				= 'S'
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    NVL(v.ie_situacao,'A') <> 'I'
and    t.nr_seq_elemento = 657
and    t.nr_sequencia not in(290419,290420,290421,290422,290424,290425,290426,290427,290428,290429,290430,290451,290452,290453,290454,290552)
--and    v.dt_liberacao is not null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
AND v.nr_seq_templ = 100707  

group BY v.NR_ATENDIMENTO, e.NR_SEQUENCIA,  t.DS_LABEL_GRID,  e.DS_RESULTADO,  e.DT_ATUALIZACAO

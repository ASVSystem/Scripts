--CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_COMPLIC_V
--AS

SELECT distinct v.NR_ATENDIMENTO 		visit_id,
	   to_char(v.dt_registro, 'yyyy-mm-dd"T"hh24:mi:ss')		complicationdate,
	   e.NR_SEQUENCIA		 	complication_id,
	   t.DS_LABEL_GRID 			complication_code,
	   decode(e.DS_RESULTADO,'N',0,'S',1) 			complication_value,
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
--and    v.dt_liberacao is not null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
AND v.nr_seq_templ = 100706  -- (Template da TESTE)

--group BY v.NR_ATENDIMENTO, e.NR_SEQUENCIA,  t.DS_LABEL_GRID,  e.DS_RESULTADO,  e.DT_ATUALIZACAO


UNION

SELECT distinct v.NR_ATENDIMENTO 		visit_id,
	   to_char(v.dt_registro, 'yyyy-mm-dd"T"hh24:mi:ss')		complicationdate,
	   e.NR_SEQUENCIA		 	complication_id,
	   t.DS_LABEL_GRID 			complication_code,
	   decode(e.DS_RESULTADO,'N',0,'S',1) 			complication_value,
	   to_char(e.DT_ATUALIZACAO, 'yyyy-mm-dd"T"hh24:mi:ss') 		updatetimestamp
	   

from	ehr_reg_elemento e
		join EHR_TEMPLATE_CONTEUDO t
		on e.NR_SEQ_TEMP_CONTEUDO = t.NR_SEQUENCIA
		join EHR_REG_TEMPLATE r
		on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
   		JOIN EHR_REGISTRO v
		on r.NR_SEQ_REG = v.NR_SEQUENCIA
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
and e.nr_registro_cluster is not null
and e.DS_RESULTADO = 'S'
--and	 e.NR_SEQ_TEMP_CONTEUDO not in(290196,290197,290198,290199,290200,290201,290202)
--and    v.dt_liberacao is not null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
AND v.nr_seq_templ = 100706
--AND a.nr_atendimento = 169117  


--select * from hmdcc_epimed
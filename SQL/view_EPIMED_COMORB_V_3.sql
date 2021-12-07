--CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_COMORB_V
--AS

SELECT v.NR_ATENDIMENTO 		visit_id,
	   max(u.DT_ENTRADA_UNIDADE)		unitadmissiondatetime,
	   e.NR_SEQUENCIA		 	comorbidity_id,
	   t.DS_LABEL_GRID 			comorbidity_code,
	   '' 		                comorbidity_site_code,
	   e.DS_RESULTADO 			comorbidity_value,
	   e.DT_ATUALIZACAO 		updatetimestamp

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
and    v.dt_liberacao is not null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
--AND v.nr_seq_templ = 100704  -- (Template da TESTE)
AND v.nr_seq_templ = 100699 --(Template da Produção)
group BY v.NR_ATENDIMENTO, e.NR_SEQUENCIA,  t.DS_LABEL_GRID,  e.DS_RESULTADO,  e.DT_ATUALIZACAO

UNION all

SELECT distinct v.NR_ATENDIMENTO 		visit_id,
	   max(u.DT_ENTRADA_UNIDADE)		unitadmissiondatetime,
	   e.NR_SEQUENCIA		 	comorbidity_id,
	   t.DS_LABEL_GRID 			comorbidity_code,
	   '' 		                comorbidity_site_code,
	   e.DS_RESULTADO 			comorbidity_value,
	   e.DT_ATUALIZACAO 		updatetimestamp
	   

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
--and    v.dt_liberacao is not null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
AND v.nr_seq_templ = 100699
--AND a.nr_atendimento = 169117   
group BY v.NR_ATENDIMENTO, e.NR_SEQUENCIA,  t.DS_LABEL_GRID,  e.DS_RESULTADO,  e.DT_ATUALIZACAO


UNION all

SELECT v.NR_ATENDIMENTO 		visit_id,
	   max(u.DT_ENTRADA_UNIDADE)		unitadmissiondatetime,
	   e.NR_SEQUENCIA		 	comorbidity_id,
	   '' 			            comorbidity_code,
	   t.DS_LABEL_GRID          comorbidity_site_code,
	   e.DS_RESULTADO 			comorbidity_value,
	   e.DT_ATUALIZACAO 		updatetimestamp
	  -- r.NR_SEQ_TEMPLATE
	   

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
and	 e.NR_SEQ_TEMP_CONTEUDO not in(290196,290197,290198,290199,290200,290201,290202)
--and    v.dt_liberacao is not null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
AND v.nr_seq_templ = 100699
--AND a.nr_atendimento = 169117   
group BY v.NR_ATENDIMENTO, e.NR_SEQUENCIA,  t.DS_LABEL_GRID,  e.DS_RESULTADO,  e.DT_ATUALIZACAO

ORDER BY 1,3













SELECT distinct v.NR_ATENDIMENTO 		visit_id,
	   max(u.DT_ENTRADA_UNIDADE)		unitadmissiondatetime,
	   e.NR_SEQUENCIA		 	comorbidity_id,
	   e.nr_seq_temp_conteudo 			comorbidity_code,
	   e.nr_seq_temp_conteudo       comorbidity_site_code,
	   e.DS_RESULTADO 			comorbidity_value,
	   e.DT_ATUALIZACAO 		updatetimestamp
	   

from	ehr_reg_elemento e
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
AND v.nr_seq_templ = 100699
--AND e.nr_registro_cluster IS null

--and    v.dt_liberacao is not null
--and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
--    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
--AND a.nr_atendimento = 169117   
group BY v.NR_ATENDIMENTO, e.NR_SEQUENCIA,  e.nr_seq_temp_conteudo,  e.DS_RESULTADO,  e.DT_ATUALIZACAO
ORDER BY 3

SELECT * FROM ehr_reg_elemento
WHERE NR_SEQUENCIA IN(
5991403,
5991404,
5991405,
5991406
)



------------------------------------TASY.CLUSTER_VLR(
------------------------------------TASY.GET_EHR_VLR(


SELECT  v.nr_atendimento             visit_id,
	    --max(u.DT_ENTRADA_UNIDADE)		unitadmissiondatetime,
	     f.NR_SEQUENCIA		 	      comorbidity_id,
	     to_char(f.nr_seq_temp_conteudo)     comorbidity_code,
	    
		 to_char((SELECT x.nr_seq_temp_conteudo FROM ehr_reg_elemento x 
	     WHERE f.nr_seq_temp_conteudo = x.nr_seq_temp_conteudo and f.NR_REGISTRO_CLUSTER IS not NULL)) 	comorbidity_site_code,
	    f.NR_REGISTRO_CLUSTER,
	    
	    f.DS_RESULTADO 			comorbidity_value,
	    f.DT_ATUALIZACAO 		updatetimestamp
	   
from	ehr_reg_elemento f
		join EHR_REG_TEMPLATE r
		on f.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
		JOIN EHR_REGISTRO v
		on r.NR_SEQ_REG = v.NR_SEQUENCIA
WHERE f.NR_SEQUENCIA IN(
5991430,
5991431,
5991432,
5991433

)
AND f.NR_REGISTRO_CLUSTER IS null

UNION 
 
SELECT   v.nr_atendimento             visit_id,
	    --max(u.DT_ENTRADA_UNIDADE)		unitadmissiondatetime,
	     e.NR_SEQUENCIA		 	      comorbidity_id,
	     --e.nr_seq_temp_conteudo
	    decode(e.NR_REGISTRO_CLUSTER,0,'290188')comorbidity_code,
	    
		 to_char((SELECT x.nr_seq_temp_conteudo FROM ehr_reg_elemento x 
	     WHERE e.nr_seq_temp_conteudo = x.nr_seq_temp_conteudo and e.NR_REGISTRO_CLUSTER IS not NULL)) 	comorbidity_site_code,
	    e.NR_REGISTRO_CLUSTER,
	    e.DS_RESULTADO 			comorbidity_value,
	    e.DT_ATUALIZACAO 		updatetimestamp
	   
from	ehr_reg_elemento e
		join EHR_REG_TEMPLATE r
		on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
		JOIN EHR_REGISTRO v
		on r.NR_SEQ_REG = v.NR_SEQUENCIA
WHERE e.NR_SEQUENCIA IN(
5991430,
5991431,
5991432,
5991433

)
AND e.NR_REGISTRO_CLUSTER IS not null
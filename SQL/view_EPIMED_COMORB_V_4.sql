--CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_COMORBIDADE_V
--AS
SELECT  v.nr_atendimento             visit_id,
       epimed_obter_data_entrada(v.nr_atendimento) unitadmissiondatetime,
	     f.NR_SEQUENCIA		 	      comorbidity_id,
	     to_char(CASE WHEN f.nr_seq_temp_conteudo = 290159 AND f.DS_RESULTADO = 'I' THEN '0'
	     					WHEN f.nr_seq_temp_conteudo = 290159 AND f.DS_RESULTADO = 'A' THEN '1'
	     					WHEN f.nr_seq_temp_conteudo = 290159 AND f.DS_RESULTADO = 'R' THEN '2'
	     					ELSE to_char(f.nr_seq_temp_conteudo)
	     					END 
	     )     comorbidity_code,
	    ''comorbidity_site_code,
	    decode(f.DS_RESULTADO,'I','S','A','S','R','S','S','S','N','N') 			comorbidity_value,
	    to_char(f.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"') 		updatetimestamp
	   
from	ehr_reg_elemento f
		join EHR_REG_TEMPLATE r
		on f.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
		JOIN EHR_REGISTRO v
		on r.NR_SEQ_REG = v.NR_SEQUENCIA
WHERE v.nr_seq_templ = 100699
AND f.NR_REGISTRO_CLUSTER IS null

UNION 
 
SELECT   v.nr_atendimento             visit_id,
			epimed_obter_data_entrada(v.nr_atendimento) unitadmissiondatetime,
	     e.NR_SEQUENCIA		 	      comorbidity_id,
	     to_char(CASE WHEN e.nr_seq_temp_conteudo = 290159 AND e.DS_RESULTADO = 'I' THEN '0'
	     					WHEN e.nr_seq_temp_conteudo = 290159 AND e.DS_RESULTADO = 'A' THEN '1'
	     					WHEN e.nr_seq_temp_conteudo = 290159 AND e.DS_RESULTADO = 'R' THEN '2'
	     					ELSE to_char(e.nr_seq_temp_conteudo)
	     					END 
	     )     comorbidity_code,
	     '' 	comorbidity_site_code,
	     decode(e.DS_RESULTADO,'I','S','A','S','R','S','S','S','N','N') 			comorbidity_value,
	    to_char(e.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"')  		updatetimestamp
	   
from	ehr_reg_elemento e
		join EHR_REG_TEMPLATE r
		on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
		JOIN EHR_REGISTRO v
		on r.NR_SEQ_REG = v.NR_SEQUENCIA
WHERE  v.nr_seq_templ = 100699
AND e.nr_seq_temp_conteudo IN (291637,291640,291644,291638,291639,291646,291641,291645,291647,291643,291649,291652,291651,291650,291655,291654,291662,291656,291653,
291663,291659,291664,291657,291665,291666,291667,291668,291669,291599,291600,291602,291603,291607,291601,291605,291606,291608,291604,291609,291610,291611,291612,
291613,291614,291615,291616,291617,291618,291619,291620,291621,291622,291629,291628,291627,291626,291625,291624,291630,291623,291631,291632,291633)

UNION

SELECT  v.nr_atendimento             visit_id,
		 epimed_obter_data_entrada(v.nr_atendimento) unitadmissiondatetime,
	    e.NR_SEQUENCIA		 	      comorbidity_id,
	    ''  comorbidity_code,
       to_char(e.nr_seq_temp_conteudo) 	comorbidity_site_code,
	    e.DS_RESULTADO 			comorbidity_value,
	    to_char(e.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"')  		updatetimestamp
	   
from	ehr_reg_elemento e
		join EHR_REG_TEMPLATE r
		on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
		JOIN EHR_REGISTRO v
		on r.NR_SEQ_REG = v.NR_SEQUENCIA
WHERE  v.nr_seq_templ = 100699
AND e.NR_REGISTRO_CLUSTER IS NOT NULL
AND e.nr_seq_temp_conteudo NOT IN (291637,291640,291644,291638,291639,291646,291641,291645,291647,291643,291649,291652,291651,291650,291655,291654,291662,291656,291653,
291663,291659,291664,291657,291665,291666,291667,291668,291669,291599,291600,291602,291603,291607,291601,291605,291606,291608,291604,291609,291610,291611,291612,
291613,291614,291615,291616,291617,291618,291619,291620,291621,291622,291629,291628,291627,291626,291625,291624,291630,291623,291631,291632,291633)

ORDER BY comorbidity_id
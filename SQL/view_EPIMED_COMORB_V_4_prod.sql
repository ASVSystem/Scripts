CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_COMORBIDADE_V
AS 
SELECT    visit_id,
            unitadmissiondatetime,
            comorbidity_id,
            CASE WHEN comorbidity_site_code  IN(290221,290217,290218,290223,290225,290229,290227,290228,290224,290220,290222,290230,290226,290237,290219,290231,290236,290232,290233,290234,290235)
            AND (comorbidity_value = 'S' OR comorbidity_value ='N') THEN decode(hmdcc_obter_dados_template(e.nr_seq_reg_template,'META'),'S','291617','N','291616')
            WHEN comorbidity_site_code  IN(291640,291639,291638,291636,291635,291634,291641,291642,291643,291637)
            AND (comorbidity_value = 'S' OR comorbidity_value ='N') THEN '291630'  
            ELSE comorbidity_code
            END AS comorbidity_code,

            comorbidity_site_code,
            decode(comorbidity_value,'S',1,'N',0) comorbidity_value,
            updatetimestamp

FROM (
         SELECT  v.nr_atendimento             visit_id,
       epimed_obter_data_entrada(v.nr_atendimento) unitadmissiondatetime,
         f.NR_SEQUENCIA                   comorbidity_id,
         to_char(CASE WHEN f.nr_seq_temp_conteudo = 291558 AND f.DS_RESULTADO = 'I' THEN '0'
                             WHEN f.nr_seq_temp_conteudo = 291558 AND f.DS_RESULTADO = 'A' THEN '1'
                             WHEN f.nr_seq_temp_conteudo = 291558 AND f.DS_RESULTADO = 'R' THEN '2'
                             ELSE to_char(f.nr_seq_temp_conteudo)
                             END ) comorbidity_code,
        ''comorbidity_site_code,
        decode(f.DS_RESULTADO,'I','S','A','S','R','S','S','S','N','N')             comorbidity_value,
        to_char(f.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"')         updatetimestamp
       
from    ehr_reg_elemento f
        join EHR_REG_TEMPLATE r
        on f.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
        JOIN EHR_REGISTRO v
        on r.NR_SEQ_REG = v.NR_SEQUENCIA
WHERE v.nr_seq_templ = 100764
AND f.NR_REGISTRO_CLUSTER IS NULL
--AND v.NR_ATENDIMENTO = 564

UNION 
 
SELECT   v.nr_atendimento             visit_id,
            epimed_obter_data_entrada(v.nr_atendimento) unitadmissiondatetime,
         e.NR_SEQUENCIA                   comorbidity_id,
         to_char(e.nr_seq_temp_conteudo)     comorbidity_code,
         ''     comorbidity_site_code,
         e.DS_RESULTADO             comorbidity_value,
        to_char(e.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"')          updatetimestamp
       
FROM    ehr_reg_elemento e
        join EHR_REG_TEMPLATE r
        on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
        JOIN EHR_REGISTRO v
        on r.NR_SEQ_REG = v.NR_SEQUENCIA
WHERE  v.nr_seq_templ = 100764
AND e.nr_seq_temp_conteudo IN (291601,291602,291609,291604,291608,291610,291606,291612,291613,291618,291624,291619,291625,291622,291626,
291620,291627,291628,291629,291570,291574,291568,291572,291573,291575,291571,291578,291579,291580,291581,291582,291583,291586,291587,291596,
291595,291594,291593,291592,291591,291597,291590,291600)
--AND v.NR_ATENDIMENTO = 564

UNION

SELECT v.nr_atendimento             visit_id,
         epimed_obter_data_entrada(v.nr_atendimento) unitadmissiondatetime,
        e.NR_SEQUENCIA                   comorbidity_id,
        to_char(CASE WHEN x.ds_label_grid = 'META'  THEN 291617
                            WHEN x.ds_label_grid = 'LOCO' THEN 291616
                            ELSE NULL
                            END) as      comorbidity_code,
       to_char(e.nr_seq_temp_conteudo)     comorbidity_site_code,
        e.DS_RESULTADO             comorbidity_value,
        to_char(e.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"')          updatetimestamp
       
FROM    ehr_reg_elemento e
        join EHR_REG_TEMPLATE r
        on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
        JOIN EHR_REGISTRO v
        on r.NR_SEQ_REG = v.NR_SEQUENCIA
        JOIN ehr_template_conteudo x
        ON x.nr_sequencia = e.nr_seq_temp_conteudo
WHERE  v.nr_seq_templ = 100764
AND e.NR_REGISTRO_CLUSTER IS NOT NULL
--AND v.NR_ATENDIMENTO = 564
AND e.nr_seq_temp_conteudo NOT IN (291601,291602,291609,291604,291608,291610,291606,291612,291613,291618,291617,291624,291619,291616,291625,291622,291626,
291620,291627,291628,291629,291630,291570,291574,291568,291572,291573,291575,291571,291578,291579,291580,291581,291582,291583,291586,291587,291596,
291595,291594,291593,291592,291591,291597,291590,291600)
ORDER BY comorbidity_id) w

JOIN ehr_reg_elemento e
ON w.comorbidity_id = e.NR_SEQUENCIA
JOIN EHR_REG_TEMPLATE r
ON e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA 

GRANT SELECT ON TASY.HMDCC_EPIMED_COMORBIDADE_V TO USR_ALESSANDER;  

CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_DIAGNOSTICO_V
AS 
SELECT DISTINCT    	visit_id,
                     diagnosis_id,
                     substr(hmdcc_obter_dados_template(r.NR_SEQUENCIA,'Origem'),1,2) diagnosis_origin_code,                       
                     substr(diagnosis_code,1,15) diagnosis_code,
                     diagnosis_date,
                     substr(decode(hmdcc_obter_dados_template(r.NR_SEQUENCIA,'Classificação'),0,'2',1,'1'),1,1) is_main_diagnosis,
                     diagnosis_event,
                     diagnosis_created_on

FROM (
        SELECT v.NR_ATENDIMENTO visit_id,
                    e.NR_SEQUENCIA diagnosis_id,
                    r.nr_seq_reg seq_reg,
                    e.DS_RESULTADO  diagnosis_origin_code, --elemento origem do diagnóstico 291113
                   '' diagnosis_code,
                    to_char(v.dt_registro,'YYYY-MM-DD"T"HH24:MI:SS."000"') diagnosis_date,
                    substr('',1,1)  is_main_diagnosis, --indica quando um diagnóstico é primário ou secundário 290687
                    nvl2(v.dt_inativacao,'2','1') diagnosis_event,
                    to_char(e.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"') diagnosis_created_on
        FROM ehr_reg_elemento e
                join EHR_REG_TEMPLATE r
                on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
                JOIN EHR_REGISTRO v
                on r.NR_SEQ_REG = v.NR_SEQUENCIA
        WHERE v.NR_SEQ_TEMPL = 100719
        AND e.nr_seq_temp_conteudo = 291113
        
          
          UNION
          
          SELECT v.NR_ATENDIMENTO visit_id,
                    e.NR_SEQUENCIA diagnosis_id,
                    r.nr_seq_reg seq_reg,
                    '' diagnosis_origin_code, --elemento origem do diagnóstico 291113
                     e.DS_RESULTADO   diagnosis_code,
                    to_char(v.dt_registro,'YYYY-MM-DD"T"HH24:MI:SS."000"') diagnosis_date,
                    substr('',1,1)  is_main_diagnosis, --indica quando um diagnóstico é primário ou secundário 290687
                    nvl2(v.dt_inativacao,'2','1') diagnosis_event,
                    to_char(e.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"') diagnosis_created_on
        FROM ehr_reg_elemento e
                join EHR_REG_TEMPLATE r
                on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
                JOIN EHR_REGISTRO v
                on r.NR_SEQ_REG = v.NR_SEQUENCIA
        WHERE v.NR_SEQ_TEMPL = 100719
        AND e.nr_seq_temp_conteudo NOT IN (291113,291114,290687)
        
        
        UNION 
        
        SELECT v.NR_ATENDIMENTO visit_id,
                    e.NR_SEQUENCIA diagnosis_id,
                    r.nr_seq_reg seq_reg,
                    '' diagnosis_origin_code, --elemento origem do diagnóstico 291113
                    ''   diagnosis_code,
                    to_char(v.dt_registro,'YYYY-MM-DD"T"HH24:MI:SS."000"') diagnosis_date,
                    CASE WHEN e.nr_seq_temp_conteudo = 290687 THEN e.DS_RESULTADO
                    ELSE ''
                    END AS  is_main_diagnosis, --indica quando um diagnóstico é primário ou secundário 290687
                    nvl2(v.dt_inativacao,'2','1') diagnosis_event,
                    to_char(e.dt_atualizacao,'YYYY-MM-DD"T"HH24:MI:SS."000"') diagnosis_created_on
        FROM ehr_reg_elemento e
                join EHR_REG_TEMPLATE r
                on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
                JOIN EHR_REGISTRO v
                on r.NR_SEQ_REG = v.NR_SEQUENCIA
        WHERE v.NR_SEQ_TEMPL = 100719
        AND e.nr_seq_temp_conteudo = 290687
        
        
          
          
        ORDER BY 2
        ) w
        
    JOIN EHR_REG_TEMPLATE r
    ON r.NR_SEQ_REG = w.seq_reg
    JOIN EHR_REGISTRO v
    on r.NR_SEQ_REG = v.NR_SEQUENCIA
    LEFT JOIN ATENDIMENTO_PACIENTE a
    ON v.NR_ATENDIMENTO = a.NR_ATENDIMENTO
    LEFT JOIN ATEND_PACIENTE_UNIDADE u
    ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO
    LEFT JOIN SETOR_ATENDIMENTO s
    ON u.CD_SETOR_ATENDIMENTO = s.CD_SETOR_ATENDIMENTO
        

WHERE  nvl(s.ie_epimed, 'N') = 'S'
AND v.dt_liberacao IS NOT null  
AND v.NR_SEQ_TEMPL = 100719
and    a.dt_cancelamento is null
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
AND v.CD_SETOR_ATENDIMENTO = u.CD_SETOR_ATENDIMENTO
AND v.CD_UNIDADE = u.CD_UNIDADE_BASICA||' '||u.CD_UNIDADE_COMPL
AND w.diagnosis_code IS NOT null 
AND length(diagnosis_code) >5
ORDER BY 5

GRANT SELECT ON TASY.HMDCC_EPIMED_DIAGNOSTICO_V TO USR_ALESSANDER;

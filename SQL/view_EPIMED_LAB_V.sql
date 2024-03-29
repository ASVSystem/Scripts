CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_LAB_V
AS SELECT  distinct
            obter_prontuario_atendimento(R.NR_ATENDIMENTO) patienteid,
            r.NR_ATENDIMENTO visitid,
            hmdcc_obter_dt_coleta_lab(i.nr_seq_resultado, i.nr_seq_exame) axam_date,
            i.NR_SEQ_EXAME id_exam,
            OBTER_CD_EXAME_RESULT(i.NR_SEQ_RESULTADO,i.NR_SEQ_EXAME,i.NR_SEQUENCIA) exam_cod,
            rtrim(rtrim(to_char(qt_resultado, 'FM999,990.990'),'0'),'.') exam_value,
            --substr(i.QT_RESULTADO,1,100) exam_value,
            i.DS_UNIDADE_MEDIDA unit_of_measure
            

FROM    EXAME_LAB_RESULT_ITEM i
        JOIN EXAME_LAB_RESULTADO R
        ON I.NR_SEQ_RESULTADO = r.NR_SEQ_RESULTADO
        JOIN ATEND_PACIENTE_UNIDADE u
        ON r.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO

WHERE    
        r.DT_RESULTADO IS NOT NULL
AND        i.NR_SEQ_EXAME IN (3030,3041,9,27,873,2037,2271,2272,2273)
AND        u.cd_tipo_acomodacao = 5
AND        hmdcc_obter_dt_coleta_lab(i.nr_seq_resultado, i.nr_seq_exame) IS NOT null
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))


UNION

--PA Sistólica / diastólica (PA máx mmHg)
SELECT
            obter_prontuario_atendimento(v.NR_ATENDIMENTO) patienteid,
            v.NR_ATENDIMENTO visitid,
            to_char(v.DT_SINAL_VITAL,'YYYY-MM-DD HH24:MI:SS') axam_date,
            v.NR_SEQUENCIA id_exam,
            'PA' exam_cod,
            substr(v.QT_PA_SISTOLICA||'/'||v.QT_PA_DIASTOLICA,1,100) exam_value,
            'mmHg' unit_of_measure

FROM    ATENDIMENTO_SINAL_VITAL v
        JOIN atend_paciente_unidade u
        ON v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO

WHERE    
        v.IE_SITUACAO = 'A'
AND        v.DT_LIBERACAO IS NOT NULL
AND		v.QT_PA_SISTOLICA IS NOT null
AND        u.cd_tipo_acomodacao = 5
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))



UNION

--Frequencia Cardiaca (FC bpm)
SELECT
            obter_prontuario_atendimento(v.NR_ATENDIMENTO) patienteid,
            v.NR_ATENDIMENTO visitid,
            to_char(v.DT_SINAL_VITAL,'YYYY-MM-DD HH24:MI:SS') axam_date,
            v.NR_SEQUENCIA id_exam,
            'FC' exam_cod,
            substr(v.QT_FREQ_CARDIACA,1,100) exam_value,
            'bpm' unit_of_measure

FROM    ATENDIMENTO_SINAL_VITAL v
        JOIN atend_paciente_unidade u
        ON v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO

WHERE    
        v.IE_SITUACAO = 'A'
AND        v.DT_LIBERACAO IS NOT NULL
AND 	v.QT_FREQ_CARDIACA IS NOT null
AND        u.cd_tipo_acomodacao = 5
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))

      
UNION

--Frequencia Respiratoria (FR irpm)
SELECT
            obter_prontuario_atendimento(v.NR_ATENDIMENTO) patienteid,
            v.NR_ATENDIMENTO visitid,
            to_char(v.DT_SINAL_VITAL,'YYYY-MM-DD HH24:MI:SS') axam_date,
            v.NR_SEQUENCIA id_exam,
            'FR' exam_cod,
            substr(v.QT_FREQ_RESP,1,100) exam_value,
            'irpm' unit_of_measure

FROM    ATENDIMENTO_SINAL_VITAL v
        JOIN atend_paciente_unidade u
        ON v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO

WHERE    
        v.IE_SITUACAO = 'A'
AND        v.DT_LIBERACAO IS NOT NULL
AND 		v.QT_FREQ_RESP IS NOT null
AND        u.cd_tipo_acomodacao = 5
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))

       
UNION

--Temperatura (TEMP ºC)
SELECT
            obter_prontuario_atendimento(v.NR_ATENDIMENTO) patienteid,
            v.NR_ATENDIMENTO visitid,
            to_char(v.DT_SINAL_VITAL,'YYYY-MM-DD HH24:MI:SS') axam_date,
            v.NR_SEQUENCIA id_exam,
            'TEMP' exam_cod,
            substr(v.QT_TEMP,1,100) exam_value,
            'ºC' unit_of_measure

FROM    ATENDIMENTO_SINAL_VITAL v
        JOIN atend_paciente_unidade u
        ON v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO

WHERE    
        v.IE_SITUACAO = 'A'
AND        v.DT_LIBERACAO IS NOT NULL
AND        v.QT_TEMP IS NOT NULL
AND        u.cd_tipo_acomodacao = 5
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))


        
UNION 

--Monitorização Resp (FiO2 %)
SELECT
            obter_prontuario_atendimento(v.NR_ATENDIMENTO) patienteid,
            v.NR_ATENDIMENTO visitid,
            to_char(v.DT_MONITORIZACAO,'YYYY-MM-DD HH24:MI:SS') axam_date,
            v.NR_SEQUENCIA id_exam,
            'FIO2' exam_cod,
            substr(v.QT_FIO2,1,100) exam_value,
            '%' unit_of_measure

FROM    ATENDIMENTO_MONIT_RESP v
        JOIN atend_paciente_unidade u
        ON v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO

WHERE    
           v.IE_SITUACAO = 'A'
AND        v.DT_LIBERACAO IS NOT NULL
AND   		v.QT_FIO2 IS NOT NULL
AND        u.cd_tipo_acomodacao = 5
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))

        
UNION  
        
--Glasgow (GLAS Pt)
SELECT
            obter_prontuario_atendimento(v.NR_ATENDIMENTO) patienteid,
            v.NR_ATENDIMENTO visitid,
            to_char(v.DT_AVALIACAO,'YYYY-MM-DD HH24:MI:SS') axam_date,
            v.NR_SEQUENCIA id_exam,
            'GLAS' exam_cod,
            substr(v.QT_GLASGOW,1,100) exam_value,
            'Pontos' unit_of_measure

FROM    ESCALA_SAPS3 v
        JOIN atend_paciente_unidade u
        ON v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
        JOIN ATENDIMENTO_PACIENTE a
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO

WHERE    
        v.IE_SITUACAO = 'A'
AND        v.DT_LIBERACAO IS NOT NULL
AND        u.cd_tipo_acomodacao = 5
AND        u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
        
      
ORDER BY 3,2 



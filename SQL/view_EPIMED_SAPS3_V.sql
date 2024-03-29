--CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_SAPS3_V
--AS

SELECT v.NR_ATENDIMENTO 														visit_id,
	   to_char(max(u.DT_ENTRADA_UNIDADE), 'YYYY-MM-DD HH24:MI:SS')				unitadmissiondatetime,
	   v.NR_SEQUENCIA		 													saps3_id,
	   decode(v.IE_CARDIOLOGICA,-5,'ARR',3,'CHO',500,'SEP',5 ,'ANA')	saps3_code,
	   decode(v.IE_CARDIOLOGICA,0,0,1) 														saps3_value,
	   to_char(v.DT_ATUALIZACAO, 'YYYY-MM-DD HH24:MI:SS') 						updatetimestamp

FROM    ESCALA_SAPS3 v
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
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
 
AND a.NR_ATENDIMENTO = 152880 
        
GROUP BY v.NR_ATENDIMENTO, v.NR_SEQUENCIA,  v.IE_CARDIOLOGICA,  v.DT_ATUALIZACAO

UNION

SELECT v.NR_ATENDIMENTO													visit_id,
	   to_char(max(u.DT_ENTRADA_UNIDADE), 'YYYY-MM-DD HH24:MI:SS')		unitadmissiondatetime,
	   v.NR_SEQUENCIA		 											saps3_id,
	   decode(v.IE_ABDOMEM,3,'AAG',9,'PSEV')			saps3_code,
	   decode(v.IE_ABDOMEM,0,0,1) 													saps3_value,
	   to_char(v.DT_ATUALIZACAO, 'YYYY-MM-DD HH24:MI:SS') 				updatetimestamp

FROM    ESCALA_SAPS3 v
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
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))


AND a.NR_ATENDIMENTO = 152880

GROUP BY v.NR_ATENDIMENTO, v.NR_SEQUENCIA,  v.IE_ABDOMEM,  v.DT_ATUALIZACAO

UNION

SELECT v.NR_ATENDIMENTO													visit_id,
	   to_char(max(u.DT_ENTRADA_UNIDADE), 'YYYY-MM-DD HH24:MI:SS')		unitadmissiondatetime,
	   v.NR_SEQUENCIA		 											saps3_id,
	   decode(v.IE_HEPATICO,6,'IHP')			saps3_code,
	   decode(v.IE_HEPATICO,0,0,1) 													saps3_value,
	   to_char(v.DT_ATUALIZACAO, 'YYYY-MM-DD HH24:MI:SS') 				updatetimestamp

FROM    ESCALA_SAPS3 v
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
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))


AND a.NR_ATENDIMENTO = 152880

GROUP BY v.NR_ATENDIMENTO, v.NR_SEQUENCIA,  v.IE_HEPATICO,  v.DT_ATUALIZACAO

ORDER BY 4,2






--
--SELECT ie_cardiologica,
--		ie_hepatico,
--		ie_abdomem,
--		ie_neurologica,
--		ie_tipo_operacao sitio_cirurgia,
--		IE_INFEC_NOSOCOMIAL,
--		IE_INFEC_RESP
--		
--		
--
-- FROM ESCALA_SAPS3
--WHERE NR_ATENDIMENTO = 152880
--AND TRUNC(DT_AVALIACAO) = '28/03/2019'
--




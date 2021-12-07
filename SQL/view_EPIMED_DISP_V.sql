CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_DISP_V
AS 
SELECT DISTINCT
		v.NR_ATENDIMENTO 								    		visit_id,
	   to_char(v.DT_INSTALACAO, 'YYYY-MM-DD"T"HH24:MI:SS') 			placement_date,
	   v.NR_SEQUENCIA		 										invasive_device_id,
	   v.NR_SEQ_DISPOSITIVO											invasive_device_code,
	   v.NR_SEQ_TOPOGRAFIA 											device_site_code,
	   v.IE_LADO 													device_laterality_code,
	   to_char(v.DT_RETIRADA, 'YYYY-MM-DD"T"HH24:MI:SS') 				removal_date,
	   to_char(v.DT_ATUALIZACAO, 'YYYY-MM-DD"T"HH24:MI:SS') 			updatetimestamp
	   
FROM		ATEND_PAC_DISPOSITIVO v
		
		JOIN ATENDIMENTO_PACIENTE a
        ON v.NR_ATENDIMENTO = a.NR_ATENDIMENTO
        
        JOIN atend_paciente_unidade u
        ON a.NR_ATENDIMENTO = u.NR_ATENDIMENTO   
                 
        JOIN SETOR_ATENDIMENTO s
        ON u.CD_SETOR_ATENDIMENTO = s.CD_SETOR_ATENDIMENTO
        

WHERE    v.NR_ATENDIMENTO = u.NR_ATENDIMENTO
AND nvl(s.ie_epimed, 'N')				= 'S'
and      u.CD_UNIDADE_BASICA NOT LIKE '%Cons%'
and      u.CD_UNIDADE_COMPL NOT LIKE '%LV%'
and    (a.dt_alta is null or (a.dt_alta between (trunc(sysdate) - (select nvl(max(g.qt_dias_alta_epimed),0) from parametro_Atendimento g)) and sysdate))
and    nvl(u.ie_passagem_setor,'N')  in  ('N','L')
and    a.dt_cancelamento is null
and    (((select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j) = 0) or
    (u.dt_entrada_unidade >= sysdate - (select abs(nvl(max(j.nr_min_mov_epimed),0)) from parametro_Atendimento j)/1440))
AND a.nr_atendimento NOT IN(564,26253,81490,110912,127584,129214,146188)       

ORDER BY 2,3 

GRANT SELECT ON TASY.HMDCC_EPIMED_DISP_V TO USR_ALESSANDER;





















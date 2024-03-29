--CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_COMORB_V
--AS

SELECT v.NR_ATENDIMENTO 		visit_id,
	   max(u.DT_ENTRADA_UNIDADE)		unitadmissiondatetime,
	   v.NR_SEQUENCIA		 	comorbidity_id,
	   --d.DS_DISP_ADEP 			comorbidity_code,
	  -- v.NR_SEQ_TOPOGRAFIA 		comorbidity_site_code,
	   v.QT_PONTUACAO 				comorbidity_value,
	   v.DT_ATUALIZACAO 		updatetimestamp

FROM    ESCALA_CHARLSON v
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
        
group BY v.NR_ATENDIMENTO, v.NR_SEQUENCIA,  v.QT_PONTUACAO, v.DT_ATUALIZACAO   
ORDER BY 3,2 





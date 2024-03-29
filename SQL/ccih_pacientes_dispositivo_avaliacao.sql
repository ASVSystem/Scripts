--SELECT DISTINCT nr_atendimento, nm_paciente, setor_atend, ds_leito, ds_dispositivo, local_instalacao, 
----dt_dispositivo
--(SELECT DISTINCT   LISTAGG(to_char(dt_dispositivo, 'dd/mm/yyyy'),', ') WITHIN GROUP (ORDER BY dt_dispositivo, ds_dispositivo) FROM hmdcc_dispositivos_avaliacao b 
--	 WHERE a.nr_atendimento = b.nr_atendimento AND b.ds_dispositivo = a.ds_dispositivo 
--	 AND b.dt_dispositivo BETWEEN to_date('01/09/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss') AND to_date('10/09/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
--	 ) data_dispositivo  
--
--FROM hmdcc_dispositivos_avaliacao a
--WHERE  a.dt_dispositivo BETWEEN to_date('01/09/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss') AND to_date('10/09/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
----AND nr_atendimento = 298658
--AND DS_DISPOSITIVO = 'CDL'
--ORDER BY nm_paciente, ds_dispositivo


SELECT DISTINCT nr_atendimento, nm_paciente, setor_atend, ds_leito, ds_dispositivo, local_instalacao, 
--to_char(dt_dispositivo, 'dd/mm/yyyy') dt_dispositivo
(SELECT DISTINCT   LISTAGG(to_char(dt_dispositivo, 'dd/mm/yyyy'),',') WITHIN GROUP (ORDER BY dt_dispositivo) FROM hmdcc_dispositivos_avaliacao b 
	 WHERE a.nr_atendimento = b.nr_atendimento AND b.ds_dispositivo = a.ds_dispositivo AND b.ds_leito = a.ds_leito
	 AND b.dt_dispositivo BETWEEN to_date('01/02/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss') AND to_date('16/02/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
	 
	 ) data_dispositivo 

FROM hmdcc_dispositivos_avaliacao a
WHERE  TRUNC(a.dt_dispositivo) BETWEEN '01/02/2021' AND '16/02/2021'
AND a.nr_atendimento =287655
--GROUP BY nr_atendimento, nm_paciente, setor_atend, ds_leito, ds_dispositivo, local_instalacao
ORDER BY a.nm_paciente, a.ds_dispositivo














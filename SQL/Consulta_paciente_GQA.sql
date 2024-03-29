select  a.nr_atendimento,
		 to_char(min(a.dt_evolucao),'dd/mm/yyyy hh24:mi:ss') primeira_dt_reg,
		 to_char(max(a.dt_evolucao),'dd/mm/yyyy hh24:mi:ss') ultima_dt_reg,
		a.dt_liberacao,
		a.nm_usuario,
		a.dt_evolucao
--		a.dt_atualizacao
--		a.cd_medico,
--		a.cd_evolucao
		--a.ds_evolucao
		
	from 	evolucao_paciente a

	where   nvl(a.ie_situacao,'A') = 'A'
	
	AND a.CD_SETOR_ATENDIMENTO IN (32,39,49)
	AND a.DT_LIBERACAO IS NOT null
	AND TRUNC(obter_data_entrada(a.nr_atendimento))    BETWEEN '01/07/2020' AND '31/12/2020' -- data entrada no CTI  --to_date('dd/mm/yyyy hh24:mi:ss', '01/06/2020 00:00:00') 
 												   --and to_date('dd/mm/yyyy hh24:mi:ss', '30/09/2020 23:59:59')
 												
	and     (obter_se_long_contem_texto(  	'EVOLUCAO_PACIENTE',
						'DS_EVOLUCAO',
						'WHERE CD_EVOLUCAO = :CD_EVOLUCAO',
						'CD_EVOLUCAO='||a.cd_evolucao,
						'prona') = 'S')
					 
GROUP BY a.nr_atendimento,
		a.dt_liberacao,
		a.nm_usuario,
		a.dt_evolucao
		
		



--============================================================================

SELECT primeiro_dia_prona,
		 ultimo_dia_prona,
		 primeiro_dia_lesao,
		 ultimo_dia_lesao,
 		 e.nr_atendimento atendimento,
 		 a.nr_anos idade,
 		 to_char(TRUNC(a.qt_dia_internado)) dias_internado,
 		 to_char(decode(a.ie_sexo,'F',1,'M',2)) sexo,
 		 obter_dados_aval_nutric(e.nr_atendimento,'DN') diag_nutric,
 		 TRUNC(avg(n.qt_imc)) imc, --média do IMC do paciente na internação
 		 obter_sinal_vital(e.NR_ATENDIMENTO,'GC') glicemia_capilar,
		 to_date(min(b.dt_braden),'dd-mm-yy' ) dt_primeiro_braden,
 		 substr(hmdcc_obter_primeiro_braden(e.NR_ATENDIMENTO),21,50) primeiro_braden, --function criada na base de homologação
 		 
		 to_date(max(b.dt_braden),'dd-mm-yy' ) dt_ultimo_braden,
 		 substr(obter_result_escala_braden(e.NR_ATENDIMENTO),21,50) ultimo_braden


FROM (SELECT e.nr_atendimento nr_atendimento,
				to_date(min(e.dt_evolucao),'dd-mm-yy' ) primeiro_dia_prona,
		 		to_date(max(e.dt_evolucao),'dd-mm-yy' ) ultimo_dia_prona
		FROM  EVOLUCAO_PACIENTE e
		JOIN ATENDIMENTO_PACIENTE a
			ON e.nr_atendimento = a.nr_atendimento
		WHERE nvl(e.ie_situacao,'A') = 'A'
		AND e.CD_SETOR_ATENDIMENTO IN (32,39,49)
		AND a.DT_ENTRADA BETWEEN '01/08/2020' AND '10/08/2020'
		AND upper(remove_formatacao_rtf_html(
 		 	convert_long_to_varchar2('ds_evolucao', 'evolucao_paciente','cd_evolucao ='||to_char(e.cd_evolucao))
 		 	)) LIKE upper('%Pronação/Supinação :  Sim%')
 		GROUP BY e.nr_atendimento
			) e


	LEFT JOIN ATENDIMENTO_PACIENTE_v a
	ON e.nr_atendimento = a.nr_atendimento
	
	LEFT JOIN AVAL_NUTRICAO n
	ON a.nr_atendimento = a.nr_atendimento
	--and e.NR_ATENDIMENTO = n.nr_atendimento
	
	LEFT JOIN (SELECT to_date(min(e.dt_evolucao),'dd-mm-yy' ) primeiro_dia_lesao,
			       to_date(max(e.dt_evolucao),'dd-mm-yy' ) ultimo_dia_lesao,
	 		       e.nr_atendimento nr_atendimento
	
				FROM EVOLUCAO_PACIENTE e
				JOIN ATENDIMENTO_PACIENTE a
				ON e.nr_atendimento = a.nr_atendimento
				
				WHERE nvl(e.ie_situacao,'A') = 'A'
			
				AND e.CD_SETOR_ATENDIMENTO IN (32,39,49)
				AND a.DT_ENTRADA BETWEEN '01/08/2020' AND '10/08/2020'
				AND upper(remove_formatacao_rtf_html(
				 		 	convert_long_to_varchar2('ds_evolucao', 'evolucao_paciente','cd_evolucao ='||to_char(e.cd_evolucao))
				 		 	)) LIKE upper('%Portador de LP :  Sim%')
				 		 	
			GROUP BY e.nr_atendimento
			) x
				
	ON a.nr_atendimento = x.nr_atendimento
	--AND e.nr_atendimento = x.nr_atendimento
	
	JOIN (SELECT	b.nr_atendimento,
						b.dt_avaliacao dt_braden,
						b.qt_ponto qt_braden
				from 	atend_escala_braden b
				JOIN ATENDIMENTO_PACIENTE a
				ON b.nr_atendimento = a.nr_atendimento
				where 	b.dt_liberacao is not NULL
				AND a.DT_ENTRADA BETWEEN '01/08/2020' AND '10/08/2020'

			) b
						  
	ON a.nr_atendimento = b.nr_atendimento
	--AND e.nr_atendimento = b.nr_atendimento


--WHERE 
----AND e.IE_TIPO_EVOLUCAO IN ('3','10')	
----AND e.CD_SETOR_ATENDIMENTO IN (32,39,49)
-- a.DT_ENTRADA BETWEEN '01/08/2020' AND '31/08/2020'


GROUP BY e.nr_atendimento,
			primeiro_dia_prona,
		 	ultimo_dia_prona,
         primeiro_dia_lesao,
			ultimo_dia_lesao,
 		 	a.nr_anos,
 	 		a.qt_dia_internado,
 	 		a.ie_sexo
 
ORDER BY   e.nr_atendimento


--============================================================================


--SELECT COUNT(*) qt_evolucao,
--				obter_nome_pf(cd_medico) profissional,
--				(SELECT sum(COUNT(CD_PESSOA_FISICA))
--						
--						FROM EVOLUCAO_PACIENTE
--						WHERE IE_TIPO_EVOLUCAO = '16'
--						AND TRUNC(DT_EVOLUCAO,'MM') = '01-MAR-21'
--						AND DT_INATIVACAO IS NULL
--						AND DT_LIBERACAO IS NOT NULL
--						
--						HAVING count(*) < 2
--						GROUP BY CD_PESSOA_FISICA) "Pacientes com uma evolução"
--				
--FROM EVOLUCAO_PACIENTE
--WHERE IE_TIPO_EVOLUCAO = '16'
--AND TRUNC(DT_EVOLUCAO,'MM') = '01-MAR-21'
--AND DT_INATIVACAO IS NULL
--AND DT_LIBERACAO IS NOT null
----AND extract(MONTH FROM DT_EVOLUCAO) = 3
--GROUP BY rollup(cd_medico)


--=============================================================================

--SELECT to_date(min(e.dt_evolucao),'dd-mm-yy' ) primeiro_dia_prona,
--		 to_date(max(e.dt_evolucao),'dd-mm-yy' ) ultimo_dia_prona,
----		 to_char(min(e.dt_evolucao),'dd/mm/yyyy' ) primeiro_dia_prona,
----		 to_char(max(e.dt_evolucao),'dd/mm/yyyy' ) ultimo_dia_prona,
--		 primeiro_dia_lesao,
--		 ultimo_dia_lesao,
-- 		 e.nr_atendimento atendimento,
-- 		 a.nr_anos idade,
-- 		 to_char(TRUNC(a.qt_dia_internado)) dias_internado,
-- 		 to_char(decode(a.ie_sexo,'F',1,'M',2)) sexo,
-- 		 obter_dados_aval_nutric(e.nr_atendimento,'DN') diag_nutric,
-- 		 TRUNC(avg(n.qt_imc)) imc, --média do IMC do paciente na internação
-- 		 obter_sinal_vital(e.NR_ATENDIMENTO,'GC') glicemia_capilar,
--		 to_date(min(b.dt_braden),'dd-mm-yy' ) dt_primeiro_braden,
-- 		 substr(hmdcc_obter_primeiro_braden(e.NR_ATENDIMENTO),21,50) primeiro_braden, --function criada na base de homologação
-- 		 
--		 to_date(max(b.dt_braden),'dd-mm-yy' ) dt_ultimo_braden,
-- 		 substr(obter_result_escala_braden(e.NR_ATENDIMENTO),21,50) ultimo_braden
--
--
--FROM EVOLUCAO_PACIENTE e
--	JOIN ATENDIMENTO_PACIENTE_v a
--	ON e.nr_atendimento = a.nr_atendimento
--	JOIN AVAL_NUTRICAO n
--	ON a.nr_atendimento = a.nr_atendimento
--	and e.NR_ATENDIMENTO = n.nr_atendimento
--	JOIN (SELECT to_date(min(e.dt_evolucao),'dd-mm-yy' ) primeiro_dia_lesao,
--			       to_date(max(e.dt_evolucao),'dd-mm-yy' ) ultimo_dia_lesao,
--	 		       e.nr_atendimento nr_atendimento
--	
--				FROM EVOLUCAO_PACIENTE e
--				JOIN ATENDIMENTO_PACIENTE_v a
--				ON e.nr_atendimento = a.nr_atendimento
--				WHERE nvl(e.ie_situacao,'A') = 'A'
--				--AND e.IE_TIPO_EVOLUCAO IN ('3','10')	
--				AND e.CD_SETOR_ATENDIMENTO IN (32,39,49)
--				AND a.DT_ENTRADA BETWEEN '01/09/2020' AND '30/09/2020'
--				AND upper(remove_formatacao_rtf_html(
--				 		 	convert_long_to_varchar2('ds_evolucao', 'evolucao_paciente','cd_evolucao ='||to_char(e.cd_evolucao))
--				 		 	)) LIKE upper('%Portador de LP :  Sim%')
--				 		 	
--				GROUP BY e.nr_atendimento) x
--				
--	ON e.nr_atendimento = x.nr_atendimento
--	AND a.nr_atendimento = x.nr_atendimento
--	
--	JOIN (SELECT	b.nr_atendimento,
--						b.dt_avaliacao dt_braden,
--						b.qt_ponto qt_braden
--				from 	atend_escala_braden b
--				where 	b.dt_liberacao is not NULL
--				AND b.DT_ATUALIZACAO BETWEEN '01/09/2020' AND '30/09/2020'
--				
--			) b
--						  
--	ON e.nr_atendimento = b.nr_atendimento
--	AND a.nr_atendimento = b.nr_atendimento
--	--AND n.nr_atendimento = b.nr_atendimento
--
--WHERE nvl(e.ie_situacao,'A') = 'A'
----AND e.IE_TIPO_EVOLUCAO IN ('3','10')	
--AND e.CD_SETOR_ATENDIMENTO IN (32,39,49)
--AND a.DT_ENTRADA BETWEEN '01/09/2020' AND '30/09/2020'
--AND upper(remove_formatacao_rtf_html(
-- 		 	convert_long_to_varchar2('ds_evolucao', 'evolucao_paciente','cd_evolucao ='||to_char(e.cd_evolucao))
-- 		 	)) LIKE upper('%Pronação/Supinação :  Sim%')
----AND upper(remove_formatacao_rtf_html(
---- 		 	convert_long_to_varchar2('ds_evolucao', 'evolucao_paciente','cd_evolucao ='||to_char(e.cd_evolucao))
---- 		 	)) LIKE upper('%Portador de LP :  Sim%')
-- 		 	
--GROUP BY e.nr_atendimento,
--         primeiro_dia_lesao,
--			 ultimo_dia_lesao,
-- 		 a.nr_anos,
-- 	 a.qt_dia_internado,
-- 	 a.ie_sexo
-- 
--ORDER BY   e.nr_atendimento


SELECT DISTINCT To_char(Count(a.nr_prescricao)) prescr_realizadas, 
Nvl(Substr(Obter_desc_status_farm(a.nr_seq_status_farm), 1, 150), 'Prescrições Sem Status: ') ds_status,
Obter_nome_pf(a.cd_farmac_lib) nm_farmaceutico, 
''                qt_intervencao,
''                total_prescr_medica,
''total_pacientes

FROM   prescr_medica a
	  
WHERE  a.dt_liberacao IS NOT NULL 
       AND a.dt_suspensao IS NULL 
       AND a.nr_atendimento <> 564
       AND obter_se_medico(a.cd_prescritor,'M') = 'S'
       AND Obter_itens_prescr_filtro('1, 2, 3, 4', A.NR_PRESCRICAO) = 'S'  
       --AND  nvl(obter_se_medic_padronizado(a.nr_prescricao),'S') = 'S'  
       AND EXISTS (SELECT 1 
                   FROM   prescr_material b 
                   WHERE  a.nr_prescricao = b.nr_prescricao) 
AND	(a.dt_prescricao between '01/01/2020'
	           	           AND	fim_dia('05/01/2020')) 
	    AND  to_char(a.dt_prescricao,'HH24:MI:SS') between ('07:00:00') and ('15:59:59')
--and ((a.cd_setor_atendimento =:setor) or (:setor ='0'))
group by rollup(a.cd_farmac_lib ), a.nr_seq_status_farm

UNION
--Total de Prescrições
SELECT   '' qt_prescricoes,
                 '' ds_status,
                 '' nm_farmaceutico,
                 '' qt_intervencao,
'Total Prescrições: '||To_char(Count(a.nr_prescricao)) total_prescr_medica,
''total_pacientes

FROM   prescr_medica a 

WHERE  a.dt_liberacao IS NOT NULL 
       AND a.dt_suspensao IS NULL 
       AND a.nr_atendimento <> 564
       AND obter_se_medico(a.cd_prescritor,'M') = 'S'
       AND Obter_itens_prescr_filtro('1, 2, 3, 4', A.NR_PRESCRICAO) = 'S'  
       --AND  nvl(obter_se_medic_padronizado(a.nr_prescricao),'S') = 'S'  
       AND EXISTS (SELECT 1 
                   FROM   prescr_material b 
                   WHERE  a.nr_prescricao = b.nr_prescricao) 
AND	(a.dt_prescricao between '01/01/2020'
	           	           AND	fim_dia('05/01/2020')) 
	    AND  to_char(a.dt_prescricao,'HH24:MI:SS') between ('07:00:00') and ('15:59:59')
        --AND ((a.cd_setor_atendimento =:setor) or (:setor ='0')) 
        
UNION

--Total de PACIENTES ACOMPANHADOS
SELECT   '' qt_prescricoes,
                 '' ds_status,
                 '' nm_farmaceutico,
                 '' qt_intervencao,
                 '' total_prescr_medica,
'Total Pacientes: '||To_char(count(Count(a.nr_prescricao))) total_pacientes


FROM   prescr_medica a 

WHERE  a.dt_liberacao IS NOT NULL 
       AND a.dt_suspensao IS NULL 
       AND a.nr_atendimento <> 564
       AND obter_se_medico(a.cd_prescritor,'M') = 'S'
       AND Obter_itens_prescr_filtro('1, 2, 3, 4', A.NR_PRESCRICAO) = 'S'  
       --AND  nvl(obter_se_medic_padronizado(a.nr_prescricao),'S') = 'S'  
       AND EXISTS (SELECT 1 
                   FROM   prescr_material b 
                   WHERE  a.nr_prescricao = b.nr_prescricao) 
AND	(a.dt_prescricao between '01/01/2020'
	           	           AND	fim_dia('05/01/2020')) 
	    AND  to_char(a.dt_prescricao,'HH24:MI:SS') between ('07:00:00') and ('15:59:59')
        --AND ((a.cd_setor_atendimento =:setor) or (:setor ='0'))
        AND a.dt_inicio_analise_farm IS NOT null
GROUP BY a.nr_atendimento

UNION

SELECT  '' prescr_realizadas,
           '' ds_status,
           ''  nm_farmaceutico,
           'Quantidade Intervenções PWDT: '|| TO_CHAR(COUNT(nr_prescricao)) qt_intervencao,
           ''                total_prescr_medica,
           ''total_pacientes

FROM MED_AVALIACAO_PACIENTE

WHERE NR_SEQ_TIPO_AVALIACAO = 263
AND	(dt_liberacao between '01/01/2020'
	           	           AND	fim_dia('05/01/2020')) 
	    AND  to_char(dt_liberacao,'HH24:MI:SS') between ('07:00:00') and ('15:59:59')
and CD_PESSOA_FISICA not in (734)
--and ((cd_setor_atendimento =:setor) or (:setor ='0'))

order by nm_farmaceutico,ds_status
			
			
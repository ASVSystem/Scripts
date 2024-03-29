SELECT DISTINCT To_char(Count(a.nr_prescricao)) qt_prescricoes, 
Nvl(Substr(Obter_desc_status_farm(a.nr_seq_status_farm), 1, 150), 'Prescrições Sem Status: ') ds_status,
Obter_nome_pf(a.cd_farmac_lib) nm_farmaceutico, 
''                qt_intervencao,
''				 total_prescr_medica

FROM   prescr_medica a 

WHERE  a.dt_liberacao IS NOT NULL 
       AND a.dt_suspensao IS NULL 
       AND a.nr_atendimento <> 564
       AND obter_se_medico(a.cd_prescritor,'M') = 'S'
       --AND Obter_funcao_usuario(a.nm_usuario_original) = '1' --Na função não é utilizado esse filtro
       --AND  nvl(obter_se_medic_padronizado(a.nr_prescricao),'S') = 'S'
       AND Obter_itens_prescr_filtro('1, 2, 3, 4', A.NR_PRESCRICAO) = 'S' 
       AND EXISTS (SELECT 1 
                   FROM   prescr_material b 
                   WHERE  a.nr_prescricao = b.nr_prescricao) 
       AND ( a.dt_prescricao BETWEEN To_date('28/10/2019 07:00:00','dd/mm/yyyy hh24:mi:ss') 
                                AND 
                                To_date('28/10/2019 16:00:00','dd/mm/yyyy hh24:mi:ss')  ) 
       AND a.cd_setor_atendimento = 32
     --((a.cd_setor_atendimento =:setor) or (:setor ='0')) 
GROUP  BY rollup( a.cd_farmac_lib ), 
          a.nr_seq_status_farm
          
UNION

SELECT DISTINCT '' qt_prescricoes,
                '' ds_status,
                '' nm_farmaceutico,
                '' qt_intervencao,
To_char(Count(a.nr_prescricao)) total_prescr_medica

FROM   prescr_medica a 

WHERE  a.dt_liberacao IS NOT NULL 
       AND a.dt_suspensao IS NULL 
       AND a.nr_atendimento <> 564
       AND obter_se_medico(a.cd_prescritor,'M') = 'S'
       AND Obter_itens_prescr_filtro('1, 2, 3, 4', A.NR_PRESCRICAO) = 'S'       
       AND EXISTS (SELECT 1 
                   FROM   prescr_material b 
                   WHERE  a.nr_prescricao = b.nr_prescricao) 
       AND ( a.dt_prescricao BETWEEN To_date('28/10/2019 07:00:00','dd/mm/yyyy hh24:mi:ss') 
                                AND 
                                To_date('28/10/2019 16:00:00','dd/mm/yyyy hh24:mi:ss')  ) 
       AND a.cd_setor_atendimento = 32
     --((a.cd_setor_atendimento =:setor) or (:setor ='0'))
     --AND Obter_funcao_usuario(a.nm_usuario_original) = '1' --Na função não é utilizado esse filtro
     --AND  nvl(obter_se_medic_padronizado(a.nr_prescricao),'S') = 'S'
   
          
UNION 

SELECT ''                               prescr_realizadas, 
       ''                               ds_status, 
       ''                               nm_farmaceutico, 
       'Quantidade Intervenções PWDT: ' 
       || To_char(Count(nr_prescricao)) qt_intervencao,
       ''                               total_prescr_medica
FROM   med_avaliacao_paciente 
WHERE  nr_seq_tipo_avaliacao = 263 
       AND dt_liberacao BETWEEN To_date('28/10/2019 07:00:00','dd/mm/yyyy hh24:mi:ss') 
                                AND 
                                To_date('28/10/2019 16:00:00','dd/mm/yyyy hh24:mi:ss') 
       AND cd_pessoa_fisica NOT IN ( 734 ) 
       AND cd_setor_atendimento = 32 
--((cd_setor_atendimento =:setor) or (:setor ='0')) 
ORDER  BY nm_farmaceutico, 
          ds_status 


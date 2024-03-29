

SELECT NR_atendimento, dt_entrada_unidade, 'No dia 06/06/2018 ocorreu uma paralisação no sistema. Diversas anotações do dia estarão anexadas em Gestão Eletrônica de Documento.' AS Incidente_Tasy

FROM ATEND_PACIENTE_UNIDADE

WHERE DT_ENTRADA_UNIDADE <= TO_DATE('06/06/2018 02:59:59','DD/MM/YYYY hh24:mi:ss' )
AND DT_SAIDA_INTERNO >= TO_DATE('06/06/2018 03:00:00','DD/MM/YYYY hh24:mi:ss')
AND CD_UNIDADE_BASICA NOT LIKE '%LV%'
AND CD_SETOR_ATENDIMENTO NOT IN (19)
--AND DT_ALTA_MEDICO_SETOR IS null
--AND NR_ATENDIMENTO = 107445


--AND DT_ALTA_MEDICO_SETOR IS NULL
--GROUP BY NR_ATENDIMENTO
--ORDER BY NR_ATENDIMENTO

--count(nr_atendimento), nr_atendimento --
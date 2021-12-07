SELECT 
      
       (SELECT convert_long_to_varchar2('ds_evolucao', 'evolucao_paciente','ie_tipo_evolucao  = ')FROM dual) AS teste
      
FROM        evolucao_paciente a

WHERE a.dt_evolucao BETWEEN '01/01/2020' AND '01/10/2020'
AND a.NR_ATENDIMENTO = 564
--AND teste LIKE '%%'






SELECT * FROM evolucao_paciente
WHERE NR_ATENDIMENTO = 564



SELECT DT_ATUALIZACAO||  ' -  Usuário: '||NM_USUARIO||
' - Atendimento: '||obter_atendimento_prescr(nr_prescricao)||' - Prescrição: '|| nr_prescricao|| chr(10) || chr(10) 
FROM	result_laboratorio
WHERE  TRUNC(DT_atualizacao) BETWEEN '12/02/2021' AND TRUNC(SYSDATE)
AND obter_data_alta_atend(obter_atendimento_prescr(nr_prescricao)) IS null
AND convert_long_to_varchar2('ds_resultado', 'result_laboratorio','nr_sequencia ='||to_char(nr_sequencia)) LIKE 'Y:\%'--'%exames\L%'





--select count(*) from (SELECT  'Usuário: '||NM_USUARIO||
--' - Atendimento: '||obter_atendimento_prescr(nr_prescricao)||' - Prescrição: '|| nr_prescricao || chr(10) || chr(10) 
--FROM	result_laboratorio
--WHERE  TRUNC(DT_atualizacao) BETWEEN '12/02/2021' AND TRUNC(SYSDATE)
--AND obter_data_alta_atend(obter_atendimento_prescr(nr_prescricao)) IS null
--AND convert_long_to_varchar2('ds_resultado', 'result_laboratorio','nr_sequencia ='||to_char(nr_sequencia)) LIKE 'Y:\%')--'%exames\L%'
--
----
----
----SELECT 1440*6 FROM dual
--
--
--SELECT * FROM RESULT_LABORATORIO
--WHERE NR_PRESCRICAO  = 2958486
--2904629
--
--2894850
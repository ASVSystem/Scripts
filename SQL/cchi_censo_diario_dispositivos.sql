SELECT 1 ie_ordem,
	
  to_char(dt_referencia,'dd/mm/yyyy') referencia,
  sum(qt_paciente) qt_paciente,
  sum(qt_admitido) qt_admitido,
   sum(qt_respirador) qt_respirador,
  sum(qt_cvc) qt_cvc,
  sum(qt_svd) qt_svd,
  0 ie_classif_peso
FROM	 niss_invasividade
WHERE  dt_referencia between to_date('01/01/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
	AND	to_date('31/01/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
and cd_setor_atendimento = 32
GROUP BY dt_referencia


UNION
SELECT 2 ie_ordem,
	
  ' Total',
 sum(qt_paciente) qt_paciente,
  sum(qt_admitido) qt_admitido,
 sum(qt_respirador) qt_respirador,
 sum(qt_cvc) qt_cvc,
  sum(qt_svd) qt_svd,
  0 ie_classif_peso
FROM	 niss_invasividade
WHERE  dt_referencia between to_date('01/01/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
	AND	to_date('31/01/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
and cd_setor_atendimento = 32
ORDER BY ie_ordem,
	 referencia
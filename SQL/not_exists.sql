SELECT a.nr_atendimento
FROM ANAMNESE_PACIENTE a
WHERE  NOT EXISTS (
 
	SELECT r.NR_ATENDIMENTO
	FROM EHR_REG_TEMPLATE t 
		JOIN EHR_REGISTRO r
		ON t.NR_SEQ_REG = r.NR_SEQUENCIA
	WHERE t.NR_SEQ_TEMPLATE = 100673
   --AND r.NR_ATENDIMENTO = 132763
   AND r.NR_ATENDIMENTO = a.nr_atendimento

)

SUBSTR(obter_doc_interno_devolucao(nr_prescricao,nr_sequencia,'F','C'),1,30)
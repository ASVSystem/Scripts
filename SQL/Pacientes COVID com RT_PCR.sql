SELECT
			a.NR_ATENDIMENTO nr_atendimento,
			a.CD_UNIDADE cd_unidade,
		 	Substr(Ehr_vlr(eh.nr_sequencia, 291894), 1, 2000) RT_PCR
		  
	FROM  ehr_reg_template eh,
	        ehr_registro a
	
	WHERE eh.NR_SEQ_TEMPLATE = 100748
	AND eh.NR_SEQ_REG = a.NR_SEQUENCIA
	AND upper(Ehr_vlr(eh.nr_sequencia, 291894)) = 'SIM'
	AND obter_data_alta_atend(a.nr_atendimento) IS null
SELECT

substr(ehr_vlr(a.nr_sequencia,289171),1,2000) ds_comorbidade  --289171 sequancia do elemento no template

FROM ehr_reg_template a

		JOIN ehr_registro t
		
		ON a.NR_SEQ_REG = t.NR_SEQUENCIA

WHERE a.NR_SEQ_TEMPLATE =100678 ---Template que tem o resultado

AND t.NR_ATENDIMENTO = 564 -- usado o atendimento como parâmetro, mas pode ser data do registro, etc..

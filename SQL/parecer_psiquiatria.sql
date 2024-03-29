SELECT DISTINCT
b.NR_ATENDIMENTO,
obter_nome_paciente(b.NR_ATENDIMENTO)  nome_pf,
obter_dados_pf(c.cd_pessoa_fisica,'I') idade,
b.cd_unidade  box,
origem,
acompanhamento,
passometro,
Remove_formatacao_rtf_html(Convert_long_to_varchar2 ('ds_motivo_consulta','PARECER_MEDICO_REQ','nr_parecer ='||to_char(c.nr_parecer)||'and nr_atendimento='|| TO_char(c.nr_atendimento))) ds_parecer

FROM

	(SELECT
			a.NR_ATENDIMENTO nr_atendimento,
			a.CD_UNIDADE cd_unidade,
			max(eh.nr_seq_reg) nr_seq_reg,
			Substr(Ehr_vlr (max(eh.nr_sequencia), 291877), 1, 2000) origem,
			Substr(Ehr_vlr(max(eh.nr_sequencia), 291888), 1, 4000) passometro,
  			Substr(Ehr_vlr (max(eh.nr_sequencia), 291890), 1, 5000)acompanhamento
	FROM  ehr_reg_template eh,
	        ehr_registro a
	
	WHERE eh.NR_SEQ_TEMPLATE = 100774 
	AND eh.NR_SEQ_REG = a.NR_SEQUENCIA
	GROUP BY 
	a.NR_ATENDIMENTO,
	a.CD_UNIDADE
	) b
	
	
LEFT JOIN
parecer_medico_req c
ON
b.nr_atendimento = c.nr_atendimento

WHERE
c.cd_especialidade_dest= 29
AND
c.NR_PARECER=(SELECT max(am.NR_PARECER) FROM parecer_medico_req am WHERE am.nr_atendimento = c.nr_atendimento)


ORDER BY 
b.nr_atendimento

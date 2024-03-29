select m.NR_ATENDIMENTO,
obter_tipo_atendimento(m.NR_ATENDIMENTO),
     p.NR_PRESCRICAO,
     OBTER_NOME_PF(m.CD_PESSOA_FISICA) PACIENTE,
     OBTER_DESC_PROC_INTERNO(p.NR_SEQ_PROC_INTERNO) ds_procedimento,
     p.DT_INTEGRACAO



 from PRESCR_PROCEDIMENTO p
	join	PRESCR_MEDICA m
	on p.NR_PRESCRICAO = m.NR_PRESCRICAO
where m.DT_PRESCRICAO between '15/09/2019' and fim_dia('20/09/2019')
and m.DT_LIBERACAO is not null
and obter_tipo_atendimento(m.NR_ATENDIMENTO) = 7
and obter_tipo_procedimento(p.CD_PROCEDIMENTO,7,'C') in (1,3)
and decode(p.DT_INTEGRACAO,null,'N','S') = 'N'
order by 4,3


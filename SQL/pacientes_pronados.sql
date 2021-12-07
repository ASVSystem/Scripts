select --g.*,
--max(i.dt_registro),
g.nr_atendimento, 
obter_desc_setor_atend(g.cd_setor_atendimento) setor_internacao,
g.qt_dias_internacao,
obter_dados_atendimento(g.nr_atendimento,'CP') cd_pessoa,
obter_dados_atendimento(g.nr_atendimento,'IDADE') idade,
obter_desc_cid(obter_cid_atendimento(g.NR_ATENDIMENTO,'P')) cid_principal,
--i.dt_registro,
obter_dados_atendimento(g.nr_atendimento,'HI') Se_hipertencao_arterial,
obter_dados_atendimento(g.nr_atendimento,'DI') Se_Diabetes,
obter_dados_atendimento(g.nr_atendimento,'DPOC') Se_Doenca_pulmonar_obstrutiva,
obter_dados_atendimento(g.nr_atendimento,'ICC') Se_Insuficiencia_cardiaca,
obter_dados_atendimento(g.nr_atendimento,'CAN') se_cancer
--obter_desc_item_prontuario(nr_seq_item) item_pep

from W_GESTAO_ASSISTENCIAL g
--join  w_pesq_itens_pront i
--on g.nr_atendimento = i.nr_atendimento
where g.CD_SETOR_ATENDIMENTO IN('32','39','49')


--ORDER BY i.dt_registro '32','39','49'

--AND QT_HORAS_POS_TEV =	'48'

--and CD_TIPO_ATENDIMENTO =	'1'
--and IE_ANAMNESE =	'N'
--and IE_ATESTADO =	'N'
--and IE_AUDITORIA =	'N'
--and IE_BOLETIM =	'N'
--and IE_CONSENTIMENTO =	'N'
--and IE_DIAGNOSTICO =	'N'
--and IE_JUSTIFICATIVAS =	'N'
--and IE_ORIENTACAO_A   = 'N'
--and IE_ORIENTACAO_G =	'N'
--and IE_PARECER =	'N'
--and IE_RECEITA =	'N'
--and IE_TEV =	'A'
--and NM_USUARIO=	'avictor'
--and NR_SEQ_META=	'0'
--and QT_HORAS_ANT_TEV=	'48'


----ORDER BY i.dt_registro
SELECT a.* FROM tasy.ATENDIMENTO_PACIENTE a
join  tasy.atend_paciente_unidade u
on u.nr_atendimento = a.nr_atendimento
WHERE a.DT_ENTRADA BETWEEN '01/03/2020' AND '30/09/2020'
AND a.IE_TIPO_ATENDIMENTO = 1
AND u.cd_setor_atendimento IN (32,39,49)



SELECT * FROM evolucao_PACIENTE
WHERE DT_liberacao BETWEEN to_date('01/03/2020 00:00:00','dd/mm/yyyy hh24:mi:ss') AND to_date('30/09/2020 23:59:59','dd/mm/yyyy hh24:mi:ss')
--AND obter_tipo_atendimento(nr_atendimento) = 1
AND CD_SETOR_ATENDIMENTO IN (32,39,49)

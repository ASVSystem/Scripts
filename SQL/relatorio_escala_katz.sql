select	distinct
 	eis_obter_setor_atend_data(a.nr_atendimento, e.dt_avaliacao) cd_setor_atendimento,
	substr(obter_nome_estabelecimento(a.cd_estabelecimento),1,80) ds_estabelecimento,
	obter_convenio_atendimento(a.nr_atendimento) cd_convenio,
	substr(obter_nome_convenio(obter_convenio_atendimento(a.nr_atendimento)),1,150) ds_convenio,
	obter_nome_setor(eis_obter_setor_atend_data(a.nr_atendimento, e.dt_avaliacao) ) ds_setor_atendimento,
	obter_sexo_pf(a.cd_pessoa_fisica,'C') ie_sexo,
	obter_sexo_pf(a.cd_pessoa_fisica,'D') ds_sexo,
	obter_nome_pessoa_fisica(e.cd_profissional, null) nm_medico,
	e.cd_profissional,
	a.cd_medico_resp,
	substr(obter_idade(obter_data_nascto_pf(a.cd_pessoa_fisica),sysdate,'E'),1,10) ie_faixa_etaria,
	substr(obter_unidade_atend_data(a.nr_atendimento, e.dt_avaliacao),1,255) ds_unidade,
	trunc(e.dt_avaliacao) dt_avaliacao,
	e.QT_PONTUACAO,
	OBTER_DESCR_ESCALA_KATZ(e.QT_PONTUACAO),
	f.cd_empresa,
	a.cd_estabelecimento,
	a.nr_atendimento,
	a.cd_pessoa_fisica cd_paciente,
   	substr(obter_turno_data(dt_avaliacao),1,255) ie_turno
from 	ESCALA_KATZ e,
	estabelecimento f,
	atendimento_paciente a
where 	a.nr_atendimento= e.nr_atendimento
and	a.cd_estabelecimento = f.cd_estabelecimento
and	e.dt_liberacao is not null


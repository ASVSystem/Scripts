select	substr(obter_nome_pf(a.cd_paciente),1,254) nm_paciente, --ok
	obter_dados_pf(a.cd_paciente,'DN') dt_nascimento, --ok
	obter_dados_pf(a.cd_paciente,'I') qt_idade, --ok
	substr(nvl(obter_dados_pf(a.cd_paciente,'SE'),'I'),1,1) ie_sexo, --ok
	a.ie_gestante, --ok
	obter_cpf_pessoa_fisica(a.cd_paciente) nr_cpf, --ok
	a.IE_RACA_COR, --ok
	a.ie_escolaridade,
--	(select  max(x.NR_CARTAO_NAC_SUS)
--	from	pessoa_fisica x
--	where    x.cd_pessoa_Fisica = a.cd_paciente) nr_cartao_sus,
	nvl((select  substr(obter_nome_pf(cd_pessoa_mae),1,254)
		from	pessoa_fisica x
		where    x.cd_pessoa_Fisica = a.cd_paciente),nm_mae) nm_mae, --ok
	ie_uf, ---ok
	(select	max(ds_municipio)
		from	sus_municipio x
		where    a.CD_MUNICIPIO_IBGE_SURTO = x.cd_municipio_ibge)  ds_municipio, --ok
	a.CD_MUNICIPIO_IBGE_SURTO, --ok
	DS_DISTRITO,
	DS_BAIRRO, --ok
	DS_ENDERECO, --ok
	NR_ENDERECO, --ok
	DS_COMPLEMENTO, --ok
	DS_PONTO_REFERENCIA,
	CD_CEP, --ok
	NR_TELEFONE, --ok
	IE_ZONA, --ok
	DS_PAIS	 --ok	 				     		
from 	notificacao_sinan a
where	a.nr_sequencia = 166
union
select	  null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
from	  dual
where	  166 = '0'

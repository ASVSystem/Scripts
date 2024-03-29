select	to_char(dt_notificacao,'dd/mm/yyyy') DT_NOTIFICACAO,
	ie_uf,
	ie_tipo_notificacao||' - '||substr(obter_valor_dominio(2607,ie_tipo_notificacao),1,255) ds_tipo_notificacao,
	(select	max(ds_municipio)
	from	sus_municipio x
	where    cd_municipio_ibge_surto = cd_municipio_ibge)  ds_municipio,
	cd_municipio_ibge_surto,
	to_char(dt_prim_sintoma, 'dd/mm/yyyy') DT_PRIM_SINTOMA,
	(select  max(obter_nome_setor(cd_setor_atendimento))
	from	usuario
	where	nm_usuario = 'avictor') ds_setor_atendimento,
	rpad(substr(obter_cnes_estab(1),1,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),2,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),3,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),4,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),5,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),6,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),7,7),2,'|')cd_cnes,
	cnes_obter_identificacao(2) ds_unidade_saude,
	substr(obter_desc_doenca_compulsoria(nr_seq_doenca_compulsoria),1,255) ds_doenca_compulsoria,
	(select	max(x.cd_doenca_cid)
	from	cih_doenca_compulsoria x
	where	x.nr_sequencia = nr_seq_doenca_compulsoria) cd_doe
from	notificacao_sinan
where	nr_sequencia = 166
union
select	  null,null,null,null,null,null,null,null,NULL,NULL,null
from	  dual
where	  166 = '0'

SELECT nr_sequencia nr_sequencia,
	  cd_estabelecimento cd_estabelecimento,
	  dt_atualizacao dt_atualizacao,
	  nm_usuario nm_usuario,
	  dt_atualizacao_nrec dt_atualizacao_nrec,
	  nm_usuario_nrec nm_usuario_nrec,
	  ie_status ie_status,
	  substr(obter_valor_dominio(403,ie_status),1,200) ds_status,
	  nr_seq_conjunto nr_seq_conjunto,
	  substr(cme_obter_nome_conjunto(nr_seq_conjunto),1,200) ds_seq_conjunto,
	  cd_setor_retirada cd_setor_retirada,
	  substr(obter_nome_setor(cd_setor_retirada),1,200) ds_setor_retirada,
	  null cd_setor_entrega,
	  null ds_setor_entrega,
	  nr_conjunto_cont nr_conjunto_cont,
	  dt_retirada dt_retirada,
	  null dt_recebimneto,
	  nm_usuario_retirada nm_usuario_retirada,
	  null nm_usuario_receb,
	  cd_setor_atendimento cd_setor_atendimento,
	  substr(obter_nome_setor(cd_setor_atendimento),1,200) ds_setor_atendimento,
	  null cd_setor_receb,
	  null ds_setor_receb,
	  cd_local_estoque cd_local_retirada,
	  substr(obter_desc_local_estoque(cd_local_estoque),1,200) ds_local_retirada,
	  null cd_local_entrega,
	  null ds_local_entrega,
	  substr(obter_desc_leito_unid(nr_seq_interno),1,200) ds_seq_interno,
	  null nm_usuario_entrega,
	  null ds_observacao
FROM	cm_expurgo_retirada
WHERE 1 = 1 
	AND	trunc(dt_retirada) between to_date('01/01/2020 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
	AND	to_date('16/04/2020 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 

UNION ALL
SELECT nr_sequencia nr_sequencia,
	  cd_estabelecimento cd_estabelecimento,
	  dt_atualizacao dt_atualizacao,
	  nm_usuario nm_usuario,
	  dt_atualizacao_nrec dt_atualizacao_nrec,
	  nm_usuario_nrec nm_usuario_nrec,
	  ie_status ie_status,
	  substr(obter_valor_dominio(403,ie_status),1,200) ds_status,
	  nr_seq_conjunto nr_seq_conjunto,
	  substr(cme_obter_nome_conjunto(nr_seq_conjunto),1,200) ds_seq_conjunto,
	  null cd_setor_retirada,
	  null ds_setor_retirada,
	  cd_setor_entrega cd_setor_entrega,
	  substr(obter_nome_setor(cd_setor_entrega),1,200) ds_setor_entrega,
	  nr_conjunto_cont nr_conjunto_cont,
	  null dt_retirada,
	  dt_recebimneto dt_recebimneto,
	  null nm_usuario_retirada,
	  nm_usuario_receb nm_usuario_receb,
	  null cd_setor_atendimento,
	  null ds_setor_atendimento,
	  cd_setor_receb cd_setor_receb,
	  substr(obter_nome_setor(cd_setor_receb),1,200) ds_setor_receb,
	  null cd_local_retirada,
	  null ds_local_retirada,
	  cd_local_estoque cd_local_entrega,
	  substr(obter_desc_local_estoque(cd_local_estoque),1,200) ds_local_entrega,
	  null nr_seq_interno,
	  nm_usuario_entrega nm_usuario_entrega,
	  ds_observacao ds_observacao
FROM	cm_expurgo_receb
WHERE 1 = 1 
	AND	trunc(dt_recebimneto) between to_date('01/01/2020 00:00:00', 'dd/mm/yyyy hh24:mi:ss') 
	AND	to_date('16/04/2020 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
ORDER BY nr_conjunto_cont,
	 nr_sequencia 
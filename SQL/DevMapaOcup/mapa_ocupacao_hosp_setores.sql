SELECT  cd_setor_atendimento cd_setor_atendimento,
	  nvl(ds_ocup_hosp,ds_setor_atendimento) ds_setores,
	  ds_setor_atendimento 
FROM	 ocupacao_setores_v2 
WHERE 1 = 1 
	AND	((ie_ocup_hospitalar = 'S' OR ie_ocup_hospitalar = 'T')) 
	AND	((('N' = 'S') 
	AND	(cd_classif_setor in (9,3,4,12,11))) OR (('N' = 'N') 
	AND	(cd_classif_setor in (3,4,12,11)))) 
	AND	Obter_se_exibe_estab(cd_estabelecimento_base,1,'avictor','N') = 'S' 
	AND	((0 = '0') OR (obter_agrupamento_setor(cd_setor_atendimento) = '0'))
ORDER BY  nvl(nr_seq_apresentacao, 999)   ,
	 ds_ocup_hosp 
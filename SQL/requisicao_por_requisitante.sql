SELECT  a.NR_REQUISICAO,
r.DT_SOLICITACAO_REQUISICAO DT_REQUISICAO,
OBTER_NOME_PF(OBTER_DADOS_REQUISICAO(a.nr_requisicao,'R')) requisitante,

	a.CD_MATERIAL ,
	substr(obter_desc_material(a.cd_material),
	1,
	255) DS_MATERIAL,
	
	a.QT_MATERIAL_REQUISITADA ,
	
	a.CD_UNIDADE_MEDIDA ,
	
	a.QT_MATERIAL_ATENDIDA ,
		
	r.dt_baixa dt_atendimento,
	
	a.CD_PESSOA_ATENDE ,
		
	substr(obter_usuario_pessoa(a.cd_pessoa_atende),
	1,
	100) NM_USUARIO_ATENDE,
	r.CD_LOCAL_ESTOQUE_DESTINO,
	r.NM_USUARIO_RECEBEDOR

	
FROM	ITEM_REQUISICAO_MATERIAL a
 join		REQUISICAO_MATERIAL r
 on a.NR_REQUISICAO = r.NR_REQUISICAO
WHERE 1 = 1 
	--AND	NR_REQUISICAO = 141128
	and OBTER_DADOS_REQUISICAO(a.nr_requisicao,'R') = '60266'
	--and TO_CHAR(DT_ATUALIZACAO, 'dd/mm/yyyy') = '04/05/2019'
	and OBTER_MES_ANO_DT(a.DT_ATUALIZACAO,'A') = '2018'
   --	and TO_char(DT_ATUALIZACAO, 'dd/mm/yyyy') between '01/07/2019' and '31/07/2019'
ORDER BY a.dt_atualizacao





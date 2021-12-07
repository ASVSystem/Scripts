
SELECT  substr(obter_nome_pj(a.CD_CNPJ),1,250) ds_fornecedor,
nvl2(GHAS_OBTER_CONTRATO_OC(nr_ordem_compra,'NR'),'S','N') ie_contrato,
--substr(OBTER_DADOS_MATERIAL(i.cd_material,'GRU'),1,250) grupo_mat,
count(*) nr_avaliacoes,
avg(a.vl_media) vl_media,
CASE 
	WHEN avg(a.vl_media) >79 THEN 'A'
	WHEN avg(a.vl_media) BETWEEN 59 AND 80 THEN 'B'
	WHEN avg(a.vl_media) > 60 THEN 'C'
END AS  ds_classificacao

 FROM avf_resultado a
-- JOIN inspecao_registro i
-- ON a.nr_seq_registro = i.nr_sequencia
JOIN inspecao_recebimento i
ON a.NR_SEQ_REGISTRO = i.NR_SEQ_REGISTRO


WHERE a.cd_cnpj = '00874929000140'
AND a.DT_AVALIACAO BETWEEN '01/01/2020' AND fim_dia('22/07/2020')


GROUP BY a.cd_cnpj,
nvl2(GHAS_OBTER_CONTRATO_OC(nr_ordem_compra,'NR'),'S','N')
--OBTER_DADOS_MATERIAL(i.cd_material,'GRU')
ORDER BY 
--grupo_mat, 
ie_contrato




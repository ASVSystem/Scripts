SELECT /*+ first_rows(100) */
	a.NR_SEQUENCIA,
	a.NR_SEQ_CONJUNTO,
	a.NR_SEQ_ITEM,
  	to_char(a.DT_ATUALIZACAO,'YYYY-MM-DD HH24:MM:SS') DT_ATUALIZACAO,
	NM_USUARIO,
	QT_ITEM,
	IE_STATUS,
	DS_OBSERVACAO,
	IE_EXCLUIDO,
	NR_SEQ_MOT_EXCLUSAO,
	 substr(tasy.cm_obter_nome_item_orig(nr_sequencia),1,255) DS_ITEM_ORIGINAL,
	 substr(tasy.cme_obter_nome_item(nr_seq_item),1,255) DS_ITEM,
	 substr(tasy.cm_obter_cod_conj_original(nr_sequencia),1,255) CD_CODIGO_ORIGINAL,
	 substr(tasy.cm_obter_cod_conj_sub(nr_seq_item),1,255) CD_CODIGO_EXT,
	 substr(tasy.CME_Obter_desc_classificacao(nr_seq_item),1,200) DS_CLASSIF_ITEM,
	 substr(tasy.obter_valor_dominio(401,ie_status),1,255) DS_STATUS
	 
	 
FROM	tasy.CM_ITEM_CONT a
--(SELECT min(nr_sequencia) nr_seq_min, NR_SEQ_CONJUNTO FROM CM_ITEM_CONT GROUP BY NR_SEQ_CONJUNTO) x

WHERE nvl(a.ie_excluido,'N') = 'N'
--AND a.NR_SEQ_CONJUNTO = x.NR_SEQ_CONJUNTO
AND TRUNC(a.DT_ATUALIZACAO) =  '19/11/2021'
AND	a.NR_SEQ_CONJUNTO = 2462089

AND EXISTS (SELECT nr_sequencia NR_SEQ_CONJUNTO FROM TASY.CM_CONJUNTO_CONT WHERE TRUNC(DT_ORIGEM) = TRUNC(A.DT_ATUALIZACAO))

--group BY x.nr_seq_min

ORDER BY 1

-- 2462130
-- 2461649
-- 2461693
-- 2461694
--2461818 
--2461695
--SELECT * FROM CM_CONJUNTO
--WHERE NR_SEQUENCIA < 500
--AND IE_SITUACAO = 'A'


--max(a.nr_sequencia) nr_seq_max,
--	x.nr_seq_min



SELECT dt_atualizacao,
	
  substr(Obter_Dados_Atributo(nm_atributo,'TITULO_PAGAR', 'LB'),1,50) ds_label,
  substr(ds_valor_old,1,255) ds_valor_old,
  substr(ds_valor_new,1,255) ds_valor_new,
  nr_seq_log_alteracao,
  nm_atributo,
 ds_utc,
 DS_UTC_ATUALIZACAO
FROM	  tasy_log_alt_campo
WHERE nr_seq_log_alteracao = 60491618
ORDER BY dt_atualizacao DESC



SELECT dt_atualizacao,
	
 obter_nome_usuario(nm_usuario) nome_usuario,
 nr_sequencia, 
  ds_chave_simples,
  substr(ds_chave_composta,1,255) ds_chave_composta ,
  substr(ds_descricao,1,255) ds_descricao,
  substr(obter_justificativa_log(nr_seq_justificativa),1,60) ds_curta_justificativa,
  ds_justificativa,
  nm_tabela,
 rownum,
 SUBSTR(obter_desc_expressao(291923),1,20) criticidade
FROM	tasy_log_alteracao
WHERE ((nm_tabela = nvl('FLUXO_CAIXA','0')) OR (nvl('FLUXO_CAIXA','0') = '0'))
and dt_atualizacao between PKG_DATE_UTILS.START_OF(to_date('01/08/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss'), 'DAY') 
	AND	to_date('05/08/2021 12:00:00', 'dd/mm/yyyy hh24:mi:ss')

and ((nm_usuario = nvl('0','0')) OR (nvl('0','0') = '0'))
	
and (((null is not null) 
	AND	(upper(nvl(ds_chave_composta,ds_chave_simples)) like '%' || upper(null) || '%')) OR (null is null))
	
--AND ds_chave_simples = 20524
ORDER BY dt_atualizacao

---TITULO_PAGAR_ALT_VENC
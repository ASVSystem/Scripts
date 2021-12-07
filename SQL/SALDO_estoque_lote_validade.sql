SELECT nr_seq_lote_fornec, sum(saldo_lote), sum(total_operacao)

FROM(
SELECT
a.cd_material,
a.nr_seq_lote_fornec nr_seq_lote_fornec,
OBTER_SALDO_LOTE_FORNEC(a.nr_seq_lote_fornec) saldo_lote,
a.dt_validade,
o.ds_operacao,
sum(a.qt_estoque) total_operacao
-- a.dt_movimento_estoque,
-- a.nr_movimento_estoque,
-- a.nr_ordem_compra,
-- substr(decode(a.cd_acao,'1',wheb_mensagem_pck.get_texto(352767),'2',wheb_mensagem_pck.get_texto(352768)),1,40) ds_acao,
-- a.dt_mesano_referencia,
-- a.dt_processo,
-- a.nr_documento,
-- substr(obter_desc_local_estoque(a.cd_local_estoque),1,40) ds_local_estoque,
-- substr(obter_nome_setor(a.cd_setor_atendimento),1,40) ds_setor_atendimento,
-- o.ds_operacao,
-- substr(obter_desc_centro_custo(a.cd_centro_custo),1,40) ds_centro_custo,
-- substr(obter_nome_pf_pj('', a.cd_fornecedor),1,100) nm_fornecedor,
-- substr(est_obter_paciente_movto (a.nr_movimento_estoque),1,100) nm_paciente,
-- a.nm_usuario,
-- substr(obter_nome_usuario(a.nm_usuario),1,150) nm_usuario_compl,
-- substr(obter_desc_funcao(cd_funcao),1,40) ds_funcao,
-- substr(obter_medico_prescricao(a.nr_prescricao,'N'),1,255) nm_medico,
-- substr(obter_valor_dominio(23,a.ie_origem_documento),1,255) ie_origem_documento
FROM	operacao_estoque o,
	
 movimento_estoque a
WHERE a.cd_operacao_estoque = o.cd_operacao_estoque
--and a.nr_seq_lote_fornec = 55225
and a.cd_estabelecimento = 1
and (nvl(null,'0') = '0' OR a.ie_origem_documento = null)
AND o.DS_OPERACAO = 'Saída por Transferência'
AND TRUNC(a.dt_validade) BETWEEN '29/10/2020' AND '31/12/2020'
AND a.CD_MATERIAL = 169

GROUP BY a.cd_material,
a.nr_seq_lote_fornec,
OBTER_SALDO_LOTE_FORNEC(a.nr_seq_lote_fornec),
a.dt_validade,
o.ds_operacao

ORDER BY a.dt_validade
)

GROUP BY nr_seq_lote_fornec


--SELECT OBTER_SALDO_LOTE_FORNEC(55225)
--FROM	dual


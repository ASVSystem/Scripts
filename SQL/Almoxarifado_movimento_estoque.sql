SELECT 
DT_MOVIMENTO_ESTOQUE,
o.ds_operacao,
obter_desc_setor_atend(m.CD_SETOR_ATENDIMENTO) setor_movimento,
obter_desc_local_estoque(m.cd_local_estoque) estoque_origem,
obter_desc_local_estoque(m.cd_local_estoque_destino) estoque_destino,
obter_desc_material(m.cd_material) ds_material,
qt_movimento,
nr_seq_lote_fornec





FROM MOVIMENTO_ESTOQUE m
JOIN operacao_estoque o
ON m.cd_operacao_estoque = o.cd_operacao_estoque
WHERE CD_SETOR_ATENDIMENTO = 15
--AND NR_MOVIMENTO_ESTOQUE = 27401924
AND DT_MOVIMENTO_ESTOQUE > '01/01/2021'
ORDER by DT_MOVIMENTO_ESTOQUE

SELECT o.ds_operacao "Operação Estoque", 
substr(obter_desc_evento_contabil(o.cd_tipo_lote_contabil, o.cd_evento),1,150) "Evento Contabil",
obter_valor_dominio(21,o.ie_tipo_requisicao) "Tipo Operacao",
o.IE_ENTRADA_SAIDA "Entrada/ Saída",
o.IE_PERMITE_DIGITACAO "Permite Digitação",
o.IE_ATUALIZA_ESTOQUE "Atualiza Estque",
decode(o.IE_ALTERA_CUSTO,'N', 'Apurado CPV','X', 'Não influi','S','Participa CM','Z','CM zerando valor') "Apuração do custo",
o.IE_ALTERA_CUSTO

FROM OPERACAO_ESTOQUE o
WHERE o.IE_SITUACAO = 'A'
--AND o.cd_evento = 2
--AND o.ie_tipo_requisicao = 5
ORDER BY 1

SELECT * FROM evento_contabil
ORDER BY 3


SELECT * FROM EVENTO_CONTABIL_PARAM_ESTAB
WHERE CD_CONTA_CONTABIL = 40094
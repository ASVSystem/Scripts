
SELECT l.NR_SEQ_EQUIPAMENTO nr_ultrassonica,
		l.DT_ATUALIZACAO dt_registro,
		l.NR_CICLO,
		'Detergente',
		l.DS_LOTE_DET_ANVISA lote_detergente
FROM CM_CICLO_LAVACAO l
WHERE nr_sequencia = :nr_seq_ciclo



SELECT CME_OBTER_NOME_CONJUNTO(c.nr_seq_conjunto) FROM CM_CONJUNTO_CONT c
WHERE c.NR_SEQ_CICLO_LAV = 3


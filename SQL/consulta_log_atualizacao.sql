SELECT dt_evento,
	
  dt_fim_evento,
  substr(obter_valor_dominio(1826, ie_evento),1,60) ds_evento,
  substr(obter_dif_data(dt_evento,dt_fim_evento,''),1,20) qt_tempo,
   nr_sequencia,
   substr(ds_ocorrencia,1,10) qt_invalidos
FROM	log_atualizacao
WHERE nr_seq_atualizacao = 553
ORDER BY dt_evento


SELECT * FROM LOG_ATUALIZACAO
WHERE NR_SEQUENCIA = 9094
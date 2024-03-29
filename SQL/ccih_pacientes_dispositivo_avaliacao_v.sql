CREATE OR REPLACE VIEW hmdcc_dispositivos_avaliacao
AS
-- Insatalação de VMI

SELECT DISTINCT

a.nr_atendimento nr_atendimento,
obter_nome_paciente(a.nr_atendimento) nm_paciente,
Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,1) setor_atend,
REPLACE(substr(Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,2),(length(Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,2))-5),4),' ','') ds_leito,
substr(decode(r.qt_resultado,1,'VMI'),1,5) ds_dispositivo,
r.qt_resultado,
''local_instalacao, --Não se aplica a VMI
TRUNC(a.dt_avaliacao) dt_dispositivo


FROM 	MED_AVALIACAO_PACIENTE a
JOIN MED_AVALIACAO_RESULT r
ON a.NR_SEQUENCIA = r.NR_SEQ_AVALIACAO
JOIN MED_AVALIACAO_PACIENTE x
ON a.NR_SEQUENCIA = x.NR_SEQUENCIA
AND a.NR_SEQUENCIA = r.NR_SEQ_AVALIACAO


WHERE a.NR_SEQ_TIPO_AVALIACAO = 362
AND r.NR_SEQ_ITEM = 11515
AND r.QT_RESULTADO = 1
AND a.IE_SITUACAO = 'A'
AND a.DT_LIBERACAO IS NOT NULL
AND a.NR_ATENDIMENTO = 287655
ORDER BY dt_dispositivo

UNION ALL

-- instalação de SVD

SELECT DISTINCT

a.nr_atendimento nr_atendimento,
obter_nome_paciente(a.nr_atendimento) nm_paciente,
Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,1) setor_atend,
REPLACE(substr(Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,2),(length(Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,2))-5),4),' ','') ds_leito,
substr(obter_resultado_avaliacao(a.nr_sequencia, r.nr_seq_item,a.nr_seq_tipo_avaliacao,a.nr_atendimento),1,5) ds_dispositivo,
'' local_instalacao, --Não se aplica a SVD
TRUNC(a.dt_avaliacao) dt_dispositivo

FROM 	MED_AVALIACAO_PACIENTE a
JOIN MED_AVALIACAO_RESULT r
ON a.NR_SEQUENCIA = r.NR_SEQ_AVALIACAO



WHERE a.NR_SEQ_TIPO_AVALIACAO = 346
AND r.NR_SEQ_ITEM = 10278
AND r.QT_RESULTADO = 6
AND a.IE_SITUACAO = 'A'
AND a.DT_LIBERACAO IS NOT NULL
--AND a.DT_AVALIACAO BETWEEN '01/05/2021' AND fim_dia('05/05/2021')

UNION ALL
-----------CVC-------------------------

SELECT DISTINCT

a.nr_atendimento nr_atendimento,
obter_nome_paciente(a.nr_atendimento) nm_paciente,
Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,1) setor_atend,
REPLACE(substr(Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,2),(length(Obter_dados_AtePacu(a.NR_SEQ_ATEPACU,2))-5),4),' ','') ds_leito,
substr(obter_resultado_avaliacao(a.nr_sequencia, r.nr_seq_item,a.nr_seq_tipo_avaliacao,a.nr_atendimento),1,5) ds_dispositivo,
substr((SELECT REPLACE(upper(obter_resultado_avaliacao(x.nr_sequencia, y.nr_seq_item,x.nr_seq_tipo_avaliacao,x.nr_atendimento)),' ','') local_disp
	FROM 	MED_AVALIACAO_PACIENTE x	JOIN MED_AVALIACAO_RESULT y	ON x.NR_SEQUENCIA = y.NR_SEQ_AVALIACAO 
		LEFT JOIN med_item_avaliar z ON z.nr_sequencia = y.nr_seq_item
	WHERE x.NR_SEQ_TIPO_AVALIACAO = 346 AND y.nr_seq_item IN (10345,10347,10349,10351)
  	AND x.NR_SEQUENCIA = a.NR_SEQUENCIA AND z.nr_seq_superior = r.nr_seq_item
),1,5) local_dispositivo,
TRUNC(a.dt_avaliacao) dt_dispositivo

FROM 	MED_AVALIACAO_PACIENTE a
JOIN MED_AVALIACAO_RESULT r
ON a.NR_SEQUENCIA = r.NR_SEQ_AVALIACAO



WHERE a.NR_SEQ_TIPO_AVALIACAO = 346
AND r.nr_seq_item in (10344,10346,10348,10350 )
AND a.IE_SITUACAO = 'A'
AND a.DT_LIBERACAO IS NOT NULL
AND obter_resultado_avaliacao(a.nr_sequencia, r.nr_seq_item,a.nr_seq_tipo_avaliacao,a.nr_atendimento) IN ('CVC', 'CDL')


ORDER BY nr_atendimento, ds_dispositivo

GRANT SELECT ON TASY.hmdcc_dispositivos_avaliacao TO USR_ALESSANDER;
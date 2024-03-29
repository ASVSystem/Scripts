


--select '' NR_SEQUENCIA,	'' CD_ESTABELECIMENTO,	'' DT_ATUALIZACAO,	'' NM_USUARIO,	'' DT_ATUALIZACAO_NREC,	'' NM_USUARIO_NREC,	'' CD_GRUPO_PROC,	'' CD_ESPECIALIDADE,	'' CD_AREA_PROCEDIMENTO,	'' CD_INTERVALO,	'' CD_PROCEDIMENTO,	'' CD_SETOR_ATENDIMENTO,	'' IE_ORIGEM_PROCED,	'' CD_PERFIL,  NR_SEQUENCIA	NR_SEQ_PROC_INTERNO,	'' NR_SEQ_EXAME
--
--from PROC_INTERNO
--WHERE DS_PROC_EXAME LIKE('%RADIOGRAFIA%')
--AND IE_SITUACAO = 'A'




/*--------------------------------------------------------*/




MERGE INTO REGRA_PROCED_PRESCR d
     USING (select '' NR_SEQUENCIA,	1 CD_ESTABELECIMENTO,	sysdate DT_ATUALIZACAO,	'avictor' NM_USUARIO,	sysdate DT_ATUALIZACAO_NREC,	'avictor' NM_USUARIO_NREC,	'' CD_GRUPO_PROC,	'' CD_ESPECIALIDADE,	'' CD_AREA_PROCEDIMENTO,	'RI14' CD_INTERVALO,	'' CD_PROCEDIMENTO,	'' CD_SETOR_ATENDIMENTO,	'' IE_ORIGEM_PROCED,	'' CD_PERFIL,  NR_SEQUENCIA	NR_SEQ_PROC_INTERNO,	'' NR_SEQ_EXAME

from PROC_INTERNO
WHERE NR_SEQ_CLASSIF in (7,8,9,10,12,13) --LIKE('%RADIOGRAFIA%')
AND IE_SITUACAO = 'A') o
     ON (d.nr_seq_proc_interno = o.nr_sequencia)
     WHEN MATCHED THEN
          UPDATE SET d.cd_intervalo = 'RI14'
     WHEN NOT MATCHED THEN
          INSERT (d.NR_SEQUENCIA, d.CD_ESTABELECIMENTO, d.DT_ATUALIZACAO, d.NM_USUARIO, d.DT_ATUALIZACAO_NREC, d.NM_USUARIO_NREC, d.CD_GRUPO_PROC, d.CD_ESPECIALIDADE, d.CD_AREA_PROCEDIMENTO, d.CD_INTERVALO, d.CD_PROCEDIMENTO, d.CD_SETOR_ATENDIMENTO, d.IE_ORIGEM_PROCED, d.CD_PERFIL, d.NR_SEQ_PROC_INTERNO, d.NR_SEQ_EXAME)
          VALUES (regra_proced_prescr_seq.nextval, o.CD_ESTABELECIMENTO, o.DT_ATUALIZACAO, o.NM_USUARIO, o.DT_ATUALIZACAO_NREC, o.NM_USUARIO_NREC, o.CD_GRUPO_PROC, o.CD_ESPECIALIDADE, o.CD_AREA_PROCEDIMENTO, o.CD_INTERVALO, o.CD_PROCEDIMENTO, o.CD_SETOR_ATENDIMENTO, o.IE_ORIGEM_PROCED, o.CD_PERFIL, o.NR_SEQ_PROC_INTERNO, o.NR_SEQ_EXAME);
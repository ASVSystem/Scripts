select    substr(obter_pessoa_atendimento(a.nr_atendimento,'N'),1,100) nm_paciente,
    substr(obter_desc_disp_cons(a.nr_sequencia),1,100) ds_dispositivo,
    substr(obter_desc_topografia_dor(nr_seq_topografia),1,60) ds_topografia,
    substr(obter_valor_dominio(1372,ie_lado),1,10) ds_lado,
    trunc(dt_instalacao,'hh24') dt_instalacao,
    trunc(dt_retirada_prev,'hh24') dt_retirada_prev,
    trunc(dt_retirada,'hh24') dt_retirada,
    a.nr_sequencia,
    a.nr_atendimento,
    substr(obter_hora_prev_ret_disp(a.nr_sequencia),1,40) qt_horas,
    substr(obter_valor_dominio(2085,obter_status_dispositivo(a.nr_sequencia,3)),1,20) ds_status,
    Obter_Setor_Atendimento(a.nr_atendimento) setor,
    a.nr_seq_dispositivo,
    obter_status_dispositivo(a.nr_sequencia,3) status,
    SUBSTR(OBTER_DADOS_DISPOSITIVO(A.NR_SEQUENCIA,'S'),1,100) TESTE,
    SUBSTR(OBTER_DADOS_DISPOSITIVO(A.NR_SEQUENCIA,'CS'),1,100),
    (trunc(dt_retirada,'hh24') - trunc(dt_instalacao,'hh24'))*24 HORAS,
    trunc(dt_retirada,'hh24') - trunc(dt_instalacao,'hh24') DIAS,
	to_date(dt_retirada ) - to_date(dt_instalacao) teste2

from    dispositivo b,
        atend_pac_dispositivo a
where   a.nr_seq_dispositivo = b.nr_sequencia
and     trunc(dt_instalacao) between '01/01/2021' and fim_dia('31/01/2021')
--and     SUBSTR(OBTER_DADOS_DISPOSITIVO(A.NR_SEQUENCIA,'CS'),1,100) in (32,39)
and     ((a.nr_seq_dispositivo = 57) or (57 = 0))
and     ((obter_setor_atendimento(a.nr_atendimento) = 32) or (32 = 0))

order by 5

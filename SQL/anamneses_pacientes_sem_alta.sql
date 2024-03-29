select obter_ds_setor_atendimento(obter_setor_atendimento(nr_atendimento)) setor,
NR_ATENDIMENTO, DT_ANANMESE,
OBTER_VALOR_DOMINIO(12,obter_tipo_atendimento(nr_atendimento))
from ANAMNESE_PACIENTE
where OBTER_DT_ALTA_MEDICA(nr_atendimento) is null
and obter_tipo_atendimento(nr_atendimento) = '1'
and DT_ANANMESE > TO_DATE('01/01/2019 00:00:00', 'dd/mm/yyyy hh24:mi:ss')

---------'\////////////////

select nr_atendimento from ATENDIMENTO_PACIENTE a
where a.ie_tipo_atendimento = 1
and not exists (select obter_ds_setor_atendimento(obter_setor_atendimento(n.nr_atendimento)) setor,
n.NR_ATENDIMENTO,
n.DT_ANANMESE,
OBTER_VALOR_DOMINIO(12,obter_tipo_atendimento(n.nr_atendimento))

from ANAMNESE_PACIENTE n
where OBTER_DT_ALTA_MEDICA(n.nr_atendimento) is null
and obter_tipo_atendimento(n.nr_atendimento) = '1'
and n.NR_ATENDIMENTO = a.nr_atendimento
and n.DT_ANANMESE > TO_DATE('01/01/2019 00:00:00', 'dd/mm/yyyy hh24:mi:ss'))
--and a.ie_tipo_atendimento = 1
and a.dt_alta is null
and a.dt_entrada >TO_DATE('01/01/2019 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
AND a.dt_cancelamento IS null


--210506
not exists (select NR_ATENDIMENTO from EHR_REGISTRO  where nr_seq_templ=100673 and ie_situacao<>'I' and nr_atendimento = :nr_atendimento)
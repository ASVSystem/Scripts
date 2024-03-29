
select s.qt_temp qt_temp, a.NR_ATENDIMENTO nr_atendimento
from ATENDIMENTO_SINAL_VITAL s
join ATENDIMENTO_PACIENTE a
on s.NR_ATENDIMENTO = a.NR_ATENDIMENTO

where qt_temp between 38 and 45
and a.DT_ALTA is null
and a.IE_TIPO_ATENDIMENTO = 1
and s.CD_SETOR_ATENDIMENTO in (32,39)


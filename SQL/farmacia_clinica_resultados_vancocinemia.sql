SELECT distinct 
 a.nr_atendimento,
 a.NR_PRESCRICAO,
 OBTER_PACIENTE_PRESCRICAO(a.NR_PRESCRICAO) nm_paciente,
 OBTER_DESC_SETOR_ATEND(a.CD_SETOR_ORIG) ds_setor,
 i.DT_APROVACAO,
 substr(Obter_Desc_Exame(c.nr_seq_exame),1,255) ds_exame,
 i.QT_RESULTADO

FROM	prescr_medica a
	join prescr_procedimento c
	on c.nr_prescricao  = a.nr_prescricao 
	join EXAME_LAB_RESULTADO r
	on c.NR_PRESCRICAO = r.NR_PRESCRICAO
	and a.NR_PRESCRICAO = r.NR_PRESCRICAO
    join EXAME_LAB_RESULT_ITEM i
    on r.NR_SEQ_RESULTADO = i.NR_SEQ_RESULTADO
    and c.NR_SEQ_EXAME = i.NR_SEQ_EXAME


 
 
WHERE a.dt_prescricao between TO_DATE('10/10/2019 00:00:00', 'dd/MM/yyyy hh24:mi:ss')
					AND	TO_DATE('11/10/2019 16:59:59' , 'dd/MM/yyyy hh24:mi:ss')
--and (a.nr_atendimento  = 195441)
and a.dt_liberacao is not null
and c.NR_SEQ_EXAME = 1730
--and a.CD_SETOR_ORIG = 32
order  by a.NR_ATENDIMENTO desc


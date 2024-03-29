SELECT 
OBTER_ATENDIMENTO_PRESCR(s.NR_PRESCRICAO) nr_atend,
s.DT_ALTERACAO,
SUBSTR(obter_valor_dominio(1620,s.ie_alteracao),1,100) evento,
s.DS_JUSTIFICATIVA,
s.DS_OBSERVACAO ,
s.DT_HORARIO dT_horario,
obter_nome_pf(s.CD_PESSOA_FISICA) nm_profissional,
obter_desc_funcao(s.CD_FUNCAO) ds_funcao_tasy,
obter_desc_solucao_adep(s.nr_prescricao,s.nr_seq_solucao) ds_item

from PRESCR_SOLUCAO_EVENTO s
join PRESCR_MEDICA p
on s.NR_PRESCRICAO = p.NR_PRESCRICAO
where 
p.dt_prescricao between to_date('14/05/2020 14:00:01', 'dd/mm/yyyy hh24:mi:ss') and to_date('15/05/2020 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
and s.DT_ALTERACAO >= s.DT_HORARIO+(5/60)
--AND s.cd_funcao IN (88,1113)
AND s.CD_FUNCAO = 88

--AND obter_setor_prescricao(s.nr_prescricao,'C') = 32


union

select
OBTER_ATENDIMENTO_PRESCR(m.NR_PRESCRICAO) nr_atend,
m.DT_ALTERACAO,
SUBSTR(obter_valor_dominio(1620,m.ie_alteracao),1,100) evento,
m.DS_JUSTIFICATIVA,
m.DS_OBSERVACAO,
m.DT_HORARIO dT_horario,
obter_nome_pf(m.CD_PESSOA_FISICA) nm_profissional,
obter_desc_funcao(m.CD_FUNCAO) ds_funcao_tasy,
OBTER_DESC_MATERIAL(m.cd_item) ds_item


from PRESCR_MAT_ALTERACAO m
join PRESCR_MEDICA p
on m.NR_PRESCRICAO = p.NR_PRESCRICAO
WHERE 
p.dt_prescricao between TO_date('14/05/2020 14:00:01', 'dd/mm/yyyy hh24:mi:ss') and TO_date('15/05/2020 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
and m.DT_ALTERACAO >= m.DT_HORARIO+(5/60)
AND m.cd_funcao IN (88,1113)
--AND obter_setor_prescricao(m.nr_prescricao,'C') = 32

AND ROWNUM <=100

order by ds_item, dt_horario





-- Filtros
--	Setor
--	Período: data prescrição vigente





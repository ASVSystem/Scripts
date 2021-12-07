
select m.DT_ATUALIZACAO,
m.DT_HORARIO dT_horario,
p.NR_ATENDIMENTO,
m.NR_PRESCRICAO,
m.NR_SEQ_LOTE,
decode(m.IE_TIPO_ITEM,'KIT',OBTER_DESC_recomendacao(m.cd_item),'M',OBTER_DESC_MATERIAL(m.cd_item),'MAT',OBTER_DESC_MATERIAL(m.cd_item)) ds_item,
SUBSTR(obter_valor_dominio(1620,m.ie_alteracao),1,100) evento,
m.DS_JUSTIFICATIVA,
obter_nome_pf(m.CD_PESSOA_FISICA) nm_profissional,
obter_nome_funcao(m.cd_funcao) funcao_checagem

from PRESCR_MAT_ALTERACAO m
join PRESCR_MEDICA p
on m.NR_PRESCRICAO = p.NR_PRESCRICAO

where p.dt_prescricao between to_date('01/01/2018','dd/mm/yyyy hh24:mi:ss') and fim_dia(to_date('30/07/2020','dd/mm/yyyy hh24:mi:ss'))
AND m.CD_PESSOA_FISICA = '284160'
AND m.CD_ITEM IN (1301,
17470,
1297,
6430)
--and (m.cd_funcao = :cd_funcao or :cd_funcao = '0')
--and (p.cd_setor_atendimento = :cd_setor_atend or :cd_setor_atend = '0')
AND m.IE_TIPO_ITEM in ('M','MAT','KIT')
and p.NR_ATENDIMENTO not in(564)
--and :ie_tipo_relatorio = 'A'
--AND 'N' = CASE WHEN m.dt_alteracao >= m.dt_horario+(5/60) THEN 'S' WHEN m.dt_alteracao < m.dt_horario+(5/60) THEN 'N' END
ORDER BY m.DT_ATUALIZACAO,
p.NR_ATENDIMENTO,
m.NR_PRESCRICAO


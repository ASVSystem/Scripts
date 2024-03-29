select s.DT_ATUALIZACAO,
s.DT_HORARIO dT_horario,
p.NR_ATENDIMENTO,
p.NR_PRESCRICAO,
obter_desc_solucao_adep(s.nr_prescricao,s.nr_seq_solucao) ds_item,
SUBSTR(obter_valor_dominio(1620,s.ie_alteracao),1,100) evento,
s.DS_JUSTIFICATIVA,
obter_nome_pf(s.CD_PESSOA_FISICA) nm_profissional,
substr(obter_nome_funcao(s.cd_funcao),1,255) funcao_checagem

from PRESCR_SOLUCAO_EVENTO s
join PRESCR_MEDICA p
on s.NR_PRESCRICAO = p.NR_PRESCRICAO

where p.dt_prescricao between to_date('11/05/2020 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('15/05/2020 23:59:59','dd/mm/yyyy hh24:mi:ss')
--and (s.cd_funcao = :cd_funcao or :cd_funcao = '0')
--and (p.cd_setor_atendimento = :cd_setor_atend or :cd_setor_atend = '0')
and p.NR_ATENDIMENTO not in(564)
and 'A' = 'A'
AND 'S' = CASE WHEN s.dt_alteracao >= s.dt_horario+(5/60) THEN 'S' WHEN s.dt_alteracao < s.dt_horario+(5/60) THEN 'N' END

union

select m.DT_ATUALIZACAO,
m.DT_HORARIO dT_horario,
p.NR_ATENDIMENTO,
m.NR_PRESCRICAO,
decode(m.IE_TIPO_ITEM,'KIT',OBTER_DESC_recomendacao(m.cd_item),'M',OBTER_DESC_MATERIAL(m.cd_item),'MAT',OBTER_DESC_MATERIAL(m.cd_item)) ds_item,
SUBSTR(obter_valor_dominio(1620,m.ie_alteracao),1,100) evento,
m.DS_JUSTIFICATIVA,
obter_nome_pf(m.CD_PESSOA_FISICA) nm_profissional,
substr(obter_nome_funcao(m.cd_funcao),1,255) funcao_checagem

from PRESCR_MAT_ALTERACAO m
join PRESCR_MEDICA p
on m.NR_PRESCRICAO = p.NR_PRESCRICAO

where p.dt_prescricao between to_date('11/05/2020 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('15/05/2020 23:59:59','dd/mm/yyyy hh24:mi:ss')
--and (m.cd_funcao = :cd_funcao or :cd_funcao = '0')
--and (p.cd_setor_atendimento = :cd_setor_atend or :cd_setor_atend = '0')
AND m.IE_TIPO_ITEM in ('M','MAT','KIT')
and p.NR_ATENDIMENTO not in(564)
and 'A' = 'A'
AND 'S' = CASE WHEN m.dt_alteracao >= m.dt_horario+(5/60) THEN 'S' WHEN m.dt_alteracao < m.dt_horario+(5/60) THEN 'N' END

union

select m.DT_ATUALIZACAO,
m.DT_HORARIO dT_horario,
p.NR_ATENDIMENTO,
m.NR_PRESCRICAO,
	CASE WHEN length(m.CD_ITEM) < 4 THEN cpoe_obter_desc_recomendacao(m.CD_ITEM,p.DT_LIBERACAO) 
	WHEN length(m.CD_ITEM) > 3 THEN m.CD_ITEM 
	END ds_item,
	SUBSTR(obter_valor_dominio(1620,m.ie_alteracao),1,100) evento,
	m.DS_JUSTIFICATIVA,
obter_nome_pf(m.CD_PESSOA_FISICA)nm_profissional,
substr(obter_nome_funcao(m.cd_funcao),1,255) funcao_checagem

from PRESCR_MAT_ALTERACAO m
join PRESCR_MEDICA p
on m.NR_PRESCRICAO = p.NR_PRESCRICAO

where p.dt_prescricao between to_date('11/05/2020 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('15/05/2020 23:59:59','dd/mm/yyyy hh24:mi:ss')
--and (m.cd_funcao = :cd_funcao or :cd_funcao = '0')
--and (p.cd_setor_atendimento = :cd_setor_atend or :cd_setor_atend = '0')
AND m.IE_TIPO_ITEM ='R'
and p.NR_ATENDIMENTO not in(564)
and 'A' = 'A'
AND 'S' = CASE WHEN m.dt_alteracao >= m.dt_horario+(5/60) THEN 'S' WHEN m.dt_alteracao < m.dt_horario+(5/60) THEN 'N' END
order by dt_atualizacao, ds_item




--SINTÉTICO-------


SELECT count(*), obter_desc_setor_atend(p.CD_SETOR_ATENDIMENTO) setor_internacao
	FROM PRESCR_MAT_ALTERACAO m
	JOIN PRESCR_SOLUCAO_EVENTO s
		ON m.nr_prescricao = s.nr_prescricao
	join PRESCR_MEDICA p
		ON s.nr_prescricao = p.nr_prescricao
	where p.DT_PRESCRICAO between to_date('01/05/2020 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('15/05/2020 23:59:59','dd/mm/yyyy hh24:mi:ss')
and (m.cd_funcao = 88 OR s.cd_funcao = 88)
and p.NR_ATENDIMENTO not in(564)

GROUP BY rollup (obter_desc_setor_atend(p.CD_SETOR_ATENDIMENTO))



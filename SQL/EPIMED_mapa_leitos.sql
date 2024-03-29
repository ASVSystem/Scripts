select s.CD_CLASSIF_SETOR,
s.cd_setor_atendimento CODIGO_SETOR,
s.ds_setor_atendimento DESCRICAO_SETOR,
u.nr_seq_interno CODIGO_LEITO,
u.CD_UNIDADE_BASICA||''||u.CD_UNIDADE_COMPL DESCRICAO_LEITO,
CASE WHEN s.CD_SETOR_ATENDIMENTO = 177 THEN 'Enfermaria'
ELSE obter_desc_tipo_acomodacao(u.CD_TIPO_ACOMODACAO) END  TIPO_LEITO

from UNIDADE_ATENDIMENTO u
LEFT join SETOR_ATENDIMENTO s
on u.CD_SETOR_ATENDIMENTO = s.CD_SETOR_ATENDIMENTO
where  s.IE_SITUACAO = 'A'
and u.IE_SITUACAO = 'A'
and s.CD_CLASSIF_SETOR in (1,3,4)
and s.CD_SETOR_ATENDIMENTO not in (38,155,59,171)
and u.CD_UNIDADE_COMPL not like '%LV%'
AND u.CD_UNIDADE_BASICA NOT LIKE '%LV%'
--AND CD_TIPO_ACOMODACAO IN (5)
--AND u.CD_UNIDADE_BASICA NOT IN()
--and s.CD_SETOR_ATENDIMENTO = 76


order by descricao_setor, descricao_leito

















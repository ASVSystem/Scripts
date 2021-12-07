select obter_nome_pf(u.cd_pessoa_fisica) nm_usuario
--OBTER_DESC_SETOR_ATEND(u.cd_setor_atendimento)
from USUARIO u
join SETOR_ATENDIMENTO s
on u.CD_SETOR_ATENDIMENTO = s.CD_SETOR_ATENDIMENTO
where u.IE_SITUACAO = 'A'
and s.IE_SITUACAO = 'A'
and s.CD_CLASSIF_SETOR = 7
order by 1

select OBTER_DESC_PERFIL(fp.cd_perfil) from FUNCAO_PERFIL fp , PERFIL p
where fp.CD_PERFIL = p.CD_PERFIL
and fp.CD_FUNCAO = 919
and p.IE_SITUACAO = 'A'

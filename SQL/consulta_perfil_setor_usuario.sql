SELECT obter_desc_setor_atend(s.CD_SETOR_ATENDIMENTO) setor_atend, obter_desc_perfil(p.CD_PERFIL) ds_perfil, obter_nome_usuario(p.nm_usuario) nome_usuario, obter_barras_usuario(p.nm_usuario) matric_barras

FROM usuario_perfil p
JOIN USUARIO_SETOR s
ON p.nm_usuario = s.NM_USUARIO_PARAM

WHERE p.NM_USUARIO = 'MARIA.CUSTODIA'

ORDER BY 1




SELECT OBTER_DESC_PERFIL(cd_perfil), nm_usuario, OBTER_NOME_USUARIO(nm_usuario)
FROM USUARIO_PERFIL
WHERE NM_USUARIO = 'paulo.camargos'


SELECT OBTER_DESC_PERFIL(cd_perfil), nm_usuario, OBTER_NOME_USUARIO(nm_usuario)
FROM USUARIO_PERFIL
WHERE NM_USUARIO = 'marcio.machado'



SELECT * FROM USUARIO
WHERE DS_USUARIO LIKE '%Marcio%Machado%'
SELECT * FROM usuario u
WHERE EXISTS(SELECT p.cd_pessoa_fisica FROM pessoa_fisica p 
				WHERE p.cd_sistema_ant =2360 
				AND p.CD_PESSOA_FISICA = u.cd_pessoa_fisica )

UPDATE TASY.usuario 
SET CD_BARRAS = '10002360'
WHERE CD_PESSOA_FISICA = '231706'

SELECT * FROM USUARIO
WHERE CD_BARRAS = '10001822'
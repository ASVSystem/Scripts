SELECT a.NM_USUARIO, a.DT_ACESSO, a.DT_SAIDA, a.DS_MAQUINA, 
(SELECT obter_desc_setor_atend(cd_setor_atendimento) FROM COMPUTADOR c WHERE upper(c.NM_COMPUTADOR) = upper(a.ds_maquina)) setor_log

FROM tasy_log_acesso a
WHERE ((a.ie_result_acesso = 'A') OR ('A' = 'A'))
and a.dt_acesso between to_date('18/01/2021 00:00:00', 'dd/mm/yyyy hh24:mi:ss')
                                 AND to_date('25/01/2021 23:59:59', 'dd/mm/yyyy hh24:mi:ss')
--and TRUNC(a.DT_ACESSO) in 
--('01/08/18',
--'21/09/18',
--'24/12/18',
--'31/12/18',
--'03/01/19',
--'04/01/19',
--'04/03/19',
--'05/03/19',
--'10/04/19',
--'17/04/19',
--'19/06/19',
--'21/08/19')
and a.nm_usuario = 'adriana.ssantos'
ORDER BY dt_acesso desc


--SELECT * FROM usuario
--WHERE CD_PESSOA_FISICA = 379538


SELECT * FROM EHR_REG_TEMPLATE --307980
WHERE NR_SEQ_REG = 289201


SELECT * FROM EHR_REGISTRO --289195
WHERE NR_ATENDIMENTO = 242413
AND NR_SEQ_TEMPL IN ( 100750, 100751)



SELECT* FROM EHR_REG_ELEMENTO --291022 templ_conteudo
WHERE NR_SEQ_REG_TEMPLATE  = 307988

SELECT * FROM EHR_TEMPLATE_CONTeudo
WHERE NR_SEQ_TEMPLATE = 100750

--291024

SELECT * FROM EHR_CLUSTER
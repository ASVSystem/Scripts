SELECT SUM(QT_PROCEDIMENTO) nr_acum , 

FROM EIS_PROCED_LABORAT_V a WHERE 1 = 1 
AND CD_EMPRESA = a.CD_EMPRESA 
AND CD_ESTABELECIMENTO = 1 
AND IE_MOTIVO_RECOLETA is not null
AND DT_REFERENCIA between to_date('01/07/2019', 'dd/mm/yyyy hh24:mi:ss') AND to_date('15/07/2019 23:59:59', 'dd/mm/yyyy hh24:mi:ss') 

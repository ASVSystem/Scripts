
CREATE OR REPLACE VIEW TASY.HMDCC_EPIMED_SAPS3_V
AS 
SELECT  to_char(a.VISIT_ID) VISIT_ID,
        (EPIMED_obter_data_entrada(a.VISIT_ID)) unitadmissiondatetime,
        to_char(SAPS3_ID) SAPS3_ID,
        to_char(SAPS3_CODE) SAPS3_CODE,
        to_char(1) SAPS3_VALUE,
        (UPDATETIMESTAMP)          
		
FROM  	(select  a.NR_ATENDIMENTO VISIT_ID, hmdcc_obter_saps3_seq('hmdcc_epimed_saps3_seq')  SAPS3_ID, to_char(a.dt_atualizacao, 'YYYY-MM-DD"T"HH24:MI:SS."000"') UPDATETIMESTAMP, DECODE(IE_CARDIOLOGICA,3,3005,500,3006,-5,3007,5,3008,0,2) SAPS3_CODE from	ESCALA_SAPS3 a where a.nr_sequencia = (select max(nr_sequencia) from ESCALA_SAPS3 b where a.nr_atendimento = b.Nr_atendimento)) a
where 	SAPS3_CODE <> '0'
--and To_Date(UPDATETIMESTAMP,'YYYY/MM/DD"T"HH24:MI:SS."000"')  > SYSDATE - 6

union all

SELECT  to_char(a.VISIT_ID) VISIT_ID,
        (EPIMED_obter_data_entrada(a.VISIT_ID)) unitadmissiondatetime,
        to_char(SAPS3_ID) SAPS3_ID,
        to_char(SAPS3_CODE) SAPS3_CODE,
        to_char(1) SAPS3_VALUE,
        (UPDATETIMESTAMP)
		
FROM  (select  a.NR_ATENDIMENTO VISIT_ID, hmdcc_obter_saps3_seq('hmdcc_epimed_saps3_seq')  SAPS3_ID, to_char(a.dt_atualizacao, 'YYYY-MM-DD"T"HH24:MI:SS."000"') UPDATETIMESTAMP, DECODE(IE_HEPATICO,6,3011,0,4) SAPS3_CODE from	ESCALA_SAPS3 a where a.nr_sequencia = (select max(nr_sequencia) from ESCALA_SAPS3 b where a.nr_atendimento = b.Nr_atendimento)) a
where 	SAPS3_CODE <> '0'
--and To_Date(UPDATETIMESTAMP,'YYYY/MM/DD"T"HH24:MI:SS."000"')  > SYSDATE - 6

union all

SELECT  to_char(a.VISIT_ID) VISIT_ID,
        (EPIMED_obter_data_entrada(a.VISIT_ID)) unitadmissiondatetime,
        to_char(SAPS3_ID) SAPS3_ID,
        to_char(SAPS3_CODE) SAPS3_CODE,
        to_char(1) SAPS3_VALUE,
        (UPDATETIMESTAMP)
		
FROM  (select  a.NR_ATENDIMENTO VISIT_ID, hmdcc_obter_saps3_seq('hmdcc_epimed_saps3_seq')  SAPS3_ID, to_char(a.dt_atualizacao, 'YYYY-MM-DD"T"HH24:MI:SS."000"') UPDATETIMESTAMP, DECODE(IE_ABDOMEM,3,3009,9,3010,0,3) SAPS3_CODE from	ESCALA_SAPS3 a where a.nr_sequencia = (select max(nr_sequencia) from ESCALA_SAPS3 b where a.nr_atendimento = b.Nr_atendimento)) a
where 	SAPS3_CODE <> '0'
--and To_Date(UPDATETIMESTAMP,'YYYY/MM/DD"T"HH24:MI:SS."000"')  > SYSDATE - 6

union all

SELECT  to_char(a.VISIT_ID) VISIT_ID,
        (EPIMED_obter_data_entrada(a.VISIT_ID)) unitadmissiondatetime,
        to_char(SAPS3_ID) SAPS3_ID,
        to_char(SAPS3_CODE) SAPS3_CODE,
        to_char(1) SAPS3_VALUE,
        (UPDATETIMESTAMP)
		
FROM  (select  a.NR_ATENDIMENTO VISIT_ID, hmdcc_obter_saps3_seq('hmdcc_epimed_saps3_seq') SAPS3_ID, to_char(a.dt_atualizacao, 'YYYY-MM-DD"T"HH24:MI:SS."000"') UPDATETIMESTAMP, DECODE(IE_NEUROLOGICA,4,3001,-4,3002,7,3003,10,3004,0,1) SAPS3_CODE from	ESCALA_SAPS3 a where a.nr_sequencia = (select max(nr_sequencia) from ESCALA_SAPS3 b where a.nr_atendimento = b.Nr_atendimento)) a
where 	SAPS3_CODE <> '0'
--and To_Date(UPDATETIMESTAMP,'YYYY/MM/DD"T"HH24:MI:SS."000"')  > SYSDATE - 6

union all

SELECT  to_char(a.VISIT_ID) VISIT_ID,
        (EPIMED_obter_data_entrada(a.VISIT_ID)) unitadmissiondatetime,
        to_char(SAPS3_ID) SAPS3_ID,
        to_char(SAPS3_CODE) SAPS3_CODE,
        to_char(1) SAPS3_VALUE,
        (UPDATETIMESTAMP)
		
FROM  (select  a.NR_ATENDIMENTO VISIT_ID, hmdcc_obter_saps3_seq('hmdcc_epimed_saps3_seq')  SAPS3_ID, to_char(a.dt_atualizacao, 'YYYY-MM-DD"T"HH24:MI:SS."000"') UPDATETIMESTAMP, DECODE(IE_TIPO_OPERACAO,-11,3012,-8,3013,-6,3014,5,3015,0,5) SAPS3_CODE  from	ESCALA_SAPS3 a where a.nr_sequencia = (select max(nr_sequencia) from ESCALA_SAPS3 b where a.nr_atendimento = b.Nr_atendimento)) a
where 	SAPS3_CODE <> '0'
--and To_Date(UPDATETIMESTAMP,'YYYY/MM/DD"T"HH24:MI:SS."000"')  > SYSDATE - 6

union all

SELECT  to_char(a.VISIT_ID) VISIT_ID,
        (EPIMED_obter_data_entrada(a.VISIT_ID)) unitadmissiondatetime,
        to_char(SAPS3_ID) SAPS3_ID,
        to_char(SAPS3_CODE) SAPS3_CODE,
        to_char(SAPS3_VALUE) SAPS3_VALUE,
        (UPDATETIMESTAMP)
		
FROM  (select  a.NR_ATENDIMENTO VISIT_ID, hmdcc_obter_saps3_seq('hmdcc_epimed_saps3_seq')  SAPS3_ID, to_char(a.dt_atualizacao, 'YYYY-MM-DD"T"HH24:MI:SS."000"') UPDATETIMESTAMP, NVL2(IE_INFEC_NOSOCOMIAL,3016,3016) SAPS3_CODE, DECODE(IE_INFEC_NOSOCOMIAL,'S',1,'N',0) SAPS3_VALUE from	ESCALA_SAPS3 a where a.nr_sequencia = (select max(nr_sequencia) from ESCALA_SAPS3 b where a.nr_atendimento = b.Nr_atendimento)) a
where 	SAPS3_CODE <> '0'
--and To_Date(UPDATETIMESTAMP,'YYYY/MM/DD"T"HH24:MI:SS."000"')  > SYSDATE - 6

union all

SELECT  to_char(a.VISIT_ID) VISIT_ID,
        (EPIMED_obter_data_entrada(a.VISIT_ID)) unitadmissiondatetime,
        to_char(SAPS3_ID) SAPS3_ID,
        to_char(SAPS3_CODE) SAPS3_CODfdE,
        to_char(SAPS3_VALUE) SAPS3_VALUE,
        (UPDATETIMESTAMP)
		
FROM  (select  a.NR_ATENDIMENTO VISIT_ID, hmdcc_obter_saps3_seq('hmdcc_epimed_saps3_seq')  SAPS3_ID, to_char(a.dt_atualizacao, 'YYYY-MM-DD"T"HH24:MI:SS."000"') UPDATETIMESTAMP, NVL2(IE_INFEC_RESP,3017,3017) SAPS3_CODE, DECODE(IE_INFEC_RESP,'S',1,'N',0) SAPS3_VALUE from	ESCALA_SAPS3 a where a.nr_sequencia = (select max(nr_sequencia) from ESCALA_SAPS3 b where a.nr_atendimento = b.Nr_atendimento)) a
where 	SAPS3_CODE <> '0'
--and To_Date(UPDATETIMESTAMP,'YYYY/MM/DD"T"HH24:MI:SS."000"')  > SYSDATE - 6
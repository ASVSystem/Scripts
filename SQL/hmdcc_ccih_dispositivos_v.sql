
--CREATE OR REPLACE VIEW	hmdcc_ccih_dispositivos_v
--AS

SELECT d.dt_instalacao, d.dt_retirada,
substr(obter_descricao_padrao('DISPOSITIVO','DS_DISPOSITIVO',d.nr_seq_dispositivo),1,100) ds_dispositivo, 
--d.nr_seq_dispositivo,
--d.nr_seq_topografia, 
obter_dados_dispositivo(d.nr_sequencia,'S') setor_instalacao,  

CASE WHEN obter_dif_data(d.dt_instalacao,d.dt_retirada,'TM') = '0' THEN 0
ELSE to_number(obter_dif_data(d.dt_instalacao,d.dt_retirada,'TM')) END permanencia_minutos,

to_number(hsc_obter_horas_minutos(to_number(obter_dif_data(d.dt_instalacao,d.dt_retirada,'TM')))) permanencia_horas
--to_number(hsc_obter_horas_minutos(to_number(obter_dif_data(d.dt_instalacao,d.dt_retirada,'TM'))),'09999.99')/24 permanencia_dias



FROM atend_pac_dispositivo d

WHERE d.dt_instalacao BETWEEN '01/03/2021' AND fim_dia('31/03/2021')
ORDER BY ds_dispositivo
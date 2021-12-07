CREATE OR REPLACE FUNCTION hmdcc_obter_procedimento_nis(
		nr_seq_proced_nis_p	NUMBER, ie_opcao_p VARCHAR)
	RETURN VARCHAR IS

ds_retorno_w		Varchar2(255);

BEGIN

if	( nr_seq_proced_nis_p is not null ) AND ie_opcao_p = 'D'then
	select 	substr(ds_proced_niss,1,255)
	into	ds_retorno_w
	from 	niss_procedimento
	where 	nr_sequencia = nr_seq_proced_nis_p;
end if;

if	( nr_seq_proced_nis_p is not null ) AND ie_opcao_p = 'C' then
	select 	cd_proced_niss
	into	ds_retorno_w
	from 	niss_procedimento
	where 	nr_sequencia = nr_seq_proced_nis_p;
end if;

RETURN ds_retorno_w;

END hmdcc_obter_procedimento_nis;

GRANT EXECUTE ON TASY.hmdcc_obter_procedimento_nis TO USR_ALESSANDER;
GRANT EXECUTE ON TASY.hmdcc_obter_procedimento_nis TO USR_DANIELLE;
GRANT EXECUTE ON TASY.hmdcc_obter_procedimento_nis TO USR_LUCASBOMTEMPO;


--SELECT hmdcc_obter_procedimento_nis(nr_seq_proced_niss, 'D') FROM proc_interno
--WHERE NR_SEQ_PROCED_NISS IS NOT null
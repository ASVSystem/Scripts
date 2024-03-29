CREATE OR REPLACE function hmdcc_obter_dt_cancel_cirurgia (	nr_cirurgia_p			number )
			return varchar2 is

ds_retorno_w		varchar2(40);

begin

	if	(nr_cirurgia_p is not null) then
		
		select	TO_CHAR(dt_cancelamento, 'dd/mm/yyyy hh24:mi:ss')
		into	ds_retorno_w
			
		from    cirurgia
		where	nr_cirurgia = nr_cirurgia_p;
		
			
	end if;

	return ds_retorno_w;

end hmdcc_obter_dt_cancel_cirurgia;


CREATE OR REPLACE FUNCTION hmdcc_obter_dados_saps3 (ie_informacao_p varchar, ie_opcao_p varchar)
   RETURN varchar2
   IS 
   
dado_saps3_w varchar2(5);

      Cursor C001 Is
      Select ie_cardiologica, ie_hepatico, ie_abdomem, ie_neurologica, ie_urgencia, ie_tipo_operacao, ie_infec_nosocomial, ie_infec_resp
      From ESCALA_SAPS3;
      dado_saps3 C001%Rowtype;
Begin
      Open C001;
      Loop
            Fetch C001
            Into dado_saps3;
            Exit When
                      C001%NotFound;
            if ie_informacao_p = 'C' and ie_opcao_p = 'D' then
				select DECODE(dado_saps3.ie_cardiologica,-5,'ARR',3,'CHO',500,'SEP',5 ,'ANA',0,'COUT')
				into dado_saps3_w
				from dual;
				else if ie_opcao_p = 'V' then
				dado_saps3_w := 'S';
				end if;
			end if;
			
			if ie_informacao_p = 'H' and ie_opcao_p = 'D' then
				select DECODE(dado_saps3.ie_hepatico,6,'IHP',3,'AAG',9,'PSEV',0,'HOUT')
				into dado_saps3_w
				from dual;
				else if ie_opcao_p = 'V' then
				dado_saps3_w := 'S';
				end if;
			end if;
                      
          -- Dbms_Output.Put_Line(dado_saps3_w);
      End Loop;
      Close C001;
	
	
return dado_saps3_w;

END hmdcc_obter_dados_saps3;




---------=======================================================






DROP FUNCTION TASY.EHR_ESCALA_SAPS3;

CREATE OR REPLACE function ehr_escala_SAPS3(	nr_seq_elemento_p	number,
					cd_pessoa_fisica_p	number,
					nr_atendimento_p	number,
					ie_inf_entidade_p	varchar2,
					ie_atendimento_p	varchar2,
					ie_profissional_p	varchar2 default 'N')
				return varchar2 is

ds_retorno_w			varchar2(20000);
ds_retorno_ww			varchar2(20000);

nr_sequencia_w			number(10);
nm_atributo_w			varchar2(255);
ds_comando_w			varchar2(2000);
ds_comando_ww			varchar2(2000);
ds_label_w			varchar2(60);
ds_quebra_w			varchar2(30);
ds_separador_w			varchar2(30);
c001				Integer;
qt_cursor_w			number(10);
nm_usuario_w			Varchar2(15);

cursor c01 is
select	nr_sequencia
from	escala_saps3 a
where	nr_atendimento	= nr_atendimento_p
and	ie_atendimento_p = 'S'
and	ie_profissional_p = 'N'
and	nr_sequencia  in (	select	max(x.nr_sequencia)
				from	escala_saps3 x
				where	nr_atendimento		= nr_atendimento_p
				and	ie_inf_entidade_p	= 'U'
				and	x.dt_inativacao is null
				union
				select	x.nr_sequencia
				from	escala_saps3 x
				where	nr_atendimento		= nr_atendimento_p
				and	x.dt_inativacao is null
				and	ie_inf_entidade_p	= 'T')
union
select	nr_sequencia
from	escala_saps3 a
where	nr_atendimento	in (	select	b.nr_atendimento
				from	atendimento_paciente b
				where	b.cd_pessoa_fisica 	= cd_pessoa_fisica_p)
and	ie_atendimento_p = 'N'
and	ie_profissional_p = 'N'
and	nr_sequencia  in (	select	max(x.nr_sequencia)
				from	escala_saps3 x
				where	x.nr_atendimento	 in (	select	b.nr_atendimento
								from	atendimento_paciente b
								where	b.cd_pessoa_fisica 	= cd_pessoa_fisica_p)
				and	ie_inf_entidade_p	= 'U'
				and	x.dt_inativacao is null
				union
				select	x.nr_sequencia
				from	escala_saps3 x
				where	x.nr_atendimento	in (	select	b.nr_atendimento
									from	atendimento_paciente b
									where	b.cd_pessoa_fisica 	= cd_pessoa_fisica_p)
				and	x.dt_inativacao is null
				and	ie_inf_entidade_p	= 'T')
union
select	nr_sequencia
from	escala_saps3 a
where	nr_atendimento	= nr_atendimento_p
and	ie_atendimento_p = 'S'
and	ie_profissional_p = 'S'
and	nr_sequencia  in (	select	max(x.nr_sequencia)
				from	escala_saps3 x
				where	nr_atendimento		= nr_atendimento_p
				and	ie_inf_entidade_p	= 'U'
				and	x.dt_inativacao is null
				and	x.nm_usuario_nrec = nm_usuario_w
				union
				select	x.nr_sequencia
				from	escala_saps3 x
				where	nr_atendimento		= nr_atendimento_p
				and	x.dt_inativacao is null
				and	x.nm_usuario_nrec = nm_usuario_w
				and	ie_inf_entidade_p	= 'T')
union
select	nr_sequencia
from	escala_saps3 a
where	nr_atendimento	in (	select	b.nr_atendimento
				from	atendimento_paciente b
				where	b.cd_pessoa_fisica 	= cd_pessoa_fisica_p)
and	ie_atendimento_p = 'N'
and	ie_profissional_p = 'S'
and	nr_sequencia  in (	select	max(x.nr_sequencia)
				from	escala_saps3 x
				where	x.nr_atendimento	 in (	select	b.nr_atendimento
								from	atendimento_paciente b
								where	b.cd_pessoa_fisica 	= cd_pessoa_fisica_p)
				and	ie_inf_entidade_p	= 'U'
				and	x.dt_inativacao is null
				and	x.nm_usuario_nrec = nm_usuario_w
				union
				select	x.nr_sequencia
				from	escala_saps3 x
				where	x.nr_atendimento	in (	select	b.nr_atendimento
									from	atendimento_paciente b
									where	b.cd_pessoa_fisica 	= cd_pessoa_fisica_p)
				and	x.dt_inativacao is null
				and	x.nm_usuario_nrec = nm_usuario_w
				and	ie_inf_entidade_p	= 'T')
order by nr_sequencia;

Cursor C02 is
select	nvl(ds_function,nm_atributo),
	ds_label,
	decode(ie_quebra_linha,'S',' chr(13) ||chr(10) ||',null),
	ds_separador
from	ehr_template_cont_ret
where	nr_seq_elemento	= nr_seq_elemento_p
order by nr_seq_apres;

begin

nm_usuario_w := WHEB_USUARIO_PCK.get_nm_usuario;

open C02;
loop
fetch C02 into
	nm_atributo_w,
	ds_label_w,
	ds_quebra_w,
	ds_separador_w;
exit when C02%notfound;
	begin
	if	(ds_comando_w is not null) then
		ds_comando_w	:= ds_comando_w ||'||'||chr(13);
	end if;
	ds_comando_w	:= ds_comando_w ||' decode('||nm_atributo_w||',null,null,'||ds_quebra_w ||chr(39) || ds_label_w ||chr(39) ||'|| '|| nm_atributo_w ||'||'|| chr(39) || ds_separador_w ||chr(39) ||')';
	end;
end loop;
close C02;

ds_comando_w	:= 'Select '||ds_comando_w ||' ds '||chr(13) ||'From escala_saps3 ';


open C01;
loop
fetch C01 into
	nr_sequencia_w;
exit when C01%notfound;
	begin
	ds_comando_ww	:= ds_comando_w || chr(13) || 'where nr_sequencia = '||to_char(nr_sequencia_w);

	c001 := dbms_sql.open_cursor;
	dbms_sql.parse(c001, ds_comando_ww, dbms_sql.native);
	dbms_sql.define_column(c001, 1, ds_retorno_ww, 2000);
	qt_cursor_w	:= dbms_sql.execute(c001);
	qt_cursor_w	:= dbms_sql.fetch_rows(c001);
	dbms_sql.column_value(c001, 1, ds_retorno_ww);
	dbms_sql.close_cursor(c001);
	ds_retorno_w	:= ds_retorno_w ||ds_retorno_ww ||chr(13);
	end;
end loop;
close C01;

return substr(ds_retorno_w,1,2000);

end ehr_escala_SAPS3;
 


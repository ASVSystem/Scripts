CREATE OR REPLACE FUNCTION hmdcc_Obter_Hist_comorbidade(nr_sequencia_p	Number)
			return varchar2 is

ds_retorno_w		Varchar2(4000);
ds_status_w		varchar2(60);
dt_inicio_w		Date;
dt_fim_w		Date;
ds_doenca_w			varchar2(255);
ds_abordagem_w		varchar2(255);
ds_observacao_w		varchar2(255);
ds_duracao_w		Varchar2(20);

BEGIN

select	substr(obter_valor_dominio(1332,ie_status),1,60),
	dt_inicio,
	dt_fim,
	ds_doenca,
	ds_abordagem,
	ds_observacao,
	substr(obter_idade(dt_inicio,nvl(dt_fim,sysdate),'S'),1,20)
into	ds_status_w,
	dt_inicio_w,
	dt_fim_w,
	ds_doenca_w,
	ds_abordagem_w,
	ds_observacao_w,
	ds_duracao_w
from	paciente_antec_clinico
where	nr_sequencia	= nr_sequencia_p;

ds_retorno_w	:= wheb_mensagem_pck.get_texto(309160) || '  '||to_char(dt_inicio_w,'dd/mm/yyyy') || chr(13) || chr(10);

if	(dt_fim_w is not null) then
	ds_retorno_w	:= wheb_mensagem_pck.get_texto(309160) || '  '||to_char(dt_inicio_w,'dd/mm/yyyy')||' ' || wheb_mensagem_pck.get_texto(309164) || ' '||to_char(dt_fim_w,'dd/mm/yyyy')||'   ' || wheb_mensagem_pck.get_texto(309167) || ' '||ds_duracao_w||chr(13) || chr(10);
end if;

if	(ds_status_w is not null) then
	ds_retorno_w	:= ds_retorno_w || wheb_mensagem_pck.get_texto(309189) || '  '||ds_status_w || chr(13) || chr(10); -- Status
end if;

if	(ds_abordagem_w is not null) then
	ds_retorno_w	:= ds_retorno_w || wheb_mensagem_pck.get_texto(309181) || '  '||ds_abordagem_w || chr(13) || chr(10);
end if;

if	(ds_observacao_w is not null) then
	ds_retorno_w	:= ds_retorno_w || wheb_mensagem_pck.get_texto(309183) || '  '||ds_observacao_w || chr(13) || chr(10);
end if;

return ds_retorno_w;

END Obter_Hist_Saude_Ant_Clinico;
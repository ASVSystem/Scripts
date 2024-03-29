CREATE OR REPLACE function hmdcc_status_alteracao_conj(
			nr_seq_conjunto_p		number
			)
			return number is

cd_status_w		number(10);
ds_alteracao_v VARCHAR2(200);

begin

select	ds_historico
into	ds_alteracao_v
from	cm_conjunto_cont_hist
where	nr_seq_conjunto = 2095213 ;-- nr_seq_conjunto_p
if ds_alteracao_v = 'Alterado status de Contaminado para Em limpeza - Termodesinfecção'THEN cd_status_w := 1;
    elseif ds_alteracao_v = 'Alterado status de Em limpeza - Termodesinfecção para Limpo' THEN cd_status_w := 2;
	elseif ds_alteracao_v = 'Alterado status de Limpo para Aguardando Esterilização' THEN cd_status_w := 3;
	--elseif ds_alteracao_v like '%Conjunto incluído no ciclo%' THEN cd_status_w := 4;
	elseif ds_alteracao_v = 'Alterado status de Aguardando Esterilização para Em esterilização' THEN cd_status_w := 5;
	elseif ds_alteracao_v = 'Alterado status de Em esterilização para Esterilizado' THEN cd_status_w := 6;
	elseif ds_alteracao_v = 'Repassado para o local de estoque Arsenal CME ' THEN cd_status_w := 7;
end if;                       

return	cd_status_w;

end hmdcc_status_alteracao_conj;

--SELECT * FROM cm_conjunto_cont_hist
--WHERE nr_seq_conjunto = 2095262

 
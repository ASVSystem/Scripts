create or replace function hmdcc_obter_ds_label_grid(
							nr_seq_template_p number,
							nr_temp_conteudo_p number)
return varchar is

ds_label_elemento_w varchar2(6)	:= '';


begin

	select t.ds_label_grid
	into ds_label_elemento_w
	from  ehr_reg_elemento e
	join EHR_TEMPLATE_CONTEUDO t
	on e.NR_SEQ_TEMP_CONTEUDO = t.NR_SEQUENCIA
	join EHR_REG_TEMPLATE r
	on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
	JOIN EHR_REGISTRO v
	on r.NR_SEQ_REG = v.NR_SEQUENCIA
	
	where r.NR_SEQ_TEMPLATE = nr_seq_template_p --nr_seq_template_p 100704
	and e.nr_registro_cluster is not null
	and r.DT_INATIVACAO is null
	and NVL(v.ie_situacao,'A') <> 'I'
 	and e.DS_RESULTADO = 'S'
	and e.NR_SEQ_TEMP_CONTEUDO = nr_temp_conteudo_p ;--nr_temp_conteudo_p 290215 ;


return ds_label_elemento_w;

end hmdcc_obter_ds_label_grid;
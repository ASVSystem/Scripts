CREATE OR REPLACE function hmdcc_obter_ds_label_grid(
							nr_seq_reg_template_p number,
							nr_reg_elemento_p number)
return varchar is
/* Esta function tem a finalidade de retornar a descrição do atributo "ds_label_grid"
da tabela "EHR_TEMPLATE_CONTEUDO" nos casos em que os elementos (Matástico e Locorregional)
do Template de Sequencia 100704(alterar na produção) estiver com resultado S.
*/



ds_label_elemento_w varchar2(6)	:= '';
ds_resultado_v varchar2(6)	:= '';


begin

	select e.DS_RESULTADO
	into ds_resultado_v
	from  ehr_reg_elemento e
	join EHR_TEMPLATE_CONTEUDO t
	on e.NR_SEQ_TEMP_CONTEUDO = t.NR_SEQUENCIA
	join EHR_REG_TEMPLATE r
	on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
	JOIN EHR_REGISTRO v
	on r.NR_SEQ_REG = v.NR_SEQUENCIA
	
	where r.NR_SEQ_TEMPLATE = 100704 --nr_seq_template_p 100704 trocar pelo template da produção
	and e.NR_SEQ_REG_TEMPLATE = nr_seq_reg_template_p
	and (case when e.NR_SEQ_TEMP_CONTEUDO = 290291 then 1
				when e.NR_SEQ_TEMP_CONTEUDO = 290292 then 2 end ) in (1,2)
	and e.DS_RESULTADO = 'S';

 
	
		if ds_resultado_v = 'S' then
		   
			select t.ds_label_grid
			   into ds_label_elemento_w
				from  ehr_reg_elemento e
				join EHR_TEMPLATE_CONTEUDO t
				on e.NR_SEQ_TEMP_CONTEUDO = t.NR_SEQUENCIA
				join EHR_REG_TEMPLATE r
				on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
				JOIN EHR_REGISTRO v
				on r.NR_SEQ_REG = v.NR_SEQUENCIA
				
				where r.NR_SEQ_TEMPLATE = 100704 --nr_seq_template_p 100704
				and e.nr_registro_cluster is not null
				and r.DT_INATIVACAO is null
				and NVL(v.ie_situacao,'A') <> 'I'
			 	and e.DS_RESULTADO = 'S'
			 	and e.NR_SEQUENCIA = nr_reg_elemento_p;
			   --	and e.NR_SEQ_TEMP_CONTEUDO = 290215 ;--nr_temp_conteudo_p 290215 ;
		end if;

--dbms_output.put_line(ds_label_elemento_w);	



return ds_label_elemento_w;

end hmdcc_obter_ds_label_grid;
--end;

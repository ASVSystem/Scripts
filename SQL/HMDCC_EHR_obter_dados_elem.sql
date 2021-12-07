CREATE OR REPLACE function HMDCC_obter_dados_elem(nr_seq_temp_conteudo_p		number)
 		    	return varchar2 IS
 		    	
ds_retorno_w VARCHAR2(250);

BEGIN 
	IF nr_seq_temp_conteudo_p IS NOT NULL
	THEN 
		SELECT ds_label_grid
		INTO  ds_retorno_w
		
		FROM ehr_template_conteudo
		
		WHERE NR_SEQUENCIA = nr_seq_temp_conteudo_p;
	
	END IF;

RETURN ds_retorno_w;

END HMDCC_obter_dados_elem;
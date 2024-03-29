CREATE OR REPLACE FUNCTION hmdcc_obter_hora_atb_aval(nr_cirurgia_p NUMBER)
RETURN VARCHAR2 IS

--DECLARE 
 
 CURSOR c_01 IS
 	SELECT to_char(ma.dt_liberacao, 'dd/mm/yyyy') dt_avaliacao,
 	substr(mr.ds_resultado,1,5) ds_resultado,
 	mr.nr_seq_item seq_item
 	FROM med_avaliacao_paciente ma, med_avaliacao_result mr
 	WHERE ma.nr_cirurgia = nr_cirurgia_p AND ma.ie_situacao = 'A'
 	AND mr.nr_seq_avaliacao = ma.nr_sequencia AND ma.nr_seq_tipo_avaliacao = 295
 	AND mr.nr_seq_item =8066 -- ATB na Uniade Origem
 	AND ma.dt_liberacao IS NOT NULL;
 	
CURSOR c_02 IS
 	SELECT to_char(ma.dt_liberacao, 'dd/mm/yyyy') dt_avaliacao,
 	substr(mr.ds_resultado,1,5) ds_resultado,
 	mr.nr_seq_item seq_item
 	FROM med_avaliacao_paciente ma, med_avaliacao_result mr
 	WHERE ma.nr_cirurgia = nr_cirurgia_p AND ma.ie_situacao = 'A'
 	AND mr.nr_seq_avaliacao = ma.nr_sequencia AND ma.nr_seq_tipo_avaliacao = 295
 	AND mr.nr_seq_item = 7807  -- ATB Profilático
 	AND ma.dt_liberacao IS NOT NULL;


 result_c01_v c_01%ROWTYPE;
 result_c02_v c_02%ROWTYPE;
 result_data_w VARCHAR2(20);
 --ie_opcao_v VARCHAR2(4);
 
 
 BEGIN
  --ie_opcao_v := 'ATBP';
 
 	IF NOT c_01%ISOPEN THEN
 		OPEN c_01;
 	END IF;
 	
 	IF NOT c_02%ISOPEN THEN
 		OPEN c_02;
 	END IF;
 
 	LOOP 
 		FETCH c_01 INTO result_c01_v;
 		FETCH c_02 INTO result_c02_v;
 		
 	EXIT WHEN c_01%NOTFOUND;
 	EXIT WHEN c_02%NOTFOUND;
 	
 	IF result_c02_v.ds_resultado IS NOT NULL AND result_c02_v.ds_resultado BETWEEN '00:00' AND '23:59'
 		
 		THEN result_data_w := substr(result_c02_v.dt_avaliacao||' '||result_c02_v.ds_resultado||':00',1,20);
 		
 		ELSE IF result_c01_v.ds_resultado IS NOT NULL AND result_c01_v.ds_resultado BETWEEN '00:00' AND '23:59'
 		
 			THEN 	result_data_w := substr(result_c01_v.dt_avaliacao||' '||result_c01_v.ds_resultado||':00',1,20);
 			
 			ELSE result_data_w := result_c01_v.dt_avaliacao||' 00:00:00';
 			
 		END IF;
 
 	END IF;
		
--	dbms_output.put_line(result_data_w);
 	 		
 	END LOOP;
 	CLOSE c_01;
 	CLOSE c_02;
 	
 RETURN result_data_w;
 
 --END;	   
 	
END hmdcc_obter_hora_atb_aval;
 

 
GRANT SELECT ON TASY.hmdcc_obter_hora_atb_aval TO USR_ALESSANDER;
GRANT SELECT ON TASY.hmdcc_obter_hora_atb_aval TO USR_LEANDRO;
GRANT SELECT ON TASY.hmdcc_obter_hora_atb_aval TO USR_BRUNOSOUZA;

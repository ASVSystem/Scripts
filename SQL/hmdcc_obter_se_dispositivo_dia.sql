
--CREATE OR REPLACE FUNCTION hmdcc_obter_se_disp_dia(nr_seq_avaliacao_p NUMBER, nr_seq_item_p number)
--RETURN NUMBER IS

DECLARE 
 
 CURSOR c_01 IS
     SELECT DISTINCT
     a.nr_atendimento nr_atendimento,
		substr(decode(r.qt_resultado,1,'VMI'),1,10) ds_dispositivo,
		a.dt_avaliacao dt_dispositivo,
		fim_dia(a.dt_avaliacao) dt_dispositivo1
		

		FROM 	MED_AVALIACAO_PACIENTE a
		JOIN MED_AVALIACAO_RESULT r
		ON a.NR_SEQUENCIA = r.NR_SEQ_AVALIACAO
		WHERE a.DT_AVALIACAO BETWEEN '01/05/2021' AND '30/05/2021'
 		AND a.NR_SEQ_TIPO_AVALIACAO = 362
		AND r.NR_SEQ_ITEM = 11515
		AND r.QT_RESULTADO = 1
		AND a.IE_SITUACAO = 'A'
		AND a.NR_ATENDIMENTO = 287458
		AND a.DT_LIBERACAO IS NOT NULL
		ORDER BY dt_dispositivo
		;
     
--UNION
--
--     SELECT DISTINCT
--     ROWNUM id,
--      a.nr_atendimento nr_atendimento,
--		substr(obter_resultado_avaliacao(a.nr_sequencia, r.nr_seq_item,a.nr_seq_tipo_avaliacao,a.nr_atendimento),1,10) ds_dispositivo,
--		a.dt_avaliacao dt_dispositivo
--
--		FROM 	MED_AVALIACAO_PACIENTE a
--		JOIN MED_AVALIACAO_RESULT r
--		ON a.NR_SEQUENCIA = r.NR_SEQ_AVALIACAO
--		WHERE a.DT_AVALIACAO BETWEEN '01/05/2021' AND '30/05/2021'
-- 		AND a.NR_SEQ_TIPO_AVALIACAO = 346
--		AND r.NR_SEQ_ITEM in (10278,10344,10346,10348,10350)
--		AND a.IE_SITUACAO = 'A'
--		AND a.DT_LIBERACAO IS NOT NULL
--		AND a.NR_ATENDIMENTO = 287458
--		AND substr(obter_resultado_avaliacao(a.nr_sequencia, r.nr_seq_item,a.nr_seq_tipo_avaliacao,a.nr_atendimento),1,10) IS NOT null
--		ORDER BY nr_atendimento,id, dt_dispositivo;
--		--AND obter_resultado_avaliacao(a.nr_sequencia, r.nr_seq_item,a.nr_seq_tipo_avaliacao,a.nr_atendimento) IN ('CVC', 'CDL');


 c01_v c_01%ROWTYPE;
 --c02_v c_02%ROWTYPE;
 qt_dia_v NUMBER := 0;
 dia_disp_w VARCHAR(20);
 
 
 
 BEGIN
  --ie_opcao_v := 'ATBP';
 
     IF NOT c_01%ISOPEN THEN
         OPEN c_01;
     END IF;
     
--     IF NOT c_02%ISOPEN THEN
--         OPEN c_02;
--     END IF;
 
     LOOP 
         FETCH c_01 INTO c01_v;
        -- FETCH c_02 INTO c02_v;
         
     EXIT WHEN c_01%NOTFOUND;
     --EXIT WHEN c_02%NOTFOUND;
     
     IF c01_v.ds_dispositivo = 'VMI' AND c01_v.dt_dispositivo1 >= c01_v.dt_dispositivo
     	THEN dia_disp_w := obter_dif_data(c01_v.dt_dispositivo, c01_v.dt_dispositivo1, 'S');
     	ELSE dia_disp_w := '0';
 
     END IF;
        
    dbms_output.put_line(dia_disp_w||' - '||c01_v.dt_dispositivo||' - '||c01_v.dt_dispositivo1);
              
     END LOOP;
     CLOSE c_01;
     --CLOSE c_02;
     
-- RETURN qt_dia_disp_w;
 
 END;       
     
--END hmdcc_obter_se_disp_dia; 

--GRANT EXECUTE ON TASY.hmdcc_obter_se_disp_dia TO USR_ALESSANDER;

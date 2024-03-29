CREATE OR REPLACE FUNCTION hmdcc_obter_dt_coleta_lab(nr_seq_resultado_p NUMBER, nr_seq_exame_p NUMBER)
    RETURN VARCHAR2 IS


dt_coleta_W date;
dt_coleta_v date;


BEGIN

dt_coleta_W := '';
dt_coleta_v :='';

BEGIN
    SELECT max(dt_coleta) 
    INTO dt_coleta_v
    FROM EXAME_LAB_RESULT_ITEM
    WHERE  NR_SEQ_RESULTADO = nr_seq_resultado_p  AND NR_SEQ_EXAME = nr_seq_exame_p;
END;
            
            
          IF dt_coleta_v IS null THEN
            SELECT max(r.dt_coleta)
            INTO dt_coleta_w
                FROM EXAME_LAB_RESULT_ITEM r
                
                WHERE r.dt_coleta IS NOT NULL
                AND r.nr_seq_resultado = nr_seq_resultado_p 
                AND (r.NR_SEQ_EXAME = (SELECT i.nr_seq_superior FROM EXAME_LABORATORIO i WHERE i.nr_seq_exame = nr_seq_exame_p) 
                OR r.NR_SEQ_EXAME = nr_seq_exame_p);
            
          ELSIF dt_coleta_v IS NOT NULL THEN  dt_coleta_W := dt_coleta_v; 
  

        END IF;


RETURN  to_char(dt_coleta_W,'YYYY-MM-DD HH24:MI:SS');


END hmdcc_obter_dt_coleta_lab; 




CREATE OR REPLACE FUNCTION hmdcc_obter_classe_nota_aval(nr_sequencia_p number)
RETURN VARCHAR IS 

ie_classe_nota_w char(1);

BEGIN 

SELECT 
	CASE 
		WHEN avg(b.vl_media) >79 THEN 'A'
		WHEN avg(b.vl_media) BETWEEN 59 AND 80 THEN 'B'
		WHEN avg(b.vl_media) < 60 THEN 'C'
	   
	END 
INTO ie_classe_nota_w
FROM avf_resultado b WHERE b.nr_sequencia = nr_sequencia_p;


RETURN ie_classe_nota_w;
END hmdcc_obter_classe_nota_aval;
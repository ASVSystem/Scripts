SELECT nm_usuario,
				ds_usuario,
				PAGING_RN 

FROM (SELECT PAGING.*, ROWNUM PAGING_RN 
	   FROM ( SELECT 	nm_usuario,
				ds_usuario
			  FROM 	usuario
			  WHERE	ie_tipo_evolucao = '1'
			  ORDER BY ds_usuario) PAGING 
			  
	  WHERE ROWNUM <= 12 )
	 
	 
WHERE (PAGING_RN >= 1 )

------------====================[00000000000098777777777777657657657657657657657659

SELECT ds_conjuntos,
				PAGING_RN 

FROM (SELECT PAGING.*, ROWNUM PAGING_RN 
	   FROM (SELECT CME_OBTER_NOME_CONJUNTO(c.nr_seq_conjunto) ds_conjuntos FROM CM_CONJUNTO_CONT c
		     WHERE c.NR_SEQ_CICLO_LAV = 59) PAGING 
			  
	  WHERE ROWNUM <= 12 )
	 
	 
WHERE (PAGING_RN >= 1 )
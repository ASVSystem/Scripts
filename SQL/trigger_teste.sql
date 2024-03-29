
--DROP TRIGGER TASY.HMDCC_TESTE;

CREATE OR REPLACE TRIGGER  --NOME DA TRIGGER
BEFORE INSERT ON CIRURGIA_PARTICIPANTE


FOR EACH ROW

DECLARE
qt_ie_funcao_w NUMBER(2);
ie_funcao_w VARCHAR(2);

Cursor C01 is
	select	count(ie_funcao) qt_ie_funcao, ie_funcao
	from	cirurgia_participante
	where	nr_cirurgia = :new.NR_CIRURGIA --37200
	AND ie_funcao IN ('1','2','3','4','5')
	GROUP BY ie_funcao;

BEGIN

open C01;
		loop
		fetch C01 into	
			qt_ie_funcao_w,
			ie_funcao_w;

		exit when C01%notfound;
		begin
			
			IF (qt_ie_funcao_w > 0 AND :NEW.IE_FUNCAO = ie_funcao_w) 
				THEN
					Wheb_mensagem_pck.exibir_mensagem_abort('Quantidade de parcitipante atingiu o limite para o tipo selecionado!');
			END IF;
		END;
			
		end loop;            
 
END;
/

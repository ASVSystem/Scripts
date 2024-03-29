Declare
dado_saps1_w varchar2(5);
--dado_saps2_w varchar2(5);


      Cursor C001 Is
      Select ie_cardiologica, ie_hepatico, ie_abdomem, ie_neurologica, ie_urgencia, ie_tipo_operacao, ie_infec_nosocomial, ie_infec_resp
      From ESCALA_SAPS3;
      dado_saps3 C001%Rowtype;
Begin
      Open C001;
      Loop
            Fetch C001
            Into dado_saps3;
            Exit When
                      C001%NotFound;
            if 'H' = 'C' and 'D' = 'D' then
				select DECODE(dado_saps3.ie_cardiologica,-5,'ARR',3,'CHO',500,'SEP',5 ,'ANA',0,'COUT')
				into dado_saps1_w
				from dual;
				else if 'D' = 'V' then
				dado_saps1_w := 'S';
				end if;
			end if;
			
			if 'H' = 'H' and 'D' = 'D' then
				select DECODE(dado_saps3.ie_hepatico,6,'IHP',3,'AAG',9,'PSEV',0,'HOUT')
				into dado_saps1_w
				from dual;
				else if 'D' = 'V' then
				dado_saps1_w := 'S';
				end if;
			end if;

                      
         Dbms_Output.Put_Line(dado_saps1_w);
        
      End Loop;
      Close C001;
      
End;
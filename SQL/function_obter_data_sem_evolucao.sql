declare
  cursor cCursorTal is
    select dt_evolucao 
      from  EVOLUCAO_PACIENTE
      WHERE NR_ATENDIMENTO = nr_atendimento_p;
begin
    for  dt_ev in  cCursorTal LOOP
      
      IF dt_ev.dt_evolucao IS NULL
      
      
    end loop;
     
exception
  when others then
    Dbms_Output.Put_Line('Erro: '||sqlerrm);    
end;


SELECT * FROM EVOLUCAO_PACIENTE_LIB_V
WHERE 
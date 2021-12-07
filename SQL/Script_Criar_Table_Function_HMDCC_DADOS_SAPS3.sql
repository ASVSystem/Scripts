 /*
 Se precisar alterar os campos da tabela é necessário excluir os tipos
  DROP type  HMDCC_DADOS_TEMPLATE_TABLE
  DROP type   HMDCC_OBTER_DADOS_TEMPLATE_COL
*/
CREATE OR REPLACE TYPE HMDCC_OBTER_DADOS_SAPS3
IS OBJECT	(
  				cd_saps3   varchar2(10),
  				vl_saps3 varchar2(10)
);



CREATE OR REPLACE TYPE HMDCC_DADOS_SAPS3_TABLE  AS TABLE OF HMDCC_OBTER_DADOS_SAPS3




PROMPT CREATE OR REPLACE FUNCTION hmdcc_obter_dados_saps3
CREATE OR REPLACE function hmdcc_obter_dados_saps3(
 nr_atendimento number


)
return  HMDCC_DADOS_SAPS3_TABLE as
  v_ret   HMDCC_DADOS_SAPS3_TABLE ;




BEGIN



SELECT
CAST(
MULTISET(
        SELECT
        hmdcc_obter_dados_saps3 (nr_atendimento_p,'C') as cd_saps3,
        hmdcc_obter_dados_saps3 (nr_atendimento_p,'V') as vl_saps3
        
        FROM dual


 )as  HMDCC_DADOS_TEMPLATE_TABLE )
into
v_ret
 from
 dual;



  return v_ret;

end  HMDCC_DADOS_TEMPLATE;
/
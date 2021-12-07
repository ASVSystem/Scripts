CREATE OR REPLACE PROCEDURE hmdcc_up_elemento_template (

  ds_resultado_elemento_p   INTEGER,
  


AS

BEGIN

  IF (EXISTS(SELECT nr_seq_temp_conteudo FROM EHR_REG_ELEMENTO WHERE (nr_seq_temp_conteudo = 291052 AND ds_resultado =:ds_resultado_elemento_p))) THEN

    UPDATE EHR_TEMPLATE_CONTEUDO

    SET ie_opcional = 'N'

        
    WHERE (nr_seq_template = 100750 AND nr_seq_template_cluster = 100751);

  

END
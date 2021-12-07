 /*
 Se precisar alterar os campos da tabela é necessário excluir os tipos
  DROP type  HMDCC_DADOS_TEMPLATE_TABLE
  DROP type   HMDCC_OBTER_DADOS_TEMPLATE_COL
*/
CREATE OR REPLACE TYPE HMDCC_OBTER_DADOS_TEMPLATE_COL
IS OBJECT (
          ds_estabelecimento VARCHAR2(50),
          cnes VARCHAR2(50),
          municipio VARCHAR2(50),
          ug VARCHAR2(50),
          reg_hosp_pac VARCHAR2(50),
          nm_paciente VARCHAR2(50),
          dt_nasc VARCHAR2(50),
          rg_tipo VARCHAR2(50),
          rg_num VARCHAR2(50),
          sexo VARCHAR2(50),
          nm_mae VARCHAR2(50),
          tc_p VARCHAR2(50),
          rm_p VARCHAR2(50),
          ple_p VARCHAR2(50),
          act_p VARCHAR2(50),
          toh_p VARCHAR2(50),
          add_p VARCHAR2(50),
          tcp_p VARCHAR2(50),
          dthr_p VARCHAR2(50),
          pa_p VARCHAR2(50),
          temp_p VARCHAR2(50),
          pfad_p_s VARCHAR2(50),
          arcpd_p_nt VARCHAR2(50),
          arocd_p_n VARCHAR2(50),
          arvcd_p_n VARCHAR2(50),
          art_p_n VARCHAR2(50),
          pa_s VARCHAR2(50),
          temp_s VARCHAR2(50),
          pfad_s_s VARCHAR2(50),
          arcpd_s_n VARCHAR2(50),
          arocd_s_s VARCHAR2(50),
          arvcd_s_n VARCHAR2(50),
          art_s_s VARCHAR2(50),
          pa_t VARCHAR2(50),
          temp_t VARCHAR2(50),
          paco_p_i VARCHAR2(50),
          paco_p_f VARCHAR2(50),
          pao_p_i VARCHAR2(50),
          pao_p_f VARCHAR2(50),
          amrp_s VARCHAR2(50),
          pa_q VARCHAR2(50),
          temp_q VARCHAR2(50),
          ang_s VARCHAR2(50),
          cint_p VARCHAR2(50),
          dotr_s VARCHAR2(50),
          apsam_s VARCHAR2(50),
          tcfec_p VARCHAR2(50)

);



CREATE OR REPLACE TYPE HMDCC_DADOS_TEMPLATE_TABLE  AS TABLE OF HMDCC_OBTER_DADOS_TEMPLATE_COL




PROMPT CREATE OR REPLACE FUNCTION HMDCC_DADOS_TEMPLATE
CREATE OR REPLACE function HMDCC_DADOS_TEMPLATE(
 nr_seq_reg_template_p number


)
return  HMDCC_DADOS_TEMPLATE_TABLE as
  v_ret   HMDCC_DADOS_TEMPLATE_TABLE ;




BEGIN



SELECT
CAST(
MULTISET(
        SELECT
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'ds_estabelecimento') as ds_estabelecimento,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'cnes') as cnes,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'municipio') as municipio,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'ug') as ug,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'reg_hosp_pac') as reg_hosp_pac,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'nm_paciente') as nm_paciente,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'dt_nasc') as dt_nasc,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'rg_tipo') as rg_tipo,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'rg_num') as rg_num,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'sexo') as sexo,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'nm_mae') as nm_mae,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'tc_p') as tc_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'rm_p') as rm_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'ple_p') as ple_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'act_p') as act_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'toh_p') as toh_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'add_p') as add_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'tcp_p') as tcp_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'dthr_p') as dthr_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pa_p') as pa_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'temp_p') as temp_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pfad_p_s') as pfad_p_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'arcpd_p_nt') as arcpd_p_nt,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'arocd_p_n') as arocd_p_n,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'arvcd_p_n') as arvcd_p_n,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'art_p_n') as art_p_n,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pa_s') as pa_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'temp_s') as temp_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pfad_s_s') as pfad_s_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'arcpd_s_n') as arcpd_s_n,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'arocd_s_s') as arocd_s_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'arvcd_s_n') as arvcd_s_n,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'art_s_s') as art_s_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pa_t') as pa_t,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'temp_t') as temp_t,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'paco_p_i') as paco_p_i,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'paco_p_f') as paco_p_f,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pao_p_i') as pao_p_i,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pao_p_f') as pao_p_f,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'amrp_s') as amrp_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'pa_q') as pa_q,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'temp_q') as temp_q,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'ang_s') as ang_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'cint_p') as cint_p,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'dotr_s') as dotr_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'apsam_s') as apsam_s,
        HMDCC_OBTER_DADOS_TEMPLATE (nr_seq_reg_template_p,'tcfec_p') as tcfec_p

        FROM dual


 )as  HMDCC_DADOS_TEMPLATE_TABLE )
into
v_ret
 from
 dual;



  return v_ret;

end  HMDCC_DADOS_TEMPLATE;
/
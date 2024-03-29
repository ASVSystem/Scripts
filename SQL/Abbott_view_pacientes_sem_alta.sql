CREATE OR REPLACE FORCE VIEW abbott_atendimento_sem_alta (nr_atendimento,
                                                            ie_tipo_atendimento,                                                            
                                                            dt_entrada,
                                                            cd_pessoa_fisica,
                                                            nm_pessoa_fisica,
                                                            dt_nascimento,
                                                            ie_sexo,
                                                            entrada_setor
                                                           )
AS   SELECT   
            to_char(atepa.nr_atendimento) nr_atendimento,  
            atepa.ie_tipo_atendimento ie_tipo_atendimento,
            atepa.dt_entrada dt_entrada,
            atepa.cd_pessoa_fisica cd_pessoa_fisica,
            obter_nome_pf (atepa.cd_pessoa_fisica) nm_pessoa_fisica,
            obter_data_nascto_pf (atepa.cd_pessoa_fisica) dt_nascimento,
            obter_sexo_pf (atepa.cd_pessoa_fisica, 'C') ie_sexo,
            MIN (dt_entrada_unidade) entrada_setor
         
       FROM tasy.atendimento_paciente atepa,
            tasy.atend_paciente_unidade ateun
      WHERE ateun.dt_saida_unidade IS NULL
        AND ateun.nr_atendimento = atepa.nr_atendimento
        AND atepa.DT_ENTRADA > to_date('01/12/2019 00:00:01', 'dd/mm/yyyy hh24:mi:ss')
        AND ateun.CD_SETOR_ATENDIMENTO NOT IN(59)
        AND atepa.DT_CANCELAMENTO IS NULL
        
   GROUP BY atepa.ie_tipo_atendimento,
            atepa.nr_atendimento,
            atepa.dt_entrada,
            atepa.cd_pessoa_fisica,
            obter_data_nascto_pf (atepa.cd_pessoa_fisica)
            order by 1
            
SELECT * FROM abbott_atendimento_sem_alta
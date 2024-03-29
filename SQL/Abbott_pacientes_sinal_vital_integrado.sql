
SELECT obter_ds_setor_atendimento(CD_SETOR_ATENDIMENTO),  QT_GLICEMIA_CAPILAR,
DT_SINAL_VITAL,
obter_nome_pf(cd_pessoa_fisica) nm_aprovador,
obter_hash_assinatura(nr_seq_assinatura) ds_assinatura


from ATENDIMENTO_SINAL_VITAL
where 
--nr_atendimento = :NR_ATENDIMENTO
 trunc(DT_SINAL_VITAL) between '25/06/2020' AND fim_dia('25/06/2020')
and QT_GLICEMIA_CAPILAR is not null
AND ds_serial_abbott IS NOT null
ORDER BY obter_ds_setor_atendimento(CD_SETOR_ATENDIMENTO), dt_sinal_vital
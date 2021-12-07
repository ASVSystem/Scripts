

SELECT  dt_atendimento, nr_atendimento, cd_material, nr_seq_tipo_baixa,substr(obter_desc_motivo_baixa(nr_seq_tipo_baixa),1,100) ds_mot_baixa, cd_local_estoque, obter_desc_funcao(cd_funcao), mp.*   FROM MATERIAL_ATEND_PACIENTE mp
WHERE dt_atendimento between '01/01/2021' and '31/01/2021'
AND nr_seq_cor_exec = 96
AND mp.cd_acao = 1
AND mp.cd_funcao = 24
--AND nr_atendimento = 282369

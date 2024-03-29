
SELECT obter_desc_material(cd_material) ds_material,
sum(qt_material) qt_dispensada,
nr_atendimento,
obter_desc_setor_atend(cd_setor_atendimento) setor_paciente,
obter_nome_paciente(nr_atendimento) nm_paciente,
dt_conta
--disp.*

FROM 
(SELECT obter_desc_material(a.cd_material),
a.DT_CONTA data_dispensacao,
obter_nome_paciente(nr_atendimento) nm_paciente,
obter_desc_setor_atend(cd_setor_atendimento) setor_paciente,
a.*
FROM material_atend_paciente a
WHERE 
obter_estrutura_material(a.cd_material,'S') = 86
--AND  CD_MATERIAL = 51192
--AND a.NR_ATENDIMENTO = 340999
AND to_char(a.DT_CONTA,'MM/YY')  = '11/21') disp

GROUP BY cd_material,
nr_atendimento,
cd_setor_atendimento,
dt_conta

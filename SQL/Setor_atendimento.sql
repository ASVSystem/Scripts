select cd_setor_atendimento cd,
ds_setor_atendimento ds,
cd_classif_setor
from setor_atendimento
where ie_situacao = 'A'
and cd_classif_setor in (1,3,4)
and CD_SETOR_ATENDIMENTO not in(38,50,59,152,155)
order by ds

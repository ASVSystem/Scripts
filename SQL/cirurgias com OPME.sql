
select p.NR_CIRURGIA, m.CD_MATERIAL,obter_desc_material(m.CD_MATERIAL) ds_material  from PRESCR_MEDICA p, PRESCR_MATERIAL m
where p.NR_CIRURGIA is not null
and p.CD_FUNCAO_ORIGEM = 900
and p.NR_PRESCRICAO = m.NR_PRESCRICAO
order by 


select * from FUNCAO
where DS_FUNCAO like '%Ciru%'


select	s.CD_PROCEDIMENTO,
		m.QT_UNITARIA,
		OBTER_DESC_PROCEDIMENTO(s.cd_procedimento,7) ds_material
	   
from	SUS_MATERIAL_OPM s
		join PRESCR_MATERIAL m
		on s.CD_MATERIAL = m.CD_MATERIAL
		join PRESCR_MEDICA p
		on m.NR_PRESCRICAO = p.NR_PRESCRICAO
where p.NR_CIRURGIA = 1424
select distinct
m.cd_material,
obter_desc_material(m.cd_material) MEDICAMENTO,
OBTER_PACIENTE_PRESCRICAO(m.NR_PRESCRICAO)	PACIENTE,
m.NR_PRESCRICAO PRESCRICAO,
NVL(m.nr_cirurgia,m.NR_SEQ_PEPO) nr_cirurgia,
DECODE(TO_CHAR(SUM(v.qt_prescrita)),0,'N','S') DISPENSADO,
DECODE(TO_CHAR(SUM(v.qt_checados)),0,'N','S') CHECADO,
to_char(decode(NVL(V.qt_devolvida,0),0,'N','S')) DEVOLVIDO

from MATERIAL_ATEND_PACIENTE m
join MEDIC_CONTROLADO c
	on m.CD_MATERIAL = c.CD_MATERIAL
 join PRESCR_MATERIAL_SIT_V v
	on m.CD_MATERIAL = v.CD_ITEM
   and c.CD_MATERIAL = v.CD_ITEM
   and m.NR_PRESCRICAO = v.NR_PRESCRICAO
   and m.NR_SEQUENCIA_PRESCRICAO = v.NR_SEQUENCIA_PRESCRICAO
   
where m.DT_PRESCRICAO between '13/09/2019' and fim_dia('13/11/2019')
and m.NR_CIRURGIA  is null
and m.nr_seq_pepo is null
and DECODE(v.QT_CHECADOS,0,'N','S') = 'N'
and to_char(decode(NVL(V.qt_devolvida,0),0,'N','S')) = 'S'
and m.CD_LOCAL_ESTOQUE = 12

group by m.cd_material,
m.NR_PRESCRICAO,
m.nr_cirurgia,
m.NR_SEQ_PEPO,
v.QT_prescrita,
V.QT_DEVOLVIDA

--order by medicamento, prescricao

---///////////////////////////////////////////////
UNION
----//////////////////////////////////////////////

select distinct
a.cd_material,
obter_desc_material(a.cd_material) MEDICAMENTO,
OBTER_PACIENTE_PRESCRICAO(a.NR_PRESCRICAO)	PACIENTE,
a.NR_PRESCRICAO	 PRESCRICAO,
a.nr_cirurgia nr_cirurgia,
DECODE(a.CD_ACAO,1,'S','D') DISPENSADO,
NVL2(ci.dt_liberacao,'S','N') CHECADO,
NVL((select e.IE_ESTORNO_CONTA from MATERIAL_ATEND_PACIENTE e where e.NR_PRESCRICAO = a.nr_prescricao and  e.CD_MATERIAL = a.cd_material and e.CD_ACAO = 2 ),'N') DEVOLVIDO


from MEDIC_CONTROLADO c
	join MATERIAL_ATEND_PACIENTE a
		on c.CD_MATERIAL =a.CD_MATERIAL
	join CIRURGIA_AGENTE_ANESTESICO ci
		on a.CD_MATERIAL = ci.CD_MATERIAL
		and a.NR_CIRURGIA = ci.NR_CIRURGIA
 
		
where a.DT_PRESCRICAO between '01/09/2019' and fim_dia('13/11/2019')
and ci.IE_SITUACAO = 'A'	
and a.CD_LOCAL_ESTOQUE = 13
and NVL2(ci.dt_liberacao,'S','N') = 'N'   ---checado?
and NVL((select e.IE_ESTORNO_CONTA from MATERIAL_ATEND_PACIENTE e where e.NR_PRESCRICAO = a.nr_prescricao and  e.CD_MATERIAL = a.cd_material and e.CD_ACAO = 2 ),'N') = 'S'

---///////////////////////////////////////////////
UNION
----//////////////////////////////////////////////


select distinct
a.cd_material,
obter_desc_material(a.cd_material) MEDICAMENTO,
OBTER_PACIENTE_PRESCRICAO(a.NR_PRESCRICAO)	PACIENTE,
a.NR_PRESCRICAO	 PRESCRICAO,
a.nr_seq_pepo nr_cirurgia,
DECODE(a.CD_ACAO,1,'S','D') DISPENSADO,
NVL2(ci.dt_liberacao,'S','N') CHECADO,
NVL((select e.IE_ESTORNO_CONTA from MATERIAL_ATEND_PACIENTE e where e.NR_PRESCRICAO = a.nr_prescricao and  e.CD_MATERIAL = a.cd_material and e.CD_ACAO = 2 ),'N') DEVOLVIDO


from MEDIC_CONTROLADO c
	join MATERIAL_ATEND_PACIENTE a
		on c.CD_MATERIAL =a.CD_MATERIAL
	join CIRURGIA_AGENTE_ANESTESICO ci
		on a.CD_MATERIAL = ci.CD_MATERIAL
		and a.NR_SEQ_PEPO = ci.NR_SEQ_PEPO
 
		
where a.DT_PRESCRICAO between '14/11/2019' and fim_dia('14/11/2019')
and ci.IE_SITUACAO = 'A'
and a.CD_LOCAL_ESTOQUE = 13
and NVL2(ci.dt_liberacao,'S','N') = 'S'  ---checado?
and NVL((select e.IE_ESTORNO_CONTA from MATERIAL_ATEND_PACIENTE e where e.NR_PRESCRICAO = a.nr_prescricao and  e.CD_MATERIAL = a.cd_material and e.CD_ACAO = 2 ),'N') = 'S'

order by medicamento, prescricao



--
--select * from PRESCR_MATERIAL_SIT_V
--where NR_PRESCRICAO = 1677071
--and CD_ITEM = 1301
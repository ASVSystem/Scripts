
select
p.cd_material,
OBTER_DESC_MATERIAL(m.CD_MATERIAL) ds_material,
OBTER_SETOR_PRESCRICAO(p.NR_PRESCRICAO,'D') setor_prescr,
COUNT(p.CD_MATERIAL) qt
from PRESCR_MATERIAL p
	join	MATERIAL m
	on p.CD_MATERIAL = m.CD_MATERIAL
where m.CD_CLASSE_MATERIAL in  (75,76,402,378,403,393,390,392,395,382,379,380,381,383,405,389,394,386,404,385,398,396,397,
384,
388,
391,
634,
387) --(73,74,75,76,215,362)
and p.CD_INTERVALO in ('Agora', 'SN')
and TO_DATE(p.DT_atualizacao) between TO_DATE('01/09/2019 00:00:00', 'dd/MM/yyyy hh24:mi:ss') 
					AND	TO_DATE('30/09/2019 23:59:59' , 'dd/MM/yyyy hh24:mi:ss')
					
group by OBTER_DESC_MATERIAL(m.CD_MATERIAL), OBTER_SETOR_PRESCRICAO(p.NR_PRESCRICAO,'D'), p.cd_material
 order by  QT desc





select p.DT_PRESCRICAO, p.DT_VALIDADE_PRESCR, m.* from PRESCR_MATERIAL m, PRESCR_MEDICA p
where 
--p.nr_prescricao_anterior is null
 m.CD_INTERVALO = '8/16h'
and m.NR_PRESCRICAO = p.NR_PRESCRICAO
and p.DT_PRESCRICAO BETWEEN To_date('19/11/2019 00:00:00','dd/mm/yyyy hh24:mi:ss'  ) 
                                         AND 
             						 To_date('20/11/2019 23:59:59','dd/mm/yyyy hh24:mi:ss') 
             						 
--and p.NR_PRESCRICAO = 1841417
and p.DT_SUSPENSAO is null

--1839525

--1841417

and m.HR_PRIM_HORARIO = '20:00'

and p.nr_prescricao_anterior is null





--select * from PRESCR_MATERIAL
--where NR_PRESCRICAO = 1774559
--
--
--select CD_CLASSE_MATERIAL cd,
--ds_classe_material ds 
--from CLASSE_MATERIAL
--where IE_SITUACAO = 'A'
--and CD_SUBGRUPO_MATERIAL = 119
--order by DS_CLASSE_MATERIAL
----
--select cd_intervalo cd,
--ds_intervalo ds  
--from INTERVALO_PRESCRICAO
--where IE_SITUACAO = 'A'



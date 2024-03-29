
select distinct	a.nr_seq_pepo cirurgia_processo,
      OBTER_NOME_PF(p.CD_PESSOA_FISICA) paciente,
	   a.cd_material,
		OBTER_DESC_REDU_MATERIAL(a.cd_material) medicamento,
		OBTER_NOME_PF(a.cd_profissional) nome_medico,
		a.dt_atualizacao data,
	 	a.NR_SEQ_ASSINATURA
	   

from CIRURGIA_AGENTE_ANESTESICO a
join MEDIC_CONTROLADO m
on a.CD_MATERIAL = m.CD_MATERIAL
join PEPO_CIRURGIA p
on a.NR_SEQ_PEPO = p.NR_SEQUENCIA

where  a.DT_LIBERACAO between TRUNC(SYSDATE-1) and sysdate
and a.NR_SEQ_ASSINATURA is null


union

select distinct	a.NR_CIRURGIA cirurgia_processo,
   OBTER_NOME_PF(c.CD_PESSOA_FISICA) paciente,
 	   a.cd_material,
		OBTER_DESC_REDU_MATERIAL(a.cd_material) medicamento,
		OBTER_NOME_PF(a.cd_profissional) nome_medico,
		a.dt_atualizacao data,
	 	a.NR_SEQ_ASSINATURA
	   

from CIRURGIA_AGENTE_ANESTESICO a
join MEDIC_CONTROLADO m
on a.CD_MATERIAL = m.CD_MATERIAL
join CIRURGIA c
on a.NR_CIRURGIA = c.NR_CIRURGIA
where  a.DT_LIBERACAO between TRUNC(SYSDATE-1) and sysdate
and a.NR_SEQ_ASSINATURA is null




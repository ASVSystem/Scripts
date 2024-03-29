--CREATE OR REPLACE VIEW HMDCC_PRESCR_MATERIAL_SIT_V
--AS
select	/*+ ORDEDED */
	p.nr_atendimento,
	p.nr_prescricao,
	a.cd_setor_atendimento,
	a.nr_sequencia_prescricao,
	p.dt_prescricao		dt_item,
	a.dt_conta,
	a.dt_entrada_unidade,
	a.cd_convenio,
	a.cd_categoria,
	a.qt_executada qt_executada,
	a.qt_devolvida qt_devolvida,
	a.qt_material qt_saldo,
	a.vl_material vl_item,
	i.nm_usuario,
	i.cd_material cd_item,
	i.qt_material qt_prescrita,
	i.cd_motivo_baixa,
	i.dt_baixa,
	m.ds_material ds_item,
	m.ie_tipo_material tp_item	 /* 1-MATERIAL 2-MED.GENERICO 3-MED.COMERC. */,
	decode(m.ie_tipo_material,1,'MATERIAL','MEDICAMENTOS') ds_tp_item,
	p.nm_usuario_original,
	substr(nvl(obter_nome_pf(p.cd_prescritor),'Não informado'),1,60) nm_prescritor,
	substr(nvl(obter_nome_setor(p.cd_setor_atendimento),'Não informado'),1,100) ds_setor_paciente,
	a.cd_local_estoque,
	(	select	count(b.dt_fim_horario)
		from	prescr_mat_hor b
		where	b.dt_fim_horario	is not null
		and	i.nr_prescricao		= b.nr_prescricao
		and	i.nr_sequencia		= b.nr_seq_material
		and	m.cd_material		= b.cd_material
	) qt_checados,
	(	select	count(b.dt_suspensao)
		from	prescr_mat_hor b
		where	b.dt_suspensao	is not null
		and	i.nr_prescricao		= b.nr_prescricao
		and	i.nr_sequencia		= b.nr_seq_material
		and	m.cd_material		= b.cd_material
	) qt_suspensos
from	prescr_medica p,
	prescr_material i,
	material_atend_paciente a,
	material m
where	p.nr_prescricao	= i.nr_prescricao
and	i.cd_material	= m.cd_material
and	i.nr_prescricao	= a.nr_prescricao(+)
and	i.nr_sequencia	= a.nr_sequencia_prescricao(+)
 


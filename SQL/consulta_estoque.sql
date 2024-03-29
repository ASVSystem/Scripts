SELECT 
	 l.ds_local_estoque ds_local_estoque,
	  m.cd_material cd_material,
	  m.ds_material ds_material,

	  sum(obter_saldo_disp_estoque(s.cd_estabelecimento, s.cd_material, s.cd_local_estoque, s.dt_mesano_referencia)) qt_estoque_disp,

	  sum(s.qt_estoque) qt_estoque
   
FROM	local_estoque l,
	  unidade_medida u,
	  estrutura_material_v t,
	  material m,
	 saldo_estoque s
WHERE m.cd_material   = s.cd_material 
	AND	m.cd_material   = t.cd_material 
	AND	u.cd_unidade_medida  = m.cd_unidade_medida_estoque 
	AND	s.cd_local_estoque = l.cd_local_estoque 
	AND	s.dt_mesano_referencia = to_date('01/11/2018', 'dd/mm/yyyy') 
	AND	s.cd_estabelecimento = 1 
	AND	l.ie_tipo_local <> 13 
	AND	l.cd_local_estoque = '52'
GROUP BY l.cd_estabelecimento,
	 l.cd_local_estoque,
	 l.ds_local_estoque,
	 m.cd_material,
	 m.ds_material,
	 m.cd_sistema_ant,
	 obter_mat_estabelecimento(l.cd_estabelecimento, l.cd_estabelecimento, m.cd_material,'CM'),
	 obter_mat_estabelecimento(l.cd_estabelecimento, l.cd_estabelecimento, m.cd_material,'PP'),
	  substr(obter_desc_loc_material(s.cd_material, s.cd_local_estoque, 'DS'),1,80),
	  substr(obter_desc_loc_material(s.cd_material, s.cd_local_estoque, 'ES'),1,80),
	 substr(obter_dados_material_estab(m.cd_material, l.cd_estabelecimento,'UME'),1,30) having sum(s.qt_estoque) <> 0
ORDER BY ds_local_estoque,
	 m.ds_material 
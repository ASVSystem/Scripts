SELECT        
			nr_contrato,
			obter_dados_contrato(nr_contrato,'CD') cd_contrato,
			cd_material,
			Obter_desc_material(cd_material) ds_material,
			(qt_material_fixa-(Sum(qt_material))) saldo
		FROM
			(SELECT distinct  
				o.nr_ordem_compra,
				nr_contrato,
				c.cd_material cd_material,
			   Nvl(c.qt_material_fixa,0) qt_material_fixa,
			       --i.qt_material
			   ghas_obter_qt_mat_oc(o.nr_ordem_compra,c.cd_material,i.nr_contrato,i.NR_ITEM_OCI) qt_material
			
				FROM ordem_compra_item i
				JOIN   contrato_regra_nf c
				ON i.nr_contrato= c.nr_seq_contrato
				AND i.cd_material=c.cd_material
				JOIN ordem_compra o
				ON  i.nr_ordem_compra=o.nr_ordem_compra
				WHERE  o.dt_liberacao IS NOT NULL
				AND  nr_contrato = 2542
				AND  c.cd_material= 62976
				and o.ie_tipo_ordem <>'W'
				ORDER BY o.nr_ordem_compra, c.cd_material
			)
			GROUP BY  cd_material, qt_material_fixa,nr_contrato
			ORDER BY cd_material
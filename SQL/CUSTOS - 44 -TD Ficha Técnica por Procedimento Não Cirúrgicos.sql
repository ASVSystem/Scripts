select  	nr_atendimento,
			cd_procedimento,
			nr_prescricao_prc,
			nr_prescricao_mat,
			DS_PROCEDIMENTO,
			sigtap,
			VL_SIGTAP,
			setor_undade_atend,
         paciente,
         cd_material,
         ds_material,
        grupo,
         CD_UNIDADE_MEDIDA,
         consumo,
         vl_preco_ult_compra,
         vl_medio,               
         total, 
         obter_procedencia_atend(nr_atendimento,'') procedencia_atend
            
from (
		select   
		a.nr_atendimento nr_atendimento,
		c.nr_prescricao nr_prescricao_prc,
		a.nr_prescricao nr_prescricao_mat,
		c.cd_procedimento cd_procedimento,
		c.CD_TIPO_ANESTESIA cd_tipo_anestesia,  
		substr(obter_exame_agenda(c.cd_procedimento, c.ie_origem_proced, c.nr_seq_proc_interno),1,240)  DS_PROCEDIMENTO
		,d.cd_procedimento sigtap
		,GHAS_OBTER_VALOR_SIGTAP(d.CD_PROCEDIMENTO) VL_SIGTAP
		,substr(Obter_ds_setor_atendimento(a.cd_setor_atendimento) ||' - '||obter_unid_atend_setor(a.nr_atendimento, A.cd_setor_atendimento,'U'),1,50) setor_undade_atend,
		Obter_dados_atendimento(a.nr_atendimento,'NP') paciente
		 ,a.cd_material cd_material
		,Obter_desc_material(a.cd_material) ds_material
		,obter_dados_material(a.cd_material,'GRU') grupo
		,a.CD_UNIDADE_MEDIDA cd_unidade_medida
		 ,sum (a.qt_material) consumo
		, (SELECT Nvl(Max(s.vl_preco_ult_compra), 0)FROM  saldo_estoque s WHERE  1 = 1 AND s.cd_material = a.cd_material AND s.dt_mesano_referencia = (SELECT Trunc(SYSDATE, 'MM') FROM dual)) vl_preco_ult_compra
		 ,(SELECT nvl(Max(Nvl(s.vl_custo_medio, 0)),0) FROM  saldo_estoque s WHERE  1 = 1 AND s.cd_material = a.cd_material AND s.dt_mesano_referencia = (SELECT Trunc(SYSDATE, 'MM') FROM   dual)) vl_medio
		,(sum(a.qt_material) * (SELECT nvl(Max(Nvl(s.vl_custo_medio, 0)),0) FROM  saldo_estoque s WHERE  1 = 1 AND s.cd_material = a.cd_material AND s.dt_mesano_referencia = (SELECT Trunc(SYSDATE, 'MM') FROM   dual))) total
		 
		 from material_atend_paciente a ,
		 prescr_procedimento c,
		 SUS_MATERIAL_OPM d
		 where  a.nr_prescricao = c.nr_prescricao
		
		 and a.cd_material = d.cd_material(+)
		 AND a.NR_CIRURGIA IS null
		-- @sql_where
		
		and a.nr_atendimento in (select p.nr_atendimento from atendimento_paciente p
		     								where   trunc(p.DT_ENTRADA) between '01/08/2021' and '01/08/2021' 
		     --((p.nr_atendimento = :nr_atendimento_p) or (:nr_atendimento_p  = 0 ))      
		  								)
		  
		and  'A' = 'A'
				 
		group BY
		a.nr_atendimento,
		a.nr_prescricao,
		c.nr_prescricao,
		a.cd_setor_atendimento, 		
		a.cd_material,				
		c.cd_procedimento,
		c.ie_origem_proced,
		c.nr_seq_proc_interno,
	  	d.CD_PROCEDIMENTO,
		c.CD_TIPO_ANESTESIA,
		a.CD_UNIDADE_MEDIDA

		) 

where consumo > 0
--AND cd_procedimento  = 209010037
AND cd_procedimento  = 202010317

order by  nr_atendimento

--PROC 311181
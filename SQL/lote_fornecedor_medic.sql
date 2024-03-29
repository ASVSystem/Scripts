SELECT '00000'||NR_SEQUENCIA||NR_DIGITO_VERIF, obter_desc_material(cd_material) FROM MATERIAL_LOTE_FORNEC
WHERE CD_MATERIAL = 40994
AND DT_VALIDADE > sysdate
AND IE_SITUACAO = 'A'

--1603
--170
--313
--68
252508



SELECT 
 a.cd_material,
decode('N','N', b.ds_material, substr(obter_desc_material(obter_material_generico(a.cd_material)),1,100)) ds_material,
 a.nr_atendimento,
 a.cd_material_exec,
 a.dt_entrada_unidade,
 a.dt_atendimento,
 a.qt_material,
 a.qt_devolvida,
 a.qt_executada,
 a.nm_usuario,
 a.nm_usuario_original,
 a.nr_interno_conta,

 a.cd_unidade_medida,

 a.cd_local_estoque cd_local_estoque,
 SUBSTR(obter_desc_local_estoque(a.cd_local_estoque),1,60) ds_local_estoque,
 a.nr_sequencia,
 SUBSTR(DECODE(a.qt_devolvida, null, Obter_Tipo_Baixa_Mat(a.nr_sequencia), Obter_Tipo_Devol_Mat_Prescr(p.nr_prescricao, p.nr_sequencia, a.nr_devolucao, a.nr_seq_item_devol)),1,200) ds_tipo_baixa,
 p.cd_material_baixa, p.qt_total_dispensar qt_prescrito,
 p.nr_prescricao, a.nr_doc_interno,
 p.nr_sequencia nr_seq_prescr_mat,
 a.nr_seq_cor_exec,
 SUBSTR(obter_desc_intervalo_prescr(p.cd_intervalo),1,100) ds_intervalo,
 p.qt_unitaria qt_unitaria_mat,
 substr(obter_desc_material(a.cd_material_exec),1,200) ds_material_exec,
 a.cd_material_prescricao,
 substr(obter_desc_material(a.cd_material_prescricao),1,200) ds_material_prescricao,
 p.nr_ocorrencia,
 a.nr_seq_lote_fornec,
 substr(obter_dados_lote_fornec(a.nr_seq_lote_fornec,'D'),1,50) ds_lote,
 substr(obter_dados_lote_fornec(a.nr_seq_lote_fornec,'V'),1,100) dt_validade,
 nr_sequencia_prescricao
FROM	material b,
	
 prescr_material p,
 material_atend_paciente a,
 ap_lote d
WHERE a.cd_material   = b.cd_material
and a.nr_prescricao  = 2958521
and a.nr_prescricao  = p.nr_prescricao (+)
and a.nr_sequencia_prescricao = p.nr_sequencia (+)
and nvl(a.nr_seq_lote_ap,0) = 6987075
and d.nr_sequencia   = a.nr_seq_lote_ap
and d.dt_atend_farmacia is not null
ORDER BY nr_sequencia_prescricao
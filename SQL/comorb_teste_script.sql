select * from ehr_reg_elemento
where NR_SEQ_TEMP_CONTEUDO =290215

-- 290201
--290197
290275



select * from EHR_REGISTRO
where NR_SEQ_TEMPL = 100704
and DT_INATIVACAO is null


select * from  EHR_TEMPLATE_CONTEUDO
where NR_SEQ_TEMPLATE = 100706


select * from EHR_REG_TEMPLATE
where NR_SEQ_TEMPLATE = 100704
and DT_INATIVACAO is null



select t.DS_LABEL_GRID, e.DS_RESULTADO

from  ehr_reg_elemento e
join EHR_TEMPLATE_CONTEUDO t
on e.NR_SEQ_TEMP_CONTEUDO = t.NR_SEQUENCIA
join EHR_REG_TEMPLATE r
on e.NR_SEQ_REG_TEMPLATE = r.NR_SEQUENCIA
JOIN EHR_REGISTRO v
on r.NR_SEQ_REG = v.NR_SEQUENCIA

where r.NR_SEQ_TEMPLATE = 100704
and e.nr_registro_cluster is not null
and r.DT_INATIVACAO is null
and NVL(v.ie_situacao,'A') <> 'I'
and e.DS_RESULTADO = 'S'
and	 e.NR_SEQ_TEMP_CONTEUDO not in(290196,290197,290198,290199,290200,290201,290202)
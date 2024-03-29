select  
	  a.ie_vacina_gripe,
 	  to_char(a.dt_ultima_dose_gripe,'dd/mm/yyyy') dt_ultima_dose_gripe,
 	  b.ie_febre,
 	  b.ie_tosse,
 	  b.ie_dor_garganta,
 	  b.ie_dispneia,
 	  b.ie_sint_resp,
 	  b.ie_saturacao_oxigenio,
 	  b.ie_outros,
 	  b.ie_cardiopatia_cronica,
 	  b.ie_imunodeprimido,
 	  b.ie_hepatopatia,
 	  b.ie_neuroparaliticas,
 	  b.ie_renal_cronico,
 	  b.ie_sind_down,
 	  b.ie_metabolica ie_mellitus,
 	  b.ie_puerpera,
 	  b.ie_obesidade,
 	  b.qt_imc,
 	  b.ie_outros_fatores,
 	  b.ds_outros_fatores,
 	  b.ie_pneumopatia
 	  
   

	  	   
from	  sinan_antecedente_epidem a,
		sinan_dados_clinico b,
	  notificacao_sinan c 
WHERE a.nr_seq_notificacao = c.nr_sequencia
AND   b.nr_seq_notificacao = c.NR_SEQUENCIA   
and	  c.nr_sequencia = 166
union
select	  null,null,null,null,NULL,null,null,null,null,NULL,null,null,null,null,NULL,null,null,null,null,NULL,null,null
from	  dual
where	  166 = '0'
union
select	  null,null,null,null,NULL,null,null,null,null,NULL,null,null,null,null,NULL,null,null,null,null,NULL,null,null
from	  notificacao_sinan   a
where	  not exists (select  1
	    	  from	  sinan_antecedente_epidem b
		  where	  b.nr_seq_notificacao = a.nr_sequencia)
and	a.nr_sequencia = 166
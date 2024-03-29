select	  a.ie_contato_ave ie_contato_ave,
	  a.ie_febre ie_febre,
	  a.ie_tosse ie_tosse,
	  a.ie_calafrio ie_calafrio,
	  a.ie_dispneia ie_dispneia,
	  a.ie_dor_garganta ie_dor_garganta,
	  a.ie_artralgia ie_artralgia,
	  a.ie_mialgia ie_mialgia,
	  a.ie_conjuntivite ie_conjuntivite,
	  a.ie_coriza ie_coriza,
	  a.ie_diarreia ie_diarreia,
	  decode(ds_outros_sintomas,null,'9','1') ie_outros_sintomas,
	  a.ds_outros_sintomas ds_outros_sintomas,
	  a.ie_cardiopatia_cronica ie_cardiopatia_cronica,
	  a.ie_pneumopatia ie_pneumopatia,
	  a.ie_renal_cronico ie_renal_cronico,
	  a.ie_hemoglobinopatia ie_hemoglobinopatia,
	  a.ie_imunodeprimido ie_imunodeprimido,
	  a.ie_tabagismo ie_tabagismo,
	  a.ie_doenca_metabolica ie_doenca_metabolica,
	  a.ds_outras_comorbidade ds_outras_comorbidade,
	  decode(ds_outras_comorbidade,null,'9','1') ie_outras_comorbidade
from  	  sinan_dados_clinico a,
	  notificacao_sinan c 
where	  a.nr_seq_notificacao = c.nr_sequencia
and	  c.nr_sequencia = :nr_seq_notificacao
union
select	  null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
from	  dual
where	  :nr_seq_notificacao = '0'
union
select	  null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
from	  notificacao_sinan   a
where	  not exists (select  1
	    	  from	  sinan_dados_clinico b
		  where	  b.nr_seq_notificacao = a.nr_sequencia)
and	a.nr_sequencia = :nr_seq_notificacao
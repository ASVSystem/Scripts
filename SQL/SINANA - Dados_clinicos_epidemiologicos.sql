select	  to_char(a.dt_investigacao,'dd/mm/yyyy') dt_investigacao,
	  substr(sinan_obter_desc_cargo_pf(a.nr_seq_notificacao),1,80) ds_ocupacao,
	  a.ie_vacina_gripe,
	  a.ie_vacina_antipneumococica,
	  to_char(a.dt_ultima_dose_gripe,'dd/mm/yyyy') dt_ultima_dose_gripe,
	  to_char(a.dt_ultima_dose_antipneu,'dd/mm/yyyy') dt_ultima_dose_antipneu,
	  nvl(a.ie_contato_suspeito,'10') ie_contato_suspeito,
	  substr(obter_valor_dominio(4113,a.ie_contato_suspeito),1,255) ds_contato_suspeito,
	  decode(a.ds_contato_transp,null,'11') ie_contato_transp,
	  a.ds_contato_transp ds_contato_transp,
	  a.ds_outras_atividades ds_outras_atividades,
	  a.ie_contato_aves ie_contato_aves,
	  a.ds_endereco_contato ds_endereco_contato,
	  substr(obter_nome_pais(a.nr_seq_pais),1,255) ds_pais,
	  to_char(to_date(substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'D',1),1,255),'dd/mm/yy'),'dd/mm/yyyy') dt_registro_um,
	  to_char(to_date(substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'D',2),1,255),'dd/mm/yy'),'dd/mm/yyyy') dt_registro_dois,
	  to_char(to_date(substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'D',3),1,255),'dd/mm/yy'),'dd/mm/yyyy') dt_registro_tres,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'UF',1),1,10) ds_estado_um,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'UF',2),1,10) ds_estado_dois,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'UF',3),1,10) ds_estado_tres,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'ML',1),1,255) ds_municipio_um,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'ML',2),1,255) ds_municipio_dois,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'ML',3),1,255) ds_municipio_tres,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'P',1),1,255) ds_pais_um,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'P',2),1,255) ds_pais_dois,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'P',3),1,255) ds_pais_tres,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'MT',1),1,255) ds_meio_transporte_um,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'MT',2),1,255) ds_meio_transporte_dois,
	  substr(sinan_obter_dados_antec_epidem(a.nr_seq_notificacao,'MT',3),1,255) ds_meio_transporte_tres  	  	  	   
from	  sinan_antecedente_epidem a,
sinan_dados_clinico b,
	  notificacao_sinan c 
where	  a.nr_seq_notificacao = c.nr_sequencia
and  b.nr_seq_notificacao = c.nr_sequencia
and	  c.nr_sequencia = 166
union
select	  null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
from	  dual
where	  166 = '0'
union
select	  null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
from	  notificacao_sinan   a
where	  not exists (select  1
	    	  from	  sinan_antecedente_epidem b
		  where	  b.nr_seq_notificacao = a.nr_sequencia)
and	a.nr_sequencia = 166

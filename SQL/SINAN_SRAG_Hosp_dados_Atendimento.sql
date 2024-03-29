SELECT
	  CASE WHEN b.ie_antibiotico = '1' THEN '2'
	       WHEN b.ie_antibiotico = '9' THEN '9'
	       WHEN b.ie_antibiotico IN (2,3,4) THEN '1'
      END ie_antibiotico,
      decode(b.ie_antibiotico,'2','1','3','2','4','3') cd_antiviral,
      b.dt_antibiotico, 
	  d.ie_ocorreu_hospi ie_hospitalizacao,
	  to_char(d.dt_internacao,'dd/mm/yyyy') dt_hospitalizacao,
	  d.sg_estado ie_estado,
	  obter_desc_municipio_ibge(d.cd_municipio_ibge) ds_municipio,
	  d.ds_nome_hospital ds_nome_hospital,
	  d.cd_municipio_ibge cd_municipio_ibge,
	  rpad(substr(obter_cnes_estab(1),1,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),2,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),3,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),4,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),5,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),6,1),2,'|')||
	rpad(substr(obter_cnes_estab(1),7,7),2,'|') cd_cnes,
	d.ie_uti,
	d.dt_entrada_uti,
	d.dt_saida_uti,
	decode(d.ie_sup_ventilatorio,'2','1','3','2','1','3','9','9') ie_sup_ventilatorio,
	d.ie_raiox_torax,
	d.dt_raiox,
	a.ie_tipo_amostra,
	a.dt_coleta,
	decode(a.ie_tipo_amostra,'2','1','4','2','3','3','5','4','9','9') ie_tipo_amostra,
	a.ds_outro
	
	  
from  	  	sinan_dados_laboratorio a,
            sinan_tratamento b,
			sinan_hospitalizacao d,
	  notificacao_sinan c 
where	 b.nr_seq_notificacao = c.nr_sequencia
and     d.nr_seq_notificacao = c.nr_sequencia
and     a.nr_seq_notificacao = c.nr_sequencia
and	  c.nr_sequencia = 166
union
select	  null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
from	  dual
where	  166 = '0'
union
select	  null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
from	  notificacao_sinan   a
where	  not exists (select  1
	    	  from	  sinan_notificacao_indiv b
		  where	  b.nr_seq_notificacao = a.nr_sequencia)
and	a.nr_sequencia = 166
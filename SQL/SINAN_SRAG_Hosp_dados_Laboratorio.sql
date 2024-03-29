SELECT a.ie_resultado_1 ie_ifi,
       a.dt_coleta_1    dt_coleta_ifi,
       a.ie_result_influenza_a,
		a.ie_resultado_2 ie_pcr,
		a.dt_coleta_rt_pcr  dt_resultado_pcr,
		a.ie_subtipo_influenza_a,
		a.ie_subtipo_influenza_a,
		a.ie_result_vsr
--	  decode(a.ie_exame,'6','Raio-X Tórax','3','PCR','5','Exibição da Hemaglutinação','4','Cultura') ds_exame,
--	  decode(a.ie_exame,'6',to_char(a.dt_coleta,'dd/mm/yyyy')) dt_realizacao_raio_x,
--	  decode(a.ie_exame,'3',to_char(a.dt_coleta,'dd/mm/yyyy')) dt_coleta_pcr,
--	  decode(a.ie_exame,'5',to_char(a.dt_coleta,'dd/mm/yyyy')) dt_inib_hem,
--	  decode(a.ie_exame,'4',to_char(a.dt_coleta,'dd/mm/yyyy')) dt_cultura,
--	  decode(a.ie_exame,'3',nvl(a.ie_tipo_amostra_exame,'6')) ie_tipo_amostra_exame_pcr,
--	  decode(a.ie_exame,'4',nvl(a.ie_tipo_amostra_exame,'6')) ie_tipo_amostra_exame_cultura,
--	  decode(a.ie_exame,'3',decode(a.ie_tipo_amostra_exame,null, a.ds_outros_amostra)) ds_outros_amostra_pcr,
--	  decode(a.ie_exame,'4',decode(a.ie_tipo_amostra_exame,null, a.ds_outros_amostra)) ds_outros_amostra_cultura,
--	  decode(a.ie_exame,'3',a.ie_resultado) ie_resultado_pcr,
--	  decode(a.ie_exame,'4',a.ie_resultado) ie_resultado_cultura,
--	  decode(a.ie_exame,'5',a.ie_resultado) ie_resultado_inib_hem,
--	  decode(a.ie_exame,'3',decode(a.ie_tipo_amostra,'1','X')) ie_tipo_pcr_h,
--	  decode(a.ie_exame,'3',decode(a.ie_tipo_amostra,'2','X')) ie_tipo_pcr_n,
--	  decode(a.ie_exame,'5',decode(a.ie_tipo_amostra,'1','X')) ie_tipo_inib_hem_h,
--	  decode(a.ie_exame,'5',decode(a.ie_tipo_amostra,'2','X')) ie_tipo_inib_hem_n,
--	  decode(a.ie_exame,'3',a.ie_classif_virus) ie_classif_virus_pcr,
--	  decode(a.ie_exame,'5',a.ie_classif_virus) ie_classif_virus_inib_hem,
--	  decode(a.ie_exame,'6',nvl(a.ie_resultado_rx,'5')) ie_resultado_rx,
--	  decode(a.ie_exame,'6',decode(a.ie_resultado_rx,null,a.ds_outros_rx)) ds_outros_rx 	  		 	  	  	  
from  	  sinan_dados_laboratorio a,
	  notificacao_sinan c 
where	  a.nr_seq_notificacao = c.nr_sequencia
and	  c.nr_sequencia = 166
union
select	  null,NULL,null,NULL,NULL,NULL, null
from	  dual
where	  166 = '0'
union
select	  null,NULL,null,NULL,NULL,NULL, null
from	  notificacao_sinan   a
where	  not exists (select  1
	    	  from	  sinan_dados_laboratorio b
		  where	  b.nr_seq_notificacao = a.nr_sequencia)
and	a.nr_sequencia = 166
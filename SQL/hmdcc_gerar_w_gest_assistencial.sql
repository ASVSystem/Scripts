CREATE OR REPLACE procedure Gerar_W_Gestao_Assistencial(	dt_inicial_p		date,
					dt_final_p		date,
					ie_somente_internados_p	varchar2,
					ie_tev_p		varchar2,
					ie_risco_tev_p		varchar2,
					ie_cirurgico_p		varchar2,
					cd_setor_atendimento_p	number,
					cd_doenca_p		varchar2,
					palavra_chave_p		varchar2,
					ie_anamnese_p		varchar2,
					ie_auditoria_p		varchar2,
					ie_consentimento_p	varchar2,
					ie_justificativas_p	varchar2,
					ie_atestado_p		varchar2,
					ie_boletim_p		varchar2,
					ie_evolucoes_p		varchar2,
					ie_receita_p		varchar2,
					ie_orientacao_g_p	varchar2,
					ie_parecer_p		varchar2,
					ie_orientacao_a_p	varchar2,
					cd_material_p		number,
					cd_procedimento_p	number,
					ie_origem_proced_p	number,
					nr_seq_proc_interno_p	number,
					cd_recomendacao_p	number,
					ie_anamense_dia_p	varchar2,
					ie_somente_anamnese_p	varchar2,
					ie_evolucao_dia_p	varchar2,
					ie_somente_evolucao_p	varchar2,
					ie_resumo_p		varchar2,
					ie_somente_resumo_p	varchar2,
					ie_somente_atb_prof_p	varchar2,
					ie_alta_real_p		number,
					ie_prev_alta_p		number,
					ie_somente_prescr_tev_p	varchar2,
					qt_carac_anamense_p	number,
					qt_carac_evolucao_p	number,
					qt_carac_resumo_p	number,
					cd_proc_cirurgias_p	varchar2,
					nr_seq_dispositivos_p	varchar2,
					nm_usuario_p		Varchar2,
					ie_risco_alto_p 	Varchar2 default null,
					ie_risco_baixo_p 	Varchar2 default null,
					ie_risco_intermed_p 	Varchar2 default null,
					ie_risco_nao_aplica_p 	Varchar2 default null,
					qt_horas_ant_tev_p	Number default null,
					qt_horas_pos_tev_p	Number default null,
					nr_seq_meta_p		number,
					ie_tipo_meta_p	varchar2 default null,
					ie_diagnostico_mentor_p          varchar2 default null,
					ie_exames_mentor_p               varchar2 default null,
					ie_sinais_vitais_mentor_p        varchar2 default null,                         
					ie_escalas_indices_mentor_p      varchar2 default null,
					ie_curativos_mentor_p            varchar2 default null,
					ie_protocolos_assis_mentor_p     varchar2 default null,
					ie_eventos_mentor_p              varchar2 default null,
					ie_classif_risco_mentor_p        varchar2 default null,
					cd_tipo_atendimento_p	         number   default null,
					ie_nao_cirurgia_p 			varchar2 default 'N',
					ie_diagnostico_p				 varchar2 default null,
					ds_exames_p				varchar2 default null,
					nr_seq_prot_ger_mentor_p number default null) is 
					
					
nr_atendimento_w		number(10);
dt_entrada_w			date;
dt_alta_w			date;
cd_pessoa_fisica_w		varchar2(10);
cd_setor_Atendimento_w		number(10);
qt_tev_w			number(10);	
ie_inserir_w			boolean	:= true;
qt_cirurgia_w			number(10);		
qt_dias_internacao_w		number(10) := 0;
QT_DIAS_POS_OPERATORIO_w	number(10):=0;	
qt_encontrada_w			number(10):=0;	
qt_diagnostico_w		number(10):=0;
qt_recomendacao_w		number(10):=0;
qt_anamnese_dia_w		number(10):=0;
qt_anamnese_caracter_w		number(10):=0;
qt_evolucao_dia_w		number(10):=0;
qt_evolucao_caracter_w		number(10):=0;
qt_resumo_pac_w			number(10):=0;
qt_resumo_pac_carac_w		number(10):=0;
qt_procedimento_w		number(10):=0;
qt_material_w			number(10):=0;
qt_pesquisados_w		number(10):=0;
nr_sequencia_w			number(10);
ds_texto_w			long;
ds_texto_diag_w			varchar2(255);
nm_usuario_w			varchar2(15);
dt_atualizacao_w		date;
cd_medico_w			varchar2(10);
dt_liberacao_w			date;
dt_registro_w			date;
ie_pesquisa_item_w		boolean;
qt_registro_w			number(10);
qt_prescr_atb_w			number(10) := 0;
dt_previsto_alta_w		date;
qt_prev_alta_w			number(10) := 0;
qt_proc_tev_w			number(10) := 0;
qt_mat_tev_w			number(10) := 0;
qt_recomend_tev_w		number(10) := 0;
nr_prescricao_w			number(14);
qt_tev_risco_alto_w		number(10) := 0;
qt_tev_risco_baixo_w		number(10) := 0;
qt_tev_risco_intermediario_w	number(10) := 0;
qt_tev_risco_nao_aplica_w	number(10) := 0;
dt_avaliacao_tev_w		Date;
nr_seq_tev_min_w		number(10);
nr_seq_dispositivos_w		varchar2(32000);
ds_exames_w			varchar2(32000);
cd_proc_cirurgias_w		varchar2(32000);
qt_meta_atend_w			number(10):= 0;
qt_tipo_pendencia_w      	number(10) := 0;
dt_final_w               	date;
dt_inicial_w             	date;
qt_exames_lab_w			number(10):=0;
ie_referencia_w			varchar2(1);
qt_resultado_w			exame_lab_result_item.qt_resultado%type;					
pr_resultado_w			exame_lab_result_item.pr_resultado%type;
nr_seq_exame_w			exame_lab_result_item.nr_seq_exame%type;
nr_seq_resultado_w		exame_lab_resultado.nr_seq_resultado%type;
ie_liberar_desfecho_w	varchar2(1);

					
					
Cursor C01 is
	select	a.cd_pessoa_fisica,
            a.nr_atendimento,
            b.cd_setor_atendimento,
            a.dt_entrada,
            a.dt_alta
	from    atend_paciente_unidade b,
            atendimento_paciente a
	where	a.nr_Atendimento	= b.nr_atendimento
	and	    b.nr_seq_interno	= obter_atepacu_paciente(a.nr_atendimento, 'A')
	and	    a.dt_entrada between dt_inicial_w and dt_final_w
	and	    a.ie_tipo_atendimento = nvl(cd_tipo_atendimento_p, a.ie_tipo_atendimento)
	and	    ((cd_setor_atendimento_p is null) or (b.cd_setor_atendimento	= cd_setor_atendimento_p))
	and	    ie_somente_internados_p	= 'N'
	and		obter_se_reg_lib_atencao(a.cd_pessoa_fisica, a.cd_medico_resp, a.ie_nivel_atencao, a.nm_usuario, 0, 0) = 'S' 
	union all
	select	a.cd_pessoa_fisica,
            a.nr_atendimento,
            b.cd_setor_atendimento,
            a.dt_entrada,
            a.dt_alta
	from	atend_paciente_unidade b,
            atendimento_paciente a
	where	a.nr_Atendimento	= b.nr_atendimento
	and	b.nr_seq_interno	= obter_atepacu_paciente(a.nr_atendimento, 'A')
	and	a.dt_alta is null
	and	a.ie_tipo_atendimento = nvl(cd_tipo_atendimento_p, a.ie_tipo_atendimento)
	and	( (cd_setor_atendimento_p is null) or (b.cd_setor_atendimento	= cd_setor_atendimento_p))
	and 	ie_somente_internados_p	= 'S'
	and		obter_se_reg_lib_atencao(a.cd_pessoa_fisica, a.cd_medico_resp, a.ie_nivel_atencao, a.nm_usuario, 0, 0) = 'S' 	
	order by 1;
	
Cursor C02 is
	select  a.nr_sequencia,
		a.ds_anamnese,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_medico,
		a.dt_liberacao,
		a.dt_ananmese
	from 	anamnese_paciente a
	where   (a.nr_atendimento = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'
	and     (obter_se_long_contem_texto(  'ANAMNESE_PACIENTE',
					      'DS_ANAMNESE',
					      'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
					      'NR_SEQUENCIA='||a.nr_sequencia,
					      palavra_chave_p) = 'S');
Cursor C03 is	
	select  a.nr_sequencia,
		a.ds_auditoria,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_medico,
		a.dt_liberacao,
		a.dt_atualizacao_nrec
	from 	atendimento_audit_medica a
	where   (a.nr_atendimento = nr_atendimento_w)
	and     (obter_se_long_contem_texto(  'ATENDIMENTO_AUDIT_MEDICA',
					      'DS_AUDITORIA',
					      'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
					      'NR_SEQUENCIA='||a.nr_sequencia,
					      palavra_chave_p) = 'S');	
Cursor C04 is
	select  a.nr_sequencia,
		a.ds_texto,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_profissional,
		a.dt_liberacao,
		a.dt_atualizacao_nrec
	from 	pep_pac_ci a
	where   (a.nr_atendimento = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'	
	and     (obter_se_long_contem_texto(  'PEP_PAC_CI',
					      'DS_TEXTO',
					      'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
					      'NR_SEQUENCIA='||a.nr_sequencia,
					      palavra_chave_p) = 'S');	
Cursor C05 is
	select  a.nr_sequencia,
		a.ds_justificativa,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_profissional,
		a.dt_liberacao,
		a.dt_atualizacao_nrec
	from 	paciente_justificativa a
	where   (a.nr_atendimento = nr_atendimento_w)
	and     (obter_se_long_contem_texto(  	'PACIENTE_JUSTIFICATIVA',
						'DS_JUSTIFICATIVA',
						'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
						'NR_SEQUENCIA='||a.nr_sequencia,
						palavra_chave_p) = 'S');
Cursor C06 is
	select  a.nr_sequencia,
		a.ds_atestado,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_medico,
		a.dt_liberacao,
		a.dt_atestado
	from 	atestado_paciente a
	where   (a.nr_atendimento = nr_atendimento_w)
	and     (obter_se_long_contem_texto(	'ATESTADO_PACIENTE',
						'DS_ATESTADO',
						'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
						'NR_SEQUENCIA='||a.nr_sequencia,
						palavra_chave_p) = 'S');	
Cursor C07 is	
	select  a.nr_sequencia,
		a.ds_boletim,
		a.nm_usuario,
		a.dt_atualizacao,
		'',
		a.dt_liberacao,
		a.dt_boletim
	from 	atendimento_boletim a
	where   (a.nr_atendimento = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'	
	and     (obter_se_long_contem_texto(	'ATENDIMENTO_BOLETIM',
						'DS_BOLETIM',
						'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
						'NR_SEQUENCIA='||a.nr_sequencia,
						palavra_chave_p) = 'S');
Cursor C08 is	
	select  a.nr_sequencia,
		a.ds_receita,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_medico,
		a.dt_liberacao,
		a.dt_receita
	from 	med_receita a
	where   (a.nr_atendimento_hosp = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'	
	and     (obter_se_long_contem_texto(	'MED_RECEITA',
						'DS_RECEITA',
						'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
						'NR_SEQUENCIA='||a.nr_sequencia,
						palavra_chave_p) = 'S');
Cursor C09 is	
	select  a.cd_evolucao,
		a.ds_evolucao,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_medico,
		a.dt_liberacao,
		a.dt_evolucao
	from 	evolucao_paciente a
	where   (a.nr_atendimento = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'	
	and     (obter_se_long_contem_texto(  	'EVOLUCAO_PACIENTE',
						'DS_EVOLUCAO',
						'WHERE CD_EVOLUCAO = :CD_EVOLUCAO',
						'CD_EVOLUCAO='||a.cd_evolucao,
						palavra_chave_p) = 'S');
Cursor C10 is	
	select  a.nr_sequencia,
		a.ds_orientacao_geral,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_profissional,
		a.dt_liberacao,
		a.dt_registro
	from 	pep_orientacao_geral a
	where   (a.nr_atendimento = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'	
	and     (obter_se_long_contem_texto(	'PEP_ORIENTACAO_GERAL',
						'DS_ORIENTACAO_GERAL',
						'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
						'NR_SEQUENCIA='||a.nr_sequencia,
						palavra_chave_p) = 'S');
Cursor C11 is	
	select  a.nr_parecer,
		a.ds_motivo_consulta,
		a.nm_usuario,
		a.dt_atualizacao,
		a.cd_medico,
		a.dt_liberacao,
		a.dt_atualizacao
	from 	parecer_medico_req a
	where   (a.nr_atendimento = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'	
	and     (obter_se_long_contem_texto(	'PARECER_MEDICO_REQ',
						'DS_MOTIVO_CONSULTA',
						'WHERE NR_PARECER = :NR_PARECER',
						'NR_PARECER='||a.nr_parecer,
						palavra_chave_p) = 'S');
Cursor C12 is	
	select  a.nr_sequencia,
		a.ds_orientacao,
		a.nm_usuario,
		a.dt_atualizacao,
		'',
		a.dt_liberacao,
		a.dt_atualizacao
	from 	atendimento_alta a
	where   (a.nr_atendimento = nr_atendimento_w)
	and	nvl(a.ie_situacao,'A') = 'A'	
	and 	((a.ie_tipo_orientacao <> 'P')
	or  	(ie_liberar_desfecho_w  = 'N') 
	or  	((a.dt_liberacao is not null) and (a.dt_inativacao is null)))
	and     (obter_se_long_contem_texto(	'ATENDIMENTO_ALTA',
						'DS_ORIENTACAO',
						'WHERE NR_SEQUENCIA = :NR_SEQUENCIA',
						'NR_SEQUENCIA='||a.nr_sequencia,
						palavra_chave_p) = 'S');	

Cursor C13 is	
	select  a.nr_seq_interno,
		substr(obter_desc_cid(CD_DOENCA),1,200),
		a.nm_usuario,
		a.dt_atualizacao,
		'',
		a.dt_liberacao,
		a.dt_atualizacao
	from 	diagnostico_doenca a
	where   (a.nr_atendimento = nr_atendimento_w)
	and		nvl(a.ie_situacao,'A') = 'A'
	and		upper(obter_desc_cid(CD_DOENCA)) like upper('%'||palavra_chave_p||'%');
	
Cursor c_laboratory_exams is
	select 	b.nr_seq_resultado,
		a.nr_sequencia, 
		b.nr_prescricao,
		a.nr_seq_exame,
		a.qt_resultado,
		a.pr_resultado,
		a.nm_usuario,  
		a.dt_atualizacao,  
		a.cd_medico_resp,  
		a.dt_liberacao,  
		a.dt_atualizacao
	from 	exame_lab_result_item a,
		exame_lab_resultado b, 
		prescr_medica c
	where 	a.nr_seq_resultado = b.nr_seq_resultado
	and  	b.nr_prescricao = c.nr_prescricao
	and  	c.nr_atendimento = nr_atendimento_w
	and  	obter_se_contido_char(a.nr_seq_exame, ds_exames_w) = 'S'
	and	lab_obter_status_exame(b.nr_prescricao, a.nr_seq_prescr)  in (2,3,5); -- 2: Typed 	3: approved 5: released
			
begin

ie_pesquisa_item_w	:= 	(palavra_chave_p is not null) and
				((ie_anamnese_p	= 'S') or
				 (ie_auditoria_p = 'S') or		
				 (ie_consentimento_p = 'S') or
				 (ie_justificativas_p = 'S') or	
				 (ie_atestado_p	= 'S') or	
				 (ie_boletim_p = 'S') or		
				 (ie_evolucoes_p = 'S') or		
				 (ie_receita_p = 'S') or
				 (ie_orientacao_g_p = 'S') or
				 (ie_parecer_p = 'S') or		
				 (ie_orientacao_a_p = 'S') or
				 (ie_diagnostico_p = 'S'));	

delete from w_gestao_assistencial
where	nm_usuario	= nm_usuario_p;

delete	from w_pesq_itens_pront
where	nm_usuario	= nm_usuario_p;

dt_inicial_w := inicio_dia(dt_inicial_p);
dt_final_W := fim_dia(dt_final_p);

select	nvl(max(ie_liberar_desfecho),'N')
into	ie_liberar_desfecho_w
from	parametro_medico
where   cd_estabelecimento = obter_estabelecimento_ativo;

open C01;
loop
fetch C01 into
	cd_pessoa_fisica_w,
	nr_atendimento_w,
	cd_setor_Atendimento_w,
	dt_entrada_w,
	dt_alta_w;
exit when C01%notfound;
	begin
	ie_inserir_w	:= true;
	
	if	(ie_tev_p	<> 'A') then
	
		select	count(*)
		into	qt_tev_w
		from	escala_tev
		where	nr_atendimento	= nr_atendimento_w
		and	dt_inativacao is null;
		
		ie_inserir_w	:= 	((qt_tev_w	> 0 ) and
					(ie_tev_p	= 'S')) or
					((qt_tev_w	= 0) and
					(ie_tev_p	= 'N'));
		if	(not ie_inserir_w) then
			goto Fim;
		end if;
	end if;
	
	if	((ie_risco_alto_p is not null) or
		(ie_risco_baixo_p is not null) or
		(ie_risco_intermed_p is not null) or
		(ie_risco_nao_aplica_p is not null) )then
		
		select	count(*)
		into	qt_tev_risco_alto_w
		from	escala_tev
		where	nr_atendimento	= nr_atendimento_w
		and	ie_risco  = ie_risco_alto_p	 
		and	ie_risco_alto_p is not null
		and	dt_inativacao is null;
		
		select	count(*)
		into	qt_tev_risco_baixo_w		
		from	escala_tev
		where	nr_atendimento	= nr_atendimento_w
		and	ie_risco  = ie_risco_baixo_p	 
		and	ie_risco_baixo_p is not null
		and	dt_inativacao is null;
		
		select	count(*)
		into	qt_tev_risco_intermediario_w
		from	escala_tev
		where	nr_atendimento	= nr_atendimento_w
		and	ie_risco  = ie_risco_intermed_p	 
		and	ie_risco_intermed_p is not null
		and	dt_inativacao is null;
		
		select	count(*)
		into	qt_tev_risco_nao_aplica_w
		from	escala_tev
		where	nr_atendimento	= nr_atendimento_w
		and	ie_risco  = ie_risco_nao_aplica_p	 
		and	ie_risco_nao_aplica_p is not null
		and	dt_inativacao is null;		
		
		qt_tev_w := qt_tev_risco_alto_w + qt_tev_risco_baixo_w + qt_tev_risco_intermediario_w + qt_tev_risco_nao_aplica_w;
		
		ie_inserir_w	:= (qt_tev_w	> 0);
		if	(not ie_inserir_w) then
			goto Fim;
		end if;
	end if;
	if	(ie_cirurgico_p		= 'S') then
		select	count(*)
		into	qt_cirurgia_w
		from	cirurgia
		where	nr_atendimento	= nr_atendimento_w;
		ie_inserir_w	:= (qt_cirurgia_w	> 0);
		if	(not ie_inserir_w) then
			goto Fim;
		end if;
	end if;
	
	if	(cd_doenca_p is not null) then
		select	count(*)
		into	qt_diagnostico_w
		from	diagnostico_doenca
		where	nr_atendimento 	= nr_atendimento_w
		and	cd_doenca	= cd_doenca_p
		and	nvl(ie_situacao,'A') = 'A';
		
		ie_inserir_w	:= (qt_diagnostico_w	> 0);
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
	end if;
	
	if	(ie_pesquisa_item_w) then
		if	(ie_anamnese_p = 'S') then --Anamnese
			open C02;
			loop
			fetch C02 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C02%notfound;
				begin
				insere_pesq_itens_pront(83,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C02;
		end if;	
		
		if	(ie_auditoria_p = 'S') then --Auditoria externa
			open C03;
			loop
			fetch C03 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C03%notfound;
				begin
				insere_pesq_itens_pront(343,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C03;
		end if;	
		
		if	(ie_consentimento_p = 'S') then --Consentimento
			open C04;
			loop
			fetch C04 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C04%notfound;
				begin
				insere_pesq_itens_pront(398,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C04;
		end if;	

		if	(ie_justificativas_p = 'S') then --Justificativas
			open C05;
			loop
			fetch C05 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C05%notfound;
				begin
				insere_pesq_itens_pront(393,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C05;
		end if;	

		if	(ie_atestado_p = 'S') then --Atestados
			open C06;
			loop
			fetch C06 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C06%notfound;
				begin
				insere_pesq_itens_pront(74,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C06;
		end if;	

		if	(ie_boletim_p = 'S') then --Boletim informativo
			open C07;
			loop
			fetch C07 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C07%notfound;
				begin
				insere_pesq_itens_pront(21,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C07;
		end if;	
		
		if	(ie_receita_p = 'S') then --Receitas
			open C08;
			loop
			fetch C08 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C08%notfound;
				begin
				insere_pesq_itens_pront(73,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C08;
		end if;	
		
		if	(ie_evolucoes_p = 'S') then --Evolucoes
			open C09;
			loop
			fetch C09 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C09%notfound;
				begin
				insere_pesq_itens_pront(5,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C09;
		end if;	

		if	(ie_orientacao_g_p = 'S') then --Orientacoes gerais
			open C10;
			loop
			fetch C10 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C10%notfound;
				begin
				insere_pesq_itens_pront(416,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C10;
		end if;	

		if	(ie_parecer_p = 'S') then --Parecer medico
			open C11;
			loop
			fetch C11 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C11%notfound;
				begin
				insere_pesq_itens_pront(51,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C11;
		end if;	
	
		if	(ie_orientacao_a_p = 'S') then --Orientacoes de alta
			open C12;
			loop
			fetch C12 into
				nr_sequencia_w,
				ds_texto_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C12%notfound;
				begin
				insere_pesq_itens_pront(153,ds_texto_w,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C12;
		end if;
		
		if	(ie_diagnostico_p = 'S') then --Diagnostico
			open C13;
			loop
			fetch C13 into
				nr_sequencia_w,
				ds_texto_diag_w,
				nm_usuario_w,
				dt_atualizacao_w,
				cd_medico_w,
				dt_liberacao_w,
				dt_registro_w;
			exit when C13%notfound;
				begin
				insere_pesq_itens_pront(1,null,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w, nr_atendimento_w, ds_texto_diag_w);
				qt_pesquisados_w := qt_pesquisados_w + 1;
				end;
			end loop;
			close C13;
		end if;
		
		ie_inserir_w	:= (qt_pesquisados_w	> 0);	
		qt_pesquisados_w:=0;
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
	end if;	

	if (ds_exames_p	is not null) then
		ds_exames_w := replace(ds_exames_p,chr(13)||chr(10),',');
		
		open c_laboratory_exams;
		loop
		fetch c_laboratory_exams into
			nr_seq_resultado_w,
			nr_sequencia_w,
			nr_prescricao_w,
			nr_seq_exame_w,
			qt_resultado_w,
			pr_resultado_w,
			nm_usuario_w,
			dt_atualizacao_w,
			cd_medico_w,
			dt_liberacao_w,
			dt_registro_w;
		exit when c_laboratory_exams%notfound;
			begin			
			ie_referencia_w := 'S';
			
			if (qt_resultado_w is not null) then			
				SELECT DECODE(COUNT(*), 0, 'N', 'S')
				into ie_referencia_w
				FROM dual
				WHERE qt_resultado_w 
				BETWEEN 
				lab_obter_valor_referencia(nr_prescricao_w, nr_sequencia_w, nr_seq_exame_w, 1) 
				AND 
				lab_obter_valor_referencia(nr_prescricao_w, nr_sequencia_w, nr_seq_exame_w, 2);
			elsif (pr_resultado_w is not null) then
				SELECT DECODE(COUNT(*), 0, 'N', 'S')
				into ie_referencia_w
				FROM dual
				WHERE pr_resultado_w
				BETWEEN 
				lab_obter_valor_referencia(nr_prescricao_w, nr_sequencia_w, nr_seq_exame_w, 1) 
				AND 
				lab_obter_valor_referencia(nr_prescricao_w, nr_sequencia_w, nr_seq_exame_w, 2);
			end if;
			
			--Result out of range
			if (ie_referencia_w = 'N') then		
				insere_pesq_itens_pront(2,null,nm_usuario_p,dt_registro_w,cd_medico_w,dt_liberacao_w,nr_atendimento_w,null,nr_seq_resultado_w, nr_sequencia_w);
				qt_exames_lab_w := qt_exames_lab_w + 1;
			end if;
			
			end;
		end loop;
		close c_laboratory_exams;
	end if;
	
	if	(nvl(cd_material_p,0) > 0) then
		select  count(*)
		into	qt_material_w
		from 	material c,
			prescr_material b,
			prescr_medica a
		where   a.nr_prescricao	= b.nr_prescricao
		and	a.nr_atendimento= nr_atendimento_w
		and	c.cd_material 	= b.cd_material
		and	b.cd_material	= cd_material_p
		and	c.ie_tipo_material in (2,3,6)
		and	nvl(c.ie_situacao,'A') = 'A';
				
		ie_inserir_w	:= (qt_material_w	> 0);	
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
	end if;	
	
	if	((nvl(cd_procedimento_p,0) > 0) and (nvl(ie_origem_proced_p,0) > 0)) or
		(nvl(nr_seq_proc_interno_p,0) > 0) then	
		select  count(*)
		into	qt_procedimento_w
		from 	procedimento c,
			prescr_procedimento b,
			prescr_medica a
		where   a.nr_prescricao		= b.nr_prescricao
		and	a.nr_atendimento	= nr_atendimento_w
		and	c.cd_procedimento	= b.cd_procedimento
		and	c.ie_origem_proced	= b.ie_origem_proced
		and	((b.cd_procedimento	= cd_procedimento_p and	b.ie_origem_proced	= ie_origem_proced_p) or 
			 (nr_seq_proc_interno = nr_seq_proc_interno_p))
		and	nvl(c.ie_situacao,'A')  = 'A';
				
		ie_inserir_w	:= (qt_procedimento_w	> 0);	
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
	end if;	
	
	if	(nvl(cd_recomendacao_p,0) > 0) then
		select  count(*)
		into	qt_recomendacao_w
		from	tipo_recomendacao c,
			prescr_recomendacao b,
			prescr_medica a
		where	a.nr_prescricao		= b.nr_prescricao
		and	b.cd_recomendacao	= c.cd_tipo_recomendacao
		and	a.nr_atendimento	= nr_atendimento_w
		and	b.cd_recomendacao 	= cd_recomendacao_p
		and	nvl(c.ie_situacao,'A')  = 'A';	
		
		ie_inserir_w	:= (qt_recomendacao_w	> 0);	
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
	end if;

	if 	(ie_anamense_dia_p = 'S') then
	
		select	count(*)
		into	qt_anamnese_dia_w
		from	anamnese_paciente a,
			atendimento_paciente b
		where	a.nr_atendimento = nr_atendimento_w
		and	a.nr_atendimento = b.nr_atendimento
		and	dt_liberacao is not null
		and	dt_inativacao is null
		and	a.dt_ananmese between dt_entrada_w and (dt_entrada_w + 1);
			
		ie_inserir_w	:= (qt_anamnese_dia_w = 0 );
		
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
		
	end if;
	
	if	(ie_somente_anamnese_p = 'S') then
		select 	count(*)
		into	qt_anamnese_caracter_w		
		from	anamnese_paciente
		where 	nr_atendimento = nr_atendimento_w
		and	dt_liberacao is not null
		and	dt_inativacao is null
		and	qt_caracteres < qt_carac_anamense_p;
					
		ie_inserir_w	:= (qt_anamnese_caracter_w > 0);
		
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
		
	end if;
	
	if	(ie_evolucao_dia_p = 'S') then
	
		if	( trunc(dt_entrada_w) <> trunc(sysdate) ) then
	
			SELECT  COUNT(*)
			INTO	qt_evolucao_dia_w
			FROM	evolucao_paciente a,
					pessoa_fisica b,
					atendimento_paciente c
			WHERE	a.nr_atendimento = nr_atendimento_w
			and		a.nr_atendimento = c.nr_atendimento
			and		a.cd_medico = b.cd_pessoa_fisica
			AND		TRUNC(dt_evolucao) < TRUNC(SYSDATE);
		
			ie_inserir_w	:=  (qt_evolucao_dia_w = 0);
			
			if	(not ie_inserir_w) then
				goto Fim;
			end if;	
		else
			goto Fim;
		end if;
	
	end if;
	
	if	(ie_somente_evolucao_p = 'S') then
		select 	count(*)
		into	qt_evolucao_caracter_w
		from	evolucao_paciente
		where	nr_atendimento = nr_atendimento_w
		and	dt_liberacao is not null
		and	dt_inativacao is null
		and	qt_caracteres < qt_carac_evolucao_p;
		
		ie_inserir_w	:= (qt_evolucao_caracter_w > 0);
		
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
			
	end if;

	if	(ie_resumo_p = 'S') then
		select 	count(*)
		into	qt_resumo_pac_w
		from	atendimento_alta a
		where	nr_atendimento = nr_atendimento_w
		and 	((a.ie_tipo_orientacao <> 'P')
		or  	(ie_liberar_desfecho_w  = 'N') 
		or  	((a.dt_liberacao is not null) and (a.dt_inativacao is null)));
	
		ie_inserir_w	:= (qt_resumo_pac_w = 0);
		
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
		
	end if;
	
	if	(ie_somente_resumo_p = 'S') then
		select 	count(*)
		into	qt_resumo_pac_carac_w
		from	atendimento_alta
		where	nr_atendimento = nr_atendimento_w
		and	dt_liberacao is not null
		and	dt_inativacao is null
		and	qt_caracteres < qt_carac_resumo_p;
		
		
		ie_inserir_w 	:= (qt_resumo_pac_carac_w > 0);
		
		if	(not ie_inserir_w) then
			goto Fim;
		end if;	
		
	end if;	
	
	
	
	if	(cd_proc_cirurgias_p	is not null) then
		
		cd_proc_cirurgias_w := substr(replace(cd_proc_cirurgias_p,chr(13)||chr(10),','),1,32000);
		
		select	count(*)
		into	qt_registro_w
		from	cirurgia
		where	nr_atendimento	= nr_atendimento_w
		and	IE_STATUS_CIRURGIA = '2'
		and	obter_se_contido_char(CD_PROCEDIMENTO_PRINC,cd_proc_cirurgias_w)	= 'S';
		
		
		if	(qt_registro_w = 0) then
			
			select	count(*)
			into	qt_registro_w
			FROM 	pepo_cirurgia b, 
				PEPO_CIRURGIA_PROC c
			where	b.nr_Sequencia = c.nr_seq_pepo 
			and	b.nr_atendimento	= nr_atendimento_w
			and	obter_se_contido_char(CD_PROCEDIMENTO,cd_proc_cirurgias_w)	= 'S';				
				
		end if;
		
		if	(qt_registro_w	= 0) then
			ie_inserir_w	:= false;
			goto Fim;	
		end if;
	end if;
	
	if	(ie_somente_atb_prof_p = 'E') then
		
		select 	count(*)
		into	qt_prescr_atb_w
		from   	prescr_medica a,
			prescr_material b,
			material c
		where  	a.nr_prescricao = b.nr_prescricao
		and    	b.cd_material = c.cd_material
		and    	a.nr_atendimento = nr_atendimento_w
		and    	c.ie_controle_medico <> 0
		and    	b.ie_objetivo in ('F','P','C')
		and    	a.dt_prescricao between (sysdate-2) and (sysdate);
		
		if	(qt_prescr_atb_w = 0) then
			ie_inserir_w	:= false;
			goto Fim;			
		end if;
	
	elsif	(ie_somente_atb_prof_p = 'L') then
	
		select 	count(*)
		into	qt_prescr_atb_w
		from   	prescr_medica a,
			prescr_material b,
			material c
		where  	a.nr_prescricao = b.nr_prescricao
		and    	b.cd_material = c.cd_material
		and    	a.nr_atendimento = nr_atendimento_w
		and    	c.ie_controle_medico <> 0
		and    	b.ie_objetivo in ('F','P','C')
		and    	a.dt_prescricao < (sysdate-2);
		
		if	(qt_prescr_atb_w = 0) then
			ie_inserir_w	:= false;
			goto Fim;			
		end if;
	
	elsif	(ie_somente_atb_prof_p = 'S') then
	
		select 	count(*)
		into	qt_prescr_atb_w
		from   	prescr_medica a,
			prescr_material b,
			material c
		where  	a.nr_prescricao = b.nr_prescricao
		and    	b.cd_material = c.cd_material
		and    	a.nr_atendimento = nr_atendimento_w
		and    	c.ie_controle_medico <> 0
		and    	b.ie_objetivo in ('F','P','C');
		
		if	(qt_prescr_atb_w = 0) then
			ie_inserir_w	:= false;
			goto Fim;			
		end if;
	
	end if;
	
	if	(ie_alta_real_p <> 2) then
		
		if (dt_alta_w is not null) then
		
			select max(a.dt_previsto_alta)
			into   dt_previsto_alta_w
			from   atendimento_paciente a
			where  a.nr_atendimento = nr_atendimento_w;
			
			if	(dt_previsto_alta_w is not null) then
				if	(ie_alta_real_p = 0) then		
					
					if	(trunc(dt_alta_w) > trunc(dt_previsto_alta_w)) then
						ie_inserir_w	:= false;
						goto Fim;
					end if;
			
				elsif 	(ie_alta_real_p = 1) then
				
					if	(trunc(dt_alta_w) <= trunc(dt_previsto_alta_w)) then
						ie_inserir_w	:= false;
						goto Fim;
					end if;
				
				end if;
			else
				begin
				ie_inserir_w	:= false;
				goto Fim;				
				end;
			end if;	
		else
			begin
			ie_inserir_w	:= false;
			goto Fim;			
			end;		
		end if;
	end if;
	
	if	(ie_prev_alta_p <> 2) then
	
		select 	count(*)
		into	qt_prev_alta_w
		from   	atend_previsao_alta a
		where  	a.nr_atendimento = nr_atendimento_w;
		
		if	(ie_prev_alta_p = 0) then
		
			if	(qt_prev_alta_w = 0) then
				ie_inserir_w	:= false;
				goto Fim;			
			end if;
		
		elsif	(ie_prev_alta_p = 1) then
		
			if	(qt_prev_alta_w > 0) then
				ie_inserir_w	:= false;
				goto Fim;			
			end if;		
		
		end if;
	
	
	end if;
	
	
	if	(ie_somente_prescr_tev_p = 'S') then		
		
		
		select	min(nr_sequencia)
		into	nr_seq_tev_min_w
		from	escala_tev
		where	nr_atendimento	= nr_atendimento_w
		and	(((ie_risco  = ie_risco_alto_p) and (ie_risco_alto_p is not null)) or	 
			((ie_risco  = ie_risco_baixo_p) and (ie_risco_baixo_p is not null)) or
			((ie_risco  = ie_risco_intermed_p) and (ie_risco_intermed_p is not null)) or
			((ie_risco  = ie_risco_nao_aplica_p) and (ie_risco_nao_aplica_p is not null)) or
			((ie_risco_alto_p is null) and (ie_risco_baixo_p is null) and (ie_risco_intermed_p is null) and (ie_risco_nao_aplica_p is null)))
		and	dt_inativacao is null;		
				
		Select	max(dt_avaliacao)
		into	dt_avaliacao_tev_w
		from	escala_tev
		where	nr_sequencia = 	nr_seq_tev_min_w;		
		
		select 	count(*) 
		into	qt_proc_tev_w
		from   	prescr_medica a,
			prescr_procedimento b,
			procedimento c
		where  	a.nr_prescricao = b.nr_prescricao
		and    	a.nr_atendimento = nr_atendimento_w
		and    	b.cd_procedimento = c.cd_procedimento
		and    	b.ie_origem_proced = c.ie_origem_proced
		and	((a.dt_prescricao  between (dt_avaliacao_tev_w - (1/24 * qt_horas_ant_tev_p)) 
					      and (dt_avaliacao_tev_w + (1/24 * qt_horas_pos_tev_p))) or
			((qt_horas_ant_tev_p = 0) or (qt_horas_pos_tev_p = 0)))
		and    	c.ie_protocolo_tev = 'S';		
		
		select 	count(*)
		into	qt_mat_tev_w
		from   	prescr_medica a,
			prescr_material b,
			material c
		where  	a.nr_prescricao = b.nr_prescricao
		and    	b.cd_material = c.cd_material
		and    	a.nr_atendimento = nr_atendimento_w
		and	((a.dt_prescricao  between (dt_avaliacao_tev_w - (1/24 * qt_horas_ant_tev_p)) 
					      and (dt_avaliacao_tev_w + (1/24 * qt_horas_pos_tev_p))) or
			((qt_horas_ant_tev_p = 0) or (qt_horas_pos_tev_p = 0)))
		and    	c.ie_protocolo_tev = 'S';
		
		select 	count(*)
		into	qt_recomend_tev_w
		from   	prescr_medica a,
			prescr_recomendacao b,
			tipo_recomendacao d
		where  	a.nr_prescricao  = b.nr_prescricao
		and	b.cd_recomendacao = d.cd_tipo_recomendacao
		and    	a.nr_atendimento = nr_atendimento_w
		and	((a.dt_prescricao  between (dt_avaliacao_tev_w - (1/24 * qt_horas_ant_tev_p)) 
					      and (dt_avaliacao_tev_w + (1/24 * qt_horas_pos_tev_p))) or
			((qt_horas_ant_tev_p = 0) or (qt_horas_pos_tev_p = 0)))
		and    	ie_protocolo_tev = 'S';
		
		if	(qt_proc_tev_w = 0) and
			(qt_mat_tev_w = 0) and
			(qt_recomend_tev_w = 0) then
			ie_inserir_w	:= false;
			goto Fim;
			
		end if;	
			
	end if;
	
	if	(ie_nao_cirurgia_p = 'S') then
		
		select	count(*)
		into	qt_cirurgia_w
		from	cirurgia
		where	nr_atendimento	= nr_atendimento_w;

		ie_inserir_w	:= (qt_cirurgia_w = 0);

		if	(not ie_inserir_w) then
			goto Fim;
		end if;
	end if;
	
	
	if	(nr_seq_dispositivos_p	is not null) then

		nr_seq_dispositivos_w := replace(nr_seq_dispositivos_p,chr(13)||chr(10),',');
				
		select	count(*)
		into	qt_registro_w
		from	ATEND_PAC_DISPOSITIVO
		where	nr_atendimento	= nr_atendimento_w
		and		OBTER_SE_CONTIDO_CHAR(NR_SEQ_DISPOSITIVO,nr_seq_dispositivos_w)	= 'S';		
	
		if	(qt_registro_w	= 0) then
			ie_inserir_w	:= false;
			goto Fim;	
		end if;
		
	end if;
	
	if (ds_exames_w is not null) then		
	
		if (qt_exames_lab_w = 0) then
			ie_inserir_w	:= false;
			goto Fim;	
		end if;
		
	end if;
	
	if	(nr_seq_meta_p 	<> 0) then
	
		select	count(*)
		into	qt_meta_atend_w
		from	tof_meta_atend
		where	nr_seq_meta = nr_seq_meta_p
		and		nr_atendimento = nr_atendimento_w
		and		((ie_status	= ie_tipo_meta_p) or ((ie_tipo_meta_p = 'A') and (ie_status is null)) or (ie_tipo_meta_p = 'M'))
		and     dt_liberacao is not null
		and     dt_inativacao is null;
			
		if	(qt_meta_atend_w = 0) then
			ie_inserir_w	:= false;
			goto Fim;	
		end if;
	end if;
          
     if ( (ie_diagnostico_mentor_p         = 'S') or
          (ie_exames_mentor_p              = 'S') or
          (ie_sinais_vitais_mentor_p       = 'S') or
          (ie_escalas_indices_mentor_p     = 'S') or
          (ie_curativos_mentor_p           = 'S') or
          (ie_protocolos_assis_mentor_p    = 'S') or
          (ie_eventos_mentor_p             = 'S') or
          (ie_classif_risco_mentor_p       = 'S')) then
          
          select count(*)
          into   qt_tipo_pendencia_w
          from   gqa_pendencia a,
                 gqa_pendencia_regra b, 
                 gqa_pend_pac_acao c,
                 gqa_acao d,
                 gqa_pendencia_pac e
          where   b.nr_seq_pendencia = a.nr_sequencia
          and    d.nr_seq_pend_regra = b.nr_sequencia
          and    c.nr_seq_regra_acao = d.nr_sequencia
          and    e.nr_sequencia = c.nr_seq_pend_pac
          and    e.nr_atendimento = nr_atendimento_w
          and    ((ie_diagnostico_mentor_p = 'S' and a.ie_tipo_pendencia = 1)
                    or (ie_exames_mentor_p = 'S' and a.ie_tipo_pendencia = 2)
                    or (ie_sinais_vitais_mentor_p = 'S' and a.ie_tipo_pendencia = 3)
                    or (ie_escalas_indices_mentor_p = 'S' and a.ie_tipo_pendencia = 4)
                    or (ie_curativos_mentor_p = 'S' and a.ie_tipo_pendencia = 5)
                    or (ie_protocolos_assis_mentor_p = 'S' and a.ie_tipo_pendencia = 6 and nr_seq_prot_ger_mentor_p is null)
                    or (ie_eventos_mentor_p = 'S' and a.ie_tipo_pendencia = 7)
                    or (ie_classif_risco_mentor_p = 'S' and a.ie_tipo_pendencia = 8));

          -- Protocolos Gerenciados
          select qt_tipo_pendencia_w + count(1)
          into qt_tipo_pendencia_w
          from gqa_protocolo_pac a,
               gqa_pendencia b
          where ie_protocolos_assis_mentor_p = 'S' 
            and nr_seq_prot_ger_mentor_p is not null
            and a.nr_atendimento = nr_atendimento_w
            and a.nr_seq_protocolo = b.nr_sequencia
            and b.nr_sequencia = nr_seq_prot_ger_mentor_p
            and a.dt_liberacao is not null;

          if (qt_tipo_pendencia_w = 0) then
               ie_inserir_w := false;
               goto Fim;
          end if;          
     end if;
     
           
          
	if	(ie_inserir_w) then
		begin
		
		qt_dias_internacao_w := (nvl(dt_alta_w,sysdate) - dt_entrada_w) + 1;
		qt_dias_pos_operatorio_w	:= obter_dias_pos_operatorio(nr_atendimento_w);
		insert into w_gestao_assistencial (	nr_sequencia,
							dt_atualizacao,
							nm_usuario,
							dt_atualizacao_nrec,
							nm_usuario_nrec,
							nr_atendimento,
							cd_setor_Atendimento,
							qt_dias_internacao,
							qt_dias_pos_operatorio)
				values		(	w_gestao_assistencial_seq.nextval,
							sysdate,
							nm_usuario_p,
							sysdate,
							nm_usuario_p,
							nr_atendimento_w,
							cd_setor_Atendimento_w,
							qt_dias_internacao_w,
							qt_dias_pos_operatorio_w);
		end;
	end if;
	
	<<Fim>>
	ie_inserir_w	:= ie_inserir_w;
	end;
	
	
end loop;
close C01;

commit;

end Gerar_W_Gestao_Assistencial;


GRANT EXECUTE ON TASY.GERAR_W_GESTAO_ASSISTENCIAL TO USR_ALESSANDER;

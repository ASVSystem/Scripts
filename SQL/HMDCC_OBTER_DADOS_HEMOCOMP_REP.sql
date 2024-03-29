CREATE OR REPLACE FUNCTION        HMDCC_OBTER_DADOS_HEMOCOMP_REP (	nr_prescricao_p		number, nr_sequencia_p number,
											ie_opcao_p			varchar2)
					return varchar2 is

ds_retorno_w		VARCHAR2(10);
ds_hemacias_w		VARCHAR2(10);
ds_plaquetas_w		VARCHAR2(10);
ds_plasma_w		VARCHAR2(10);
ds_crio_w		VARCHAR2(10);
/*
	ie_opcao_p
  CH - 	IE_DESC_HEMOCOMPONENTE (Concentrado de Hemácias)
  CHVP - IE_VOL_HEMOC_PROG
  CHVR - IE_VOL_HEMOC_ROT
  CHVU - IE_VOL_HEMOC_URG
  CP - 	IE_DESC_HEMOCOMPONENTE (Concentrado de Plaquetas)
  CPUP - IE_UND_HEMOC_PROG
  CPUR - IE_UND_HEMOC_ROT
  CPUU - IE_UND_HEMOC_URG
  PFC - 	IE_DESC_HEMOCOMPONENTE(Plasma Fresco)
  PFCVP - IE_VOL_HEMOC_PROG
  PFCVR - IE_VOL_HEMOC_ROT
  PFCVU - IE_VOL_HEMOC_URG
  CRI - 	IE_DESC_HEMOCOMPONENTE (Crioprecipitado)
  CRIUP - IE_UND_HEMOC_PROG
  CRIUR - IE_UND_HEMOC_ROT
  CRIUU - IE_UND_HEMOC_URG
  TA - 	IE_TIPO_ATENDIMENTO_HEM (Tipo de atendimento - tempo)
  QTV - 	IE_QUANTIDADE_HEM
  QTU - 	IE_QUANTIDADE_HEM
  CHIR - IE_IRRADIADO
  CHLV - IE_LAVADO
  CPLV - IE_LAVADO

  HEM - IE_HEMOCOMPONENTE (String Concatenada)

  Atualizações:

  Atualizado em 08/05/2016 - Alessander Victor;
--Atualizado em 10/08/2021 - Alessander Victor;--------
	Caso Cirurgico
 comentado AND (s.ie_tipo_paciente = 'CI'OR s.IE_RESERVA = 'S');
 adicionado AND (s.IE_RESERVA = 'S');

*/

BEGIN
--Teste hemocomponente
if	(ie_opcao_p = 'HEM') then
	select DISTINCT s1.sg_sigla||s2.sg_sigla||s3.sg_sigla||s4.sg_sigla
	into	ds_retorno_w
  from	san_derivado s1, san_derivado s2, san_derivado s3, san_derivado s4, prescr_procedimento p
	where	s1.nr_sequencia = 1
  AND s2.nr_sequencia = 21
  AND s3.nr_sequencia = 9
  AND s4.nr_sequencia = 29
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p;

--DS CH
elsif	(ie_opcao_p = 'CH') then
	select s.sg_sigla
	into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1 ;

--DS CHVP (volume Programado do hemocomponente hemácias)
elsif	(ie_opcao_p = 'CHVP') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  where  s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1
  AND s.ie_tipo = 1
  AND s.ie_tipo_paciente <> 'CI'
  AND s.IE_RESERVA <> 'S';
  
--DS CHVR (volume Rotina do hemocomponente hemácias)
elsif	(ie_opcao_p = 'CHVR') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1
  AND s.ie_tipo = 2
  AND s.ie_tipo_paciente <> 'CI';
  
--DS CHVU (volume Urgente do hemocomponente hemácias)
elsif	(ie_opcao_p = 'CHVU') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1
  AND s.ie_tipo = 3;
  --AND s.ie_tipo_paciente <> 'CI';



--DS CP
elsif	(ie_opcao_p = 'CP') then
	select	s.sg_sigla
	into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 21 ;

--DS CPUP (volume Programado do hemocomponente plaquetas)
elsif	(ie_opcao_p = 'CPUP') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  where  s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 21
  AND s.ie_tipo = 1
  AND s.ie_tipo_paciente <> 'CI'
  AND s.IE_RESERVA <> 'S';
  
--DS CPUR (volume Rotina do hemocomponente plaquetas)
elsif	(ie_opcao_p = 'CPUR') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 21
  AND s.ie_tipo = 2
  AND s.ie_tipo_paciente <> 'CI';
  
--DS CPUU (volume Urgente do hemocomponente plaquetas)
elsif	(ie_opcao_p = 'CPUU') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 21
  AND s.ie_tipo = 3;
  --AND s.ie_tipo_paciente <> 'CI';


--DS PFC
elsif	(ie_opcao_p = 'PFC') then
	select	s.sg_sigla
	into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 9 ;

--DS PFCVP (volume Programado do hemocomponente Plasma Fresco)
elsif	(ie_opcao_p = 'PFCVP') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  where  s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 9
  AND s.ie_tipo = 1
  AND s.ie_tipo_paciente <> 'CI'
  AND s.IE_RESERVA <> 'S';
  
--DS PFCVR (volume Rotina do hemocomponente plasma fresco)
elsif	(ie_opcao_p = 'PFCVR') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 9
  AND s.ie_tipo = 2
  AND s.ie_tipo_paciente <> 'CI';
  
--DS PFCVU (volume Urgente do hemocomponente plasma fresco)
elsif	(ie_opcao_p = 'PFCVU') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 9
  AND s.ie_tipo = 3;
  --AND s.ie_tipo_paciente <> 'CI';



--DS CRI
elsif	(ie_opcao_p = 'CRI') then
	select	s.sg_sigla
	into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 29 ;

--DS CRIUP (volume Programado do hemocomponente crioprecipitado)
elsif	(ie_opcao_p = 'CRIUP') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  where  s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 29
  AND s.ie_tipo = 1
  AND s.ie_tipo_paciente <> 'CI'
  AND s.IE_RESERVA <> 'S';
  
--DS CRIUR (volume Rotina do hemocomponente crioprecipitados)
elsif	(ie_opcao_p = 'CRIUR') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 29
  AND s.ie_tipo = 2
  AND s.ie_tipo_paciente <> 'CI';
--DS CRIUU (volume Urgente do hemocomponente crioprecipitado)
elsif	(ie_opcao_p = 'CRIUU') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 29
  AND s.ie_tipo = 3;
  --AND s.ie_tipo_paciente <> 'CI';

--Caso Cirurgico--------------------------------

--QT CHCI (volume Reserva Cirurgia do hemocomponente CH )
elsif	(ie_opcao_p = 'CHCI') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  where  s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1
  --AND (s.ie_tipo_paciente = 'CI'OR s.IE_RESERVA = 'S');
  AND (s.IE_RESERVA = 'S');
  
--QT CPCI (volume Reserva Cirurgia do hemocomponente CP)
elsif	(ie_opcao_p = 'CPCI') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 21
  --AND (s.ie_tipo_paciente = 'CI'OR s.IE_RESERVA = 'S');
  AND (s.IE_RESERVA = 'S');
  
--QT PFCCI (volume Reserva Cirurgia do hemocomponente Plasma Fresco)
elsif	(ie_opcao_p = 'PFCCI') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 9
 -- AND (s.ie_tipo_paciente = 'CI'OR s.IE_RESERVA = 'S');
  AND (s.IE_RESERVA = 'S');
  
--QT CRICI (volume Reserva Cirurgia do hemocomponente Crioprecipitado)
elsif	(ie_opcao_p = 'CRICI') then
	select p.qt_procedimento
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 29
  --AND (s.ie_tipo_paciente = 'CI'OR s.IE_RESERVA = 'S');
  AND (s.IE_RESERVA = 'S');

--Caso Transfusão de Emergência(Extrema Urgencia)------------------
--QT CHEU
elsif	(ie_opcao_p = 'CHEU') then
	select p.qt_vol_hemocomp
	into	ds_retorno_w
	from	 prescr_procedimento p, prescr_solic_bco_sangue s
  WHERE s.nr_prescricao = p.nr_prescricao
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1
  AND s.ie_tipo = 4;

--Tipo Atendimento (tempo)
elsif	(ie_opcao_p = 'TA') then
	select v.vl_dominio
	into	ds_retorno_w
	from	valor_dominio v, prescr_solic_bco_sangue s
	where	v.cd_dominio = 1223
  AND s.nr_prescricao = nr_prescricao_p
  AND s.nr_sequencia = nr_sequencia_p
  AND   v.vl_dominio = s.ie_tipo;

--Quantidade hemocomponente em Volume
elsif	(ie_opcao_p = 'QTV') then
	select
    max(CASE
         WHEN p.nr_seq_derivado = 1 then p.qt_vol_hemocomp
         WHEN  p.nr_seq_derivado = 9 then p.qt_vol_hemocomp
        END)
  into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p;

--Quantidade hemocomponente em Unidade
elsif	(ie_opcao_p = 'QTU') then
	SELECT
    max(CASE
          WHEN  p.nr_seq_derivado = 21 then p.qt_procedimento
          WHEN p.nr_seq_derivado = 29 then p.qt_procedimento
        END)
  into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p;

--IE CH Irradiado
elsif	(ie_opcao_p = 'CHIR') then
	select	decode(p.ie_irradiado,'S','X','')
	into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1;
--IE CH Lavado
elsif	(ie_opcao_p = 'CHLV') then
	select	decode(p.ie_lavado,'S','X','')
	into	ds_retorno_w
	from	san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 1;


--IE CP Lavado
elsif	(ie_opcao_p = 'CPLV') then
	select	decode(p.ie_lavado,'S','X','')
	into	ds_retorno_w
	from		san_derivado s, prescr_procedimento p
	where	s.nr_sequencia = p.nr_seq_derivado
  AND p.nr_prescricao = nr_prescricao_p
  AND p.nr_seq_solic_sangue = nr_sequencia_p
  AND p.nr_seq_derivado = 21;

end if;

return	ds_retorno_w;
--return	(ds_hemacias_w||ds_plaquetas_w||ds_plasma_w||ds_crio_w);

end Hmdcc_Obter_dados_hemocomp_REP;

GRANT EXECUTE ON TASY.HMDCC_OBTER_DADOS_HEMOCOMP_REP TO USR_ALESSANDER;



CREATE OR REPLACE FUNCTION hmdcc_obter_dados_agen_cirur(nr_seq_agenda_p NUMBER,
				 ie_opcao_p	 VARCHAR2)
RETURN VARCHAR2 IS

/*
ie_opcao_p -> futuras customizaçoes.

E - Equipamentos.
B - Bolsa de Sangue
O - OPME
CO - Caixa de OPME
CME - Conjuntos de CME

*/

cd_equipamento_w 	NUMBER(15,0):=NULL;
CD_SETOR_AGENDA_W	NUMBER(15,0):=NULL;
ds_retorno_w		VARCHAR(4000):=NULL;

BEGIN

IF ie_opcao_p = 'E' THEN
	SELECT 	e.cd_equipamento
	--INTO	cd_equipamento_w
	FROM   	agenda_pac_equip e
	WHERE  	e.NR_SEQ_AGENDA = 135767786 --nr_seq_agenda_p
	and e. = 6;
	ds_retorno_w := cd_equipamento_w;
END IF;

IF ie_opcao_p = 'CSA' THEN
	SELECT	MAX(a.cd_setor)
	INTO	cd_setor_agenda_w
	FROM	(
		SELECT 	MAX(NVL(a.cd_setor_agenda,a.cd_setor_exclusivo)) cd_setor
		FROM	agenda a,
			agenda_consulta b
		WHERE	a.cd_agenda 	= b.cd_agenda
		AND	b.nr_sequencia 	= nr_seq_agenda_p
		UNION
		SELECT 	MAX(NVL(a.cd_setor_agenda,a.cd_setor_exclusivo))
		FROM	agenda a,
			agenda_paciente b
		WHERE	a.cd_agenda 	= b.cd_agenda
		AND	b.nr_sequencia 	= nr_seq_agenda_p
	)a;
	DS_RETORNO_W := CD_SETOR_AGENDA_W;
END IF;

RETURN	ds_retorno_w;

END hmdcc_obter_dados_agen_cirur;
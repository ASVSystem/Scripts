CREATE OR REPLACE FUNCTION hmdcc_obter_opme_cirurgia(
		nr_cirurgia_p	NUMBER)
	RETURN VARCHAR IS

ds_retorno_w		Varchar2(255);

BEGIN

if	( nr_seq_proced_nis_p is not null ) AND ie_opcao_p = 'D'then
	SELECT m.* FROM PRESCR_MATERIAL m
		JOIN PRESCR_MEDICA p
		ON m.nr_prescricao = p.nr_prescricao
	WHERE p.NR_CIRURGIA = 24438 --nr_cirurgia_p
	AND obter_estrutura_material(m.CD_MATERIAL,'G') IN (12,13)
	AND m.cd_motivo_baixa = 1;
end if;


RETURN ds_retorno_w;

END hmdcc_obter_opme_cirurgia;

--GRANT EXECUTE ON TASY.hmdcc_obter_opme_cirurgia TO ALEVICTOR;
--GRANT EXECUTE ON TASY.hmdcc_obter_opme_cirurgia TO DANISANTOS;
--GRANT EXECUTE ON TASY.hmdcc_obter_opme_cirurgia TO GHAS;
--
--SELECT convert_long_to_string('DS_ESPEC_TECNICA','MATERIAL_ESPEC_TECNICA','CD_MATERIAL=2365') FROM dual
--DS_ESPEC_TECNICA

SELECT
converte_rtf_string('select ds_espec_tecnica
			     from  material_espec_tecnica
			     where nr_sequencia = :nr_sequencia_p',e.nr_sequencia , 'avictor', call_java_ws('/br/com/wheb/funcoes/ConverteRTFOracle/converteRtfString',params))
FROM 
EVOLUCAO_PACIENTE E

WHERE NR_ATENDIMENTO = 564


CREATE OR REPLACE PROCEDURE converte_rtf_string (
    ds_sql_consulta_p VARCHAR2,
    ds_parametros_sql_p VARCHAR2,
    nm_usuario_p IN VARCHAR2,
    nr_sequencia_p IN OUT VARCHAR2
) IS
    params params_java_ws_pck.param_tab := params_java_ws_pck.param_tab();
    address VARCHAR2(255) := obter_valor_param_usuario(0,227,0,wheb_usuario_pck.get_nm_usuario,wheb_usuario_pck.get_cd_estabelecimento);
BEGIN
    IF (address IS NOT NULL) THEN
        params.extend;
        params(1).ds_key := 'sqlConsulta';
        params(1).ds_value := ds_sql_consulta_p;
        params.extend;
        params(2).ds_key := 'parametros';
        params(2).ds_value := ds_parametros_sql_p;
        params.extend;
        params(3).ds_key := 'nmUsuario';
        params(3).ds_value := nm_usuario_p;
        nr_sequencia_p := call_java_ws('/br/com/wheb/funcoes/ConverteRTFOracle/converteRtfString',params);
    ELSE
        converte_rtf_string_leg(ds_sql_consulta_p,ds_parametros_sql_p,nm_usuario_p,nr_sequencia_p);
    END IF;
END converte_rtf_string;
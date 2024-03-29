CREATE OR replace FUNCTION Hmdcc_med_obter_preco_estimado ( cd_material_p NUMBER,
                                                           nr_qt_media_p  NUMBER,
                                                           nr_meses_p     NUMBER )
  RETURN NUMBER
IS
  result_media_w NUMBER;
BEGIN
  SELECT avg(vl_unitario_material)
  INTO   result_media_w
  FROM   (
                  SELECT   vl_unitario_material
                  FROM     ordem_compra_item
                  WHERE    cd_material = cd_material_p
                  AND      obter_data_ordem_compra_dt(nr_ordem_compra, 'B') IS NULL
                  AND      months_between(SYSDATE, dt_aprovacao) <= nr_meses_p
                  AND      ROWNUM <= nr_qt_media_p
                  ORDER BY dt_atualizacao DESC);
  
  RETURN result_media_w;
  --dbms_output.put_line(result_media_w);
END hmdcc_med_obter_preco_estimado;

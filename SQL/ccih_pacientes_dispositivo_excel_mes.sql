SELECT
nm_paciente,
ds_setor,
ds_leito,
ds_dispositivo,
to_char(dt_ref_dispositivo,'MM') ds_mes,
sum(dias) dias_dispositivo

FROM
(
	SELECT DISTINCT
	TRUNC(a.dt_instalacao,'MONTH') dt_referencia,
	substr(obter_pessoa_atendimento(a.nr_atendimento,'N'),1,100) nm_paciente,
	a.nr_seq_dispositivo,
   substr(obter_desc_disp_cons(a.nr_sequencia),1,100) ds_dispositivo,
   TRUNC(a.dt_instalacao) dt_ref_dispositivo,
   u.cd_setor_atendimento,
   obter_desc_setor_atend(u.cd_setor_atendimento) ds_setor,
   u.cd_unidade_basica ds_leito,
       -- substr(obter_desc_topografia_dor(nr_seq_topografia),1,60) ds_topografia,
   -- substr(obter_valor_dominio(1372,ie_lado),1,10) ds_lado,
   -- trunc(dt_instalacao,'hh24') dt_instalacao1,
   -- trunc(dt_retirada,'hh24') dt_retirada,
   -- dt_instalacao,
   --nvl(to_char(dt_retirada, 'dd/mm/yyyy hh24:mi:ss'),'Sem Data Retirada') dt_retirada,
   --substr(obter_desc_motivo_disp(a.NR_SEQ_MOTIVO_RET),1,180)    ds_motivo_retirada,
   -- trunc(dt_retirada_prev,'hh24') dt_retirada_prev,
   --  a.nr_sequencia,
   -- a.nr_atendimento,
   -- substr(obter_hora_prev_ret_disp(a.nr_sequencia),1,40) qt_horas,
   -- substr(obter_valor_dominio(2085,obter_status_dispositivo(a.nr_sequencia,3)),1,20) ds_status,
   -- obter_status_dispositivo(a.nr_sequencia,3) status,
   --SUBSTR(OBTER_DADOS_DISPOSITIVO(A.NR_SEQUENCIA,'S'),1,100) ds_setor,    
   --(trunc(dt_retirada,'hh24') - trunc(dt_instalacao,'hh24'))*24 HORAS,
   --trunc(dt_retirada,'hh24') - trunc(dt_instalacao,'hh24') DIAS,
   round(nvl(to_date(dt_retirada), SYSDATE) - to_date(dt_instalacao)) dias --no mês/
	--to_date(dt_retirada ) - to_date(dt_instalacao) dias --no mês/ leito , considerar a movimentação para fazer a virada.


from    dispositivo b
left join    atend_pac_dispositivo a
	ON a.nr_seq_dispositivo = b.nr_sequencia
left join        atend_paciente_unidade u
	ON u.nr_atendimento = a.nr_atendimento
        
WHERE a.NR_ATENDIMENTO = 332256

--AND TRUNC(nvl(a.dt_retirada, sysdate),'MONTH') = TRUNC(a.dt_instalacao,'MONTH')
--AND TRUNC(nvl(a.dt_retirada, sysdate),'MONTH') = TRUNC(a.dt_instalacao,'MONTH')
--AND TRUNC(a.dt_instalacao,'MONTH') = TRUNC(u.dt_entrada_unidade,'MONTH')


AND u.cd_setor_atendimento IN (32,37,39)
AND  EXISTS (select (TRUNC(e.x) + level -1)  dt_ref_dispositivo
  		from (select min(a.dt_instalacao) x, max(nvl(a.dt_retirada,SYSDATE)) y
  			from atend_pac_dispositivo a where a.NR_ATENDIMENTO = 332256) e
  				connect by level <= ceil(y-x)+1 )

----and     SUBSTR(OBTER_DADOS_DISPOSITIVO(A.NR_SEQUENCIA,'CS'),1,100) in (32,39)
----and     ((a.nr_seq_dispositivo = :cd_dispositivo) or (:cd_dispositivo = 0))
----and     ((obter_setor_atendimento(a.nr_atendimento) = :cd_setor) or (:cd_setor = 0))
----and     (b.ie_classif_disp_niss IN (:cd_dispositivo_niss) or (:cd_dispositivo_niss = '0' ) )
----OBTER_DADOS_DISPOSITIVO(A.NR_SEQUENCIA,'CS') = u.cd_setor_atendimento
----and    decode('I','R',trunc(dt_retirada),'I',trunc(dt_instalacao)) between '01/11/2021' and fim_dia('05/11/2021')
----and    decode('I','R',trunc(dt_retirada),'I',trunc(dt_instalacao)) between '01/10/2021' and fim_dia('17/11/2021')
order by ds_setor, nm_paciente , dt_ref_dispositivo, cd_unidade_basica

)

GROUP BY to_char(dt_ref_dispositivo,'MM'), ds_setor, ds_leito,ds_dispositivo, nm_paciente
ORDER BY ds_leito
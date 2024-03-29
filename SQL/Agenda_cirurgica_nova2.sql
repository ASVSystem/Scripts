
select    a.nr_sequencia nr_seq_agenda,
          a.nm_paciente_pf  nm_pessoa_fisica,
OBTER_ESPECIALIDADE_MEDICO( a.CD_MEDICO,'D') ds_especialidade,
obter_valor_dominio(1016,ie_carater_cirurgia) ds_carater,
decode(a.IE_RESERVA_LEITO,'U','S','E','N','N','N','S','N') UTI,
nvl2((SELECT sum(s.QT_BOLSAS_SANGUE) FROM agenda_pac_sangue s WHERE a.nr_sequencia = s.nr_seq_agenda),'S','N') sangue,
nvl2((SELECT q.cd_equipamento FROM agenda_pac_equip q WHERE a.nr_sequencia = q.nr_seq_agenda AND q.cd_equipamento =1),'S','N') RX,
(SELECT nvl2(OBTER_LISTA_OPME_AGENDA(ao.nr_sequencia),'S','N') FROM agenda_paciente ao WHERE ao.nr_sequencia = a.nr_sequencia) opme,
(SELECT nvl2(max(NR_SEQ_TIPO_CAIXA_OPME),'S','N') FROM AGENDA_PAC_CAIXA_OPME ao WHERE ao.NR_SEQ_AGENDA = a.nr_sequencia) cx_opme,
a.*



from     agenda_paciente_v a

where      (a.cd_tipo_agenda         = 1)
and     a.ie_status_agenda        not in ('C','L','B')
and    (a.dt_agenda_dia        between sysdate-5 and sysdate )
AND (a.IE_STATUS_AGENDA     = 'PA' or 'PA' = 'N' ) 
--and     a.cd_agenda         = 51
--and     (a.cd_turno         = :cd_turno or :ie_turno = 'N' ) 
order by     a.ds_agenda, 
             a.hr_inicio


SELECT SYSDATE - (sysdate+365) FROM dual

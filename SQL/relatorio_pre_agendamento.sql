SELECT a.hr_inicio data_agenda,
a.ds_agenda,
a.ds_status_agenda status_agenda ,
(SELECT c.ds_motivo FROM agenda_motivo_cancelamento c where a.CD_MOTIVO_CANCELAMENTO = c.CD_MOTIVO) motivo_cancelamento,
          a.nm_paciente_pf  nm_pessoa_fisica,
OBTER_ESPECIALIDADE_MEDICO( a.CD_MEDICO,'D') ds_especialidade,
a.ds_procedimento,
obter_valor_dominio(1016,ie_carater_cirurgia) ds_carater,
decode(a.IE_RESERVA_LEITO,'U','S','E','N','N','N','S','N') UTI,
nvl2((SELECT sum(s.QT_BOLSAS_SANGUE) FROM agenda_pac_sangue s WHERE a.nr_sequencia = s.nr_seq_agenda),'S','N') sangue,
nvl2((SELECT q.cd_equipamento FROM agenda_pac_equip q WHERE a.nr_sequencia = q.nr_seq_agenda AND q.cd_equipamento =1),'S','N') RX,
(SELECT nvl2(OBTER_LISTA_OPME_AGENDA(ao.nr_sequencia),'S','N') FROM agenda_paciente ao WHERE ao.nr_sequencia = a.nr_sequencia) opme,
(SELECT nvl2(max(NR_SEQ_TIPO_CAIXA_OPME),'S','N') FROM AGENDA_PAC_CAIXA_OPME ao WHERE ao.NR_SEQ_AGENDA = a.nr_sequencia) cx_opme
--a.*



from     agenda_paciente_v a

where      a.ie_status_agenda        not in (
--'C',
'L',
'B')
and   (a.cd_tipo_agenda         = 1)  
and    a.dt_agenda_dia     BETWEEN '01/05/2021' AND '04/05/2021'
--and     a.cd_agenda         = :cd_agenda
--and     (a.cd_turno         = :cd_turno or :ie_turno = 'N' ) 
--and     (a.ie_status_agenda         = :ie_status or :ie_status = '0' )

order by     a.ds_agenda, 
    a.hr_inicio
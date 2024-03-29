select     a.*, a.nr_sequencia nr_seq_agenda,
          a.nm_paciente_pf  nm_pessoa_fisica,
OBTER_ESPECIALIDADE_MEDICO( a.CD_MEDICO,'D') ds_especialidade,
obter_valor_dominio(1016,ie_carater_cirurgia) ds_carater,
DECODE(a.IE_RESERVA_LEITO, 'U','S','N') UTI,    
            DECODE(GHAS_D_OBTER_PRE_AGEN_CIRURGIA(a.dt_agenda,a.cd_pessoa_fisica,'TEMPLATE','SANGUE'),'S','S','N') SANGUE,
        a.IE_CDI RX,
            DECODE(GHAS_OBTER_PRE_AGEN_CIRURGIA(a.dt_agenda,a.cd_pessoa_fisica,'AVALIACAO','OPME'),'S','S','N') OPME,


from     agenda_paciente_v a
where      (a.cd_tipo_agenda         = 1)
and     a.ie_status_agenda        not in ('C','L','B')
and    TRUNC(a.dt_agenda_dia)         = '21/05/2019'
--and     a.cd_agenda         = :cd_agenda
--and     (a.cd_turno         = :cd_turno or :ie_turno = 'N' ) 
order by     a.ds_agenda, 
    a.hr_inicio


GHAS_OBTER_PRE_AGEN_CIRURGIA
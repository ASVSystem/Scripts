select * from EHR_REGISTRO
where NR_ATENDIMENTO = 184840


/*Anamnese*/

select	obter_nome_medico(a.cd_profissional,'NCD') nm_medico,
                    'Assinatura Digital: '|| d.ds_hash_assinatura ds_hash
from	tasy_assinatura_digital d, anamnese_paciente a
where	a.NR_SEQUENCIA = 27330
and a.nr_seq_assinatura = d.nr_sequencia

/*Atestado*/

select	obter_nome_medico(a.cd_profissional,'NCD') nm_medico,
                    'Assinatura Digital: '|| d.ds_hash_assinatura ds_hash
from	tasy_assinatura_digital d, atestado_paciente a
where	a.nr_atendimento = 27330
and a.nr_seq_assinatura = d.nr_sequencia

/*Termo de Consentimento*/

select	obter_nome_medico(a.cd_profissional,'NCD') nm_medico,
                    'Assinatura Digital: '|| d.ds_hash_assinatura ds_hash
from	tasy_assinatura_digital d, PEP_PAC_CI a
where	a.NR_SEQUENCIA = 27330
and a.nr_seq_assinatura = d.nr_sequencia


SELECT * FROM prescr_procedimento
WHERE nr_prescricao =  713274

SELECT nr_prescricao FROM prescr_medica
WHERE nr_atendimento = 109243



UPDATE tasy.prescr_procedimento
SET cd_setor_atendimento = 40
WHERE nr_prescricao = 713274
AND nr_sequencia = 1
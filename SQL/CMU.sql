select	c.nm_paciente,
	c.nr_cirurgia,
	c.nr_prontuario,
	c.nr_prescricao,
	c.nr_atendimento,
	c.dt_inicio_prevista
	

	
from	cirurgia_v c
where	c.nr_cirurgia = 521
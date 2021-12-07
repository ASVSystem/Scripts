--CREATE OR REPLACE procedure atualiza_acomp_atend(nr_atendimento_p	number,
			       cd_categoria_p	number) is

cd_template_p	varchar2(10);
--ie_permite_acomp_p	varchar2(255);
begin

if	(nvl(nr_atendimento_p,0) > 0)  then

	select	max(cd_pessoa_fisica)
	into	cd_pessoa_fisica_p
	from	atendimento_paciente
	where	nr_atendimento = nr_atendimento_p;

	select	obter_se_permite_acomp(cd_pessoa_fisica_p,nvl(cd_convenio_p,0))
	into	ie_permite_acomp_p
	from 	dual;

	if	(ie_permite_acomp_p <> 'XPTO') then

		update	atendimento_paciente
		set	ie_permite_acomp = ie_permite_acomp_p
		where	nr_atendimento = nr_atendimento_p;
	end if;
end if;

commit;

end atualiza_acomp_atend;

--  100758
-- 100759
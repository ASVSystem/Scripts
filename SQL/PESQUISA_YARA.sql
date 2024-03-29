CREATE OR REPLACE VIEW hmdcc_estudo_perfil_paciente(

-- //Identificação, variáveis demográficas e comorbidades
prontuario --Número do prontuário
sexo,
data_nascimento,--Data de nascimento
dt_entrada_uti,--Data de admissão na UTI
ie_gestante --Gestante ou não
ie_vacinado_covid --Vacinação prévia contra covid-19
ds_vacina --Se sim, qual vacina
---------//Comorbidades/doença crônica---------------------------------------
ds_resultado_charlson --Índice de comorbidade  de Charlson
ie_infarto_previo --História de infarto prévio
ie_insuficiencia_cardiaca --Insuficiência cardíaca
Doença arterial periférica
AVC prévio (acidente vascular cerebral)
AIT prévio (ataque isquemico transitório)
Demencia 
DPOC
Doença do tecido conjuntivo
Doença ulcerosa péptica
Cirrose com hemorragia digestiva prévia por varizes
Cirrose com hipertensão portal, sem hemorragia prévia
Cirrose sem hipertensão portal
Hepatite crônica
Diabetes
Hemiplegia
Hemodiálise ou diálise peritoneal prévias
Neoplasia de órgão sólido sem metástases
Neoplasia de órgão sólido sem metástases
Leucemia
Linfoma
SIDA
Hipertensão arterial sistêmica
Doença arterial coronariana (inclui história de angina, angioplastia o cirurgia de revascularização prévia, ou infarto prévio)
Fibrilação atrial ou flutter
Obesidade (IMC > 30) ou IMC (índice de massa corporal)
ie_tabagismo,--Tabagismo
-------------//Uso contínuo de medicamentos-----------------------------
Anti-inflamatório não hormonal
Amiodarona
Anticoagulante oral
Betabloqueador
Bloqueador de canal de cálcio
Corticoide inalatório
Corticoide oral
Digitálico
Diurético de alça
Diurético poupador de potássio
Diurético tiazídico
Hipoglicemiante (não insulina)
Estatina
Imunossupressor
Inibidor de ECA ou BRA
Insulina
Outro medicamento: qual?
--//Características clínicas à admissão na UTI
Tipo de admissão (cirúrgica eletiva, clínica ou cirúrgica não-eletiva)
Escala de coma de Glasgow/nível de consciência
Temperatura 
Frequência cardíaca
Frequência respiratória
Saturação periférica de O2
Pressão arterial sistólica
Pressão arterial diastólica
Pressão arterial invasiva (se for o caso)
Uso de noradrenalina (sim/não e dose)
Uso de dopamina (sim/não e dose)
Uso de dobutamina (sim/não e dose)
Uso de oxigênio suplementar (sim/não)
Uso de cateter nasal (sim/não e fluxo)
Uso de máscara facial (sim/não e fluxo)
Necessidade de ventilação mecânica (sim/não e FiO2)
FiO2
Débito urinário (volume urinário registrado nas primeiras 12h na UTI)
--/Exames laboratoriais do dia da admissão em UTI (se houver 2 exames, considerar o 1o)
ALT (alanino aminotransferase)
AST (aspartato aminotransferase)
Bicarbonato (gasometrial arterial)
Bilirrubinas
BNP
Creatinina
Creatinofosfoquinase
D-dímero
Ferritina
Global de leucócitos
Hemoglobina
Lactato
Lactato desidrogenase (LDH)
Linfócitos
Método de confirmação de Covid-19
Neutrófilos
NT-pro BNP
Plaquetas
Potássio
Pressão parcial de oxigênio (PaO2)
Sódio
Proteína C reativa
Sódio
Troponina
PTTA (trompo parcial de tromboplastina ativada)
RNI
Ureia
--//Medicamentos de uso até admissão na UTI
Dexametasona
Prednisona
Prednisolona
Budesonida inalatória
Beblometasona inalatória
Tocilizumabe
Outro: qual?
--//Intercorrências durante internação/cti
Choque séptico
Coagulação intravascular disseminada
IC aguda (nova ou crônica descompensada)
Infecção nosocomial
Infarto agudo do miocárdio
Miocardite
Hemorragia
Hiperglicemia
Síndrome de angústia respiratória do adulto
Trombose vascular
Outra. Qual?
Qual tipo de evento tromboembólico? (TVP, TEP, trombose arterial)
--//Desfechos
Houve necessidade de ventilação mecânica?
Houve necessidade de terapia renal substitutiva (diálise)?
Óbito 
//Variáveis do escore SAPS 3, que já é calculado na unidade

) AS
SELECT 
nr_prontuario,
ie_sexo

FROM ATENDIMENTO_PACIENTE_V v

WHERE v.nr_atendimento > 33000
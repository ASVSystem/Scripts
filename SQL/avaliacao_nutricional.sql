SELECT NR_ATENDIMENTO,
QT_PESO_ATUAL,
QT_ALTURA,
QT_IMC,
TO_CHAR(PR_CIRC_BRACO,'999999D99MI','NLS_NUMERIC_CHARACTERS = '',.''') CIRC_BRACO,
nvl(obter_result_cb(pr_circ_braco),'Não Informado') diag_nutricional,
obter_desc_imc(qt_imc,qt_idade,qt_ig_semana) imc 

FROM AVAL_NUTRICAO
WHERE DT_AVALIACAO BETWEEN '01/03/2020' AND fim_dia('30/09/2020')
--AND NR_ATENDIMENTO = 255817
--AND QT_PESO_ATUAL > 150



datasetCTI = "/content/drive/MyDrive/dados_to/consolidado.xlsx"
datasetCTI = pd.read_excel(datasetCTI , index_col=0)

### Retirando espaços dos nomes de colunas
colsCTI = datasetCTI.columns
colsCTI = colsCTI.map(lambda x: x.replace(' ','_') if isinstance(x, (str)) else x)
datasetCTI.columns = colsCTI
#### Dataframe com dados somente do CTI
datasetCTI = datasetCTI.query('SETOR_ATENDIMENTO in ["CTI Terreo","CTI 4° Andar","CTI 2° Andar"]')
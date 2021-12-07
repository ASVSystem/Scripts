
SELECT count(*) qt_mat, obter_desc_classe_mat(cd_classe_material) ds_classe, cd_classe_material
FROM MATERIAL
WHERE obter_estrutura_material(cd_material, 'G') IN (15,13)
AND IE_SITUACAO = 'A'
GROUP BY cd_classe_material
ORDER BY 1


--CD_MATERIAL,cd_classe_material, ltrim(obter_desc_material(cd_material),' ') ds_material

12, ' Placas em T ou L de 4,5 '
2, 'Âncora Montada'
11, 'Âncora Montada'
55, 'Artroscopia de Joelho'
5, 'Cimento c/ Antibiótico'
3, 'Cimento s/ Antibiótico'
1, 'Cirurgia Geral'
27, 'CIRURGIA VASCULAR'
30, 'Cirurgia Vascular'
11, 'Comum'
62, 'Endoscopia'
19, 'Fio Liso'
26, 'Fixadores Externos'
109, 'Grandes Fragmentos'
73, 'Grandes Fragmentos'
431, 'Hastes Especiais'
359, 'Materiais Consignados '
1, 'Materiais Implantes'
22, 'Material comun'
22, 'Material Especial'
163, 'Mini Micro Fragmentos'
125, 'NEUROCIRURGIA'
39, 'Neurocirurgia'
14, 'Neurologia'
1, 'Neurologia'
93, 'Ortopedia'
121, 'Parafuso Canulado'
29, 'Parafuso Canulado 3.5'
30, 'Parafuso Canulado 4,5'
35, 'Parafuso Canulado 7,0'
159, 'Pequenos Fragmentos'
159, 'Placa Tubo - Richard'
372, 'Placas Bloqueadas'
24, 'Protese'
204, 'Prótese de Joelho'
41, 'Prótese de Ombro'
244, 'Prótese de Quadril'
4, 'Prótese de Rádio'
16, 'Urologia'
1, 'Urologia'
2, 'VASCULAR'
3, 'Vascular'
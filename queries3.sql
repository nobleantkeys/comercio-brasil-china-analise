SELECT *
FROM V_EXPORTACAO_E_IMPORTACAO_GERAL_CLEAN

--=========================================================
-- Análise de Comércio Brasil x China (2020-2025)
-- Fonte: ComexStat
--=========================================================

--Quais foram as maiores exportações pra China?

SELECT TOP 10 Descrição_SH6, SUM(Valor_US_FOB) AS Total_FOB
FROM V_EXPORTACAO_E_IMPORTACAO_GERAL_CLEAN
WHERE Países = 'China' AND Fluxo = 'Exportação' 
GROUP BY Descrição_SH6
ORDER BY Total_FOB DESC
--1. Soja, 2. Minério de Ferro, 3. Óleos brutos

--=========================================================

-- Quais foram as maiores importações do Brasil?

SELECT TOP 10 Descrição_SH6, SUM(Valor_US_FOB) AS Total_FOB
FROM V_EXPORTACAO_E_IMPORTACAO_GERAL_CLEAN
WHERE Países = 'China' AND Fluxo = 'Importação'
GROUP BY Descrição_SH6
ORDER BY Total_FOB DESC
--1. Células fotovoltaicas, 2. Herbicidas, 3. Conversores elétricos
--=========================================================

--Qual foi o ano com mais comércio?

SELECT SUM(Valor_US_FOB) AS Total_Comércio, Ano
FROM V_EXPORTACAO_E_IMPORTACAO_GERAL_CLEAN
GROUP BY Ano
ORDER BY Total_Comércio DESC
--2025

--=========================================================

--Calculando Saldo de Importações x Exportações 

SELECT Ano,
    SUM(CASE WHEN Fluxo = 'Exportação' THEN Valor_US_FOB ELSE 0 END) AS Exportações,
    SUM(CASE WHEN Fluxo = 'Importação' THEN Valor_US_FOB ELSE 0 END) AS Importações,
    SUM(CASE WHEN Fluxo = 'Exportação' THEN Valor_US_FOB ELSE -Valor_US_FOB END) AS Saldo
FROM [V_EXPORTACAO_E_IMPORTACAO_GERAL_CLEAN]
WHERE Países = 'China'
GROUP BY Ano
ORDER BY Ano
--2025 teve o maior volume, Brasil teve superávit em todos os anos

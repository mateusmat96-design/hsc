-- ============================================
-- Título: Backup de Tabela
-- Descrição: Cria uma cópia de backup de uma tabela específica
-- Autor: Sistema HSC
-- Data: 2026-01-14
-- Última modificação: 2026-01-14
-- ============================================
-- Uso: 
--   1. Substitua [NOME_TABELA] pelo nome da tabela a ser copiada
--   2. Substitua [DATA] pela data no formato YYYYMMDD
--   3. O backup será criado com o sufixo _BKP_YYYYMMDD
-- 
-- Exemplo:
--   Para tabela CLIENTES em 14/01/2026:
--   CREATE TABLE CLIENTES_BKP_20260114 AS SELECT * FROM CLIENTES;
--
-- Nota: 
--   Verifique espaço disponível antes de executar
--   Considere usar NOLOGGING para tabelas grandes
-- ============================================

-- Criar backup da tabela
CREATE TABLE [NOME_TABELA]_BKP_[DATA] AS 
SELECT * FROM [NOME_TABELA];

-- Verificar quantidade de registros
SELECT 
    '[NOME_TABELA]' AS tabela_original,
    COUNT(*) AS qtd_registros
FROM [NOME_TABELA]
UNION ALL
SELECT 
    '[NOME_TABELA]_BKP_[DATA]' AS tabela_backup,
    COUNT(*) AS qtd_registros
FROM [NOME_TABELA]_BKP_[DATA];

-- Adicionar comentário na tabela de backup
COMMENT ON TABLE [NOME_TABELA]_BKP_[DATA] IS 
'Backup criado em ' || TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS');

-- ============================================
-- Título: Auditoria de Alterações em Tabela
-- Descrição: Rastreia modificações recentes em uma tabela específica
-- Autor: Sistema HSC
-- Data: 2026-01-14
-- Última modificação: 2026-01-14
-- ============================================
-- Uso: 
--   Substitua [NOME_TABELA] pela tabela a ser auditada
--   Ajuste o período conforme necessário (:dias_anteriores)
-- 
-- Exemplo:
--   Para verificar alterações nos últimos 7 dias na tabela USUARIOS:
--   :dias_anteriores = 7
--
-- Nota: 
--   Requer que auditoria esteja habilitada na tabela
--   Acessa a view DBA_AUDIT_TRAIL
-- ============================================

SELECT 
    timestamp,
    username,
    action_name,
    obj_name,
    sql_text,
    os_username,
    userhost,
    returncode
FROM 
    dba_audit_trail
WHERE 
    obj_name = '[NOME_TABELA]'
    AND timestamp >= TRUNC(SYSDATE) - :dias_anteriores
    AND action_name IN ('INSERT', 'UPDATE', 'DELETE', 'ALTER', 'DROP')
ORDER BY 
    timestamp DESC;

-- Resumo de operações por usuário
SELECT 
    username,
    action_name,
    COUNT(*) AS quantidade_operacoes,
    MIN(timestamp) AS primeira_operacao,
    MAX(timestamp) AS ultima_operacao
FROM 
    dba_audit_trail
WHERE 
    obj_name = '[NOME_TABELA]'
    AND timestamp >= TRUNC(SYSDATE) - :dias_anteriores
GROUP BY 
    username,
    action_name
ORDER BY 
    quantidade_operacoes DESC;

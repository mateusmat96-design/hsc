-- ============================================
-- Título: Análise de Índices Não Utilizados
-- Descrição: Identifica índices que não estão sendo utilizados
-- Autor: Sistema HSC
-- Data: 2026-01-14
-- Última modificação: 2026-01-14
-- ============================================
-- Uso: 
--   Execute para identificar índices candidatos à remoção
--   Considere remover índices não utilizados para melhorar performance de DML
-- 
-- Nota: 
--   Requer acesso a views DBA_ ou V$
--   Considere o histórico de uso antes de remover índices
-- ============================================

SELECT 
    i.owner,
    i.index_name,
    i.table_name,
    i.uniqueness,
    s.bytes/1024/1024 AS tamanho_mb,
    i.last_analyzed,
    i.num_rows
FROM 
    dba_indexes i
    LEFT JOIN dba_segments s ON i.owner = s.owner 
                             AND i.index_name = s.segment_name
WHERE 
    i.owner NOT IN ('SYS', 'SYSTEM', 'OUTLN', 'DBSNMP')
    AND i.index_name NOT IN (
        SELECT index_name 
        FROM v$object_usage 
        WHERE used = 'YES'
    )
    AND i.status = 'VALID'
ORDER BY 
    s.bytes DESC NULLS LAST;

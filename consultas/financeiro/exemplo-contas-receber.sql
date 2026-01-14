-- ============================================
-- Título: Análise de Contas a Receber
-- Descrição: Relatório de valores a receber por faixa de vencimento
-- Autor: Sistema HSC
-- Data: 2026-01-14
-- Última modificação: 2026-01-14
-- ============================================
-- Uso: 
--   Execute esta query para visualizar o aging de contas a receber
--   Agrupa por faixas: vencidas, vencendo em 30/60/90 dias
-- 
-- Nota: 
--   Considera apenas contas com status PENDENTE ou PARCIAL
-- ============================================

SELECT 
    CASE 
        WHEN c.data_vencimento < TRUNC(SYSDATE) THEN 'VENCIDO'
        WHEN c.data_vencimento BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + 30 THEN '0-30 DIAS'
        WHEN c.data_vencimento BETWEEN TRUNC(SYSDATE) + 31 AND TRUNC(SYSDATE) + 60 THEN '31-60 DIAS'
        WHEN c.data_vencimento BETWEEN TRUNC(SYSDATE) + 61 AND TRUNC(SYSDATE) + 90 THEN '61-90 DIAS'
        ELSE 'ACIMA 90 DIAS'
    END AS faixa_vencimento,
    COUNT(*) AS quantidade_titulos,
    SUM(c.valor_total - NVL(c.valor_pago, 0)) AS valor_total_aberto,
    MIN(c.data_vencimento) AS vencimento_mais_antigo,
    MAX(c.data_vencimento) AS vencimento_mais_recente
FROM 
    contas_receber c
WHERE 
    c.status IN ('PENDENTE', 'PARCIAL')
    AND c.valor_total > NVL(c.valor_pago, 0)
GROUP BY 
    CASE 
        WHEN c.data_vencimento < TRUNC(SYSDATE) THEN 'VENCIDO'
        WHEN c.data_vencimento BETWEEN TRUNC(SYSDATE) AND TRUNC(SYSDATE) + 30 THEN '0-30 DIAS'
        WHEN c.data_vencimento BETWEEN TRUNC(SYSDATE) + 31 AND TRUNC(SYSDATE) + 60 THEN '31-60 DIAS'
        WHEN c.data_vencimento BETWEEN TRUNC(SYSDATE) + 61 AND TRUNC(SYSDATE) + 90 THEN '61-90 DIAS'
        ELSE 'ACIMA 90 DIAS'
    END
ORDER BY 
    CASE faixa_vencimento
        WHEN 'VENCIDO' THEN 1
        WHEN '0-30 DIAS' THEN 2
        WHEN '31-60 DIAS' THEN 3
        WHEN '61-90 DIAS' THEN 4
        ELSE 5
    END;

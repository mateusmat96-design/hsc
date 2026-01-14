-- ============================================
-- Título: Relatório de Vendas por Período
-- Descrição: Consulta vendas totalizadas por período específico
-- Autor: Sistema HSC
-- Data: 2026-01-14
-- Última modificação: 2026-01-14
-- ============================================
-- Uso: 
--   Execute esta query substituindo :data_inicio e :data_fim
--   pelas datas desejadas no formato DD-MM-YYYY
-- 
-- Exemplo:
--   :data_inicio = '01-01-2026'
--   :data_fim = '31-01-2026'
--
-- Nota: 
--   Esta query usa índices nas colunas DATA_VENDA e ID_PRODUTO
--   Performance otimizada para períodos de até 12 meses
-- ============================================

SELECT 
    TO_CHAR(v.data_venda, 'YYYY-MM') AS mes_ano,
    p.nome_produto,
    COUNT(*) AS quantidade_vendas,
    SUM(v.valor_total) AS valor_total,
    AVG(v.valor_total) AS ticket_medio
FROM 
    vendas v
    INNER JOIN produtos p ON v.id_produto = p.id_produto
WHERE 
    v.data_venda BETWEEN TO_DATE(:data_inicio, 'DD-MM-YYYY') 
                     AND TO_DATE(:data_fim, 'DD-MM-YYYY')
    AND v.status = 'CONCLUIDA'
GROUP BY 
    TO_CHAR(v.data_venda, 'YYYY-MM'),
    p.nome_produto
ORDER BY 
    mes_ano DESC,
    valor_total DESC;

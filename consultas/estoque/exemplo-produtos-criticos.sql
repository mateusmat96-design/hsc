-- ============================================
-- Título: Produtos com Estoque Crítico
-- Descrição: Lista produtos com quantidade abaixo do estoque mínimo
-- Autor: Sistema HSC
-- Data: 2026-01-14
-- Última modificação: 2026-01-14
-- ============================================
-- Uso: 
--   Execute esta query para verificar produtos que precisam
--   de reposição urgente
-- 
-- Nota: 
--   Considera apenas produtos ativos
--   Ordena por criticidade (menor estoque primeiro)
-- ============================================

SELECT 
    p.codigo_produto,
    p.nome_produto,
    p.categoria,
    e.quantidade_atual,
    p.estoque_minimo,
    (p.estoque_minimo - e.quantidade_atual) AS deficit,
    ROUND(((p.estoque_minimo - e.quantidade_atual) / p.estoque_minimo * 100), 2) AS percentual_deficit
FROM 
    produtos p
    INNER JOIN estoque e ON p.id_produto = e.id_produto
WHERE 
    p.status = 'ATIVO'
    AND e.quantidade_atual < p.estoque_minimo
ORDER BY 
    percentual_deficit DESC,
    deficit DESC;

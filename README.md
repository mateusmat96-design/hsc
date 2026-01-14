# HSC - Arquivo de SQLs Oracle

Repositório para arquivar e organizar queries SQL chaves do negócio.

## 📁 Estrutura do Repositório

```
├── consultas/          # Queries de consulta e análise
│   ├── vendas/        # Consultas relacionadas a vendas
│   ├── estoque/       # Consultas de estoque e inventário
│   ├── financeiro/    # Consultas financeiras
│   ├── relatorios/    # Queries para relatórios gerenciais
│   └── manutencao/    # Consultas de manutenção de dados
├── scripts/           # Scripts de automação e manutenção
│   ├── backup/        # Scripts de backup
│   ├── otimizacao/    # Scripts de otimização e performance
│   └── auditoria/     # Scripts de auditoria
└── templates/         # Templates de queries reutilizáveis
```

## 🚀 Como Usar

### Adicionar uma Nova Query

1. Identifique a categoria apropriada (consultas, scripts, templates)
2. Crie um arquivo `.sql` com nome descritivo
3. Use o padrão de nomenclatura: `descricao-acao.sql`
4. Adicione comentários explicativos no início do arquivo

### Padrão de Nomenclatura

- Use letras minúsculas
- Separe palavras com hífen (-)
- Seja específico e descritivo
- Exemplos:
  - `vendas-mensal-por-produto.sql`
  - `estoque-produtos-criticos.sql`
  - `backup-tabela-clientes.sql`

### Exemplo de Estrutura de Arquivo SQL

```sql
-- ============================================
-- Título: [Nome descritivo da query]
-- Descrição: [O que a query faz]
-- Autor: [Seu nome]
-- Data: [YYYY-MM-DD]
-- Última modificação: [YYYY-MM-DD]
-- ============================================
-- Uso: [Como usar esta query, parâmetros necessários]
-- Nota: [Observações importantes]
-- ============================================

SELECT ...
FROM ...
WHERE ...;
```

## 📝 Boas Práticas

1. **Documente suas queries**: Sempre adicione comentários explicando o propósito
2. **Use nomes descritivos**: Facilita encontrar queries específicas
3. **Teste antes de commitar**: Valide a query em ambiente de desenvolvimento
4. **Versionamento**: Mantenha histórico de mudanças importantes nos comentários
5. **Segurança**: NUNCA commite senhas ou credenciais

## ⚠️ Atenção

- Não commite dados sensíveis (senhas, conexões, dados pessoais)
- Sempre use variáveis bind para queries parametrizadas
- Valide queries em ambiente de teste antes de usar em produção

## 🔧 Ferramentas Recomendadas

- Oracle SQL Developer
- DBeaver
- SQL*Plus
- Toad for Oracle

## 📞 Suporte

Para dúvidas ou sugestões sobre a organização deste repositório, abra uma issue.

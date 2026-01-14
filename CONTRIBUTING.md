# Guia de Contribuição

## Como Contribuir com o Repositório

Obrigado por contribuir com o repositório HSC! Este guia vai ajudá-lo a adicionar suas queries SQL de forma organizada.

## 📋 Antes de Adicionar uma Query

1. Verifique se já não existe uma query similar no repositório
2. Teste sua query em ambiente de desenvolvimento/homologação
3. Certifique-se de que não há dados sensíveis (senhas, IDs reais, etc.)
4. Documente adequadamente o propósito e uso da query

## 📝 Padrões de Documentação

Toda query deve incluir um cabeçalho com:

```sql
-- ============================================
-- Título: [Nome claro e descritivo]
-- Descrição: [O que a query faz em detalhes]
-- Autor: [Seu nome ou equipe]
-- Data: [Data de criação YYYY-MM-DD]
-- Última modificação: [Data da última modificação]
-- ============================================
-- Uso: 
--   [Instruções passo a passo de como usar]
--   [Parâmetros necessários]
-- 
-- Exemplo:
--   [Exemplo prático de uso]
--
-- Nota: 
--   [Observações sobre performance, dependências, etc.]
-- ============================================
```

## 📂 Estrutura de Diretórios

### consultas/
Queries de leitura e análise de dados:
- **vendas/**: Análises e relatórios de vendas
- **estoque/**: Consultas de inventário e estoque
- **financeiro/**: Queries financeiras (contas a pagar/receber, fluxo de caixa)
- **relatorios/**: Relatórios gerenciais e dashboards
- **manutencao/**: Queries para manutenção de dados

### scripts/
Scripts de automação e manutenção do banco:
- **backup/**: Scripts de backup e restore
- **otimizacao/**: Scripts de otimização e tuning
- **auditoria/**: Scripts de auditoria e monitoramento

### templates/
Templates reutilizáveis para criar novas queries

## ✅ Checklist de Qualidade

Antes de commitar, verifique:

- [ ] Query está testada e funcionando
- [ ] Documentação completa no cabeçalho
- [ ] Nomes de variáveis e tabelas estão claros
- [ ] Não há hardcoding de valores que deveriam ser parâmetros
- [ ] Não há dados sensíveis (senhas, dados pessoais)
- [ ] Indentação e formatação estão consistentes
- [ ] Query está no diretório correto
- [ ] Nome do arquivo segue o padrão (minúsculas, hífens)

## 🚫 O Que Não Fazer

- ❌ Não commite senhas ou strings de conexão
- ❌ Não commite dados reais de clientes ou informações sensíveis
- ❌ Não use SELECT * em produção (especifique as colunas)
- ❌ Não crie queries sem documentação
- ❌ Não adicione arquivos binários ou logs

## 🔄 Processo de Commit

1. Adicione sua query no diretório apropriado
2. Use mensagem de commit descritiva:
   - `feat: adiciona query de análise de vendas por região`
   - `fix: corrige filtro de data na query de estoque`
   - `docs: atualiza documentação da query financeira`
3. Faça push das suas alterações

## 💡 Dicas

- Use variáveis bind (`:variavel`) para valores parametrizados
- Prefira JOINs explícitos ao invés de WHERE para relacionamentos
- Adicione comentários em lógicas complexas
- Use nomes significativos para aliases
- Considere performance ao criar queries complexas

## 🤝 Revisão

Queries críticas devem ser revisadas por outro membro da equipe antes do commit em produção.

## 📞 Dúvidas

Se tiver dúvidas sobre onde colocar uma query ou como documentá-la, abra uma issue ou consulte a equipe.

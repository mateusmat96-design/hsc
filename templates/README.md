# Templates

Este diretório contém templates reutilizáveis para criar novas queries SQL.

## 📋 Templates Disponíveis

### template-consulta.sql
Template base para criar novas queries de consulta.

Inclui:
- Estrutura de documentação padrão
- Seções para descrição e uso
- Exemplo de query SELECT básica
- Comentários explicativos

## 💡 Como Usar um Template

1. Copie o template apropriado
2. Renomeie o arquivo com um nome descritivo
3. Preencha todas as seções de documentação:
   - Título
   - Descrição
   - Autor
   - Data
   - Instruções de uso
   - Exemplos
   - Notas importantes
4. Substitua a query de exemplo pela sua query real
5. Teste a query em ambiente de desenvolvimento
6. Mova o arquivo para o diretório apropriado (consultas/ ou scripts/)

## 📝 Exemplo de Uso

```bash
# Copiar template
cp templates/template-consulta.sql consultas/vendas/vendas-trimestre.sql

# Editar arquivo
# ... adicionar sua query ...

# Testar a query

# Commitar
git add consultas/vendas/vendas-trimestre.sql
git commit -m "feat: adiciona query de vendas por trimestre"
```

## ✅ Benefícios

- **Consistência**: Todas as queries seguem o mesmo padrão
- **Documentação**: Não esquece nenhum campo importante
- **Rapidez**: Economiza tempo na criação de novas queries
- **Qualidade**: Garante que informações essenciais estão presentes

## 🔄 Melhoria Contínua

Se você criar um tipo de query que se repete frequentemente, considere criar um novo template específico para esse caso.

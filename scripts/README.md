# Scripts

Este diretório contém scripts SQL para automação, manutenção e administração do banco de dados Oracle.

## 📁 Subdiretórios

### backup/
Scripts para backup e restore:
- Backup de tabelas específicas
- Export de dados
- Restore de backups
- Validação de backups

### otimizacao/
Scripts para melhorar performance do banco:
- Análise de índices
- Estatísticas de tabelas
- Identificação de queries lentas
- Tuning de SQL
- Rebuild de índices fragmentados

### auditoria/
Scripts de auditoria e monitoramento:
- Rastreamento de alterações
- Logs de acesso
- Monitoramento de uso de recursos
- Análise de segurança

## 💡 Como Usar

1. Navegue até o subdiretório apropriado
2. Leia cuidadosamente a documentação do script
3. **IMPORTANTE**: Scripts de manutenção devem ser executados com cautela
4. Sempre faça backup antes de executar scripts que modificam dados
5. Teste em ambiente de desenvolvimento primeiro

## ⚠️ Atenção Especial

Estes scripts podem:
- Modificar estruturas de banco de dados
- Alterar dados
- Consumir recursos significativos
- Afetar performance do sistema

**Recomendações:**
- Execute fora do horário de pico
- Obtenha aprovação antes de executar em produção
- Monitore o progresso da execução
- Tenha um plano de rollback

## 🔐 Permissões

Muitos scripts neste diretório requerem privilégios elevados no banco de dados:
- DBA role
- Acesso a views DBA_* e V$*
- Permissões de DDL (para scripts de otimização)

Certifique-se de ter as permissões necessárias antes de executar.

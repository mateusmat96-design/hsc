# Relatórios SQL do EBS

Este diretório contém consultas SQL para análises em módulos AR, PO, AP e esquema customizado CLL do Oracle E-Business Suite.

## 1) cm_tx_li_report.sql
- Objetivo: relacionar linhas de NF (item), linhas de Imposto e a Reversão (nota de crédito/CM) correspondente.
- Esquemas/Tabelas: `apps.ra_customer_trx_all`, `apps.ra_customer_trx_lines_all`, `apps.ra_cust_trx_types_all`, `apps.ar_vat_tax_all`, `apps.mtl_system_items`.
- Estrutura: 3 CTEs
  - `CM_TAB`: linhas de imposto de CM (`ratyp.TYPE = 'CM'`, `line_type = 'TAX'`)
  - `TX_TAB`: linhas de imposto de NF (`ratyp.TYPE = 'INV'`, `line_type = 'TAX'`)
  - `LI_TAB`: linhas de item da NF (`ratyp.TYPE = 'INV'`, `line_type = 'LINE'`)
- Junções chave:
  - `TX_TAB.customer_trx_line_id = CM_TAB.previous_customer_trx_line_id`
  - `TX_TAB.link_to_cust_trx_line_id = LI_TAB.customer_trx_line_id`
- Filtros:
  - `cm_tab.creation_date > To_Date('01122025','DDMMYYYY')`
  - Opcional: filtrar por número da NF (`-- AND LI_TAB.trx_number = '4270'`).
- Observação: usa o operador de outer join legado `(+)` compatível com versões Oracle antigas.

## 2) open_po_bpa_report.sql
- Objetivo: listar POs aprovadas e atributos de linhas, itens e BPAs vinculados à PO.
- Esquemas/Tabelas: `PO_HEADERS_ALL`, `PO_LINES_ALL`, `PO_LINE_LOCATIONS_ALL`, `PO_DISTRIBUTIONS_ALL`, `INV.MTL_SYSTEM_ITEMS_B`.
- Filtro inicial (CTE `hdr`):
  - `org_id = 4361`
  - `authorization_status = 'APPROVED'`
  - Período: `approved_date` entre `2025-12-01` e `2026-01-01`
  - `creation_date >= 2025-11-01`
- Junções:
  - Item vinculando `inventory_item_id` e `organization_id` via `NVL(plla.ship_to_organization_id, pda.destination_organization_id)`
  - BPA via `pla.from_header_id`/`pla.from_line_id`
- Observação: se desejar apenas "POs em aberto" (saldo não totalmente recebido/fechadas), incluir critérios adicionais (ex.: `plla.shipment_closed_code IS NULL` e verificação de saldo recebido vs. solicitado).

## 3) vendor_cnpj_lookup.sql
- Objetivo: buscar fornecedores pelo CNPJ (concatenado de atributos globais do site).
- Esquemas/Tabelas: `ap.ap_suppliers`, `ap.ap_supplier_sites_all`.
- Lógica:
  - `cnpj_com_zeros = global_attribute10 || global_attribute11 || global_attribute12`
  - `cnpj` sem zero à esquerda via `REGEXP_REPLACE(..., '^0(?=\\d{14}$)', '')`
- Filtros:
  - `ss.org_id IN (4361, 8121)`
  - Lista de CNPJs a ser fornecida no `IN` (inclua valores com zero à esquerda quando aplicável).

## 4) purchase_summary_period.sql
- Objetivo: resumo de compras (últimos 12 meses) com cabeçalhos, linhas, itens e tipos de nota.
- Esquemas/Tabelas: `CLL.CLL_F189_INVOICE_LINES`, `CLL.CLL_F189_INVOICES`, `INV.MTL_SYSTEM_ITEMS_B`, `CLL.CLL_F189_INVOICE_TYPES#`, `CLL.CLL_F189_FISCAL_ENTITIES_ALL`, `CLL.CLL_F189_BUSINESS_VENDORS`.
- Filtros:
  - Período: `cfi.invoice_date >= ADD_MONTHS(TRUNC(SYSDATE), -12)`
  - Tipos de nota: `it.invoice_type_code IN ('E003','E004','E008')`
  - Entidade de negócio: 
    - `business_code IN ('INDUSTRIAL','COMERCIAL','CONTRIBUINTE DO ICMS','VAREJISTA')`
    - ou `business_code LIKE '%SIMPLES%'` (para correspondência parcial).
- Saída: inclui `cfli.*` (detalhes da linha), `segment1` e `description` do item, `invoice_type_code`, e campos do cabeçalho (`INVOICE_NUM`, `invoice_date`).

## Requisitos/Execução
- Executar com privilégios de leitura nos esquemas indicados (APPS/PO/INV/CLL).
- Para ambientes com padrões locais, verifique NLS e permissões.
- Ajuste datas/organizações conforme necessário.
- Para performance, considere índices nas colunas usadas em filtros/junções.

## Observações
- Alguns scripts usam sintaxe antiga de join Oracle `(+)` por compatibilidade.
- Em `vendor_cnpj_lookup.sql`, forneça os CNPJs na lista `IN` ao executar.
- Em `open_po_bpa_report.sql`, adapte critérios para "aberto" conforme regras de negócio locais.

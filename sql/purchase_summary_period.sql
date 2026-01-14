SELECT
  cfi.INVOICE_NUM,
  cfi.invoice_date,
  msi.segment1,
  msi.description,
  it.invoice_type_code,
  cfli.*
FROM
  CLL.CLL_F189_INVOICE_LINES cfli
JOIN CLL.CLL_F189_INVOICES cfi
  ON cfi.invoice_id = cfli.invoice_id
JOIN INV.MTL_SYSTEM_ITEMS_B msi
  ON msi.inventory_item_id = cfli.item_id
 AND msi.organization_id   = cfli.organization_id
LEFT JOIN CLL.CLL_F189_INVOICE_TYPES# it
  ON it.invoice_type_id = cfi.invoice_type_id
WHERE
  cfi.invoice_date >= ADD_MONTHS(TRUNC(SYSDATE), -12)
  AND EXISTS (
        SELECT 1
        FROM CLL.CLL_F189_FISCAL_ENTITIES_ALL cffe
        JOIN CLL.CLL_F189_BUSINESS_VENDORS cfbv
          ON cfbv.business_id = cffe.business_vendor_id
       WHERE cffe.entity_id = cfi.entity_id
         AND cfbv.business_code IN ('INDUSTRIAL', 'COMERCIAL','CONTRIBUINTE DO ICMS','VAREJISTA','%SIMPLES%')
  )
  AND it.invoice_type_code IN ('E003','E004','E008')
ORDER BY
  cfi.invoice_date DESC

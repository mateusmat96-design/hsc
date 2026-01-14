WITH CM_TAB AS
(
SELECT ratyp.name, rat.trx_number, rat.creation_date, rat.customer_trx_id, ral.customer_trx_line_id, ral.previous_customer_trx_line_id
    , vt.tax
    , ral.taxable_amount
    , ral.tax_rate
    , ral.extended_amount
  FROM apps.ra_customer_trx_all rat
     , apps.ra_customer_trx_lines_all ral       
     , apps.ra_cust_trx_types_all ratyp                                         
     , apps.ar_vat_tax_all vt
WHERE rat.customer_trx_id = ral.customer_trx_id
   AND rat.cust_trx_type_id = ratyp.cust_trx_type_id
   AND ral.vat_tax_id = vt.vat_tax_id                                
   AND ratyp.TYPE = 'CM'
   AND ral.line_type = 'TAX'
), TX_TAB AS ( 
SELECT  rat.customer_trx_id
     , ral.customer_trx_line_id
     , ral.link_to_cust_trx_line_id
     , vt.tax
     , ral.taxable_amount
     , ral.tax_rate
     , ral.extended_amount
  FROM apps.ra_customer_trx_all rat
     , apps.ra_customer_trx_lines_all ral       
     , apps.ra_cust_trx_types_all ratyp
     , apps.ar_vat_tax_all vt
     , apps.mtl_system_items it
WHERE rat.customer_trx_id = ral.customer_trx_id
   AND rat.cust_trx_type_id = ratyp.cust_trx_type_id
   AND ral.vat_tax_id = vt.vat_tax_id
   AND ral.inventory_item_id = it.inventory_item_id  (+)
   AND ral.warehouse_id  = it.organization_id        (+)                          
   AND ratyp.TYPE = 'INV'
   AND ral.line_type = 'TAX'
), LI_TAB AS ( 
SELECT ratyp.name, rat.trx_number, rat.creation_date, rat.customer_trx_id, ral.customer_trx_line_id, it.segment1
    , ral.extended_amount
    , ral.quantity_invoiced
  FROM apps.ra_customer_trx_all rat
     , apps.ra_customer_trx_lines_all ral       
     , apps.ra_cust_trx_types_all ratyp
     , apps.mtl_system_items it
WHERE rat.customer_trx_id = ral.customer_trx_id
   AND rat.cust_trx_type_id = ratyp.cust_trx_type_id
   AND ral.inventory_item_id = it.inventory_item_id  (+)
   AND ral.warehouse_id  = it.organization_id        (+)                          
   AND ratyp.TYPE = 'INV'
   AND ral.line_type = 'LINE'
   )
SELECT 'NF/LINHA=>' l, LI_TAB.*, 'IMPOSTO=>' l, TX_TAB.*, 'REVERSAO=>' l, CM_TAB.* 
  FROM TX_TAB, CM_TAB, LI_TAB
WHERE TX_TAB.customer_trx_line_id = CM_TAB.previous_customer_trx_line_id
   AND tx_tab.link_to_cust_trx_line_id = li_tab.customer_trx_line_id
   AND cm_tab.creation_date > To_Date('01122025','DDMMYYYY')
--   AND LI_TAB.trx_number = '4270'
ORDER BY li_tab.creation_date, li_tab.trx_number

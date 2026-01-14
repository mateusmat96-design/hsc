WITH hdr AS (
  SELECT *
  FROM PO.PO_HEADERS_ALL
  WHERE org_id = 4361
    AND authorization_status = 'APPROVED'
    AND approved_date >= DATE '2025-12-01'
    AND approved_date <  DATE '2026-01-01'
    AND creation_date >= DATE '2025-11-01'
)
SELECT DISTINCT
    pha.segment1,
    pha.approved_date,
    pha.creation_date,
    pha.org_id,
    pla.line_num,
    pla.transaction_reason_code,
    msi.segment1,
    msi.description,
    msi.organization_id,
    bpa.segment1,
    bpa.creation_date,
    bpla.transaction_reason_code
FROM hdr pha
JOIN PO.PO_LINES_ALL pla
  ON pla.po_header_id = pha.po_header_id
LEFT JOIN PO.PO_LINE_LOCATIONS_ALL plla
  ON plla.po_line_id = pla.po_line_id
LEFT JOIN PO.PO_DISTRIBUTIONS_ALL pda
  ON pda.po_line_id = pla.po_line_id
JOIN INV.MTL_SYSTEM_ITEMS_B msi
  ON msi.inventory_item_id = pla.item_id
 AND msi.organization_id = NVL(plla.ship_to_organization_id, pda.destination_organization_id)
LEFT JOIN PO.PO_HEADERS_ALL bpa
  ON bpa.po_header_id = pla.from_header_id
LEFT JOIN PO.PO_LINES_ALL bpla
  ON bpla.po_line_id = pla.from_line_id
 AND bpla.po_header_id = bpa.po_header_id
WHERE pla.item_id IS NOT NULL
ORDER BY pha.segment1, pla.line_num, msi.segment1;

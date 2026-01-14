-- Busca fornecedores pelo CNPJ a partir dos atributos globais do site (global_attribute10/11/12)
SELECT
    s.vendor_name,
    (ss.global_attribute10 || ss.global_attribute11 || ss.global_attribute12) AS cnpj_com_zeros,
    REGEXP_REPLACE(
        (ss.global_attribute10 || ss.global_attribute11 || ss.global_attribute12),
        '^0(?=\d{14}$)', ''
    ) AS cnpj
FROM
    ap.ap_suppliers s
JOIN
    ap.ap_supplier_sites_all ss ON s.vendor_id = ss.vendor_id
WHERE
    ss.org_id IN (4361, 8121)
    AND (ss.global_attribute10 || ss.global_attribute11 || ss.global_attribute12) IN (
        -- Inclua CNPJs com um zero na frente, por exemplo:
        -- '01234567890123', '04567890123456'
    )
ORDER BY
    s.vendor_name;

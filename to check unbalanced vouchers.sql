select v.module_doc_id, si.sales_invoice_id, si.sales_invoice_no, sum(debit), sum(credit)
from gl_vouchers v, gl_voucher_accounts va, sm_sales_invoices si
where v.voucher_id = va.voucher_id
and v.module = 'AR' and v.module_doc = 'SALE_INVOICE' and v.voucher_type = 'JVR'
and v.module_doc_id = si.sales_invoice_id
group by v.module_doc_id, si.sales_invoice_id, si.sales_invoice_no
having sum(debit) <> sum(credit);

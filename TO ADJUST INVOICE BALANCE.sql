UPDATE SM_SALES_INVOICES SET INVOICE_ADJUSTED = 0;

update sm_sales_invoices si
set si.INVOICE_ADJUSTED = (select nvl(suM(RI.ENTERED_AMOUNT),0) from ar_receipt_invoices ri, ar_receipts r
                            where RI.ENTERED_AMOUNT is not null and RI.INVOICE_ID = SI.SALES_INVOICE_ID
                            and RI.RECEIPT_ID=R.RECEIPT_ID and R.RECEIPT_STATUS in ('APPROVED','CLOSED'))
where SI.INVOICE_TYPE = 'STANDARD' and SI.INVOICE_STATUS in ('APPROVED','CLOSED') 
AND SI.SALES_INVOICE_ID IN (SELECT C.INVOICE_ID FROM AR_RECEIPTS B, AR_RECEIPT_INVOICES C 
                            WHERE B.RECEIPT_ID=C.RECEIPT_ID AND B.RECEIPT_STATUS IN ('APPROVED'))
AND SI.SALES_INVOICE_ID = 8359;

update sm_sales_invoices si  --ar_receipts  sys_companies sys_branches
set si.INVOICE_ADJUSTED = (select nvl(round(suM(RI.ENTERED_AMOUNT)),0) from ar_receipt_invoices ri, ar_receipts r
                            where RI.ENTERED_AMOUNT is not null and RI.INVOICE_ID = SI.SALES_INVOICE_ID
                            and RI.RECEIPT_ID=R.RECEIPT_ID and R.RECEIPT_STATUS in ('APPROVED','CLOSED'))
where SI.INVOICE_TYPE = 'STANDARD' and SI.INVOICE_STATUS in ('APPROVED','CLOSED') 
AND SI.SALES_INVOICE_ID IN (SELECT C.INVOICE_ID FROM AR_RECEIPTS B, AR_RECEIPT_INVOICES C 
                            WHERE B.RECEIPT_ID=C.RECEIPT_ID AND B.RECEIPT_STATUS IN ('APPROVED'))
--AND SI.SALES_INVOICE_ID = 11241
;

update sm_sales_invoices A
set A.invoice_adjusted=nvl(A.invoice_adjusted,0)+(select SUM(round(sri.qty*sri.rate,2))
                                                    from sm_sale_returns sr, sm_sale_return_items sri
                                                    where SR.SR_ID = SRI.SR_ID
						    and SR.SR_STATUS in ('APPROVED','CLOSED')
                                                    AND SR.SALE_INVOICE_ID=A.SALES_INVOICE_ID)
where A.sales_invoice_id IN (SELECT B.SALE_INVOICE_ID FROM SM_SALE_RETURNS B
				WHERE B.SR_STATUS IN ('APPROVED','CLOSED'));

update sm_sales_invoices A
set A.invoice_adjusted=nvl(A.invoice_adjusted,0)+(select SUM(round(sri.amount,2))
                                                    from sm_sale_returns sr, sm_sale_return_items sri
                                                    where SR.SR_ID = SRI.SR_ID
						    and SR.SR_STATUS in ('APPROVED','CLOSED')
                                                    AND SR.SALE_INVOICE_ID=A.SALES_INVOICE_ID)
where A.sales_invoice_id IN (SELECT B.SALE_INVOICE_ID FROM SM_SALE_RETURNS B
				WHERE B.SR_STATUS IN ('APPROVED','CLOSED'));

update sm_sales_invoices si
set SI.INVOICE_BALANCE = nvl(SI.TOTAL_INVOICE_AMOUNT,0) - nvl(SI.INVOICE_ADJUSTED,0)
--where SI.SALES_INVOICE_ID = 8359
;

ar_receipts
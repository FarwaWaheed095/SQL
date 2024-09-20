DECLARE
   v_id       NUMBER;
   acc_date   DATE;
   user_id    number;
BEGIN
   for i in (SELECT SI.SALES_INVOICE_ID FROM sm_sales_invoices si
             WHERE SI.GL_VOUCHER_ID in (select voucher_id from gl_voucher_accounts
                                        group by voucher_id
                                        having sum(debit) <> sum(credit)))
   loop 
    
       SELECT APPROVAL_DATE,GL_VOUCHER_ID,APPROVED_BY
         INTO acc_date, v_id, USER_ID
         FROM sm_sales_invoices
        WHERE SALES_INVOICE_ID = i.SALES_INVOICE_ID;

	DELETE FROM GL_VOUCHER_ACCOUNTS WHERE VOUCHER_ID = V_ID;      
 
      INSERT INTO GL_VOUCHER_ACCOUNTS
               (voucher_account_id, voucher_id, account_id, debit, credit,
                naration, created_by, creation_date, last_updated_by,
                last_update_date, reference_id)
      SELECT gl_voucher_account_id_s.NEXTVAL, v_id, account_id, debit, credit,
             naration, user_id, acc_date, user_id, acc_date, receipt_id
        FROM ar_invoice_transfer_v
       WHERE receipt_id = i.SALES_INVOICE_ID;
   end loop;
   
   COMMIT;
END;
/
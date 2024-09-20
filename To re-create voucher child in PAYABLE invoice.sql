DECLARE
   company    VARCHAR2 (2);
   branch     VARCHAR2 (2);
   v_id       NUMBER;
   v_no       NUMBER;
   chk        NUMBER;
   acc_date   DATE;
   REMARKS    VARCHAR2(250);
   proj    VARCHAR2(50);
   cost_cent  NUMBER;
   user_id    number;
BEGIN
   for i in (SELECT INVOICE_ID FROM AP_INVOICES WHERE INVOICE_STATUS<>'CREATED')
   
   loop 
    
       SELECT DECODE (invoice_amount, 0, reversal_date, accounting_date),
              invoice_amount, company_id, branch_id,project,gl_cost_center_id , GL_VOUCHER_ID , APPROVED_BY
         INTO acc_date, chk, company, branch,proj,cost_cent , V_ID , USER_ID
         FROM AP_INVOICES
        WHERE invoice_id = i.INVOICE_ID;

       
       IF chk > 0
       THEN
          INSERT INTO GL_VOUCHER_ACCOUNTS
                      (voucher_account_id, voucher_id, account_id, debit, credit,
                       naration, created_by, creation_date, last_updated_by,
                       last_update_date, reference_id,sub_account_code,COST_CENTER_ID)
             SELECT gl_voucher_account_id_s.NEXTVAL, v_id, account_id, debit,
                    credit, naration, user_id, acc_date, user_id, acc_date,
                    invoice_id,proj,cost_cent
               FROM ap_invoice_transfer_v
              WHERE invoice_id = i.INVOICE_ID;
       ELSIF chk < 0
       THEN
          INSERT INTO GL_VOUCHER_ACCOUNTS
                      (voucher_account_id, voucher_id, account_id, debit, credit,
                       naration, created_by, creation_date, last_updated_by,
                       last_update_date, reference_id,sub_account_code,COST_CENTER_ID)
             SELECT gl_voucher_account_id_s.NEXTVAL, v_id, account_id, debit,
                    credit, naration, user_id, acc_date, user_id, acc_date,
                    invoice_id,proj,cost_cent
               FROM ap_debit_transfer_v
              WHERE invoice_id = i.INVOICE_ID;
       ELSE
          INSERT INTO GL_VOUCHER_ACCOUNTS
                      (voucher_account_id, voucher_id, account_id, debit, credit,
                       naration, created_by, creation_date, last_updated_by,
                       last_update_date, reference_id,sub_account_code,COST_CENTER_ID)
             SELECT gl_voucher_account_id_s.NEXTVAL, v_id, account_id, debit,
                    credit, naration, user_id, acc_date, user_id, acc_date,
                    invoice_id,proj,cost_cent
               FROM ap_reversal_transfer_v
              WHERE invoice_id = i.INVOICE_ID;
       END IF;
   
   end loop;
   
   COMMIT;
END;
/
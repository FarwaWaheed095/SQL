DECLARE
   v_id       NUMBER;
   acc_date   DATE;
   user_id    number;
BEGIN
   for i in (SELECT GRN_ID FROM INV_GRNS WHERE VOUCHER_ID IS NOT NULL)
   
   loop 
    
       SELECT CREATION_DATE,VOUCHER_ID, CREATED_BY
         INTO ACC_DATE, V_ID , USER_ID
         FROM INV_GRNS
        WHERE GRN_ID = i.GRN_ID;

       DELETE FROM GL_VOUCHER_ACCOUNTS WHERE VOUCHER_ID = V_ID;
       
       INSERT INTO GL_VOUCHER_ACCOUNTS
                  (voucher_account_id, voucher_id, account_id, debit, credit,
                   naration, created_by, creation_date, last_updated_by,
                   last_update_date, reference_id)
            SELECT gl_voucher_account_id_s.NEXTVAL,V_ID, v.account_id, v.dr, v.cr, 
                   v.naration, user_id, ACC_DATE, user_id, ACC_DATE, v.grn_id
              FROM inv_grn_transfer_v v
             WHERE v.grn_id =  i.GRN_ID;
   end loop;
   COMMIT;
END;
/
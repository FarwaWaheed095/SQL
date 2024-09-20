UPDATE INV_IRNS
SET (IS_DONE,ccn_status,gl_lc_acc_id)=(select 'N','CREATED',gl_lc_acc_id from imp_ccns where ccn_id=:p_ccn_id)
WHERE ccn_ID=:p_ccn_id;

delete from gl_voucher_accounts where voucher_id = (select voucher_id from imp_ccns where ccn_id=:p_ccn_id);

update imp_ccns set ccn_status = 'CREATED' WHERE CCN_ID = :P_CCN_ID;

--TO DELETE UNAPPROVED CCN
update inv_irn_items a
SET VALUE = NULL WHERE IRN_ID IN (SELECT IRN_ID FROM INV_IRNS WHERE CCN_ID=:CCN_ID);

UPDATE INV_IRNS SET CCN_ID=NULL, gl_lc_acc_id=NULL WHERE CCN_ID = :CCN_ID;

DELETE FROM INV_IRN_IMPORT_CHARGES
WHERE CCN_ID = :CCN_ID;

DELETE FROM IMP_CCNS WHERE CCN_ID=:CCN_ID; 
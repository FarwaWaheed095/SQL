select * from inv_grns where purchase_type = 'IMP' and irn_id = (select irn_id from inv_irns where ccn_id = 17);

select * from inv_grn_items where irn_id = (select irn_id from inv_irns where ccn_id = 17);



inv_cur_item_value(rec_item.item_id,:parameter.company,user_id,rec_item.qty,rec_item.val,'U'); --IF STOCK IS NOT USED OR CONSUMED
Inv_company_store_stock(rec_item.item_id,:parameter.company,:store_id,user_id,rec_item.qty ,'SIN');
if rec_item.order_id is not null then
   Inv_company_order_stock(rec_item.item_id,:parameter.company,rec_item.order_id,user_id,rec_item.qty ,'SIN');
end if;
            
SELECT     igi.indent_id,igi.item_id, ii.order_id,igi.received_qty qty,igi.rate,ROUND(received_qty*igi.rate,0) val,igi.creation_date
        FROM     INV_GRN_ITEMS igi,INV_INDENTS ii
        WHERE     ii.indent_id = igi.indent_id;

delete from inv_grn_items where irn_id = (select irn_id from inv_irns where ccn_id = 17);

delete from inv_grns where purchase_type = 'IMP' and irn_id = (select irn_id from inv_irns where ccn_id = 17);


UPDATE INV_IRNS
SET (IS_DONE,ccn_status,gl_lc_acc_id)=(select 'N','CREATED',gl_lc_acc_id from imp_ccns where ccn_id=:p_ccn_id)
WHERE ccn_ID=:p_ccn_id;

delete from gl_voucher_accounts where voucher_id = 6019;
delete from gl_vouchers where voucher_id = 6019;

update imp_ccns
SET CCN_STATUS='CREATED', VOUCHER_ID = NULL
WHERE CCN_ID=:p_ccn_id;
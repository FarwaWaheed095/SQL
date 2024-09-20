begin
    for i in (SELECT sin_mir_id,item_id, issue_qty, issue_rate, mir_id, REQUEST_ID
                   FROM INV_SIN_MIRS WHERE sin_id = 1038)
    loop
        update  inv_item_companies
          set    cur_qty = cur_qty + i.issue_qty,
              cur_value = cur_value + round(i.issue_qty * cur_rate,0)
          where item_id = i.item_id and company_id =  1;
        
          update  INV_ITEM_COMPANY_STORES
          set    cur_qty = cur_qty + i.issue_qty
          where item_id = i.item_id and company_id =  1
          and store_id =83;
          
        update inv_mirs set ISSUE_QTY = nvl(ISSUE_QTY,0)-i.issue_qty, MIR_STATUS='APPROVED'
        where mir_id = i.mir_id;
        
            update inv_mir_master set STATUS = 'APPROVED' WHERE REQUEST_ID = I.REQUEST_ID;
    end loop;
end;

delete from gl_voucher_accounts where voucher_id in (select VOUCHER_ID from inv_sins where sin_id = 9810385);

delete from gl_vouchers where voucher_id in (select VOUCHER_ID from inv_sins where sin_id = 1038); 

Update inv_sins set sin_status = 'CREATED' where sin_id = 1038;




SELECT SL.ITEM_ID, I.ITEM_CODE, I.ITEM_DESC, SUM(SL.QTY) QTY 
FROM INV_STOCK_LEDGER SL, INV_ITEMS I
WHERE SL.ITEM_ID = I.ITEM_ID
GROUP BY SL.ITEM_ID, I.ITEM_CODE, I.ITEM_DESC
HAVING SUM(SL.QTY) < 0;
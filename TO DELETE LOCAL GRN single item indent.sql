SELECT G.GRN_ID, G.PO_ID, G.IRN_ID FROM INV_GRNS G WHERE G.GRN_NO in (45,46);

DELETE FROM GL_VOUCHER_ACCOUNTS VA
WHERE VA.VOUCHER_ID in (SELECT G.VOUCHER_ID FROM INV_GRNS G WHERE G.GRN_ID in (93,94));

DELETE FROM GL_VOUCHERS V
WHERE V.VOUCHER_ID in (SELECT G.VOUCHER_ID FROM INV_GRNS G WHERE G.GRN_ID in (93,94));

update inv_pos set po_status='APPROVED' where po_id=103;

update INV_PO_MANUALS set status='PO_CREATED' where po_id=103;

update inv_indents set indent_status='IRN_CREATED'
where indent_id IN (SELECT IG.INDENT_ID FROM INV_GRN_ITEMS IG WHERE IG.GRN_ID = 1662);

SELECT IG.RECEIVED_QTY, IG.ITEM_ID, G.COMPANY_ID, G.BRANCH_ID 
FROM INV_GRN_ITEMS IG, INV_GRNS G WHERE G.GRN_ID = IG.GRN_ID AND G.GRN_ID = 1662;

--optional if exist
update inv_items_locators set qty=nvl(qty,0)+:qty 
where item_id=:item_id and company_id=:company and branch_id=:branch;

SELECT IR.IRN_ID, IR.IRN_ITEM_ID, IR.IGP_QTY FROM INV_IRN_ITEMS IR WHERE IR.IRN_ID =1782;

--optional if data exist
update inv_grn_locators set grn_id=NULL, grn_item_id=NULL where irn_id=:irn_id and irn_item_id=:irn_item_id;

DECLARE
  cursor rec_item is (  
    SELECT GI.ITEM_ID,G.COMPANY_ID,G.CREATED_BY,GI.RECEIVED_QTY,GI.VALUE,G.STORE_ID,I.ORDER_ID
    from inv_grns g, inv_grn_items gi, inv_indents i
    where g.grn_id = gi.grn_id and GI.INDENT_ID = I.INDENT_ID and G.GRN_ID = 1662);
BEGIN
    for i in rec_item loop 
        inv_cur_item_value(i.ITEM_ID,i.COMPANY_ID,i.CREATED_BY,i.RECEIVED_QTY,i.VALUE,'U');
        Inv_company_store_stock(i.ITEM_ID,i.COMPANY_ID,i.STORE_ID,i.CREATED_BY,i.RECEIVED_QTY ,'SIN');
        if i.ORDER_ID is not null then
            Inv_company_order_stock(i.ITEM_ID,i.COMPANY_ID,i.ORDER_ID,i.CREATED_BY,i.RECEIVED_QTY ,'SIN');
        end if;
    end loop;
    commit;
END;

update inv_irns set irn_status = 'APPROVED' where irn_id in (65,66);

DELETE FROM INV_GRN_ITEMS WHERE GRN_ID in (93,94);

DELETE FROM INV_GRNS WHERE GRN_ID in (93,94);
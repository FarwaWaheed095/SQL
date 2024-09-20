select grn_id, IRN_ID, voucher_id from inv_grn_cottons where grn_no = :grn_no;

select NET_WEIGHT, LOT_ID from inv_irn_cottons where irn_id = :irn_id;

select item_id, COMPANY_ID, APPROVED_BY, IGP_QTY,NET_WEIGHT, LOT_ID
from inv_irn_cottons where irn_id = :irnid;

select store_id from inv_grn_cottons where grn_id = :grn_id;
    
select rate from INV_COTTON_CONTRACTS where CONTRACT_ID = :po_id;
   
declare
   itemid   number;
   c_id number;
   userid  number;
   igpQty   number;
   netWait  number;
   cc_rate     number;
   lotid    number;
   stor_id  number;
begin
    select item_id, COMPANY_ID, APPROVED_BY, IGP_QTY,NET_WEIGHT, LOT_ID
    into itemid,c_id,userid,igpQty,netWait,lotid
    from inv_irn_cottons where irn_id = :irnid;
    
    select store_id into stor_id from inv_grn_cottons where grn_id = :grn_id;
    
    select rate into cc_rate from INV_COTTON_CONTRACTS where CONTRACT_ID = :po_id;
    
    inv_cur_item_value(itemid,c_id,userid,igpQty,((netWait/37.324)*cc_rate),'U');
    Inv_company_store_stock(itemid,c_id,stor_id,userid,igpQty,'SIN');
    INV_COMPANY_COTTON_LOT_STOCK(itemid,c_id,userid,igpQty,((netWait/37.324)*cc_rate),NULL,'U',lotid);
end;

update inv_lots set ACTUAL_WEIGHT=nvl(ACTUAL_WEIGHT,0)-nvl(:net_WEIGHT,0) where LOT_ID=:LOT_ID;

update INV_IRN_COTTONS
set irn_status = 'APPROVED'
where irn_id = :irn_id;

update INV_COTTON_CONTRACTS
set STATUS = 'APPROVED'
where CONTRACT_ID = :CONTRACT_ID;

DELETE FROM GL_VOUCHERS WHERE VOUCHER_ID = :VID;

DELETE FROM GL_VOUCHER_ACCOUNTS WHERE VOUCHER_ID = :VID;

delete from INV_GRN_COTTONS
where GRN_ID = :grn_id;
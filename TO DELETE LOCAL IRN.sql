select irn_id, IRN_NO from inv_irns where irn_no in (45,46);

declare
    cursor c1 is (
         select nvl(igp_qty,0)-nvl(accepted_qty,0) diff_qty,indent_id
         from inv_irn_items
         where irn_id in ()
         );
    cursor c2 is (select a.po_item_id,b.received_qty,a.indent_id,b.po_id   
                     from inv_po_items a, inv_po_item_shipments b
                     where a.po_item_id=b.po_item_id
                     and b.po_id=b.po_id
                     and a.indent_id in (select INDENT_ID FROM INV_IRN_ITEMS WHERE IRN_ID IN (1466))
                     );
begin
  
  for i in c1 loop
    --if i.diff_qty > 0 then
      for j in c2 loop
        update inv_po_item_shipments
        set received_qty=received_qty - (nvl(j.received_qty,0) + i.diff_qty)
        where po_id=j.po_id
        and po_item_id=j.po_item_id;
      end loop;
    --end if;
  end loop;
  
  update inv_indents set indent_status = 'IGP_CREATED'
  where indent_id IN (SELECT INDENT_ID FROM INV_IRN_ITEMS WHERE IRN_ID=1438);

  update inv_igps set igp_status ='IGP_CREATED' where igp_id in (select IR.IGP_ID from inv_irns ir where irn_id in (65));
  
  delete from inv_irn_items where irn_id in ();
  delete from inv_irns where irn_id in ();
end;
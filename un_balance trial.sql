select v.voucher_id, v.voucher_type v_type, v.voucher_no v_no, to_char(v.voucher_date,'dd-mon-rr') v_date, v.description, v.status,
v.module, v.module_doc doc, v.module_doc_id doc_id,
sum(debit) dr, sum(credit) cr, sum(debit) - sum(credit) diff,
v.company_id, v.branch_id
from gl_vouchers v, gl_voucher_accounts va where v.voucher_id = va.voucher_id --and v.voucher_type = 'JVG'
and  v.voucher_id in (select voucher_id from gl_voucher_accounts group by voucher_id having sum(debit) - sum(credit) > 0)
group by v.voucher_id, v.voucher_type, v.voucher_no, v.voucher_date, v.description, v.status,
v.module, v.module_doc, v.module_doc_id,v.company_id, v.branch_id;


select * from gl_vouchers where voucher_id in
(
select voucher_id from gl_voucher_accounts
group by voucher_id
having sum(debit) <> sum(credit)
)
and voucher_type = 'JCV';

select sum(debit) - sum(credit) diff from gl_voucher_accounts where voucher_id in (
select voucher_id from gl_vouchers where voucher_id in
(
select voucher_id from gl_voucher_accounts
group by voucher_id
having sum(debit) <> sum(credit)
)
and voucher_type = 'JCV'
);


select sum(diff) from (
select sum(debit) - sum(credit) diff
from gl_voucher_accounts a, gl_vouchers b
where a.voucher_id = b.voucher_id --and voucher_type = 'JCV'
group by a.voucher_id
having sum(debit) <> sum(credit))

declare 
    cursor stock is select distinct T_ID, T_TYPE, DATED, CGS_V_ID 
        from stock_v   where T_TYPE = 'SALE'  order by dated;
begin
for each_row in stock 
    loop
        CORRECTION(each_row.t_id,each_row.t_type,each_row.dated,each_row.cgs_v_id);
    end loop;
end;
    
                                 
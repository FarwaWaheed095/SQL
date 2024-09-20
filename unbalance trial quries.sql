select * from gl_vouchers where voucher_id in
(
select voucher_id from gl_voucher_accounts
group by voucher_id
having sum(debit) <> sum(credit)
);

select * from gl_vouchers where voucher_id in
(
select voucher_id from gl_voucher_accounts
group by voucher_id
having round(sum(debit),0) - round(sum(credit),0) >1
);

select voucher_id from gl_voucher_accounts
group by voucher_id
having round(sum(debit),0) - round(sum(credit),0) >1;

select * from gl_voucher_accounts
where account_id not in (select chart_of_account_id from gl_chart_of_accounts);


select b.account_id,sum(debit) ,sum(credit), sum(debit) - sum(credit) 
from gl_chart_of_account_v a, gl_voucher_accounts b 
where a.account_id(+)=b.account_id
and a.account_id is null
group by b.account_id;
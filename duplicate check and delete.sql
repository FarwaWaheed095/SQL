select acc_code
from crdr
group by acc_code
having count(acc_code) > 1

--TO REMOVE DUPLICATE SECURITY
select scr_id, SCR_OPT_ID
from sys_scr_options
group by scr_id, SCR_OPT_ID
having count(SCR_OPT_ID) > 1;

select scr_id, SCR_OPT_ID, user_id
from sys_user_scr_options
group by scr_id, SCR_OPT_ID, user_id
having count(SCR_OPT_ID) > 1;



select count(*) FROM inv_items
WHERE rowid not in (SELECT MIN(rowid) FROM inv_items GROUP BY item_desc, packing);

DELETE FROM inv_items WHERE rowid not in (SELECT MIN(rowid) FROM inv_items GROUP BY item_desc, packing);
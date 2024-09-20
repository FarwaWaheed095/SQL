select min(scr_id)+1 as skip_id
from SYS_SCREENS e1
where not exists ( select null from SYS_SCREENS e2 where e2.scr_id = e1.scr_id+1);

select PARANT_VAL, SCREEN,  MENU_TYPE
from SYS_SCREENS where MENU_NAME = 'T_PURCHASE_MENU';

--
-- SYS_SCREENS
--
Insert into SYS_SCREENS
   (SCR_ID, SCR_NAME, SCR_DESC, CREATED_BY, CREATION_DATE, 
    LAST_UPDATE_BY, LAST_UPDATE_DATE, MENU_NAME, PARANT_VAL, SCREEN, 
    MENU_TYPE, SCR_NO)
 Values
   (100, 'STOCK_BALANCE_ITEM_LOT_WISE', 'Stock Balance Item Lot Wise', 1, sysdate, 
    NULL, NULL, 'R_INVENTORY_MENU', 147, 'Y', 
    'R', 100);

--
-- SYS_SCR_OPTIONS
--
Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 100, 1);

--
-- SYS_USER_SCR_OPTIONS
--
insert into sys_user_scr_options
select SYS_USER_SCR_OPT_ID_S.nextval, 100, sso.scr_opt_id, 'N', u.user_id, sysdate, 1
from sys_users u, sys_scr_options sso
where sso.scr_id = 100;

update sys_user_scr_options
set opt = 'Y'
where  opt <> 'Y'
and user_id = 1;

---------------------
Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 100, 1);

insert into sys_user_scr_options
select SYS_USER_SCR_OPT_ID_S.nextval, 38, 10, 'N', user_id, sysdate, 1
from sys_users;

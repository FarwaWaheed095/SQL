
delete from sys_scr_options
where SCR_OPT_ID not in (1,2,3,4,5,6,8,17)
and scr_id = 67;

delete from sys_user_scr_options
where SCR_OPT_ID not in (1,2,3,4,5,6,8,17)
and scr_id = 67;

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 67, 6);
--
-- SYS_USER_SCR_OPTIONS
--
insert into sys_user_scr_options
select SYS_USER_SCR_OPT_ID_S.nextval, 67, 6, 'N', u.user_id, sysdate, 1
from sys_users u;


Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 67, 8);
--
-- SYS_USER_SCR_OPTIONS
--
insert into sys_user_scr_options
select SYS_USER_SCR_OPT_ID_S.nextval, 67, 8, 'N', u.user_id, sysdate, 1
from sys_users u;

update sys_user_scr_options
set opt = 'Y'
where user_id = 1
and opt = 'N';
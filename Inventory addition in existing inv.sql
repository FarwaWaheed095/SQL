create table item
(   code        varchar2(30),
    I_desc      varchar2(300),
    cur_qty     number(16,4),
    cur_rate    number(16,4),
    cur_val     number(16,4),
    uom         varchar2(30),
    item_id     number(16)
    );
    
select code
from item
group by code
having count(code) > 1;

update item
set uom = 'NOS'
where length(code) = 10;

Insert into INV_ITEM_CODE_SEGMENT_VALUES
   (VAL_ID, SEGMENT_VAL, SEGMENT_VAL_DESC,SEGMENT_ID,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE)
select INV_ITEM_CODE_SEGMENT_VALUES_V.nextval , CODE, I_DESC, 1,1,sysdate,1,sysdate
from ITEM
where length(CODE) = 2;

Insert into INV_ITEM_CODE_SEGMENT_VALUES
   (VAL_ID, SEGMENT_VAL, SEGMENT_VAL_DESC,SEGMENT_ID,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE)
select INV_ITEM_CODE_SEGMENT_VALUES_V.nextval , CODE, I_DESC, 2,1,sysdate,1,sysdate
from ITEM
where length(CODE) = 4;

Insert into INV_ITEM_CODE_SEGMENT_VALUES
   (VAL_ID, SEGMENT_VAL, SEGMENT_VAL_DESC,SEGMENT_ID,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE)
select INV_ITEM_CODE_SEGMENT_VALUES_V.nextval , CODE, I_DESC, 3,1,sysdate,1,sysdate
from ITEM
where length(CODE) = 6;

declare
cursor INV is ( select CODE, I_DESC, UOM from ITEM where length(CODE) = 10 );
begin
for i in INV  loop
    
       Insert into INV_ITEMS
           (ITEM_ID, ITEM_CODE, ITEM_DESC,UOM,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE)
       values
           (inv_items_s.nextval, i.CODE, i.I_DESC, UPPER(I.UOM), 1,sysdate,1,sysdate);

END loop;
commit;
end;

update INV_ITEM_CODE_SEGMENT_VALUES a
set PARENT_VAL = (select VAL_ID from INV_ITEM_CODE_SEGMENT_VALUES b 
where to_char(b.SEGMENT_VAL) = to_char(substr(a.SEGMENT_VAL,1,4))
and length(segment_val) = 4)
where length(SEGMENT_VAL) = 6;

update inv_item_code_segment_values
set parent_val = 541
where length(segment_val) = 4;

update inv_items a
set PARENT_ID = (select VAL_ID from INV_ITEM_CODE_SEGMENT_VALUES b 
                where substr(a.ITEM_CODE,1,6) =  B.SEGMENT_VAL
                and B.SEGMENT_ID = 3
                and length(B.SEGMENT_VAL) = 6)
where substr(a.item_code,1,2) = 10;

update INV_ITEM_CODE_SEGMENT_VALUES a
set SEGMENT_VAL = TO_CHAR(SUBSTR(SEGMENT_VAL, 3,4))
where length(SEGMENT_VAL) = 4;

update INV_ITEM_CODE_SEGMENT_VALUES a
set SEGMENT_VAL = TO_CHAR(SUBSTR(SEGMENT_VAL, 5,6))
where length(SEGMENT_VAL) = 6;

UPDATE INV_ITEMS
SET SALEABLE='N',IS_WASTE='N',FINISHED_PRODUCT='N',CHECK_MATERIAL_SHORTAGE='N',IS_ACTIVE='Y',IS_CONSUMABLE='N',IS_CEP_REQ='N',
IS_REPLACEMENT_REQ='N',IS_PART='N',IS_MACHINE='N',IS_TOOL='N'
where substr(item_code,1,2) = '10';

update item a
set a.item_id = (select b.item_id from inv_items b where b.item_code = A.CODE and substr(b.item_code,1,2)='10')
where length(code) = 10; 

insert into inv_item_companies(ITEM_COMP_ID,ITEM_ID,COMPANY_ID,CUR_RATE,CUR_QTY,CUR_VALUE,CREATED_BY,CREATION_DATE,UPDATE_BY,UPDATE_DATE)
select INV_ITEMS_COMP_S.nextval, item_id, 1,CUR_RATE,CUR_QTY,CUR_VAL,1,sysdate,1,sysdate
from item
where length(code) = 10;
create table item
(   code        varchar2(30),
    I_desc      varchar2(300),
    uom         varchar2(30)
    );
    
select code
from item
group by code
having count(code) > 1;

truncate table INV_ITEM_CODE_SEGMENT_VALUES;

truncate table INV_ITEMS;

DROP SEQUENCE INV_ITEM_CODE_SEGMENT_VALUES_V;

CREATE SEQUENCE INV_ITEM_CODE_SEGMENT_VALUES_V
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOORDER;

DROP SEQUENCE INV_ITEMS_S;

CREATE SEQUENCE INV_ITEMS_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOORDER;

Insert into INV_ITEM_CODE_SEGMENT_VALUES
   (VAL_ID, SEGMENT_ID, SEGMENT_VAL, SEGMENT_VAL_DESC, PARENT_VAL, 
    CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
 Values
   (0, 0, NULL, 'Item Chart', NULL, 
    1, SYSDATE, 1, SYSDATE);
    
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
where to_char(b.SEGMENT_VAL) = to_char(substr(a.SEGMENT_VAL,1,4)))
where length(SEGMENT_VAL) = 6;

update INV_ITEM_CODE_SEGMENT_VALUES a
set PARENT_VAL = (select VAL_ID from INV_ITEM_CODE_SEGMENT_VALUES b 
where to_char(b.SEGMENT_VAL) = to_char(substr(a.SEGMENT_VAL,1,2)))
where length(SEGMENT_VAL) = 4;

update INV_ITEM_CODE_SEGMENT_VALUES a
set PARENT_VAL = 0
where length(SEGMENT_VAL) = 2;

update inv_items a
set PARENT_ID = (select VAL_ID from INV_ITEM_CODE_SEGMENT_VALUES b 
where substr(a.ITEM_CODE,1,6) =  B.SEGMENT_VAL
and B.SEGMENT_ID = 3);


update INV_ITEM_CODE_SEGMENT_VALUES a
set SEGMENT_VAL = TO_CHAR(SUBSTR(SEGMENT_VAL, 3,4))
where length(SEGMENT_VAL) = 4;

update INV_ITEM_CODE_SEGMENT_VALUES a
set SEGMENT_VAL = TO_CHAR(SUBSTR(SEGMENT_VAL, 5,6))
where length(SEGMENT_VAL) = 6;

UPDATE INV_ITEMS
SET SALEABLE='N',IS_WASTE='N',FINISHED_PRODUCT='N',CHECK_MATERIAL_SHORTAGE='N',IS_ACTIVE='Y',IS_CONSUMABLE='N',IS_CEP_REQ='N',
IS_REPLACEMENT_REQ='N',IS_PART='N',IS_MACHINE='N',IS_TOOL='N';
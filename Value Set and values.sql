select min(VALUE_SET_ID)+1 as skip_id
from value_sets e1
where not exists ( select null from value_sets e2 where e2.VALUE_SET_ID = e1.VALUE_SET_ID+1);

select * from value_sets where value_set_id=137;

select * from data_values where value_set_id=137;

Insert into VALUE_SETS
   (VALUE_SET_ID, VALUE_SET_NAME, DESCRIPTION, FORMAT_TYPE, MAX_SIZE, 
    CHILD, SYSTEM_VALUE, VALUE_SET_MODULE_ID)
Values
(137, 'PORT_OF_DISCHARGE', 'Discharge Port (PI)', 'Varchar2', 30, 
'N', NULL(to show in segment management and N to hide from segment mangement), NULL);
   
Insert into DATA_VALUES
   (VALUE_ID, VALUE_SET_ID, VALUE_SET_VALUE, VALUE_SET_DESCRIPTION, SEGMENT1, 
    SEGMENT2, SEGMENT3, SEGMENT4, SEGMENT5, CREATED_BY, 
    CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
Values
(DATA_VALUES_S.NEXTVAL, 137, 'CHECKED', 'Checked', NULL, 
NULL, NULL, NULL, NULL, 1, 
sysdate, 1, sysdate);
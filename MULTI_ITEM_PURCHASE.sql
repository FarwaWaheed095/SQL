CREATE TABLE INV_PURCHASE_REQUISITIONS
(
  PR_ID              NUMBER(16) PRIMARY KEY,
  PR_NO              NUMBER(16),
  PR_DATE            DATE,
  REF_NO             VARCHAR2(50),
  REMARKS            VARCHAR2(1000),
  COMPANY_ID         NUMBER(16),
  BRANCH_ID          VARCHAR2(16),
  DEPT_ID            NUMBER(16),
  CREATED_BY         NUMBER(16),
  CREATION_DATE      DATE,
  LAST_UPDATED_BY    NUMBER(16),
  LAST_UPDATE_DATE   DATE,
  HOD_APP_BY         NUMBER(16),
  HOD_APPROVAL_DATE  DATE,
  APPROVED_BY        NUMBER(16),
  APPROVED_DATE      DATE,
  PR_STATUS          VARCHAR2(30),
  CANCELED_BY        NUMBER(16),
  IMPORTS            VARCHAR2(1),
  STORE_ID           NUMBER(16),
  PURCHASE_TYPE      VARCHAR2(30),
  REJECTED_BY        NUMBER(16),
  REJECTION_DATE     DATE,
  REJECTION_REASON   VARCHAR2(999),
  REQUEST_ID         NUMBER(16)
);

ALTER TABLE INV_INDENTS
ADD(PR_ID                   NUMBER(16),
    INDENT_CREATION_DATE    DATE
    );
    

CREATE SEQUENCE INV_PUR_REQ_ID_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;    

alter table inv_indents_checked
add PR_ID_C number(16);

--IF INDENTS ARE ALREADY CREATED

insert into INV_PURCHASE_REQUISITIONS (PR_ID,PR_NO,PR_DATE,REMARKS,
COMPANY_ID,BRANCH_ID,DEPT_ID,CREATED_BY,CREATION_DATE,
LAST_UPDATED_BY,LAST_UPDATE_DATE,HOD_APP_BY,HOD_APPROVAL_DATE,
APPROVED_BY,APPROVED_DATE,PR_STATUS,IMPORTS)
select INV_PUR_REQ_ID_S.nextval, I.INDENT_NO, I.INDENT_CREATION_DATE, I.REMARKS,
I.COMPANY_ID, I.BRANCH_ID, I.ORG_ID, I.CREATED_BY, I.CREATION_DATE,
I.LAST_UPDATED_BY, I.LAST_UPDATE_DATE, I.HOD_APP_BY, I.HOD_APPROVAL_DATE,
I.APPROVED_BY, I.APPROVED_DATE, I.INDENT_STATUS, I.IMPORTS 
from inv_indents i where I.PR_ID is null;

update inv_indents ind
set ind.pr_id = (select pr.pr_id from INV_PURCHASE_REQUISITIONS pr where pr.pr_no = ind.indent_no )
where ind.pr_id is not null; 
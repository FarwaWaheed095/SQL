delete from SYS_SCR_OPTIONS
where scr_id in (51,52,112,113);

delete from SYS_USER_SCR_OPTIONS
where scr_id in (51,52,112,113);

delete from sys_screens
where scr_id in (51,52,112,113);

update SYS_USER_SCR_OPTIONS
set scr_id = 449
where scr_id = 451;

update SYS_SCR_OPTIONS
set scr_id = 449
where scr_id = 451;

update SYS_SCREENS
set scr_id = 449
where scr_id = 451;


CREATE SEQUENCE LC_ID_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

CREATE SEQUENCE IMP_PERFORMA_ID_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

CREATE SEQUENCE P_I_D_ID_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

DROP SEQUENCE IMP_CCNS_ID_S;
CREATE SEQUENCE IMP_CCNS_ID_S
  START WITH 1
  MAXVALUE 9999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

DROP SEQUENCE INV_IRN_IMPORT_CHARGE_ID_S;
CREATE SEQUENCE INV_IRN_IMPORT_CHARGE_ID_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

ALTER TABLE LC_HEADER
ADD(  LC_ACCOUNT_ID     NUMBER(16),
      LC_CLOSE_DATE     DATE,
      LC_OPEN_DATE      DATE,
      REMARKS           VARCHAR2(200 BYTE),
      custom_duty_id    number(16),
      sales_tax_id      number(16),
      income_tax_id     number(16),
      rd_id             number(16),
      SED_ID            NUMBER(16),
      SUB_ACC_CODE      VARCHAR2(30)
    );

alter table  PERFORMA_INV_MASTER
add(  BRANCH_ID          VARCHAR2(16),
      COMPANY_ID         NUMBER(16),
      CREATED_BY         NUMBER(16),
      CREATION_DATE      DATE,
      LAST_DATE_OF_LC    DATE,
      LAST_UPDATE_DATE   DATE,
      LAST_UPDATED_BY    NUMBER(16),
      LC_ID              NUMBER(16),
      LC_OPENING_BANK    VARCHAR2(100 BYTE),
      LC_OPENING_DATE    DATE,
      PO_ID              NUMBER(16),
      RECEIVED_DATE      DATE
    );

ALTER TABLE PERFORM_INV_DETAIL
ADD(  ORG_ID         NUMBER(16),
      P_I_D_ID       NUMBER(16)
    );

alter table INV_POS
add(    EXCHANGE_RATE_DATE  DATE,
        P_INV_M_ID          number(16),
        PURCHASE_TYPE       varchar2(50)
    );

ALTER TABLE INV_IRNS
ADD(IRN_TYPE          VARCHAR2(1 BYTE)    DEFAULT 'I'     NOT NULL,
    GL_LC_ACC_ID      NUMBER(16),
    CCN_STATUS        VARCHAR2(30 BYTE),
    STORE_ID          NUMBER(16)
    );

ALTER TABLE INV_IRN_ITEMS
ADD(    COMMERCIAL_QTY        NUMBER(16),
        CUSTOM_VALUE          NUMBER(16,4),
        SALES_TAX             NUMBER (16,4),
        VALUE                 NUMBER(16,4),
        WH_TAX                NUMBER (16,4)
    );

alter table imp_ccns
add(    approval_date      date,
        approved_by        number(16),
        BRANCH_ID          VARCHAR2(8),
        CCN_NO             NUMBER(16),
        COMPANY_ID         NUMBER(8),
        FR                 NUMBER(16,4),
        GL_LC_ACC_ID       number(16),
        IGP_ID             NUMBER(16),
        IMP_VALUE_WITH_GST number(16,4),
        LC_ID              NUMBER(16),
        SUB_ACC_CODE       VARCHAR2(16 BYTE),
        voucher_id         number(16)
);

alter table INV_IRN_IMPORT_CHARGES
add(    GL_LC_ACC_ID       NUMBER(16),
        SUB_ACCOUNT_CODE   VARCHAR2(16 BYTE),
        VOUCHER_ID         number(16)
    );

Insert into SYS_PARMS (PARAMETER_ID, DESCRIPTION, VALUE, CREATED_BY, CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
 Values(30, 'Import Charges', NULL, 1, sysdate, 1, sysdate);

insert into sys_parms(PARAMETER_ID,DESCRIPTION,VALUE,CREATED_BY,CREATION_DATE,LAST_UPDATED_BY,LAST_UPDATE_DATE)
values (40, 'LC MARGIN',NULL,1,SYSDATE,1,SYSDATE);

Insert into VALUE_SETS
   (VALUE_SET_ID, VALUE_SET_NAME, DESCRIPTION, FORMAT_TYPE, MAX_SIZE, 
    CHILD, SYSTEM_VALUE, VALUE_SET_MODULE_ID)
 Values
   (141, 'LC_OPEN_STATUS', 'LC Open Status', 'Varchar2', 30, 
    'N', 'N', NULL);

Insert into DATA_VALUES
   (VALUE_ID, VALUE_SET_ID, VALUE_SET_VALUE, VALUE_SET_DESCRIPTION, SEGMENT1, 
    SEGMENT2, SEGMENT3, SEGMENT4, SEGMENT5, CREATED_BY, 
    CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
Values
(DATA_VALUES_S.NEXTVAL, 141, 'CREATED', 'Created', NULL, 
NULL, NULL, NULL, NULL, 1, 
sysdate, 1, sysdate);

Insert into DATA_VALUES
   (VALUE_ID, VALUE_SET_ID, VALUE_SET_VALUE, VALUE_SET_DESCRIPTION, SEGMENT1, 
    SEGMENT2, SEGMENT3, SEGMENT4, SEGMENT5, CREATED_BY, 
    CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
Values
(DATA_VALUES_S.NEXTVAL, 141, 'APPROVED', 'Approved', NULL, 
NULL, NULL, NULL, NULL, 1, 
sysdate, 1, sysdate);

Insert into DATA_VALUES
   (VALUE_ID, VALUE_SET_ID, VALUE_SET_VALUE, VALUE_SET_DESCRIPTION, SEGMENT1, 
    SEGMENT2, SEGMENT3, SEGMENT4, SEGMENT5, CREATED_BY, 
    CREATION_DATE, LAST_UPDATED_BY, LAST_UPDATE_DATE)
Values
(DATA_VALUES_S.NEXTVAL, 141, 'CLOSED', 'Closed', NULL, 
NULL, NULL, NULL, NULL, 1, 
sysdate, 1, sysdate);

UPDATE DATA_VALUES
SET VALUE_SET_VALUE = 'PERFORMA',
    VALUE_SET_DESCRIPTION = 'Proforma Received'
WHERE VALUE_SET_ID=16 AND VALUE_SET_VALUE = 'APPROVED';

--
-- SYS_SCREENS
--
Insert into SYS_SCREENS
   (SCR_ID, SCR_NAME, SCR_DESC, CREATED_BY, CREATION_DATE, 
    LAST_UPDATE_BY, LAST_UPDATE_DATE, MENU_NAME, PARANT_VAL, SCREEN, 
    MENU_TYPE, SCR_NO)
 Values
   (451, 'LC_OPENING', 'LC Opening', 1, sysdate, 
    NULL, NULL, 'T_IMPORTS_MENU', 54, 'Y', 
    'T', 451);
--
-- SYS_SCR_OPTIONS
--1-VIEW, 2-ADD, 3-EDIT, 4-APPROVE, 5-Un-approve, 6-PRINT 
Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 451, 1);

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 451, 2);

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 451, 3);

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 451, 4);

--
-- SYS_USER_SCR_OPTIONS
--
insert into sys_user_scr_options
select SYS_USER_SCR_OPT_ID_S.nextval, 451, sso.scr_opt_id, 'N', u.user_id, sysdate, 1
from sys_users u, sys_scr_options sso
where sso.scr_id = 451;

update sys_user_scr_options
set opt = 'Y'
where user_id = 1
and opt = 'N';

delete from sys_screens where scr_id = 109;
delete from SYS_SCR_OPTIONS where scr_id = 109;
delete from SYS_USER_SCR_OPTIONS where scr_id = 109;
--
-- SYS_SCREENS
--
Insert into SYS_SCREENS
   (SCR_ID, SCR_NAME, SCR_DESC, CREATED_BY, CREATION_DATE, 
    LAST_UPDATE_BY, LAST_UPDATE_DATE, MENU_NAME, PARANT_VAL, SCREEN, 
    MENU_TYPE, SCR_NO)
 Values
   (320, 'PROFORMA_INVOICE', 'Proforma Invoice', 1, sysdate, 
    NULL, NULL, 'T_IMPORTS_MENU', 54, 'Y', 
    'T', 320);
--
-- SYS_SCR_OPTIONS
--1-VIEW, 2-ADD, 3-EDIT, 4-APPROVE, 5-Un-approve, 6-PRINT --scr_options
Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 320, 1);

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 320, 2);

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 320, 3);

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 320, 39);

Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 320, 9);

--
-- SYS_USER_SCR_OPTIONS
--
insert into sys_user_scr_options
select SYS_USER_SCR_OPT_ID_S.nextval, 320, sso.scr_opt_id, 'N', u.user_id, sysdate, 1
from sys_users u, sys_scr_options sso
where sso.scr_id = 320;

update sys_user_scr_options
set opt = 'Y'
where user_id = 1
and opt = 'N';

CREATE OR REPLACE FORCE VIEW INV_GRN_IMP_TRANSFER_V
(
   ORDERBY,
   CCN_ID,
   ACCOUNT_ID,
   CREATION_DATE,
   DR,
   CR,
   NARRATION,
   SUB_ACCOUNT_CODE
)
AS
     SELECT   1 AS orderby,
              iic.ccn_id,
              TO_NUMBER (GET_SYS_PARMS_VALUE (17)) ACCOUNT_ID, --V.PAYABLE_ACCOUNT_ID ACCOUNT_ID,
              IC.CREATION_DATE,
              0 dr,
              ROUND (II.VALUE * IC.EXCH_RATE) cr,
              'IMPORT AGAINST CCN #' || IC.CCN_NO AS NARRATION,
              NULL sub_acc_code
       FROM   IMP_CCNS IC,
              inv_irn_import_charges IIC,
              inv_irns I,
              INV_IRN_ITEMS II,
              INV_IGPS IG,
              INV_VENDORS V
      WHERE       IC.CCN_ID = IIC.CCN_ID
              AND I.IRN_ID = II.IRN_ID
              AND IC.IGP_ID = I.IGP_ID
              AND I.IGP_ID = IG.IGP_ID
              AND IG.VENDOR_ID = V.VENDOR_ID
              AND NVL (II.VALUE, 0) > 0
   GROUP BY   iic.ccn_id,
              --V.PAYABLE_ACCOUNT_ID,
              IC.CREATION_DATE,
              II.VALUE,
              IC.EXCH_RATE,
              IC.CCN_NO
   --IC.sub_acc_code
   UNION ALL
     SELECT   2 AS orderby,
              iic.ccn_id,
              IIC.GL_LC_ACC_ID ACCOUNT_ID,
              IC.CREATION_DATE,
              0 dr,
              ROUND (iic.exp_amount) cr,
              'IMPORT AGAINST CCN #' || IC.CCN_NO AS NARRATION,
              IC.sub_acc_code sub_acc_code
       FROM   IMP_CCNS IC, inv_irn_import_charges IIC
      WHERE   IC.CCN_ID = IIC.CCN_ID AND NVL (IIC.EXP_AMOUNT, 0) > 0
   GROUP BY   iic.ccn_id,
              IIC.GL_LC_ACC_ID,
              IC.CREATION_DATE,
              IIC.EXP_AMOUNT,
              IC.CCN_NO,
              IC.SUB_ACC_CODE
   UNION ALL
     SELECT   3 AS orderby,
              iic.ccn_id,
              IIC.GL_LC_ACC_ID ACCOUNT_ID,
              IC.CREATION_DATE,
              0 dr,
              ROUND (ic.fr * IC.EXCH_RATE) cr,
              'IMPORT AGAINST CCN #' || IC.CCN_NO AS NARRATION,
              NULL sub_acc_code
       FROM   IMP_CCNS IC,
              inv_irn_import_charges IIC,
              inv_irns I,
              INV_IRN_ITEMS II,
              INV_INDENTS IND,
              INV_ITEMS ITEM
      WHERE       IC.CCN_ID = IIC.CCN_ID
              AND I.IRN_ID = II.IRN_ID
              AND IC.IGP_ID = I.IGP_ID
              AND II.INDENT_ID = IND.INDENT_ID
              AND IND.ITEM_ID = ITEM.ITEM_ID
              AND NVL (IC.FR, 0) > 0
   GROUP BY   iic.ccn_id,
              IIC.GL_LC_ACC_ID,
              IC.CREATION_DATE,
              IC.FR,
              IC.EXCH_RATE,
              IC.CCN_NO
   UNION ALL
     SELECT   4 AS orderby,
              iic.ccn_id,
              TO_NUMBER (ITEM.GL_ASSET_ACC_ID) ACCOUNT_ID,
              IC.CREATION_DATE,
              ROUND (II.PKR_VALUE) dr,
              0 cr,
              'IMPORT AGAINST CCN #' || IC.CCN_NO AS NARRATION,
              NULL sub_acc_code
       FROM   IMP_CCNS IC,
              inv_irn_import_charges IIC,
              inv_irns I,
              INV_IRN_ITEMS II,
              INV_INDENTS IND,
              INV_ITEMS ITEM
      WHERE       IC.CCN_ID = IIC.CCN_ID
              AND I.IRN_ID = II.IRN_ID
              AND IC.IGP_ID = I.IGP_ID
              AND II.INDENT_ID = IND.INDENT_ID
              AND IND.ITEM_ID = ITEM.ITEM_ID
              AND NVL (II.PKR_VALUE, 0) > 0
   GROUP BY   IIC.CCN_ID,
              TO_NUMBER (ITEM.GL_ASSET_ACC_ID),
              IC.CREATION_DATE,
              II.PKR_VALUE,
              IC.CCN_NO
   ORDER BY   ORDERBY, CCN_ID;

CREATE OR REPLACE FUNCTION inv_imp_voucher (IMP_ID IN NUMBER, user_id IN NUMBER, V_ID NUMBER) RETURN NUMBER
IS
   branch             VARCHAR2 (2);
   company            NUMBER (16);
   v_no               NUMBER;
   v_voucher_id       NUMBER;
   v_voucher_no       NUMBER;
   acc_date           DATE;   
BEGIN
    if v_id is null then 
       SELECT gl_voucher_id_s.NEXTVAL INTO v_voucher_id FROM DUAL;
        
       SELECT CREATION_DATE, COMPANY_ID, BRANCH_ID 
       INTO acc_date, company, branch 
       FROM IMP_CCNS
       WHERE CCN_ID = IMP_ID;    
       v_voucher_no:=Get_Voucher_No (ACC_DATE,'JVG',BRANCH,COMPANY);          
       INSERT INTO GL_VOUCHERS
                   (voucher_id, voucher_type, voucher_no, voucher_date,
                    description, created_by, creation_date,
                    last_updated_by, last_updated_date, status,
                    approved_by, approval_date, posted_by, posting_date, module,
                    module_doc, module_doc_id, company_id, branch_id
                   )
            SELECT v_voucher_id, 'JVG', v_voucher_no, acc_date,
                    'ENTRY against CCN# ' || ic.ccn_no, user_id, SYSDATE,
                    user_id, SYSDATE, 'APPROVED',
                    user_id, SYSDATE, user_id, SYSDATE, 'IMP',
                    'IMP', ic.ccn_id, company, branch
                    FROM IMP_CCNS IC
                    WHERE  IC.CCN_id = imp_id;
    else
       v_voucher_id := v_id;
    end if;
--********************
      INSERT INTO GL_VOUCHER_ACCOUNTS
                  (voucher_account_id, voucher_id, account_id,SUB_ACCOUNT_CODE, debit, credit,
                   naration, created_by, creation_date, last_updated_by,
                   last_update_date, reference_id)
            SELECT gl_voucher_account_id_s.NEXTVAL,v_voucher_id, v.account_id,V.SUB_ACCOUNT_CODE, v.dr, v.cr, 
                   v.narration, user_id, SYSDATE, user_id, SYSDATE, v.ccn_id
              FROM INV_GRN_IMP_TRANSFER_V v
             WHERE v.ccn_id = imp_id;
   RETURN v_voucher_id;
END;
/

create or replace Procedure import_costing(p_ccn_id number, userid  number) is
    exchage_rate number(12,4);
    lc_account number;
    irnid   number;
    v_no number;
    grnid number;
    user_id number;
begin
    --update exchange rate
    update inv_irns i
    set (exch_rate,exch_rate_date) =  
        (select exch_rate,exch_rate_date 
           from imp_ccns 
           where ccn_id =i.ccn_id and i.ccn_id = p_ccn_id)
    where i.ccn_id = p_ccn_id
    and I.IRN_ID = irnid;
            
    --get total expenses for ccn
    select unique exch_rate into exchage_rate
    from inv_irns
    where ccn_id = p_ccn_id;

    --update pkr value
    ----update inv_irn_items it
    ---set pkr_value = (it.value * exchage_rate) + it.CHARGES
    ---where irn_id in (select irn_id from inv_irns where ccn_id = p_ccn_id);

    --update pkr rate
    ---update inv_irn_items
    ---set pkr_rate = pkr_value/accepted_qty
    ---where irn_id in (select irn_id from inv_irns where ccn_id = p_ccn_id);

    --update grn
    --update inv_grn_items it
    --set (rate,value) = (select pkr_rate,pkr_value from inv_irn_items where irn_item_id=it.irn_item_id)
    --where irn_id in (select irn_id from inv_irns where ccn_id = p_ccn_id);

    --Update Done
    UPDATE INV_IRNS
    SET (IS_DONE,ccn_status,gl_lc_acc_id)=(select 'Y','APPROVED',gl_lc_acc_id from imp_ccns where ccn_id=p_ccn_id)
    WHERE ccn_ID=p_ccn_id;

    --Update LC ACC ID in GRN--
    select irn_id,created_by into irnid,user_id from inv_irns where ccn_id = p_ccn_id;

    --UPDATE INV_GRNS
    --SET (GL_UNBILLED_ACCOUNT_ID)=(select gl_lc_acc_id from imp_ccns where ccn_id=p_ccn_id)
    --WHERE irn_id=irnid;

    --Delete Voucher lines
    ---select voucher_id,grn_id into v_no,grnid from inv_grns where irn_id=irnid;
    ---delete from gl_voucher_accounts where voucher_id=v_no;

    --regenerate voucher accounts
    v_no := inv_imp_voucher(p_ccn_id, user_id,v_no);

    --Update CCN Status
    UPDATE IMP_CCNS
    SET CCN_STATUS='APPROVED', approved_by=userid, approval_date=sysdate, voucher_id=v_no
    WHERE CCN_ID=p_ccn_id;

    --update irn status from closed IRNS
    update inv_irns i
    set irn_status = 'CLOSED'
    where irn_id in (select irn_id from inv_grns where irn_id = i.irn_id)
    AND i.irn_status = 'APPROVED';
end;

CREATE OR REPLACE FUNCTION inv_grn_voucher (g_id IN NUMBER, user_id IN NUMBER, V_ID NUMBER) RETURN NUMBER
IS
   branch             VARCHAR2 (2);
   company            NUMBER (16);
   v_no               NUMBER;
   v_voucher_id       NUMBER;
   v_voucher_no       NUMBER;
   acc_date           DATE;   
BEGIN

if v_id is null then 
   SELECT gl_voucher_id_s.NEXTVAL    INTO v_voucher_id   FROM DUAL;
    
   SELECT creation_date, company_id, branch_id 
   INTO acc_date, company, branch 
   FROM INV_GRNS
   WHERE grn_id = g_id;    
   v_voucher_no:=Get_Voucher_No (ACC_DATE,'JVG',BRANCH,COMPANY);          
   INSERT INTO GL_VOUCHERS
               (voucher_id, voucher_type, voucher_no, voucher_date,
                description, created_by, creation_date,
                last_updated_by, last_updated_date, status,
                approved_by, approval_date, posted_by, posting_date, module,
                module_doc, module_doc_id, company_id, branch_id
               )
        SELECT v_voucher_id, 'JVG', v_voucher_no, acc_date,
                'ENTRY against GRN# ' || ig.grn_no, user_id, SYSDATE,
                user_id, SYSDATE, 'APPROVED',
                user_id, SYSDATE, user_id, SYSDATE, 'AP',
                'GRN', ig.grn_id, company, branch
                FROM INV_GRNS ig
                WHERE  ig.grn_id = g_id;
else
   v_voucher_id := v_id;
end if;

--********************
      INSERT INTO GL_VOUCHER_ACCOUNTS
                  (voucher_account_id, voucher_id, account_id, debit, credit,
                   naration, created_by, creation_date, last_updated_by,
                   last_update_date, reference_id)
            SELECT gl_voucher_account_id_s.NEXTVAL,v_voucher_id, v.account_id, v.dr, v.cr, 
                   v.naration, user_id, SYSDATE, user_id, SYSDATE, v.grn_id
              FROM inv_grn_transfer_v v
             WHERE v.grn_id = g_id;
   RETURN v_voucher_id;

END;
/

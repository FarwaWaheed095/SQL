CREATE TABLE INV_PURCHASE_RETURN_LOCATORS
(
  PR_LOCATOR_ID     NUMBER(16) primary key,
  PR_ID             NUMBER(16),
  PR_ITEM_ID        NUMBER(16),
  LOCATOR_ID        NUMBER(16),
  ITEM_ID           NUMBER(16),
  QTY               NUMBER(20,6),
  EXPIRY_DATE       DATE,
  CREATED_BY        NUMBER(16),
  CREATION_DATE     DATE,
  LAST_UPDATED_BY   NUMBER(16),
  LAST_UPDATE_DATE  DATE,
  STORE_ID          NUMBER(16)
);

alter table INV_PURCHASE_RETURN_ITEMS
add (
    LOT_ID          NUMBER(16),
    GRN_ITEM_ID     NUMBER(16),
    INDENT_ID       NUMBER(16),
    EXPIRY_DATE     DATE
);



alter table INV_PURCHASE_RETURNS
add (
    REPLACEMENT_REQ     VARCHAR2(30),
    INVOICE_REQ         VARCHAR2(30)
);


update sys_screens set scr_id = 328 where scr_id=285;

update sys_scr_options set scr_id = 328 where scr_id=285;

update sys_user_scr_options set scr_id = 328 where scr_id=285;

update sys_screens set scr_id=285 where scr_id=278;

update sys_scr_options set scr_id=285 where scr_id=278;

update sys_user_scr_options set scr_id=285 where scr_id=278;


Insert into SYS_SCR_OPTIONS
   (SYS_SCR_OPT_ID, SCR_ID, SCR_OPT_ID)
 Values
   (SYS_SCR_OPT_ID_S.NEXTVAL, 285, 6);
   
--
-- SYS_USER_SCR_OPTIONS
--
insert into sys_user_scr_options
select SYS_USER_SCR_OPT_ID_S.nextval, 285, 6, 'N', u.user_id, sysdate, 1
from sys_users u;

update sys_user_scr_options
set opt = 'Y'
where user_id = 1
and opt = 'N';

--DROP SEQUENCE INV_PR_LOCATOR_ID_S;

CREATE SEQUENCE INV_PR_LOCATOR_ID_S
  START WITH 1
  MAXVALUE 99999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;


CREATE TABLE INV_LOTS
(
  LOT_ID            NUMBER(16) primary key,
  LOT_NO            VARCHAR2(99 BYTE),
  REMARKS           VARCHAR2(900 BYTE),
  COMPANY_ID        NUMBER(16),
  BRANCH_ID         VARCHAR2(55 BYTE),
  CREATED_BY        NUMBER(16),
  CREATION_DATE     DATE,
  LAST_UPDATED_BY   NUMBER(16),
  LAST_UPDATE_DATE  DATE,
  LOT_DATE          DATE,
  LOT_CLOSED        VARCHAR2(1 BYTE),
  ITEM_ID           NUMBER(16),
  LOT_STATUS        VARCHAR2(55 BYTE),
  APPROVED_BY       NUMBER(16),
  APPROVED_DATE     DATE,
  CONE_SIZE         VARCHAR2(20 BYTE),
  CONE_COLOR        VARCHAR2(30 BYTE),
  CLOSE_DATE        DATE,
  COTTON            VARCHAR2(1 BYTE),
  VENDOR_ID         NUMBER(16),
  ACTUAL_WEIGHT     NUMBER(16,4),
  HO_WEIGHT         NUMBER(16,4),
  IGP_ID            NUMBER(16),
  IRN_ID            NUMBER(16),
  GRN_ID            NUMBER(16),
  DOC_ID            NUMBER(16),
  LOT_TYPE          VARCHAR2(55 BYTE),
  DOC_ITEM_ID       NUMBER(16)
);


alter table inv_irn_items
add (SAP_NO             VARCHAR2(55),
     BATCH_NO           VARCHAR2(99),
     PROCESSED          VARCHAR2(55),
     OGP_REQ            VARCHAR2(55),
     EXPIRY_DATE        DATE,
     QC_NO              VARCHAR2(55),
     MANUFACTURING_DATE DATE
     );

CREATE TABLE INV_SIN_MIR_LOCATORS
(
  SIN_MIR_LOCATOR_ID  NUMBER(16) primary key,
  SIN_MIR_ID          NUMBER(16),
  SIN_ID              NUMBER(16),
  REQUEST_ID          NUMBER(16),
  MIR_ID              NUMBER(16),
  ITEM_LOCATOR_ID     NUMBER(16),
  ITEM_ID             NUMBER(16),
  QTY                 NUMBER(16,4),
  CREATED_BY          NUMBER(16)                NOT NULL,
  CREATION_DATE       DATE                      NOT NULL,
  LAST_UPDATED_BY     NUMBER(16)                NOT NULL,
  LAST_UPDATE_DATE    DATE                      NOT NULL,
  LOT_ID              NUMBER(16),
  EXPIRY_DATE         DATE
);

CREATE TABLE INV_SRN_ITEM_LOCATORS
(
  SRN_ITEM_LOCATOR_ID  NUMBER(16) primary key,
  SRN_ID               NUMBER(16),
  SRN_MRR_ID           NUMBER(16),
  MRR_ID               NUMBER(16),
  ITEM_ID              NUMBER(16),
  ITEM_LOCATOR_ID      NUMBER(16),
  LOT_ID               NUMBER(16),
  QTY                  NUMBER(20,6),
  CREATED_BY           NUMBER(16),
  CREATION_DATE        DATE,
  LAST_UPDATED_BY      NUMBER(16),
  LAST_UDPATE_DATE     DATE,
  EXPIRY_DATE          DATE
);


CREATE TABLE INV_STN_LOCATORS
(
  STN_LOCATOR_ID    NUMBER(16),
  TRANSFER_ID       NUMBER(16),
  STN_ITEM_ID       NUMBER(16),
  ITEM_LOCATOR_ID   NUMBER(16),
  LOT_ID            NUMBER(16),
  ITEM_ID           NUMBER(16),
  STORE_ID          NUMBER(16),
  QTY               NUMBER(20,6),
  STN_LOCATOR_TYPE  VARCHAR2(50 BYTE),
  EXPIRY_DATE       DATE,
  CREATED_BY        NUMBER(16),
  CREATION_DATE     DATE,
  LAST_UPDATED_BY   NUMBER(16),
  LAST_UPDATE_DATE  DATE
);

CREATE TABLE INV_BRANCH_TRANSFER_LOCATORS
(
  BTN_LOCATOR_ID    NUMBER(16) primary key,
  BTN_ID            NUMBER(16),
  BTN_ITEM_ID       NUMBER(16),
  STORE_ID          NUMBER(16),
  LOCATOR_ID        NUMBER(16),
  LOT_ID            NUMBER(16),
  ITEM_ID           NUMBER(16),
  QTY               NUMBER(20,6),
  BTN_LOCATOR_TYPE  VARCHAR2(50 BYTE),
  EXPIRY_DATE       DATE,
  CREATED_BY        NUMBER(16),
  CREATION_DATE     DATE,
  LAST_UPDATED_BY   NUMBER(16),
  LAST_UPDATE_DATE  DATE
);

CREATE TABLE INV_GRN_ITEM_LOCATORS
(
  GRN_ITEM_LOCATOR_ID  NUMBER(16) primary key,
  GRN_ITEM_ID          NUMBER(16),
  GRN_ID               NUMBER(16),
  IRN_ITEM_ID          NUMBER(16),
  IRN_ID               NUMBER(16),
  INDENT_ID            NUMBER(16),
  ITEM_ID              NUMBER(16),
  ITEM_LOCATOR_ID      NUMBER(16),
  QTY                  NUMBER(20,6),
  CREATED_BY           NUMBER(16),
  CREATION_DATE        DATE,
  LAST_UPDATED_BY      NUMBER(16),
  LAST_UDPATE_DATE     DATE
);


alter table inv_adjs
add (
    BATCH_NO    VARCHAR2(200),
    EXPIRY_DATE    DATE,
    LOT_ID    NUMBER(16)
    );

CREATE TABLE INV_ADJ_ITEM_LOCATORS
(
  ADJ_ITEM_LOCATOR_ID  NUMBER(16) primary key,
  ITEM_ID              NUMBER(16),
  ITEM_LOCATOR_ID      NUMBER(16),
  QTY                  NUMBER(20,6),
  CREATED_BY           NUMBER(16),
  CREATION_DATE        DATE,
  LAST_UPDATED_BY      NUMBER(16),
  LAST_UDPATE_DATE     DATE,
  ADJ_ID               NUMBER(8)
);

alter table inv_grn_items
add LOT_ID    NUMBER(16); 

alter table inv_items
add IS_LOT  varchar2(1);

alter table inv_locators
add STORE_ID    NUMBER(16);

CREATE TABLE SYS_USER_STORES
(
  USER_STORE_ID     NUMBER(16) primary key,
  CREATED_BY        NUMBER(16),
  CREATION_DATE     DATE,
  LAST_UPDATED_BY   NUMBER(16),
  LAST_UPDATE_DATE  DATE,
  STORE_ID          NUMBER(16),
  USER_ID           NUMBER(16),
  VIEW_OPT          CHAR(1 BYTE),
  ACTIVE            CHAR(1 BYTE)
);

CREATE TABLE SYS_USER_COST_CENTERS
(
  USER_CC_ID        NUMBER(16) primary key,
  CREATED_BY        NUMBER(16),
  CREATION_DATE     DATE,
  LAST_UPDATED_BY   NUMBER(16),
  LAST_UPDATE_DATE  DATE,
  CC_ID             NUMBER(16),
  USER_ID           NUMBER(16),
  VIEW_OPT          CHAR(1 BYTE),
  ACTIVE            CHAR(1 BYTE)
);

CREATE OR REPLACE FORCE VIEW INV_LOT_STOCK_LEDGER
(
   PRIORITY,
   TRAN_ID,
   TRAN_TYPE,
   TRAN_DATE,
   TRAN_NO,
   REF_RENCE1,
   ITEM_ID,
   RATE,
   QTY,
   AMOUNT,
   REMARKS,
   COMPANY_ID,
   BRANCH_ID,
   SHORT_DATE,
   STORE_ID,
   LOT_ID,
   LOT_NO,
   EXPIRY_DATE,
   STATUS
)
AS
   SELECT   0 priority,
            GR.GRN_ID,
            'GRN' tran_type,
            TO_DATE (GR.creation_date, 'DD-MON-YY') tran_date,
            GR.grn_no tran_no,
            'PO # '
            || (SELECT   po_no
                  FROM   inv_pos
                 WHERE   po_id = GR.PO_ID)
               ref_rence1,
            GI.item_id,
            GI.rate,
            GI.RECEIVED_QTY qty,
            GI.VALUE amount,
            (SELECT   v.vendor_name
               FROM   INV_VENDORS V, INV_IRNS IR
              WHERE   V.VENDOR_ID = IR.VENDOR_ID AND IR.IRN_ID = GR.IRN_ID)
               remarks,
            TO_NUMBER (GR.company_id),
            GR.branch_id,
            GR.creation_date short_date,
            GR.store_id,
            GI.lot_id,
            L.LOT_NO,
            IR.EXPIRY_DATE,
            GR.GRN_STATUS STATUS
     FROM   INV_GRNS GR,
            INV_GRN_ITEMS GI,
            INV_LOTS L,
            INV_IRN_ITEMS IR
    WHERE       GR.GRN_ID = GI.GRN_ID
            AND GI.IRN_ID = IR.IRN_ID
            AND GI.LOT_ID = L.LOT_ID
            AND GI.IRN_ITEM_ID = IR.IRN_ITEM_ID
            AND L.LOT_TYPE = 'GRN'
            AND L.DOC_ID = GI.GRN_ID
            AND L.DOC_ITEM_ID = GI.GRN_ITEM_ID
   UNION ALL
   SELECT   0 priority,
            AD.ADJ_ID,
            'ADJ' tran_type,
            TO_DATE (AD.CREATION_DATE, 'DD-MON-YY') tran_date,
            AD.ADJ_ID tran_no,
            NULL ref_rence1,
            AD.ITEM_ID,
            AD.ADJ_RATE rate,
            AD.ADJ_QTY qty,
            AD.ADJ_AMOUNT amount,
            AD.REMARKS remarks,
            TO_NUMBER (AD.company_id),
            AD.branch_id,
            AD.creation_date short_date,
            ad.store_id,
            ad.lot_id,
            L.LOT_NO,
            AD.EXPIRY_DATE,
            AD.ADJ_STATUS STATUS
     FROM   INV_ADJS AD, INV_LOTS L
    WHERE   AD.LOT_ID = L.LOT_ID AND AD.ADJ_STATUS = 'APPROVED'
   UNION ALL
   SELECT   0 priority,
            AD.ADJ_ID,
            'ADJ' tran_type,
            TO_DATE (AD.CREATION_DATE, 'DD-MON-YY') tran_date,
            AD.ADJ_ID tran_no,
            NULL ref_rence1,
            AD.ITEM_ID,
            AD.ADJ_RATE rate,
            AD.ADJ_QTY qty,
            AD.ADJ_AMOUNT amount,
            AD.REMARKS remarks,
            TO_NUMBER (AD.company_id),
            AD.branch_id,
            AD.creation_date short_date,
            ad.store_id,
            ad.lot_id,
            L.LOT_NO,
            AD.EXPIRY_DATE,
            AD.ADJ_STATUS STATUS
     FROM   INV_ADJS AD, INV_LOTS L
    WHERE       AD.LOT_ID = L.LOT_ID
            AND AD.ADJ_STATUS = 'CREATED'
            AND AD.LOT_ID IS NOT NULL
   UNION ALL
     SELECT   1 priority,
              S.SIN_ID tran_id,
              'SIN' tran_type,
              TO_DATE (S.CREATION_DATE, 'DD-MON-YY') tran_date,
              S.SIN_NO tran_no,
              'MIR # '
              || (SELECT   mir_no
                    FROM   inv_mirs
                   WHERE   mir_id = sm.mir_id)
                 ref_rence1,
              SM.item_id,
              SM.ISSUE_RATE rate,
              -SUM (SML.QTY) QTY,
              - (NVL (SM.ISSUE_RATE, 0) * NVL (SUM (SML.QTY), 0)) amount,
              S.remarks,
              TO_NUMBER (S.company_id),
              S.branch_id,
              S.CREATION_DATE short_date,
              S.STORE_ID,
              SML.lot_id,
              L.LOT_NO,
              SML.EXPIRY_DATE,
              S.SIN_STATUS STATUS
       FROM   INV_SINS S,
              INV_SIN_MIRS SM,
              INV_SIN_MIR_LOCATORS SML,
              INV_LOTS L
      WHERE       S.SIN_ID = SM.SIN_ID
              AND SML.SIN_ID = S.SIN_ID
              AND SM.SIN_MIR_ID = SML.SIN_MIR_ID
              AND SM.ITEM_ID = SML.ITEM_ID
              AND SML.LOT_ID = L.LOT_ID
   GROUP BY   S.SIN_ID,
              S.SIN_NO,
              sm.mir_id,
              SM.item_id,
              SM.ISSUE_RATE,
              S.remarks,
              S.company_id,
              S.branch_id,
              S.CREATION_DATE,
              S.STORE_ID,
              SML.lot_id,
              L.LOT_NO,
              SML.EXPIRY_DATE,
              S.SIN_STATUS
   UNION ALL
     SELECT   0 priority,
              S.SRN_ID tran_id,
              'SRN' tran_type,
              TO_DATE (S.CREATION_DATE, 'DD-MON-YY') tran_date,
              S.SRN_NO tran_no,
              'MRR # ' || MR.MRR_NO ref_rence1,
              MR.item_id,
              RETURN_RATE rate,
              SUM (SML.QTY) QTY,
              (NVL (SM.RETURN_RATE, 0) * NVL (SUM (SML.QTY), 0)) amount,
              MR.remarks,
              TO_NUMBER (S.company_id),
              S.branch_id,
              S.CREATION_DATE short_date,
              MR.STORE_ID,
              SML.lot_id,
              L.LOT_NO,
              SML.EXPIRY_DATE,
              MR.MRR_STATUS STATUS
       FROM   INV_SRNS S,
              INV_SRN_MRRS SM,
              INV_SRN_ITEM_LOCATORS SML,
              INV_LOTS L,
              INV_MRRS MR
      WHERE       S.SRN_ID = SM.SRN_ID
              AND SM.MRR_ID = MR.MRR_ID
              AND SM.SRN_ID = SML.SRN_ID
              AND SM.SRN_MRR_ID = SML.SRN_MRR_ID
              AND MR.ITEM_ID = SML.ITEM_ID
              AND SML.LOT_ID = L.LOT_ID
   GROUP BY   S.SRN_ID,
              S.SRN_NO,
              MR.item_id,
              MR.MRR_NO,
              SM.RETURN_RATE,
              MR.remarks,
              S.company_id,
              S.branch_id,
              S.CREATION_DATE,
              MR.STORE_ID,
              SML.lot_id,
              L.LOT_NO,
              SML.EXPIRY_DATE,
              MR.MRR_STATUS
   UNION ALL
     SELECT   1 priority,
              ST.TRANSFER_ID tran_id,
              'STN' tran_type,
              TO_DATE (ST.TRANSFER_DATE, 'DD-MON-YY') tran_date,
              ST.TRANSFER_NO tran_no,
              'TRANSFER NO ' || ST.TRANSFER_NO ref_rence1,
              STI.ITEM_ID,
              STI.RATE,
              -SUM (SL.QTY) QTY,
              - (NVL (STI.RATE, 0) * NVL (SUM (SL.QTY), 0)) amount,
              ST.REMARKS,
              TO_NUMBER (ST.COMPANY_ID),
              ST.BRANCH_ID,
              ST.TRANSFER_DATE short_date,
              ST.FROM_STORE_ID STORE_ID,
              SL.lot_id,
              L.LOT_NO,
              SL.EXPIRY_DATE,
              ST.STATUS
       FROM   INV_STORE_TRANSFERS ST,
              INV_STORE_TRANSFER_ITEMS STI,
              INV_STN_LOCATORS SL,
              INV_LOTS L
      WHERE       ST.TRANSFER_ID = STI.TRANSFER_ID
              AND STI.TRANSFER_ID = SL.TRANSFER_ID
              AND STI.TRANSFER_ITEM_ID = SL.STN_ITEM_ID
              AND STI.ITEM_ID = SL.ITEM_ID
              AND SL.LOT_ID = L.LOT_ID
              AND SL.STN_LOCATOR_TYPE = 'TRANSFER'
   GROUP BY   ST.TRANSFER_ID,
              ST.TRANSFER_NO,
              STI.item_id,
              STI.RATE,
              ST.REMARKS,
              ST.COMPANY_ID,
              ST.BRANCH_ID,
              ST.TRANSFER_DATE,
              ST.FROM_STORE_ID,
              SL.lot_id,
              L.LOT_NO,
              SL.EXPIRY_DATE,
              ST.STATUS
   UNION ALL
     SELECT   0 priority,
              ST.TRANSFER_ID tran_id,
              'STN' tran_type,
              TO_DATE (ST.TRANSFER_DATE, 'DD-MON-YY') tran_date,
              ST.TRANSFER_NO tran_no,
              'TRANSFER NO ' || ST.TRANSFER_NO ref_rence1,
              STI.ITEM_ID,
              STI.RATE,
              SUM (SL.QTY) QTY,
              (NVL (STI.RATE, 0) * NVL (SUM (SL.QTY), 0)) amount,
              ST.REMARKS,
              TO_NUMBER (ST.COMPANY_ID),
              ST.BRANCH_ID,
              ST.TRANSFER_DATE short_date,
              ST.FROM_STORE_ID STORE_ID,
              SL.lot_id,
              L.LOT_NO,
              SL.EXPIRY_DATE,
              ST.STATUS
       FROM   INV_STORE_TRANSFERS ST,
              INV_STORE_TRANSFER_ITEMS STI,
              INV_STN_LOCATORS SL,
              INV_LOTS L
      WHERE       ST.TRANSFER_ID = STI.TRANSFER_ID
              AND STI.TRANSFER_ID = SL.TRANSFER_ID
              AND STI.TRANSFER_ITEM_ID = SL.STN_ITEM_ID
              AND STI.ITEM_ID = SL.ITEM_ID
              AND SL.LOT_ID = L.LOT_ID
              AND SL.STN_LOCATOR_TYPE = 'RECEIVE'
   GROUP BY   ST.TRANSFER_ID,
              ST.TRANSFER_NO,
              STI.item_id,
              STI.RATE,
              ST.REMARKS,
              ST.COMPANY_ID,
              ST.BRANCH_ID,
              ST.TRANSFER_DATE,
              ST.FROM_STORE_ID,
              SL.lot_id,
              L.LOT_NO,
              SL.EXPIRY_DATE,
              ST.STATUS
   UNION ALL
     SELECT   1 priority,
              BT.TRANSFER_ID tran_id,
              'BTN' tran_type,
              TO_DATE (BT.TRANSFER_DATE, 'DD-MON-YY') tran_date,
              BT.TRANSFER_NO tran_no,
              'TRANSFER NO ' || BT.TRANSFER_NO ref_rence1,
              BTI.ITEM_ID,
              BTI.RATE,
              -SUM (BL.QTY) QTY,
              - (NVL (BTI.RATE, 0) * NVL (SUM (BL.QTY), 0)) amount,
              BT.REMARKS,
              BT.COMPANY_ID,
              BT.BRANCH_ID,
              BT.TRANSFER_DATE short_date,
              BT.FROM_STORE_ID STORE_ID,
              BL.lot_id,
              L.LOT_NO,
              BL.EXPIRY_DATE,
              BT.STATUS
       FROM   INV_BRANCH_TRANSFERS BT,
              INV_BRANCH_TRANSFER_ITEMS BTI,
              INV_BRANCH_TRANSFER_LOCATORS BL,
              INV_LOTS L
      WHERE       BT.TRANSFER_ID = BTI.TRANSFER_ID
              AND BTI.TRANSFER_ID = BL.BTN_ID
              AND BTI.TRANSFER_ITEM_ID = BL.BTN_ITEM_ID
              AND BTI.ITEM_ID = BL.ITEM_ID
              AND BL.LOT_ID = L.LOT_ID
              AND BL.BTN_LOCATOR_TYPE = 'TRANSFER'
   GROUP BY   BT.TRANSFER_ID,
              BT.TRANSFER_NO,
              BTI.item_id,
              BTI.RATE,
              BT.REMARKS,
              BT.COMPANY_ID,
              BT.BRANCH_ID,
              BT.TRANSFER_DATE,
              BT.FROM_STORE_ID,
              BL.lot_id,
              L.LOT_NO,
              BL.EXPIRY_DATE,
              BT.STATUS
   UNION ALL
     SELECT   0 priority,
              BT.TRANSFER_ID tran_id,
              'BTN' tran_type,
              TO_DATE (BT.TRANSFER_DATE, 'DD-MON-YY') tran_date,
              BT.TRANSFER_NO tran_no,
              'TRANSFER NO ' || BT.TRANSFER_NO ref_rence1,
              BTI.ITEM_ID,
              BTI.RATE,
              SUM (BL.QTY) QTY,
              (NVL (BTI.RATE, 0) * NVL (SUM (BL.QTY), 0)) amount,
              BT.REMARKS,
              BT.COMPANY_ID,
              BT.TO_BRANCH_ID,
              BT.TRANSFER_DATE short_date,
              BT.TO_STORE_ID STORE_ID,
              BL.lot_id,
              L.LOT_NO,
              BL.EXPIRY_DATE,
              BT.STATUS
       FROM   INV_BRANCH_TRANSFERS BT,
              INV_BRANCH_TRANSFER_ITEMS BTI,
              INV_BRANCH_TRANSFER_LOCATORS BL,
              INV_LOTS L
      WHERE       BT.TRANSFER_ID = BTI.TRANSFER_ID
              AND BTI.TRANSFER_ID = BL.BTN_ID
              AND BTI.TRANSFER_ITEM_ID = BL.BTN_ITEM_ID
              AND BTI.ITEM_ID = BL.ITEM_ID
              AND BL.LOT_ID = L.LOT_ID
              AND BL.BTN_LOCATOR_TYPE = 'RECEIVE'
   GROUP BY   BT.TRANSFER_ID,
              BT.TRANSFER_NO,
              BTI.item_id,
              BTI.RATE,
              BT.REMARKS,
              BT.COMPANY_ID,
              BT.TO_BRANCH_ID,
              BT.TRANSFER_DATE,
              BT.TO_STORE_ID,
              BL.lot_id,
              L.LOT_NO,
              BL.EXPIRY_DATE,
              BT.STATUS
   UNION ALL
   SELECT   1 priority,
            PR.PR_ID tran_id,
            'PRN' tran_type,
            TO_DATE (PR.PR_DATE, 'DD-MON-YY') tran_date,
            PR.PR_NO tran_no,
            'PURCHASE RETURN NO ' || PR.PR_NO ref_rence1,
            PRI.ITEM_ID,
            PRI.RATE,
            -NVL (PRI.QTY, 0) qty,
            - (NVL (PRI.RATE, 0) * NVL (PRI.QTY, 0)) amount,
            PR.REMARKS,
            PR.COMPANY_ID,
            PR.BRANCH_ID,
            PR.CREATION_DATE short_date,
            PR.STORE_ID,
            PRI.LOT_ID,
            L.LOT_NO,
            PRI.EXPIRY_DATE,
            PR.PR_STATUS STATUS
     FROM   INV_PURCHASE_RETURNS PR,
            INV_PURCHASE_RETURN_ITEMS PRI,
            INV_LOTS L
    WHERE   PR.PR_ID = PRI.PR_ID AND PRI.LOT_ID = L.LOT_ID --AND PR.PR_STATUS = 'APPROVED'
   ORDER BY   item_id, short_date, priority;



CREATE OR REPLACE FORCE VIEW INV_LOCATOR_LEDGER
(
   PRIORITY,
   TRAN_TYPE,
   TRAN_DATE,
   TRAN_NO,
   TRAN_ID,
   ITEM_LOCATOR_ID,
   REF_RENCE1,
   ITEM_ID,
   RATE,
   QTY,
   AMOUNT,
   REMARKS,
   COMPANY_ID,
   BRANCH_ID,
   SHORT_DATE,
   STORE_ID,
   BATCH_ID,
   VOUCHER_ID,
   LOT_ID,
   LOT_NO,
   EXPIRY_DATE
)
AS
   SELECT   0 priority,
            'GRN' tran_type,
            TO_DATE (GR.creation_date, 'DD-MON-YY') tran_date,
            GR.grn_no tran_no,
            GR.grn_id tran_id,
            GIL.ITEM_LOCATOR_ID,
            'indent # ' || I.indent_no ref_rence1,
            GRI.item_id,
            GRI.rate AS rate,
            GIL.QTY,
            (GRI.rate * GIL.QTY) amount,
            (SELECT   v.vendor_name
               FROM   INV_GRNS g, INV_POS p, INV_VENDORS v
              WHERE       g.po_id = p.po_id
                      AND v.vendor_id = p.vendor_id
                      AND g.grn_id = GRI.grn_id)
               remarks,
            TO_NUMBER (GR.company_id),
            GR.branch_id,
            GR.creation_date short_date,
            GR.store_id,
            NULL,
            GR.VOUCHER_ID,
            L.LOT_ID,
            L.LOT_NO,
            EXPIRY_DATE
     FROM   INV_GRN_ITEMS GRI,
            INV_GRNS GR,
            INV_INDENTS I,
            INV_GRN_ITEM_LOCATORS GIL,
            INV_IRN_ITEMS IR,
            INV_LOTS L
    WHERE       GRI.grn_id = GR.grn_id
            AND GRI.indent_id = I.indent_id
            AND GRI.GRN_ID = GIL.GRN_ID
            AND GRI.GRN_ITEM_ID = GIL.GRN_ITEM_ID
            AND GRI.ITEM_ID = GIL.ITEM_ID
            AND IR.IRN_ID = GRI.IRN_ID
            AND IR.IRN_ITEM_ID = GRI.IRN_ITEM_ID
            AND GRI.LOT_ID = L.LOT_ID(+)--AND L.LOT_TYPE = 'GRN' AND L.DOC_ID = GRI.GRN_ID AND L.DOC_ITEM_ID = GRI.GRN_ITEM_ID
   UNION ALL
   SELECT   0 priority,
            'ADJ' tran_type,
            TO_DATE (AD.CREATION_DATE, 'DD-MON-YY') tran_date,
            AD.ADJ_ID tran_no,
            AD.ADJ_ID TRAN_ID,
            AIL.ITEM_LOCATOR_ID,
            NULL ref_rence1,
            AD.ITEM_ID,
            AD.ADJ_RATE rate,
            AIL.qty,
            NVL (AD.ADJ_RATE, 0) * NVL (AIL.qty, 0) amount,
            AD.REMARKS remarks,
            TO_NUMBER (AD.company_id),
            AD.branch_id,
            AD.creation_date short_date,
            ad.store_id,
            NULL,
            NULL,
            ad.lot_id,
            L.LOT_NO,
            AD.EXPIRY_DATE
     FROM   INV_ADJS AD, INV_LOTS L, INV_ADJ_ITEM_LOCATORS AIL
    WHERE       AD.LOT_ID = L.LOT_ID(+)
            AND AD.ADJ_ID = AIL.ADJ_ID --AND L.LOT_TYPE = 'ADJ' AND AD.ADJ_ID = L.DOC_ID
            AND AD.ADJ_STATUS = 'APPROVED'
   UNION ALL
   SELECT   0 priority,
            'ADJ' tran_type,
            TO_DATE (AD.CREATION_DATE, 'DD-MON-YY') tran_date,
            AD.ADJ_ID tran_no,
            AD.ADJ_ID TRAN_ID,
            AIL.ITEM_LOCATOR_ID,
            NULL ref_rence1,
            AD.ITEM_ID,
            AD.ADJ_RATE rate,
            AIL.qty,
            NVL (AD.ADJ_RATE, 0) * NVL (AIL.qty, 0) amount,
            AD.REMARKS remarks,
            TO_NUMBER (AD.company_id),
            AD.branch_id,
            AD.creation_date short_date,
            ad.store_id,
            NULL,
            NULL,
            ad.lot_id,
            L.LOT_NO,
            AD.EXPIRY_DATE
     FROM   INV_ADJS AD, INV_LOTS L, INV_ADJ_ITEM_LOCATORS AIL
    WHERE       AD.LOT_ID = L.LOT_ID
            AND AD.LOT_ID IS NOT NULL
            AND NVL (AIL.QTY, 0) < 0
            AND AD.ADJ_ID = AIL.ADJ_ID --AND L.LOT_TYPE = 'ADJ' AND AD.ADJ_ID = L.DOC_ID
            AND AD.ADJ_STATUS = 'CREATED'
   UNION ALL
   SELECT   0 priority,
            'ADJ' tran_type,
            TO_DATE (AD.CREATION_DATE, 'DD-MON-YY') tran_date,
            AD.ADJ_ID tran_no,
            AD.ADJ_ID TRAN_ID,
            AIL.ITEM_LOCATOR_ID,
            NULL ref_rence1,
            AD.ITEM_ID,
            AD.ADJ_RATE rate,
            AIL.qty,
            NVL (AD.ADJ_RATE, 0) * NVL (AIL.qty, 0) amount,
            AD.REMARKS remarks,
            TO_NUMBER (AD.company_id),
            AD.branch_id,
            AD.creation_date short_date,
            ad.store_id,
            NULL,
            NULL,
            ad.lot_id,
            L.LOT_NO,
            AD.EXPIRY_DATE
     FROM   INV_ADJS AD, INV_LOTS L, INV_ADJ_ITEM_LOCATORS AIL
    WHERE       AD.LOT_ID = L.LOT_ID(+)
            AND NVL (AIL.QTY, 0) < 0
            AND ad.lot_id IS NULL
            AND AD.ADJ_ID = AIL.ADJ_ID --AND L.LOT_TYPE = 'ADJ' AND AD.ADJ_ID = L.DOC_ID
            AND AD.ADJ_STATUS = 'CREATED'
   UNION ALL
   SELECT   1 priority,
            'SIN' tran_type,
            TO_DATE (S.CREATION_DATE, 'DD-MON-YY') tran_date,
            S.SIN_NO tran_no,
            S.SIN_ID tran_id,
            SML.ITEM_LOCATOR_ID,
            ' ' ref_rence1,
            SM.item_id,
            SM.ISSUE_RATE rate,
            -SML.QTY,
            - (NVL (SM.ISSUE_RATE, 0) * NVL (SML.QTY, 0)) amount,
            S.remarks,
            TO_NUMBER (S.company_id),
            S.branch_id,
            S.CREATION_DATE short_date,
            S.STORE_ID,
            NULL,
            S.VOUCHER_ID,
            L.LOT_ID,
            L.LOT_NO,
            SML.EXPIRY_DATE
     FROM   INV_SINS S,
            INV_SIN_MIRS SM,
            INV_SIN_MIR_LOCATORS SML,
            INV_LOTS L
    WHERE       S.SIN_ID = SM.SIN_ID
            AND SML.SIN_ID = S.SIN_ID
            AND SM.SIN_MIR_ID = SML.SIN_MIR_ID
            AND SM.ITEM_ID = SML.ITEM_ID
            AND SML.LOT_ID = L.LOT_ID(+)
   UNION ALL
   SELECT   0 priority,
            'SRN' tran_type,
            TO_DATE (S.CREATION_DATE, 'DD-MON-YY') tran_date,
            S.SRN_NO tran_no,
            S.SRN_ID tran_id,
            SML.ITEM_LOCATOR_ID,
            ' ' ref_rence1,
            MR.item_id,
            SM.RETURN_RATE rate,
            SML.QTY,
            (NVL (SM.RETURN_RATE, 0) * NVL (SML.QTY, 0)) amount,
            MR.remarks,
            TO_NUMBER (S.company_id),
            S.branch_id,
            S.CREATION_DATE short_date,
            MR.STORE_ID,
            NULL BATCH_ID,
            MR.VOUCHER_ID,
            L.LOT_ID,
            L.LOT_NO,
            SML.EXPIRY_DATE
     FROM   INV_SRNS S,
            INV_SRN_MRRS SM,
            INV_SRN_ITEM_LOCATORS SML,
            INV_LOTS L,
            INV_MRRS MR
    WHERE       S.SRN_ID = SM.SRN_ID
            AND SM.MRR_ID = MR.MRR_ID
            AND SM.SRN_ID = SML.SRN_ID
            AND SM.SRN_MRR_ID = SML.SRN_MRR_ID
            AND MR.ITEM_ID = SML.ITEM_ID
            AND SML.LOT_ID = L.LOT_ID(+)
   UNION ALL
   SELECT   1 priority,
            'STN' tran_type,
            TO_DATE (ST.TRANSFER_DATE, 'DD-MON-YY') tran_date,
            ST.TRANSFER_NO tran_no,
            ST.TRANSFER_ID tran_id,
            SL.ITEM_LOCATOR_ID,
            ' ' ref_rence1,
            STI.ITEM_ID,
            STI.RATE,
            -SL.QTY,
            - (NVL (STI.RATE, 0) * NVL (SL.QTY, 0)) amount,
            ST.REMARKS,
            TO_NUMBER (ST.COMPANY_ID),
            ST.BRANCH_ID,
            ST.TRANSFER_DATE short_date,
            ST.FROM_STORE_ID STORE_ID,
            NULL BATCH_ID,
            NULL VOUCHER_ID,
            L.LOT_ID,
            L.LOT_NO,
            SL.EXPIRY_DATE
     FROM   INV_STORE_TRANSFERS ST,
            INV_STORE_TRANSFER_ITEMS STI,
            INV_STN_LOCATORS SL,
            INV_LOTS L
    WHERE       ST.TRANSFER_ID = STI.TRANSFER_ID
            AND STI.TRANSFER_ID = SL.TRANSFER_ID
            AND STI.TRANSFER_ITEM_ID = SL.STN_ITEM_ID
            AND STI.ITEM_ID = SL.ITEM_ID
            AND SL.LOT_ID = L.LOT_ID(+)
            AND SL.STN_LOCATOR_TYPE = 'TRANSFER'
   UNION ALL
   SELECT   0 priority,
            'STN' tran_type,
            TO_DATE (ST.TRANSFER_DATE, 'DD-MON-YY') tran_date,
            ST.TRANSFER_NO tran_no,
            ST.TRANSFER_ID tran_id,
            SL.ITEM_LOCATOR_ID,
            ' ' ref_rence1,
            STI.ITEM_ID,
            STI.RATE,
            SL.QTY,
            (NVL (STI.RATE, 0) * NVL (SL.QTY, 0)) amount,
            ST.REMARKS,
            TO_NUMBER (ST.COMPANY_ID),
            ST.BRANCH_ID,
            ST.TRANSFER_DATE short_date,
            ST.TO_STORE_ID STORE_ID,
            NULL BATCH_ID,
            NULL VOUCHER_ID,
            L.LOT_ID,
            L.LOT_NO,
            SL.EXPIRY_DATE
     FROM   INV_STORE_TRANSFERS ST,
            INV_STORE_TRANSFER_ITEMS STI,
            INV_STN_LOCATORS SL,
            INV_LOTS L
    WHERE       ST.TRANSFER_ID = STI.TRANSFER_ID
            AND STI.TRANSFER_ID = SL.TRANSFER_ID
            AND STI.TRANSFER_ITEM_ID = SL.STN_ITEM_ID
            AND STI.ITEM_ID = SL.ITEM_ID
            AND SL.LOT_ID = L.LOT_ID(+)
            AND SL.STN_LOCATOR_TYPE = 'RECEIVE'
   UNION ALL
   SELECT   1 priority,
            'BTN' tran_type,
            TO_DATE (BT.TRANSFER_DATE, 'DD-MON-YY') tran_date,
            BT.TRANSFER_NO tran_no,
            BT.TRANSFER_ID tran_id,
            BL.LOCATOR_ID,
            ' ' ref_rence1,
            BTI.ITEM_ID,
            BTI.RATE,
            -BL.QTY,
            - (NVL (BTI.RATE, 0) * NVL (BL.QTY, 0)) amount,
            BT.REMARKS,
            BT.COMPANY_ID,
            BT.BRANCH_ID,
            BT.TRANSFER_DATE short_date,
            BT.FROM_STORE_ID STORE_ID,
            NULL BATCH_ID,
            VOUCHER_ID_1 VOUCHER_ID,
            L.LOT_ID,
            L.LOT_NO,
            BL.EXPIRY_DATE
     FROM   INV_BRANCH_TRANSFERS BT,
            INV_BRANCH_TRANSFER_ITEMS BTI,
            INV_BRANCH_TRANSFER_LOCATORS BL,
            INV_LOTS L
    WHERE       BT.TRANSFER_ID = BTI.TRANSFER_ID
            AND BTI.TRANSFER_ID = BL.BTN_ID
            AND BTI.TRANSFER_ITEM_ID = BL.BTN_ITEM_ID
            AND BTI.ITEM_ID = BL.ITEM_ID
            AND BL.LOT_ID = L.LOT_ID(+)
            AND BL.BTN_LOCATOR_TYPE = 'TRANSFER'
   UNION ALL
   SELECT   0 priority,
            'BTN' tran_type,
            TO_DATE (BT.TRANSFER_DATE, 'DD-MON-YY') tran_date,
            BT.TRANSFER_NO tran_no,
            BT.TRANSFER_ID tran_id,
            BL.LOCATOR_ID,
            ' ' ref_rence1,
            BTI.ITEM_ID,
            BTI.RATE,
            BL.QTY,
            (NVL (BTI.RATE, 0) * NVL (BL.QTY, 0)) amount,
            BT.REMARKS,
            BT.COMPANY_ID,
            BT.TO_BRANCH_ID,
            BT.TRANSFER_DATE short_date,
            BT.TO_STORE_ID STORE_ID,
            NULL BATCH_ID,
            VOUCHER_ID_2 VOUCHER_ID,
            L.LOT_ID,
            L.LOT_NO,
            BL.EXPIRY_DATE
     FROM   INV_BRANCH_TRANSFERS BT,
            INV_BRANCH_TRANSFER_ITEMS BTI,
            INV_BRANCH_TRANSFER_LOCATORS BL,
            INV_LOTS L
    WHERE       BT.TRANSFER_ID = BTI.TRANSFER_ID
            AND BTI.TRANSFER_ID = BL.BTN_ID
            AND BTI.TRANSFER_ITEM_ID = BL.BTN_ITEM_ID
            AND BTI.ITEM_ID = BL.ITEM_ID
            AND BL.LOT_ID = L.LOT_ID(+)
            AND BL.BTN_LOCATOR_TYPE = 'RECEIVE'
   UNION ALL
   SELECT   0 priority,
            'PRN' tran_type,
            TO_DATE (PR.PR_DATE, 'DD-MON-YY') tran_date,
            PR.PR_NO tran_no,
            PR.PR_ID tran_id,
            PRL.LOCATOR_ID,
            ' ' ref_rence1,
            PRI.ITEM_ID,
            PRI.RATE,
            -PRL.QTY,
            - (NVL (PRI.RATE, 0) * NVL (PRL.QTY, 0)) amount,
            PR.remarks,
            PR.company_id,
            PR.branch_id,
            PR.CREATION_DATE short_date,
            PR.STORE_ID,
            NULL BATCH_ID,
            PR.GL_VOUCHER_ID,
            PRI.LOT_ID,
            L.LOT_NO,
            PRI.EXPIRY_DATE
     FROM   INV_PURCHASE_RETURNS PR,
            INV_PURCHASE_RETURN_ITEMS PRI,
            INV_PURCHASE_RETURN_LOCATORS PRL,
            INV_LOTS L
    WHERE       PR.PR_ID = PRI.PR_ID
            AND PRI.PR_ID = PRL.PR_ID
            AND PRI.ITEM_ID = PRL.ITEM_ID
            AND PRI.PR_ITEM_ID = PRL.PR_ITEM_ID
            AND PR.PR_STATUS = 'APPROVED'
            AND PRI.LOT_ID = L.LOT_ID(+)
   ORDER BY   item_id, short_date, priority;


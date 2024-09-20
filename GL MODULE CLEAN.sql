DELETE FROM GL_VOUCHERS;
DELETE FROM GL_VOUCHER_ACCOUNTS;

DROP SEQUENCE GL_VOUCHER_ID_S;

CREATE SEQUENCE GL_VOUCHER_ID_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;
  
DROP SEQUENCE GL_VOUCHER_ACCOUNT_ID_S;

CREATE SEQUENCE GL_VOUCHER_ACCOUNT_ID_S
  START WITH 1
  MAXVALUE 999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  NOCACHE
  NOORDER;

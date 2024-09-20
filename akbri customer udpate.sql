begin
    update SM_SALE_ORDERS
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
    
    update SM_DELIVERY_ORDERS
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
    
    update SM_DELIVERY_CHALLANS
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
    
    update SM_OGPS
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
    
    
    update SM_SALE_RETURN_IGPS
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
    
    update SM_SALE_RETURNS
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
    
    update SM_SALES_INVOICES
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
    
    update AR_RECEIPTS
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
        
    update AR_ADVANCES
    set CUSTOMER_ID = :new_customer
    where  CUSTOMER_ID = :old_customer;
end;    
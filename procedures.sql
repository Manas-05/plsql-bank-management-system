-- ==============================
-- BANK MANAGEMENT SYSTEM (PL/SQL)
-- Stored Procedures
-- ==============================

-- Add Customer Procedure
CREATE OR REPLACE PROCEDURE add_customer (
    p_name VARCHAR2,
    p_email VARCHAR2,
    p_phone VARCHAR2
) AS
BEGIN
    INSERT INTO customers
    VALUES (customer_seq.NEXTVAL, p_name, p_email, p_phone, SYSDATE);

    DBMS_OUTPUT.PUT_LINE('Customer Added Successfully');
END;
/

-- Deposit Money Procedure
CREATE OR REPLACE PROCEDURE deposit_money (
    p_account_id NUMBER,
    p_amount NUMBER
) AS
BEGIN
    UPDATE accounts
    SET balance = balance + p_amount
    WHERE account_id = p_account_id;

    INSERT INTO transactions
    VALUES (transaction_seq.NEXTVAL, p_account_id, 'DEPOSIT', p_amount, SYSDATE);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Deposit Successful');
END;
/

-- Withdraw Money Procedure
CREATE OR REPLACE PROCEDURE withdraw_money (
    p_account_id NUMBER,
    p_amount NUMBER
) AS
    v_balance NUMBER;
BEGIN
    SELECT balance INTO v_balance
    FROM accounts
    WHERE account_id = p_account_id;

    IF v_balance < p_amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient Balance');
    END IF;

    UPDATE accounts
    SET balance = balance - p_amount
    WHERE account_id = p_account_id;

    INSERT INTO transactions
    VALUES (transaction_seq.NEXTVAL, p_account_id, 'WITHDRAW', p_amount, SYSDATE);

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Withdrawal Successful');
END;
/

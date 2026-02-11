-- ==============================
-- BANK MANAGEMENT SYSTEM (PL/SQL)
-- Schema Definition
-- ==============================

-- Customers Table
CREATE TABLE customers (
    customer_id NUMBER PRIMARY KEY,
    name VARCHAR2(100),
    email VARCHAR2(100),
    phone VARCHAR2(15),
    created_at DATE DEFAULT SYSDATE
);

-- Accounts Table
CREATE TABLE accounts (
    account_id NUMBER PRIMARY KEY,
    customer_id NUMBER,
    balance NUMBER(12,2),
    account_type VARCHAR2(20),
    created_at DATE DEFAULT SYSDATE,
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Transactions Table
CREATE TABLE transactions (
    transaction_id NUMBER PRIMARY KEY,
    account_id NUMBER,
    transaction_type VARCHAR2(20),
    amount NUMBER(12,2),
    transaction_date DATE DEFAULT SYSDATE,
    CONSTRAINT fk_account
        FOREIGN KEY (account_id)
        REFERENCES accounts(account_id)
);

-- Sequences
CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE account_seq START WITH 1001 INCREMENT BY 1;
CREATE SEQUENCE transaction_seq START WITH 5001 INCREMENT BY 1;

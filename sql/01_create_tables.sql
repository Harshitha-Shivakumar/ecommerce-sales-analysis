CREATE TABLE Orders (
    Order_ID VARCHAR2(20),
    Order_Date DATE,
    Customer_Name VARCHAR2(100),
    City VARCHAR2(100),
    State VARCHAR2(100),
    Platform VARCHAR2(50)
);

CREATE TABLE Order_Details (
    Order_ID VARCHAR2(20),
    Product VARCHAR2(100),
    Category VARCHAR2(100),
    Quantity NUMBER,
    Selling_Price NUMBER(10,2),
    Unit_Cost NUMBER(10,2)
);

CREATE TABLE Sales_Targets (
    Month DATE,
    Category VARCHAR2(100),
    Target NUMBER(12,2)
);Oracle
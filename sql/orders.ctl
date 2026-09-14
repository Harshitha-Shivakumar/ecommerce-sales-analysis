LOAD DATA
INFILE 'C:\Users\abc\Desktop\ecommerce-sales-analysis\data\Orders.csv'
INTO TABLE Orders
APPEND
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    Order_ID,
    Order_Date DATE "YYYY-MM-DD",
    Customer_Name,
    Platform,
    State,
    City
)
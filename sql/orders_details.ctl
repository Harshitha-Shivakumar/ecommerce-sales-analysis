
LOAD DATA
INFILE 'C:\Users\abc\Desktop\ecommerce-sales-analysis\data\Order_Details.csv'
INTO TABLE Order_Details
APPEND
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    Order_ID,
    line_number FILLER,
    Product,
    Category,
    Quantity,
    Selling_Price,
    Unit_Cost
)
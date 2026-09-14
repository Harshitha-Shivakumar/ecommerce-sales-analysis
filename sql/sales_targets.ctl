LOAD DATA
INFILE 'C:\Users\abc\Desktop\ecommerce-sales-analysis\data\Sales_Targets.csv'
INTO TABLE Sales_Targets
APPEND
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    Month DATE "YYYY-MM",
    Category,
    Target
)
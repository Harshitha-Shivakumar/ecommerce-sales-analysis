-- =====================================================
-- E-COMMERCE SALES ANALYSIS
-- SQL ANALYSIS QUERIES
-- =====================================================


-- =====================================================
-- 1. CHECK TABLES
-- =====================================================

SELECT * FROM Orders;

SELECT * FROM Order_Details;

SELECT * FROM Sales_Targets;


-- =====================================================
-- 2. COUNT RECORDS
-- =====================================================

-- Total orders
SELECT COUNT(*) AS Total_Orders
FROM Orders;

-- Total order details
SELECT COUNT(*) AS Total_Order_Details
FROM Order_Details;

-- Total sales targets
SELECT COUNT(*) AS Total_Targets
FROM Sales_Targets;


-- =====================================================
-- 3. BASIC BUSINESS KPIs
-- =====================================================

-- Total Units Sold
SELECT
    SUM(Quantity) AS Total_Units_Sold
FROM Order_Details;


-- Total Revenue
SELECT
    SUM(Quantity * Selling_Price) AS Total_Revenue
FROM Order_Details;


-- Total Cost
SELECT
    SUM(Quantity * Unit_Cost) AS Total_Cost
FROM Order_Details;


-- Total Profit
SELECT
    SUM(Quantity * (Selling_Price - Unit_Cost)) AS Total_Profit
FROM Order_Details;


-- Profit Margin
SELECT
    ROUND(
        SUM(Quantity * (Selling_Price - Unit_Cost))
        / SUM(Quantity * Selling_Price) * 100,
        2
    ) AS Profit_Margin
FROM Order_Details;


-- =====================================================
-- 4. PLATFORM ANALYSIS
-- =====================================================

SELECT
    o.Platform,
    COUNT(DISTINCT o.Order_ID) AS Total_Orders,
    SUM(od.Quantity) AS Units_Sold,
    SUM(od.Quantity * od.Selling_Price) AS Revenue,
    SUM(od.Quantity * (od.Selling_Price - od.Unit_Cost)) AS Profit
FROM Orders o
JOIN Order_Details od
    ON o.Order_ID = od.Order_ID
GROUP BY o.Platform
ORDER BY Revenue DESC;


-- =====================================================
-- 5. CATEGORY ANALYSIS
-- =====================================================

SELECT
    od.Category,
    SUM(od.Quantity) AS Units_Sold,
    SUM(od.Quantity * od.Selling_Price) AS Revenue,
    SUM(od.Quantity * (od.Selling_Price - od.Unit_Cost)) AS Profit
FROM Order_Details od
GROUP BY od.Category
ORDER BY Revenue DESC;


-- =====================================================
-- 6. PRODUCT ANALYSIS
-- =====================================================

SELECT
    od.Product,
    SUM(od.Quantity) AS Units_Sold,
    SUM(od.Quantity * od.Selling_Price) AS Revenue,
    SUM(od.Quantity * (od.Selling_Price - od.Unit_Cost)) AS Profit
FROM Order_Details od
GROUP BY od.Product
ORDER BY Revenue DESC;


-- =====================================================
-- 7. STATE ANALYSIS
-- =====================================================

SELECT
    o.State,
    SUM(od.Quantity) AS Units_Sold,
    SUM(od.Quantity * od.Selling_Price) AS Revenue,
    SUM(od.Quantity * (od.Selling_Price - od.Unit_Cost)) AS Profit
FROM Orders o
JOIN Order_Details od
    ON o.Order_ID = od.Order_ID
GROUP BY o.State
ORDER BY Revenue DESC;


-- =====================================================
-- 8. MONTHLY SALES ANALYSIS
-- =====================================================

SELECT
    TO_CHAR(o.Order_Date, 'YYYY-MM') AS Sales_Month,
    SUM(od.Quantity * od.Selling_Price) AS Revenue,
    SUM(od.Quantity * (od.Selling_Price - od.Unit_Cost)) AS Profit
FROM Orders o
JOIN Order_Details od
    ON o.Order_ID = od.Order_ID
GROUP BY TO_CHAR(o.Order_Date, 'YYYY-MM')
ORDER BY Sales_Month;


-- =====================================================
-- 9. TOP 10 PRODUCTS BY REVENUE
-- =====================================================

SELECT *
FROM (
    SELECT
        Product,
        SUM(Quantity) AS Units_Sold,
        SUM(Quantity * Selling_Price) AS Revenue,
        SUM(Quantity * (Selling_Price - Unit_Cost)) AS Profit
    FROM Order_Details
    GROUP BY Product
    ORDER BY Revenue DESC
)
WHERE ROWNUM <= 10;


-- =====================================================
-- 10. TOP 10 PRODUCTS BY PROFIT
-- =====================================================

SELECT *
FROM (
    SELECT
        Product,
        SUM(Quantity) AS Units_Sold,
        SUM(Quantity * Selling_Price) AS Revenue,
        SUM(Quantity * (Selling_Price - Unit_Cost)) AS Profit
    FROM Order_Details
    GROUP BY Product
    ORDER BY Profit DESC
)
WHERE ROWNUM <= 10;
-- =====================================================
-- ADVANCED SQL ANALYSIS
-- =====================================================

-- 11. Revenue by Category with Ranking
SELECT
    Category,
    SUM(Quantity * Selling_Price) AS Revenue,
    RANK() OVER (
        ORDER BY SUM(Quantity * Selling_Price) DESC
    ) AS Revenue_Rank
FROM Order_Details
GROUP BY Category
ORDER BY Revenue_Rank;


-- 12. Profit by Product with Ranking
SELECT
    Product,
    SUM(Quantity * (Selling_Price - Unit_Cost)) AS Profit,
    RANK() OVER (
        ORDER BY SUM(Quantity * (Selling_Price - Unit_Cost)) DESC
    ) AS Profit_Rank
FROM Order_Details
GROUP BY Product
ORDER BY Profit_Rank;


-- 13. Monthly Revenue
SELECT
    TO_CHAR(o.Order_Date, 'YYYY-MM') AS Month,
    SUM(od.Quantity * od.Selling_Price) AS Revenue
FROM Orders o
JOIN Order_Details od
    ON o.Order_ID = od.Order_ID
GROUP BY TO_CHAR(o.Order_Date, 'YYYY-MM')
ORDER BY Month;


-- 14. Month-over-Month Revenue Growth
WITH Monthly_Sales AS (
    SELECT
        TO_CHAR(o.Order_Date, 'YYYY-MM') AS Month,
        SUM(od.Quantity * od.Selling_Price) AS Revenue
    FROM Orders o
    JOIN Order_Details od
        ON o.Order_ID = od.Order_ID
    GROUP BY TO_CHAR(o.Order_Date, 'YYYY-MM')
)
SELECT
    Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Month) AS Previous_Month_Revenue,
    ROUND(
        (Revenue - LAG(Revenue) OVER (ORDER BY Month))
        / NULLIF(LAG(Revenue) OVER (ORDER BY Month), 0) * 100,
        2
    ) AS Growth_Percentage
FROM Monthly_Sales
ORDER BY Month;


-- 15. Actual Revenue vs Sales Target
SELECT
    TO_CHAR(o.Order_Date, 'YYYY-MM') AS Month,
    od.Category,
    SUM(od.Quantity * od.Selling_Price) AS Actual_Revenue,
    st.Target,
    SUM(od.Quantity * od.Selling_Price) - st.Target AS Variance
FROM Orders o
JOIN Order_Details od
    ON o.Order_ID = od.Order_ID
JOIN Sales_Targets st
    ON TO_CHAR(o.Order_Date, 'YYYY-MM') = TO_CHAR(st.Month, 'YYYY-MM')
    AND od.Category = st.Category
GROUP BY
    TO_CHAR(o.Order_Date, 'YYYY-MM'),
    od.Category,
    st.Target
ORDER BY Month, od.Category;
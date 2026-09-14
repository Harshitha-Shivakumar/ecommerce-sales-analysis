# E-Commerce Sales Analysis

## Project Overview

This project analyzes e-commerce sales data to identify sales trends, profitable products, category performance, platform performance, and state-wise sales performance.

The project uses Python, SQL, Oracle Database, Power BI, and Excel to perform data analysis and create business insights.

## Business Objectives

- Analyze overall sales and profit performance
- Identify top-performing products
- Compare sales across e-commerce platforms
- Analyze category-wise revenue and profit
- Identify high-performing states
- Track monthly sales trends
- Measure month-over-month revenue growth
- Compare actual revenue with sales targets

## Tools & Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Oracle SQL
- SQL*Loader
- Power BI
- Microsoft Excel
- Git & GitHub

## Dataset

The project contains e-commerce order and order-detail data.

Main datasets:

- Orders
- Order Details
- Sales Targets

The Orders dataset contains information such as:

- Order ID
- Order Date
- Customer ID
- Platform
- State
- City

The Order Details dataset contains:

- Order ID
- Product
- Category
- Quantity
- Selling Price
- Unit Cost

## Key Business KPIs

| KPI | Value |
|---|---:|
| Total Orders | 1,000 |
| Total Units Sold | 5,100 |
| Total Revenue | ₹8,430,922 |
| Total Cost | ₹5,912,260 |
| Total Profit | ₹2,518,662 |
| Profit Margin | 29.87% |

## Analysis Performed

### Platform Analysis

Compared revenue, orders, units sold, and profit across:

- Amazon
- Flipkart
- Meesho
- Shopsy

### Category Analysis

Analyzed:

- Revenue by category
- Units sold by category
- Profit by category

### Product Analysis

Identified top products based on:

- Revenue
- Units sold
- Profit

### State Analysis

Analyzed sales and profit performance across different Indian states.

### Monthly Sales Analysis

Analyzed monthly revenue and profit trends.

### Advanced SQL Analysis

Used SQL techniques including:

- GROUP BY
- JOIN
- ORDER BY
- RANK()
- LAG()
- Common Table Expressions (CTEs)
- Aggregate functions

### Sales Target Analysis

Compared actual revenue against monthly category-wise sales targets and calculated revenue variance.

## Python Analysis

Python was used for:

- Data loading
- Data cleaning
- Duplicate removal
- Missing-value handling
- Date conversion
- Revenue calculation
- Cost calculation
- Profit calculation
- Business analysis
- Data visualization

Generated visualizations include:

- Monthly Sales Trend
- Sales by Platform
- Sales by Category
- Top 10 Products
- Profit by Category
- Sales by State

## Power BI Dashboard

The Power BI dashboard provides an interactive view of:

- Total Orders
- Total Revenue
- Total Profit
- Profit Margin
- Monthly Sales Trend
- Platform Performance
- Category Performance
- Top Products
- State-wise Sales

Interactive slicers are available for:

- Platform
- Category
- Date

## Project Structure

```text
ecommerce-sales-analysis
│
├── dashboard
│   └── ecommerce-sales-analysis-dashboard.pbix
│
├── data
│   ├── Category_Analysis.csv
│   ├── Order_Details.csv
│   ├── Order_Details_Cleaned.csv
│   ├── Orders.csv
│   ├── Platform_Analysis.csv
│   ├── Product_Analysis.csv
│   ├── Sales_Targets.csv
│   └── State_Analysis.csv
│
├── images
│   ├── monthly_sales.png
│   ├── sales_by_category.png
│   ├── profit_by_category.png
│   ├── top_10_products.png
│   ├── sales_by_platform.png
│   └── sales_by_state.png
│
├── notebooks
│
├── scripts
│   └── analysis.py
│
└── sql
    ├── 01_create_tables.sql
    ├── 02_analysis_queries.sql
    ├── orders.ctl
    ├── orders_details.ctl
    └── sales_targets.ctl
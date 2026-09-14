import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from pathlib import Path

# =====================================================
# 1. PROJECT PATH
# =====================================================

project_folder = Path(__file__).resolve().parents[1]

data_folder = project_folder / "data"
images_folder = project_folder / "images"

# Create images folder if it doesn't exist
images_folder.mkdir(exist_ok=True)


# =====================================================
# 2. LOAD DATA
# =====================================================

orders = pd.read_csv(data_folder / "Orders.csv")
order_details = pd.read_csv(data_folder / "Order_Details.csv")


# =====================================================
# 3. CLEAN DATA
# =====================================================

orders = orders.drop_duplicates()
order_details = order_details.drop_duplicates()

orders["City"] = orders["City"].fillna("Unknown")
orders["Order_Date"] = pd.to_datetime(
    orders["Order_Date"],
    errors="coerce"
)


# =====================================================
# 4. CREATE BUSINESS CALCULATIONS
# =====================================================

order_details["Revenue"] = (
    order_details["Quantity"] *
    order_details["Selling_Price"]
)

order_details["Total_Cost"] = (
    order_details["Quantity"] *
    order_details["Unit_Cost"]
)

order_details["Profit"] = (
    order_details["Revenue"] -
    order_details["Total_Cost"]
)


# =====================================================
# 5. MERGE ORDERS + ORDER DETAILS
# =====================================================

sales = orders.merge(
    order_details,
    on="Order_ID",
    how="inner"
)


# =====================================================
# CHART 1 — MONTHLY SALES
# =====================================================

monthly_sales = (
    sales.groupby(
        sales["Order_Date"].dt.to_period("M")
    )["Revenue"]
    .sum()
    .reset_index()
)

monthly_sales["Order_Date"] = (
    monthly_sales["Order_Date"].astype(str)
)

plt.figure(figsize=(12, 6))

sns.lineplot(
    data=monthly_sales,
    x="Order_Date",
    y="Revenue",
    marker="o"
)

plt.title("Monthly Sales Revenue")
plt.xlabel("Month")
plt.ylabel("Revenue (₹)")
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig(
    images_folder / "monthly_sales.png",
    dpi=300
)

plt.close()


# =====================================================
# CHART 2 — SALES BY PLATFORM
# =====================================================

platform_sales = (
    sales.groupby("Platform")["Revenue"]
    .sum()
    .sort_values(ascending=False)
)

plt.figure(figsize=(10, 6))

platform_sales.plot(
    kind="bar"
)

plt.title("Sales Revenue by Platform")
plt.xlabel("Platform")
plt.ylabel("Revenue (₹)")
plt.xticks(rotation=0)
plt.tight_layout()

plt.savefig(
    images_folder / "sales_by_platform.png",
    dpi=300
)

plt.close()


# =====================================================
# CHART 3 — SALES BY CATEGORY
# =====================================================

category_sales = (
    sales.groupby("Category")["Revenue"]
    .sum()
    .sort_values(ascending=False)
)

plt.figure(figsize=(10, 6))

category_sales.plot(
    kind="bar"
)

plt.title("Sales Revenue by Category")
plt.xlabel("Category")
plt.ylabel("Revenue (₹)")
plt.xticks(rotation=30)
plt.tight_layout()

plt.savefig(
    images_folder / "sales_by_category.png",
    dpi=300
)

plt.close()


# =====================================================
# CHART 4 — TOP 10 PRODUCTS
# =====================================================

top_products = (
    sales.groupby("Product")["Revenue"]
    .sum()
    .sort_values(ascending=False)
    .head(10)
)

plt.figure(figsize=(10, 7))

top_products.sort_values().plot(
    kind="barh"
)

plt.title("Top 10 Products by Revenue")
plt.xlabel("Revenue (₹)")
plt.ylabel("Product")
plt.tight_layout()

plt.savefig(
    images_folder / "top_10_products.png",
    dpi=300
)

plt.close()


# =====================================================
# CHART 5 — PROFIT BY CATEGORY
# =====================================================

category_profit = (
    sales.groupby("Category")["Profit"]
    .sum()
    .sort_values(ascending=False)
)

plt.figure(figsize=(10, 6))

category_profit.plot(
    kind="bar"
)

plt.title("Profit by Category")
plt.xlabel("Category")
plt.ylabel("Profit (₹)")
plt.xticks(rotation=30)
plt.tight_layout()

plt.savefig(
    images_folder / "profit_by_category.png",
    dpi=300
)

plt.close()


# =====================================================
# CHART 6 — SALES BY STATE
# =====================================================

state_sales = (
    sales.groupby("State")["Revenue"]
    .sum()
    .sort_values(ascending=False)
)

plt.figure(figsize=(12, 6))

state_sales.plot(
    kind="bar"
)

plt.title("Sales Revenue by State")
plt.xlabel("State")
plt.ylabel("Revenue (₹)")
plt.xticks(rotation=45)
plt.tight_layout()

plt.savefig(
    images_folder / "sales_by_state.png",
    dpi=300
)

plt.close()


# =====================================================
# FINISHED
# =====================================================

print("\n========================================")
print("ALL CHARTS CREATED SUCCESSFULLY!")
print("========================================")

print("\nCharts saved inside:")

print(images_folder)

print("\nCreated files:")
print("1. monthly_sales.png")
print("2. sales_by_platform.png")
print("3. sales_by_category.png")
print("4. top_10_products.png")
print("5. profit_by_category.png")
print("6. sales_by_state.png")
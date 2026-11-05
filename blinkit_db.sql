-- Create Database
CREATE DATABASE IF NOT EXISTS blinkit_db;
USE blinkit_db;

-- Main Outlet/Sales Table
CREATE TABLE blinkit_grocery_data (
    item_identifier       VARCHAR(20) PRIMARY KEY,
    item_fat_content      VARCHAR(30),
    item_type             VARCHAR(50),
    item_weight           DECIMAL(6,2),
    item_visibility       DECIMAL(8,6),
    item_mrp              DECIMAL(10,2),
    outlet_identifier     VARCHAR(20),
    outlet_establishment_year INT,
    outlet_size           VARCHAR(20),
    outlet_location_type  VARCHAR(20),
    outlet_type           VARCHAR(50),
    item_outlet_sales     DECIMAL(12,4),
    rating                DECIMAL(3,2)
);

-- Calendar Dimension (for MoM / YoY)
CREATE TABLE calendar (
    date_id     DATE PRIMARY KEY,
    month_num   INT,
    month_name  VARCHAR(15),
    quarter_num INT,
    year_num    INT
);
## KPI CARD QUERIES
-- Total Sales
SELECT ROUND(SUM(item_outlet_sales) / 1000, 2) AS total_sales_k
FROM blinkit_grocery_data;

-- Average Sales per Item
SELECT ROUND(AVG(item_outlet_sales), 2) AS avg_sales
FROM blinkit_grocery_data;

-- Total Number of Items
SELECT COUNT(DISTINCT item_identifier) AS total_items
FROM blinkit_grocery_data;

-- Average Rating
SELECT ROUND(AVG(rating), 2) AS avg_rating
FROM blinkit_grocery_data;

-- Sales by Outlet Location Tier (Donut Chart)
SELECT 
    outlet_location_type AS tier,
    ROUND(SUM(item_outlet_sales), 2) AS total_sales,
    ROUND(SUM(item_outlet_sales) * 100.0 / 
          (SELECT SUM(item_outlet_sales) FROM blinkit_grocery_data), 2) AS contribution_pct,
    COUNT(DISTINCT outlet_identifier) AS outlet_count
FROM blinkit_grocery_data
GROUP BY outlet_location_type
ORDER BY total_sales DESC;

-- Sales by Item Fat Content (Bar Chart)
SELECT 
    item_fat_content,
    COUNT(*) AS item_count,
    ROUND(SUM(item_outlet_sales), 2) AS total_sales,
    ROUND(AVG(rating), 2) AS avg_rating
FROM blinkit_grocery_data
GROUP BY item_fat_content
ORDER BY total_sales DESC;

-- Sales by Outlet Size (Column Chart)
SELECT 
    outlet_size,
    COUNT(DISTINCT outlet_identifier) AS outlet_count,
    ROUND(SUM(item_outlet_sales), 2) AS total_sales,
    ROUND(AVG(item_outlet_sales), 2) AS avg_sales_per_item,
    ROUND(AVG(rating), 2) AS avg_rating
FROM blinkit_grocery_data
GROUP BY outlet_size
ORDER BY total_sales DESC;

-- Sales by Establishment Year (2012–2022)
SELECT 
    outlet_establishment_year AS est_year,
    COUNT(DISTINCT outlet_identifier) AS outlets_opened,
    ROUND(SUM(item_outlet_sales), 2) AS total_sales,
    ROUND(AVG(item_outlet_sales), 2) AS avg_sales
FROM blinkit_grocery_data
GROUP BY outlet_establishment_year
ORDER BY outlet_establishment_year;

-- Monthly Sales Trend + MoM Growth %
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(c.date_id, '%Y-%m') AS month,
        SUM(b.item_outlet_sales) AS total_sales
    FROM blinkit_grocery_data b
    JOIN calendar c ON DATE(c.date_id) = DATE(c.date_id)
    GROUP BY DATE_FORMAT(c.date_id, '%Y-%m')
)
SELECT 
    month,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY month)) * 100.0 /
        NULLIF(LAG(total_sales) OVER (ORDER BY month), 0), 
    2) AS mom_growth_pct
FROM monthly_sales
ORDER BY month;

-- Top 10 Outlets
SELECT 
    outlet_identifier,
    outlet_type,
    outlet_location_type AS tier,
    ROUND(SUM(item_outlet_sales), 2) AS total_sales,
    ROUND(AVG(rating), 2) AS avg_rating
FROM blinkit_grocery_data
GROUP BY outlet_identifier, outlet_type, outlet_location_type
ORDER BY total_sales DESC
LIMIT 10;

-- Bottom 10 Outlets
SELECT 
    outlet_identifier,
    outlet_type,
    outlet_location_type AS tier,
    ROUND(SUM(item_outlet_sales), 2) AS total_sales,
    ROUND(AVG(rating), 2) AS avg_rating
FROM blinkit_grocery_data
GROUP BY outlet_identifier, outlet_type, outlet_location_type
ORDER BY total_sales ASC
LIMIT 10;

-- Sales by Item Type (TreeMap)
SELECT 
    item_type,
    COUNT(*) AS items_sold,
    ROUND(SUM(item_outlet_sales), 2) AS total_sales,
    ROUND(AVG(item_outlet_sales), 2) AS avg_sales,
    ROUND(SUM(item_outlet_sales) * 100.0 / 
          (SELECT SUM(item_outlet_sales) FROM blinkit_grocery_data), 2) AS contribution_pct
FROM blinkit_grocery_data
GROUP BY item_type
ORDER BY total_sales DESC;

SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'blinkit_grocery_data';


SHOW TABLES;

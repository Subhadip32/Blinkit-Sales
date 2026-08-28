# 📊 Blinkit Sales Analytics Dashboard

An interactive Power BI dashboard application designed to track and audit sales performance, product distribution, and outlet metrics for **Blinkit (India's Last Minute App)**.

---

## 📈 Executive Summary KPIs

| Metric | Value | Description |
| :--- | :--- | :--- |
| **Total Sales** | `$1.20M` | Accumulated revenue across all active outlet locations |
| **Average Rating** | `3.9 ★` | Customer satisfaction rating baseline |
| **Avg. Sales** | `141` | Average basket size value per transaction |
| **No. of Items** | `8,523` | Total unique inventory items actively tracked |

---

## 🔍 Interactive Data Explorer

### 🎛️ Filter Panel Controls
Tailor the dashboard views dynamically by using the left-hand slicer configurations:
* 📍 **Outlet Location Type:** Isolate performance between `Tier 1`, `Tier 2`, or `Tier 3` cities.
* 📦 **Outlet Size:** Filter metrics by `Small`, `Medium`, or `High` capacity dimensions.
* 🍎 **Item Type:** Drill down into specific product categories.

---

## 📊 Core Visualization Modules

### 1. Sales Performance & Growth
* **Monthly Sales Performance Trends:** Dual-axis visualization highlighting total monthly revenue alongside historic growth baselines.
* **Monthly Sales Growth Rate (%):** Continuous line charting tracking volatile performance percentage spikes over time.

### 2. Inventory & Fat Content Distribution
* **Fat Content Mix:** Interactive donut-chart breakdown partitioning consumer preference between `Low Fat` vs `Regular` items.
* **Fat Mix by Regional Tier:** Stacked horizontal bar structures comparing fat content distributions across Tiers 1, 2, and 3.

### 3. Product Category Rankings
A ranked horizontal bar structure detailing high-volume inventory categories:
* 🥦 **Fruits and Vegetables** (Top Performing)
* 🍿 **Snack Foods**
* 🧻 **Household Goods**
* 🧊 **Frozen Foods**
* 🥛 **Dairy, Canned Goods, Soft Drinks, and Baking Essentials**

---

## 📑 Outlet Performance Matrix

| Outlet Type | Total Sales | No. of Items | Avg. Sales | Avg. Rating | Item Visibility |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Supermarket Type 1** | `$7,87,550` | `5577` | `141.21` | `3.92` | `0.06` |
| **Grocery Store** | `$1,51,936` | `1083` | `140.29` | `3.93` | `0.10` |
| **Supermarket Type 3** | `$1,30,715` | `935` | `139.80` | `3.91` | `0.06` |
| **Supermarket Type 2** | `$1,31,478` | `928` | `141.68` | `3.93` | `0.06` |

---

## 🛠️ Data Infrastructure & Fields
The dashboard schema processes live transformations utilizing the following structural fields:
* `Avg. Rating`, `Avg. Sales`, `Item Fat Content`, `Item Identifier`, `Item Type`, `Item Visibility`, `Item Weight`
* `MoM Sales Growth`, `No. of Items`, `Outlet Establishment Year`, `Outlet Identifier`, `Outlet Location`, `Outlet Size`, `Outlet Type`

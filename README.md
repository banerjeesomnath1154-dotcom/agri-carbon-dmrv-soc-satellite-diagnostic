# 🌍 Agri-Carbon Credit & Soil Organic Carbon (SOC) dMRV Diagnostic

## 📌 Executive Project Overview
This repository contains a digital Measurement, Reporting, and Verification (**dMRV**) diagnostic pipeline for Soil Organic Carbon (SOC) sequestration and carbon credit monetization across smallholder agricultural clusters in India.

The project models baseline vs. project soil carbon stocks across **1,000 verified farm fields** (3,180.83 Hectares), applies **IPCC Tier-2 Soil Carbon Logic**, enforces a **15% permanence buffer pool deduction**, and constructs an audit-ready financial model allocating **70% of carbon revenue directly to smallholder farmers** and **30% to FPO/developer operations**.

---

## 📊 Key Quantitative Audit Summary

| Metric | Verified Portfolio Value | Excel Audit | Variance | Unit |
| :--- | :---: | :---: | :---: | :--- |
| **Total Verified Fields** | 1,000 | 1,000 | **0.00** | Fields |
| **Total Cultivated Area** | 3,180.83 | 3,180.83 | **0.00** | Hectares |
| **Gross Net Sequestration** | 191,888.31 | 191,888.31 | **0.00** | tCO2e |
| **Buffer Reserve (15%)** | 28,783.08 | 28,783.08 | **0.00** | tCO2e |
| **Issuable Carbon Credits** | 163,105.23 | 163,105.23 | **0.00** | tCO2e |
| **Gross Offset Revenue ($25/t)** | $4,077,630.75 | $4,077,630.75 | **$0.00** | USD ($) |
| **Farmer Share (70%)** | $2,854,339.52 | $2,854,339.52 | **$0.00** | USD ($) |
| **FPO / Developer Share (30%)** | $1,223,288.08 | $1,223,288.08 | **$0.00** | USD ($) |

---

## 🗂️ Repository Directory Structure

```text
agri-carbon-dmrv-soc-satellite-diagnostic/
│
├── README.md                            <-- Master project documentation & executive overview
├── EXECUTIVE_REPORT_AGRI_CARBON_dMRV.md  <-- Executive dMRV audit & carbon credit strategy brief
│
├── data/
│   ├── field_carbon_sequestration_raw.csv   <-- Messy raw field carbon logs (1,000 records)
│   ├── field_carbon_sequestration_clean.csv <-- Cleaned, feature-engineered dMRV dataset
│   ├── soc_cluster_summary.csv              <-- District & FPO-level carbon summary export
│   └── agri_carbon_dmrv.db                  <-- Primary SQLite relational dMRV database
│
├── sql/
│   └── 02_carbon_credit_queries.sql         <-- SQL window function queries & cluster rankings
│
├── excel/
│   └── soc_carbon_credit_reconciliation.xlsx <-- Audit-ready Excel revenue & credit model
│
└── notebooks/
    └── 01_soc_dmrv_spatial_analysis.ipynb   <-- Jupyter notebook covering Pandas/GeoPandas pipeline
```

---

## ⚙️ 4-Phase Technical Methodology

### 🐍 Phase 1: Python Data Cleaning & IPCC Tier-2 Feature Engineering
* **Data Ingestion**: Cleaned and validated 1,000 field logs across 10 agricultural clusters in India.
* **IPCC Tier-2 Logic**: Calculated soil organic carbon stock (`SOC Stock (t C/Ha) = SOC % * Bulk Density * Depth * 100`).
* **Net Sequestration**: Computed net carbon volume after operational emissions and applied a **15% permanence buffer pool deduction**.

### 🗄️ Phase 2: Relational SQL Warehousing & Window Function Analytics
* **SQLite Ingestion**: Populated `agri_carbon_dmrv.db` with clean tables.
* **Window Functions**: Executed `RANK() OVER (ORDER BY net_issuable_credits_tco2e DESC)` to rank district carbon performance.

### 📊 Phase 3: Spreadsheet Audit & Revenue Reconciliation Model
* **Workbook**: Built `soc_carbon_credit_reconciliation.xlsx` featuring dynamic `SUMIF` and `COUNTA` formulas.
* **Reconciliation Result**: Verified total carbon revenue ($4,077,630.75) against SQLite database queries with **$0.00 / 0.00 tCO2e variance**.

### 💡 Phase 4: Executive BI & Carbon Strategy Report
* **Strategy Brief**: Authored `EXECUTIVE_REPORT_AGRI_CARBON_dMRV.md` detailing practice efficiency, permanence risk mitigation, and automated farmer payout escrows.

---

## 🚀 How to Reproduce

1. **Run Python Data Pipeline**:
   ```bash
   jupyter notebook notebooks/01_soc_dmrv_spatial_analysis.ipynb
   ```
2. **Execute SQL Analytics**:
   ```bash
   sqlite3 data/agri_carbon_dmrv.db < sql/02_carbon_credit_queries.sql
   ```
3. **Inspect Excel Audit**:
   Open `excel/soc_carbon_credit_reconciliation.xlsx` to review the revenue waterfall and variance checks.

---
## 👤 Author & Contact
* **Author:** Somnath Banerjee
* **Role:** Aspiring Agri-Business Analyst & Geospatial BI Specialist
* **LinkedIn:** linkedin.com/in/somnath-banerjee-621720239
* **GitHub:** https://github.com/banerjeesomnath1154-dotcom
* **Gmail:** banerjeesomnath1154@gmail.com

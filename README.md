# Agri-Carbon Credit & Soil Organic Carbon (SOC) dMRV Diagnostic

## Executive Project Overview
This repository implements a digital Measurement, Reporting, and Verification (dMRV) pipeline for Soil Organic Carbon (SOC) sequestration, carbon credit issuance, and Scope 3 Supply Chain Decarbonization Accounting across smallholder agricultural clusters in India.

The diagnostic integrates IPCC Tier-2 Soil Carbon Logic, Six et al. (2024) Mineral Carbon Saturation Ceilings, N2O Direct Emissions Avoidance (GWP=273), Pumping Energy CO2 Abatement, and a 70/30 Farmer-FPO Carbon Revenue Split Model verified down to $0.00 / 0.00 tCO2e audit variance.

---

## Top-Line Decarbonization & Financial Audit

| Diagnostic Metric | Quantitative Value | Audit Verification |
| :--- | :--- | :--- |
| **Total Verified Field Area** | 3,180.83 Hectares | 1,000 Smallholder Farm Boundaries |
| **Net SOC Carbon Sequestration** | 191,888.31 tCO2e | IPCC Tier-2 Field Sequestration |
| **Issuable Carbon Credits (15% Buffer Deduction)** | 163,105.23 tCO2e | Permanence Leakage Deduction |
| **Gross Carbon Offset Monetization ($25/t)** | $4,077,630.75 | Verified Carbon Market Realization |
| **Direct Farmer Revenue Share (70%)** | $2,854,339.52 | Smallholder Escrow Payout |
| **FPO & Developer Management Share (30%)** | $1,223,288.08 | Technology & Audit Escrow |
| **Scope 3 Intensity Reduction** | -3.40 kg CO2e / kg Produce | EU ECGT & CSRD Anti-Greenwashing Standard |
| **Audit Variance** | **$0.00 / 0.00 tCO2e** | SQL vs. Excel Unit-for-Unit Proof |

---

## Repository Directory Structure

```text
agri-carbon-dmrv-soc-satellite-diagnostic/
│
├── README.md                                  <-- Master project documentation & executive overview
├── EXECUTIVE_REPORT_AGRI_CARBON_dMRV.md       <-- Executive dMRV brief & B2B Scope 3 dossier
│
├── data/
│   ├── field_carbon_sequestration_raw.csv     <-- 1,000 raw smallholder farm field logs
│   ├── field_carbon_sequestration_clean.csv   <-- Cleaned dMRV dataset with Scope 3 metrics
│   ├── soc_cluster_summary.csv                <-- Aggregated cluster summary export for BI dashboards
│   └── agri_carbon_dmrv.db                    <-- Primary SQLite relational dMRV database
│
├── engine/
│   └── scope3_ghg_engine.py                   <-- Scope 3 GHG calculation engine (N2O, Pumping, Clay Ceilings)
│
├── notebooks/
│   └── 01_soc_dmrv_spatial_analysis.ipynb     <-- Jupyter notebook walking through pipeline & dMRV logic
│
├── sql/
│   ├── 02_carbon_credit_queries.sql           <-- SQL queries for field rankings & buffer deductions
│   └── 03_scope3_decarbonization_queries.sql  <-- SQL queries for Scope 3 B2B exporter certificates
│
└── excel/
    └── soc_carbon_credit_reconciliation.xlsx  <-- Audit-ready financial & credit reconciliation model
```

---

## Phase-by-Phase Technical Methodology

### Phase 1: Spatial Ingestion & IPCC Tier-2 dMRV (Pandas)
* **Field Boundary Topology**: Validated 1,000 smallholder farm field polygons totaling 3,180.83 Hectares across 10 agricultural clusters.
* **IPCC Tier-2 Sequestration Logic**: Computed net SOC accumulation across regenerative practice transitions (*No-Till + Cover Crops*, *Agroforestry + Biochar*, *Regenerative Crop Rotation*).
* **Buffer Pool Deductions**: Automatically deducted a 15% permanence buffer pool (28,783.08 tCO2e) to guard against drought or tilling risk.

### Phase 2: Scope 3 GHG Decarbonization Engine (`engine/scope3_ghg_engine.py`)
* **N2O Emissions Avoidance**: Applied IPCC Tier 1/2 factors (1% N to N2O, GWP=273) for reduced synthetic fertilizer application.
* **Irrigation Energy Abatement**: Computed grid electricity CO2 savings (0.82 kg CO2e / kWh) from solar/drip irrigation efficiency.
* **Mineral Carbon Ceilings**: Integrated Six et al. (2024) saturation thresholds based on 2:1 smectite vs. 1:1 kaolinite clay fractions.
* **Product Carbon Intensity**: Calculated net decarbonization per kg of harvested produce (averaging -3.40 kg CO2e / kg produce).

### Phase 3: Relational SQL Warehousing (`sql/02_...sql` & `sql/03_...sql`)
* **Database Ingestion**: Created `agri_carbon_dmrv.db` housing `clean_field_dmrv` and `soc_cluster_summary`.
* **Analytical Window Functions**: Ran SQL queries using `RANK() OVER (PARTITION BY district ORDER BY net_issuable_credits_tco2e DESC)` to isolate top carbon-sequestering clusters.
* **Epistemic Audit Classification**: Classified datasets into `OBSERVED`, `DERIVED`, and `MEASURED` data streams to satisfy EU Empowering Consumers for the Green Transition (ECGT) directives.

### Phase 4: Financial Reconciliation & Revenue Allocation (`excel/`)
* **Excel Workbook**: Built `soc_carbon_credit_reconciliation.xlsx` with `SUMIF` and `COUNTA` formulas.
* **Zero-Variance Verification**: Reconciled total credit volume (163,105.23 tCO2e) and gross monetization ($4,077,630.75) between SQLite and Excel to $0.00 / 0.00 tCO2e variance.

---

## How to Reproduce

1. **Scope 3 Engine**:
   ```python
   from engine.scope3_ghg_engine import calculate_scope3_decarbonization
   df_clean = calculate_scope3_decarbonization(df_raw)
   ```
2. **Jupyter Notebook**:
   ```bash

   ---
## 👤 Author & Contact
* **Author:** Somnath Banerjee
* **Role:** Aspiring Agri-Business Analyst & Geospatial BI Specialist
* **LinkedIn:** linkedin.com/in/somnath-banerjee-621720239
* **GitHub:** https://github.com/banerjeesomnath1154-dotcom
* **Gmail:** banerjeesomnath1154@gmail.com

   jupyter notebook notebooks/01_soc_dmrv_spatial_analysis.ipynb
   ```
3. **SQLite Queries**:
   ```bash
   sqlite3 data/agri_carbon_dmrv.db < sql/03_scope3_decarbonization_queries.sql
   ```

-- ===============================================================================
-- PROJECT 6: AGRI-CARBON CREDIT & SOIL ORGANIC CARBON (SOC) dMRV DIAGNOSTIC
-- SQL Analytics Pipeline & Window Function Ranking Suite
-- Database Target: SQLite (agri_carbon_dmrv.db)
-- ===============================================================================

-- -------------------------------------------------------------------------------
-- QUERY 1: Regional Cluster Performance & Carbon Yield Ranking (Window Functions)
-- Evaluates net sequestration, buffer pool deductions, and total carbon revenue by district.
-- -------------------------------------------------------------------------------
WITH DistrictCarbonAggregates AS (
    SELECT 
        state,
        district,
        fpo_name,
        COUNT(field_id) AS total_verified_fields,
        ROUND(SUM(field_area_ha), 2) AS total_area_ha,
        ROUND(AVG(delta_soc_pct), 4) AS avg_delta_soc_pct,
        ROUND(SUM(total_net_sequestration_tco2e), 2) AS gross_net_sequestration_tco2e,
        ROUND(SUM(buffer_deduction_tco2e), 2) AS total_buffer_deduction_tco2e,
        ROUND(SUM(issuable_credits_tco2e), 2) AS net_issuable_credits_tco2e,
        ROUND(SUM(total_revenue_usd), 2) AS total_revenue_usd,
        ROUND(SUM(farmer_share_usd), 2) AS total_farmer_payout_usd,
        ROUND(SUM(fpo_developer_share_usd), 2) AS total_fpo_share_usd
    FROM field_carbon_sequestration
    GROUP BY state, district, fpo_name
)
SELECT 
    state,
    district,
    fpo_name,
    total_verified_fields,
    total_area_ha,
    avg_delta_soc_pct,
    net_issuable_credits_tco2e,
    total_revenue_usd,
    total_farmer_payout_usd,
    RANK() OVER (ORDER BY net_issuable_credits_tco2e DESC) AS national_carbon_rank,
    RANK() OVER (PARTITION BY state ORDER BY net_issuable_credits_tco2e DESC) AS state_carbon_rank
FROM DistrictCarbonAggregates
ORDER BY net_issuable_credits_tco2e DESC;


-- -------------------------------------------------------------------------------
-- QUERY 2: Regenerative Practice Type Efficiency & Sequestration Density
-- Compares net sequestration rates per hectare across practice categories.
-- -------------------------------------------------------------------------------
SELECT 
    practice_type,
    COUNT(field_id) AS field_count,
    ROUND(SUM(field_area_ha), 2) AS total_area_ha,
    ROUND(AVG(baseline_soc_pct), 3) AS avg_baseline_soc_pct,
    ROUND(AVG(project_soc_pct), 3) AS avg_project_soc_pct,
    ROUND(AVG(delta_soc_pct), 3) AS avg_delta_soc_gain_pct,
    ROUND(AVG(net_sequestration_tco2e_ha), 2) AS avg_net_sequestration_tco2e_ha,
    ROUND(SUM(issuable_credits_tco2e), 2) AS total_issuable_credits_tco2e,
    ROUND(SUM(total_revenue_usd), 2) AS gross_carbon_revenue_usd,
    ROUND(SUM(farmer_share_usd), 2) AS total_farmer_share_usd
FROM field_carbon_sequestration
GROUP BY practice_type
ORDER BY avg_net_sequestration_tco2e_ha DESC;


-- -------------------------------------------------------------------------------
-- QUERY 3: Permanence Risk & Carbon Reversal Vulnerability Profiling
-- Identifies fields with low accretion (<0.25%) or excessive volatility (>0.65%).
-- -------------------------------------------------------------------------------
SELECT 
    risk_flag,
    COUNT(field_id) AS field_count,
    ROUND(SUM(field_area_ha), 2) AS total_area_ha,
    ROUND(SUM(total_net_sequestration_tco2e), 2) AS total_net_sequestration_tco2e,
    ROUND(SUM(buffer_deduction_tco2e), 2) AS total_buffer_reserve_tco2e,
    ROUND(SUM(issuable_credits_tco2e), 2) AS issuable_credits_tco2e,
    ROUND(AVG(delta_soc_pct), 3) AS avg_delta_soc_pct
FROM field_carbon_sequestration
GROUP BY risk_flag
ORDER BY field_count DESC;


-- -------------------------------------------------------------------------------
-- QUERY 4: Top 20 High-Yield Carbon Farms (Farmer Payout Priority Audit)
-- Ranks individual smallholder farm fields by net farmer payout USD.
-- -------------------------------------------------------------------------------
SELECT 
    field_id,
    farmer_id,
    fpo_name,
    state,
    district,
    practice_type,
    field_area_ha,
    delta_soc_pct,
    issuable_credits_tco2e,
    total_revenue_usd,
    farmer_share_usd,
    DENSE_RANK() OVER (ORDER BY farmer_share_usd DESC) AS top_farmer_payout_rank
FROM field_carbon_sequestration
LIMIT 20;

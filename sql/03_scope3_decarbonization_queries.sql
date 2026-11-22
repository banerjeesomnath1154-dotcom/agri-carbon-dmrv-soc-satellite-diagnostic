-- ====================================================================
-- SQL QUERIES FOR SCOPE 3 SUPPLY CHAIN DECARBONIZATION REPORTING
-- Database: agri_carbon_dmrv.db
-- Target: FPO Cluster Aggregations for Corporate B2B Exporter Dossiers
-- ====================================================================

-- 1. FPO Cluster Summary for Scope 3 Decarbonization Certificates
SELECT 
    fpo_cluster_id,
    district_name,
    COUNT(field_id) AS total_farms,
    ROUND(SUM(area_hectares), 2) AS total_hectares,
    ROUND(SUM(n2o_avoidance_tco2e_ha * area_hectares), 2) AS total_n2o_avoided_tco2e,
    ROUND(SUM(pumping_co2_avoidance_tco2e_ha * area_hectares), 2) AS total_pumping_co2_saved_tco2e,
    ROUND(SUM(soc_biomass_abatement_tco2e), 2) AS total_soc_biomass_sequestration_tco2e,
    ROUND(SUM(total_scope3_abatement_tco2e), 2) AS grand_total_scope3_abatement_tco2e,
    ROUND(AVG(ghg_intensity_reduction_kg_co2e_per_kg_crop), 3) AS avg_ghg_intensity_reduction_kg_per_kg_crop
FROM clean_field_dmrv
GROUP BY fpo_cluster_id, district_name
ORDER BY grand_total_scope3_abatement_tco2e DESC;

-- 2. Audit Trail by Epistemic Classification (EU ECGT Anti-Greenwashing Proof)
SELECT 
    epistemic_label_nitrogen,
    epistemic_label_pumping,
    epistemic_label_soc,
    COUNT(field_id) AS field_count,
    ROUND(SUM(area_hectares), 2) AS total_area_ha,
    ROUND(SUM(total_scope3_abatement_tco2e), 2) AS verified_scope3_abatement_tco2e
FROM clean_field_dmrv
GROUP BY epistemic_label_nitrogen, epistemic_label_pumping, epistemic_label_soc;

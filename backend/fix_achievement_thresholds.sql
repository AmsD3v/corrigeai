-- ============================================================================
-- CORREÇÃO DE THRESHOLDS DE CONQUISTAS
-- Execute: docker exec -i prosaai_db psql -U user -d prosaai < fix_achievement_thresholds.sql
-- ============================================================================

-- ============================================================================
-- VESTIBULARES COM ESCALAS PRÓPRIAS
-- ============================================================================

-- UnB (0-10): Bronze=6, Prata=8, Ouro=9
UPDATE achievement SET condition_value = 6, description = 'Atingiu 6+ na UnB' 
WHERE code = 'unb_bronze';
UPDATE achievement SET condition_value = 8, description = 'Atingiu 8+ na UnB' 
WHERE code = 'unb_prata';
UPDATE achievement SET condition_value = 9, description = 'Atingiu 9+ na UnB' 
WHERE code = 'unb_ouro';

-- UFPR (0-60): Bronze=36, Prata=48, Ouro=54
UPDATE achievement SET condition_value = 36, description = 'Atingiu 36+ na UFPR' 
WHERE code = 'ufpr_bronze';
UPDATE achievement SET condition_value = 48, description = 'Atingiu 48+ na UFPR' 
WHERE code = 'ufpr_prata';
UPDATE achievement SET condition_value = 54, description = 'Atingiu 54+ na UFPR' 
WHERE code = 'ufpr_ouro';

-- UFRGS (0-30): Bronze=18, Prata=24, Ouro=27
UPDATE achievement SET condition_value = 18, description = 'Atingiu 18+ na UFRGS' 
WHERE code = 'ufrgs_bronze';
UPDATE achievement SET condition_value = 24, description = 'Atingiu 24+ na UFRGS' 
WHERE code = 'ufrgs_prata';
UPDATE achievement SET condition_value = 27, description = 'Atingiu 27+ na UFRGS' 
WHERE code = 'ufrgs_ouro';

-- UFSC (0-10): Bronze=6, Prata=8, Ouro=9
UPDATE achievement SET condition_value = 6, description = 'Atingiu 6+ na UFSC' 
WHERE code = 'ufsc_bronze';
UPDATE achievement SET condition_value = 8, description = 'Atingiu 8+ na UFSC' 
WHERE code = 'ufsc_prata';
UPDATE achievement SET condition_value = 9, description = 'Atingiu 9+ na UFSC' 
WHERE code = 'ufsc_ouro';

-- PUC-Minas (0-10): Bronze=6, Prata=8, Ouro=9
UPDATE achievement SET condition_value = 6, description = 'Atingiu 6+ na PUC-Minas' 
WHERE code = 'pucminas_bronze';
UPDATE achievement SET condition_value = 8, description = 'Atingiu 8+ na PUC-Minas' 
WHERE code = 'pucminas_prata';
UPDATE achievement SET condition_value = 9, description = 'Atingiu 9+ na PUC-Minas' 
WHERE code = 'pucminas_ouro';

-- PUCPR (0-10): Bronze=6, Prata=8, Ouro=9
UPDATE achievement SET condition_value = 6, description = 'Atingiu 6+ na PUCPR' 
WHERE code = 'pucpr_bronze';
UPDATE achievement SET condition_value = 8, description = 'Atingiu 8+ na PUCPR' 
WHERE code = 'pucpr_prata';
UPDATE achievement SET condition_value = 9, description = 'Atingiu 9+ na PUCPR' 
WHERE code = 'pucpr_ouro';

-- ============================================================================
-- FEDERAIS VIA SISU (0-1000): Bronze=600, Prata=800, Ouro=900
-- ============================================================================

-- Norte
UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFAC' WHERE code = 'ufac_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFAC' WHERE code = 'ufac_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFAC' WHERE code = 'ufac_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UNIFAP' WHERE code = 'unifap_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UNIFAP' WHERE code = 'unifap_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UNIFAP' WHERE code = 'unifap_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFAM' WHERE code = 'ufam_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFAM' WHERE code = 'ufam_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFAM' WHERE code = 'ufam_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFPA' WHERE code = 'ufpa_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFPA' WHERE code = 'ufpa_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFPA' WHERE code = 'ufpa_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UNIR' WHERE code = 'unir_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UNIR' WHERE code = 'unir_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UNIR' WHERE code = 'unir_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFRR' WHERE code = 'ufrr_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFRR' WHERE code = 'ufrr_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFRR' WHERE code = 'ufrr_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFT' WHERE code = 'uft_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFT' WHERE code = 'uft_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFT' WHERE code = 'uft_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UERR' WHERE code = 'uerr_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UERR' WHERE code = 'uerr_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UERR' WHERE code = 'uerr_ouro';

-- Nordeste
UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFAL' WHERE code = 'ufal_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFAL' WHERE code = 'ufal_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFAL' WHERE code = 'ufal_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFBA' WHERE code = 'ufba_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFBA' WHERE code = 'ufba_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFBA' WHERE code = 'ufba_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFC' WHERE code = 'ufc_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFC' WHERE code = 'ufc_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFC' WHERE code = 'ufc_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFMA' WHERE code = 'ufma_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFMA' WHERE code = 'ufma_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFMA' WHERE code = 'ufma_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFPB' WHERE code = 'ufpb_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFPB' WHERE code = 'ufpb_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFPB' WHERE code = 'ufpb_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFPE' WHERE code = 'ufpe_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFPE' WHERE code = 'ufpe_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFPE' WHERE code = 'ufpe_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFPI' WHERE code = 'ufpi_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFPI' WHERE code = 'ufpi_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFPI' WHERE code = 'ufpi_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFRN' WHERE code = 'ufrn_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFRN' WHERE code = 'ufrn_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFRN' WHERE code = 'ufrn_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFS' WHERE code = 'ufs_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFS' WHERE code = 'ufs_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFS' WHERE code = 'ufs_ouro';

-- Centro-Oeste (exceto UnB que já foi corrigido acima)
UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UDF' WHERE code = 'udf_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UDF' WHERE code = 'udf_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UDF' WHERE code = 'udf_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFG' WHERE code = 'ufg_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFG' WHERE code = 'ufg_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFG' WHERE code = 'ufg_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFMT' WHERE code = 'ufmt_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFMT' WHERE code = 'ufmt_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFMT' WHERE code = 'ufmt_ouro';

UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFMS' WHERE code = 'ufms_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFMS' WHERE code = 'ufms_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFMS' WHERE code = 'ufms_ouro';

-- Sudeste (via SISU)
UPDATE achievement SET condition_value = 600, description = 'Atingiu 600+ na UFES' WHERE code = 'ufes_bronze';
UPDATE achievement SET condition_value = 800, description = 'Atingiu 800+ na UFES' WHERE code = 'ufes_prata';
UPDATE achievement SET condition_value = 900, description = 'Atingiu 900+ na UFES' WHERE code = 'ufes_ouro';

-- ============================================================================
-- VERIFICAÇÃO
-- ============================================================================
SELECT code, description, condition_value 
FROM achievement 
WHERE condition_type = 'score' 
  AND (code LIKE '%_bronze' OR code LIKE '%_prata' OR code LIKE '%_ouro')
ORDER BY exam_type, code;

SELECT 'Correção de thresholds concluída!' as status;

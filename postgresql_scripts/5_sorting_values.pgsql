SELECT
    *
FROM metrics_perf
WHERE sales_growth_proj > 15
    AND liq_ratio > 1
    AND de_ratio < 0.5
    AND ind_sales_growth > 15
    AND industry = 'Semiconductor Equip'
ORDER BY sector ASC, industry ASC, market_cap DESC
-- -- Calculate the percentage of analysts EPS projection for companies in 2025.
-- SELECT 
--     ROUND(
--         (
--             -- Count distinct active symbols in 2025 for 'Next Year' period
--             (SELECT COUNT(DISTINCT act_symbol)
--              FROM eps_estimate
--              WHERE extract(year FROM period_end_date::date) = 2025 
--              AND period = 'Next Year')
--             * 100.0 
--             / 
--             -- Count total distinct active symbols
--             (SELECT COUNT(DISTINCT act_symbol) 
--              FROM eps_estimate)
--         ), 2
--     ) AS percentage_2025;
-- ;


-- -- Average EPS projection for 2025 
-- SELECT 
--     act_symbol, 
--     period_end_date, 
--     ROUND(CAST(AVG(consensus) AS numeric), 2) AS "eps_projection" 
-- FROM eps_estimate
-- WHERE 
--     extract(year FROM period_end_date::date) >= 2025 
--     AND period = 'Next Year'
-- GROUP BY act_symbol, period_end_date
-- ORDER BY act_symbol ASC;

-- -- Fact sales and eps for 2023
-- SELECT 
--     act_symbol,
--     date,
--     period,
--     sales,
--     diluted_net_eps
-- FROM public.income_statement
-- WHERE period = 'Year' and extract(year FROM date::date) = 2023
-- ORDER BY act_symbol ASC


SELECT 
    eps.act_symbol, 
    eps.period_end_date, 
    ROUND(CAST(AVG(eps.consensus) AS numeric), 2) AS "eps_projection", 
    inc.diluted_net_eps AS "2023_eps", 
    inc.sales AS "2023_sales"
FROM eps_estimate eps 
LEFT JOIN income_statement inc
    ON eps.act_symbol = inc.act_symbol
WHERE 
    extract(year FROM eps.period_end_date::date) = 2025 
    AND eps.period = 'Next Year'
    AND inc.period = 'Year' AND extract(year FROM inc.date::date) = 2023
GROUP BY 
    eps.act_symbol, 
    eps.period_end_date, 
    inc.diluted_net_eps, 
    inc.sales
ORDER BY 
    eps.act_symbol ASC;

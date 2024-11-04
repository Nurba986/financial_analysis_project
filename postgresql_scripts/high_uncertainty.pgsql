-- Compare 2023 sales and eps with analyst projections for 2025
WITH sales_estimate AS (
    SELECT
        act_symbol,
        EXTRACT(YEAR FROM period_end_date) AS year_period,
        consensus AS sales_projection
    FROM sales_estimate
    WHERE EXTRACT(YEAR FROM period_end_date) = 2025
)

-- Get EPS projections for 2025 with 2023 financials, average sales projections, and calculate growth rates.
SELECT 
    eps.act_symbol, 
    EXTRACT(YEAR FROM eps.period_end_date) AS period, 
    inc.diluted_net_eps AS "2023_eps",
    ROUND(AVG(eps.consensus)::numeric, 2) AS "2025_eps_projection", 
    inc.sales AS "2023_sales",
    ROUND(AVG(sales.sales_projection)::numeric, 0) AS "2025_sales_projection",
    CASE 
        WHEN inc.diluted_net_eps = 0 THEN NULL
        ELSE ROUND(((AVG(eps.consensus) - inc.diluted_net_eps) / ABS(inc.diluted_net_eps) * 100)::numeric, 2) 
    END AS "eps_growth_percent",
    CASE 
        WHEN inc.sales = 0 THEN NULL
        ELSE ROUND(((AVG(sales.sales_projection) - inc.sales) / inc.sales * 100)::numeric, 2) 
    END AS "sales_growth_percent"
FROM eps_estimate eps 
JOIN income_statement inc ON eps.act_symbol = inc.act_symbol
JOIN sales_estimate sales ON eps.act_symbol = sales.act_symbol 
WHERE 
    EXTRACT(YEAR FROM eps.period_end_date) = 2025 
    AND eps.period = 'Next Year'
    AND inc.period = 'Year' AND EXTRACT(YEAR FROM inc.date) = 2023
GROUP BY 
    eps.act_symbol, 
    eps.period_end_date, 
    inc.diluted_net_eps, 
    inc.sales
ORDER BY 
    eps.act_symbol;

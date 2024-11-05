-- Create table growth_metrics
CREATE TABLE growth_metrics AS
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
    EXTRACT(YEAR FROM inc.date) AS fact_period, 
    EXTRACT(YEAR FROM eps.period_end_date) AS proj_period, 
    inc.diluted_net_eps AS "eps_fact",
    ROUND(AVG(eps.consensus)::numeric, 2) AS "eps_proj", 
    inc.sales AS "sales_fact",
    ROUND(AVG(sales.sales_projection)::numeric, 0) AS "sales_proj",
    CASE 
        WHEN inc.diluted_net_eps = 0 THEN NULL
        ELSE ROUND(((AVG(eps.consensus) - inc.diluted_net_eps) / ABS(inc.diluted_net_eps) * 100)::numeric, 2) 
    END AS "eps_growth_proj",
    CASE 
        WHEN inc.sales = 0 THEN NULL
        ELSE ROUND(((AVG(sales.sales_projection) - inc.sales) / inc.sales * 100)::numeric, 2) 
    END AS "sales_growth_proj",
    CASE
        WHEN ROUND(AVG(sales.sales_projection)::numeric, 0) > 0 AND inc.sales = 0 THEN 2
        WHEN inc.sales > 0 AND ROUND(AVG(sales.sales_projection)::numeric, 0) = 0 THEN 1
        WHEN inc.sales = 0 AND ROUND(AVG(sales.sales_projection)::numeric, 0) = 0 THEN 0
        ELSE 3
    END AS "flag_sales_growth"
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
    inc.sales, 
    fact_period
ORDER BY 
    eps.act_symbol;


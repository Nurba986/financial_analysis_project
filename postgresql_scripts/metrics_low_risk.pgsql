-- Create or Replace Table for Combined ROE, Debt to Equity Ratio, Liquidity Ratio, and Free Cash Flow Yield
CREATE TABLE low_risk_metrics AS
WITH total_liabilities AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS date,
        act_symbol,
        total_liabilities
    FROM balance_sheet_liabilities
    WHERE 
        period = 'Year' 
        AND EXTRACT(YEAR FROM date) = 2023 
),
total_equity AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS date,
        act_symbol,
        total_equity
    FROM balance_sheet_equity
    WHERE 
        period = 'Year' 
        AND EXTRACT(YEAR FROM date) = 2023 
),
current_liabilities AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS date,
        act_symbol,
        total_current_liabilities
    FROM balance_sheet_liabilities
    WHERE 
        period = 'Year' 
        AND EXTRACT(YEAR FROM date) = 2023 
),
current_assets AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS date,
        act_symbol,
        total_current_assets
    FROM balance_sheet_assets
    WHERE 
        period = 'Year' 
        AND EXTRACT(YEAR FROM date) = 2023 
),
income_statement AS (
    SELECT 
        EXTRACT(YEAR FROM date) AS date,
        act_symbol,
        net_income,
        average_shares
    FROM income_statement
    WHERE 
        period = 'Year' 
        AND EXTRACT(YEAR FROM date) = 2023 
),
filtered_free_cashflow AS (
    SELECT
        act_symbol,
        net_cash_from_operating_activities - property_and_equipment AS fcf
    FROM cash_flow_statement
    WHERE period = 'Year' AND EXTRACT(YEAR from date) = 2023
),
filtered_price AS (
    SELECT
        date,
        act_symbol,
        close AS price
    FROM stock_price
    WHERE date = '2023-12-29'
)

SELECT 
    tl.act_symbol,
    CASE WHEN cl.total_current_liabilities != 0 THEN ROUND(CAST(ca.total_current_assets AS DECIMAL) / CAST(cl.total_current_liabilities AS DECIMAL), 2) ELSE 0 END AS liq_ratio,
    CASE
        WHEN ca.total_current_assets = 0 AND cl.total_current_liabilities = 0 THEN 0 -- Flag for undefined
        WHEN ca.total_current_assets = 0 THEN 1 -- Flag for bad financial situation
        WHEN cl.total_current_liabilities = 0 THEN 2 -- Flag for good financial situation
        ELSE 3 -- Normal cases
    END AS flag_liq_ratio,
    CASE 
        WHEN te.total_equity != 0 
        THEN ROUND(tl.total_liabilities::numeric / te.total_equity::numeric, 2) 
        ELSE NULL 
    END AS de_ratio,
    CASE 
        WHEN tl.total_liabilities = 0 AND te.total_equity = 0 THEN 0  -- Flag for undefined
        WHEN tl.total_liabilities = 0 THEN 2  -- Flag for good financial situation
        WHEN te.total_equity = 0 THEN 1  -- Flag for bad financial situation
        ELSE 3 -- Normal cases
    END AS flag_de_ratio,
    ROUND(
        CASE
            WHEN te.total_equity <= 0 THEN NULL
            ELSE CAST(i.net_income AS NUMERIC) / CAST(te.total_equity AS NUMERIC)
        END, 2
    ) AS roe_ratio,
    CASE
        WHEN i.net_income = 0 AND te.total_equity > 0 THEN 2
        WHEN i.net_income = 0 AND te.total_equity < 0 THEN 1
        WHEN i.net_income < 0 AND te.total_equity < 0 THEN 1
        WHEN i.net_income = 0 AND te.total_equity = 0 THEN 0
        ELSE 3
    END AS flag_roe_ratio,
    fcf.fcf,
    (fp.price * i.average_shares) AS market_cap,
    CASE
        WHEN fp.price * i.average_shares = 0 THEN NULL
        ELSE ROUND(CAST((fcf.fcf / (fp.price * i.average_shares)) AS NUMERIC), 2)
    END AS fcf_yield
FROM total_liabilities tl
JOIN total_equity te 
    ON tl.act_symbol = te.act_symbol AND tl.date = te.date
JOIN current_assets ca
    ON tl.act_symbol = ca.act_symbol AND tl.date = ca.date
JOIN current_liabilities cl
    ON tl.act_symbol = cl.act_symbol AND tl.date = cl.date
JOIN income_statement i
    ON tl.act_symbol = i.act_symbol AND tl.date = i.date
JOIN filtered_free_cashflow fcf
    ON tl.act_symbol = fcf.act_symbol
JOIN filtered_price fp
    ON tl.act_symbol = fp.act_symbol;

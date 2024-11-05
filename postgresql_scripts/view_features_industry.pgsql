CREATE OR REPLACE VIEW vw_MetricsPerformance AS
SELECT
    i_n.name,
    lrm.act_symbol,
    i_n.sector,
    i_n.industry,
    i_n.exchange,
    i_n.broad_group,
    g_m.fact_period,
    ROUND(CAST(lrm.market_cap AS NUMERIC), 2) AS market_cap,
    lrm.fcf AS f_cash_flow,
    lrm.fcf_yield,
    lrm.liq_ratio,
    lrm.de_ratio,
    (lrm.roe_ratio*100) as roe,
    g_m.proj_period,
    g_m.eps_growth_proj,
    g_m.sales_growth_proj,
    lrm.flag_de_ratio,
    lrm.flag_liq_ratio,
    lrm.flag_roe_ratio,
    g_m.flag_sales_growth     
FROM low_risk_metrics lrm
JOIN ind_name i_n
    ON lrm.act_symbol = i_n.act_symbol
JOIN growth_metrics g_m
    ON i_n.act_symbol = g_m.act_symbol;



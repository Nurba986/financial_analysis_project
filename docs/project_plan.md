Stock Investing Strategy: Low Risk, High Uncertainty
    Project Overview
        Objective: Identify stocks in unprofitable industries with strong financial health and high growth potential.
        Approach: Leverage data analysis and financial metrics to build a portfolio that balances risk and opportunity.

    Scope
        Data Sources: Yahoo Finance, Bloomberg, Kaggle, industry reports.
        Key Metrics: Debt-to-equity ratio, liquidity ratios, cash flow yield, revenue growth.

    Data Collection
        Sources: Balance sheets, income statements, cash flow statements, and industry insights.
        Tools: APIs like Yahoo Finance, web scraping for specific data needs.

    Data Cleaning
        Impute or drop missing data where necessary.
        Identify and handle outliers using IQR or Z-score methods.
        Standardize data formats for consistency.

    Data Analysis (use PostgresSql)
        Low risk metrics
            Liquidity ratios to evaluate short-term financial health. 
            Debt-to-equity ratio for leverage assessment.
            ROE ratio.
            Cash flow to determine available cash for investments.
        
        High uncertainty metrics
            Calculate EPS growth using by analysts eps projection for 2025.
            Calculate SALES growth using by analysts eps projection for 2025.
        
        Group companies by industries.
            Calculate average values by industry for ROE, DE_Ratio, Liq_Ratio.
                Check distribution and outliers.
                Use mean or median depends on the type of distribution.
                    
        Compare companies growth with industry average.    
            Find industry leaders or companies with over 15% growth prospects.
            Find industry leaders with debt to equity less 0.5.
            Find industry leaders with liquidity ratio over 1.

    Investment Decision Framework
        Financial Stability: Companies with strong liquidity and low debt.
        Growth Potential: Preference for industries with high projected growth.
        Diversification: Spread investments across different high-growth sectors to manage risk.


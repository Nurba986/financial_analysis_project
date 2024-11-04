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
            Add flag for:
                unknown value = 0,
                for bad company health = 1,
                for good company health = 2.
            Debt-to-equity ratio for leverage assessment.
            Add flag for:
                unknown value = 0,
                for bad company health = 1,
                for good company health = 2.
            ROE ratio.
            Add flag for:
                unknown value = 0,
                for bad company health = 1,
                for good company health = 2.
            Cash flow to determine available cash for investments.
        High uncertainty metrics
            Analyst predictions for earnings per share (EPS) and sales for 2025.
            Group companies by industries.
            Retrieve industries with over 15 % growth potential in sales and EPS.
            Compare companies growth with industry average.
        Total    
            Find industry leaders or companies with over 15% growth prospects.
            Find industry leaders with debt to equity less 0.5.
            Find industry leaders with liquidity ratio over 1.

    Modeling and Scoring
        Scoring System:
        Assign higher scores to companies with low debt and high liquidity.
        Prioritize sectors with high growth potential based on EPS estimates and other financial indicators.

    Investment Decision Framework
        Financial Stability: Companies with strong liquidity and low debt.
        Growth Potential: Preference for industries with high projected growth.
        Diversification: Spread investments across different high-growth sectors to manage risk.

    Future Enhancements
        Machine Learning: Integrate machine learning models to automate company scoring and prediction.
        Sentiment Analysis: Apply sentiment analysis to gauge market perceptions.
        Reinforcement Learning: Use reinforcement learning for dynamic portfolio adjustments based on market changes.

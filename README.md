# Analysis of CyrptoMarket
**Note:** I have a Word document, "Analyzing the crypto market," that dives deeper into my analysis and showcases step-by-step the processes of my code in Python and R. This ReadMe is a summarised version. It provides recommendations using my findings from an investor and business point of view. If you have time, you can read and learn more!!

## **Project Name: Exploring Crypto Market data with a smart workflow**

**Project description:**
This project involves using Python to pull data on the cryptocurrency market from CoinMarketCap’s API and then automating that process. Next, I take the data gathered and perform simple Data Analytics and Data Science techniques on the data gathered to generate visualization. The purpose of this project was for me to learn basic workflow skills and develop a written report on my findings.

## **Data set**
I pulled the data set used in this project through the CoinMarketCap API across 15 minutes and with 1-minute intervals between each pull. I utilized Python and its automation capabilities to do so

## **Key Metrics used in analysis**
- **Timestamp**: The timestamp of the cryptocurrency data.
- **Time**: The extracted time (HH:MM:SS format) from the timestamp.
- **quote.USD.price**: The price of the cryptocurrency in USD.
- **quote.USD.market_cap**: The market capitalization of the cryptocurrency.
- **quote.USD.market_cap_dominance**: The dominance of the cryptocurrency in terms of market cap percentage.
- **quote.USD.percent_change_1h**: Percent change in price over the past 1 hour. --> 1hr - 90days'

## **Simple Data Analysis Visualizations** 

![image alt](https://github.com/T-Tamz/Smart-Data-Workflow-API-Automation-in-Python-Analysis-in-R/blob/8816f53230f321f936952c30dba9d1e48d4db69b/Images/Percent%20changes.png)

![image alt](https://github.com/T-Tamz/Smart-Data-Workflow-API-Automation-in-Python-Analysis-in-R/blob/8816f53230f321f936952c30dba9d1e48d4db69b/Images/Market%20Cap%20distribution.png)

### Key Findings:
Cryptocurrency Market Volatility Increases Over Time:
- Short-term fluctuations (1h-24h) are minor, but volatility grows over longer periods (30d-90d).
Avalanche shows the highest growth, suggesting strong adoption or external influences.

General Market Uptrend with Periodic Spikes:
- Most cryptocurrencies show positive growth, with notable rallies at 60d and 90d.
Some cryptos, like Solana, Ethereum, and Chainlink, exhibit steady growth, while others (Shiba Inu, Dogecoin) display erratic spikes, indicating speculative trading.

Bitcoin and Ethereum Dominate Market Capitalization:
- Bitcoin leads with the highest market cap dominance, reinforcing its role as the most influential cryptocurrency.
Ethereum follows as the second-largest due to its DeFi, smart contract, and NFT applications.

Stablecoins (Tether USDT, USDC) Show Minimal Price Changes:
- As expected, stablecoins maintain price stability, emphasizing their role in liquidity and trading.

Lower-Tier Cryptos Have Limited Market Influence:
- Shiba Inu, Stellar, and Sui have minimal market cap dominance, suggesting lower adoption or speculative value.


## **Data Science Visualizations**
### Original Distribution

![image alt](https://github.com/T-Tamz/Analysis-of-Crypto-Market/blob/483b568e504a453edc6f1a01cd25be328e91c577/Images/Original%20Dist.png)

### BootStrapped Distribution

![image alt](https://github.com/T-Tamz/Smart-Data-Workflow-API-Automation-in-Python-Analysis-in-R/blob/8816f53230f321f936952c30dba9d1e48d4db69b/Images/Boot%20Dist.png)

![image alt](https://github.com/T-Tamz/Smart-Data-Workflow-API-Automation-in-Python-Analysis-in-R/blob/8816f53230f321f936952c30dba9d1e48d4db69b/Images/Clustering.png)


### **Key Findings**:
Bootstrapped Price Distribution Enhances Accuracy:
- Resampling 20,000 times reduced sampling bias, improving the mean estimate to $7,242.10, slightly higher than the initial $7,239.86.
The refined estimate provides a more reliable foundation for market analysis.

Cryptocurrency Price Distribution is Highly Skewed:
- Most prices cluster at the lower end, while a few cryptos (e.g., Bitcoin) have extreme high values.
Suggests a market dominated by a few high-value assets, with many lower-value speculative coins.

Clustering Reveals Market Segmentation:
- Cluster 1 (Low Market Cap, Low Price): Emerging or speculative cryptos, priced below $1.
- Cluster 2 (High Market Cap, High Price): Bitcoin, Ethereum—dominant, widely adopted assets.
- Cluster 3 (Mid-Tier Cryptos): Established but non-dominant assets (e.g., Solana, XRP).
- Log-transformation of market cap improved visualization and cluster separation.


## **Recomendations**
**For Investors & Traders:**
- Leverage Long-Term Volatility Trends: Use 30d-90d price fluctuations to time strategic entry and exit points.
- Use Bootstrapped Mean for Risk Assessment: A refined mean estimate enhances price forecasting and decision-making.

**Business/internal:**
- Develop AI-Driven Price Forecasting Models – Utilize bootstrapped mean estimates and historical volatility (30d-90d) to improve predictive analytics for crypto pricing.
- Implement Clustering-Based Market Segmentation – Use K-Means clustering to categorize cryptocurrencies into investment tiers (dominant, mid-tier, speculative), enabling targeted trading strategies.
- Integrate Volatility-Based Trading Strategies – Design and deploy algorithmic trading models that leverage observed market trends for optimal buy/sell execution.

## **Next Steps**
- Integrate sentiment analysis from social media/news.
- Identify seasonal trends and correlations with macroeconomic indicators.
- Detect trading anomalies (pump-and-dump schemes).
- Migrate to cloud for better computing capabilities to improve accuracy of predictive model

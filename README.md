# Hotel Revenue SQL Analysis (2018–2020)

## Overview
Analysis of a hotel booking dataset spanning three years (2018–2020), combining
data across two hotel types to answer business questions around cancellations,
pricing, and guest behavior. Built in Microsoft SQL Server, with a Power BI
dashboard for the family-bookings-by-country visualization.

## Tools Used
- Microsoft SQL Server (T-SQL)
- Power BI Desktop

## Data
Three yearly tables (2018, 2019, 2020) with identical structure — booking-level
hotel data including arrival dates, length of stay, ADR (average daily rate),
cancellation status, guest counts, country, and deposit/market segment info.

A user-defined function, `AllHotelBookings()`, combines all three years into a
single queryable set:

\`\`\`sql
CREATE FUNCTION dbo.AllHotelBookings()
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM ['2018$']
    UNION ALL
    SELECT * FROM ['2019$']
    UNION ALL
    SELECT * FROM ['2020$']
)
\`\`\`

## Findings

### 1. Cancellations by Country
While [country from Q1a] has the highest raw number of cancellations, driven
largely by booking volume, [country from Q1b] shows the highest cancellation
rate at [X]% — indicating a proportionally bigger cancellation problem despite
a smaller customer base. Additionally, canceled bookings show a higher average
lead time than non-canceled ones, suggesting that guests who book further in
advance are more likely to cancel.

2. Revenue & Pricing Patterns

August is the strongest month overall, both in average daily rate (145.89) and total estimated revenue (R8.65M) — but this is driven almost entirely by Resort Hotel, whose pricing is highly seasonal (ranging from 47.92 in November to 180.48 in August, a ~3.75x swing). City Hotel shows a much flatter pattern, peaking instead in May (127.85) with only a ~23% range across the year, suggesting steadier, less vacation-driven demand. This implies the two hotel types need different pricing strategies: Resort Hotel has room to price aggressively in peak summer and should focus on competitive/discount strategy in the off-season (Nov–Feb), while City Hotel's demand is better suited to more consistent year-round pricing.

How to Run
Restore the hotel revenue data into SQL Server (one table per year)
Run functions.sql to create AllHotelBookings()
Run queries from queries.sql individually, or open the .pbix file in Power BI Desktop for the visual dashboard

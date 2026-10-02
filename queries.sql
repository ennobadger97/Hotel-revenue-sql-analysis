USE HotelDB;

CREATE FUNCTION AllHotelBookings ()
RETURNS TABLE 
AS 
RETURN 
(
	SELECT * 
	FROM ['2018$']
	UNION ALL
	SELECT *
	FROM ['2019$']
	UNION ALL
	SELECT *
	FROM ['2020$']
)


/* Cancellation counts by country */
SELECT TOP (15)
    country,
    COUNT(*) AS TotalBookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS TotalCancellations
FROM AllHotelBookings()
GROUP BY country
ORDER BY TotalCancellations DESC

/* Cancellation rate by country */
SELECT TOP (15)
    country,
    COUNT(*) AS TotalBookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) AS TotalCancellations,
    ROUND(
        SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)
    , 2) AS CancellationRatePct
FROM AllHotelBookings()
GROUP BY country
ORDER BY CancellationRatePct DESC

/* Average lead time by cancellation status */
SELECT is_canceled, AVG(lead_time) as 'avg_lead_time'
FROM AllHotelBookings()
WHERE is_canceled = 1 OR is_canceled = 0
GROUP BY is_canceled

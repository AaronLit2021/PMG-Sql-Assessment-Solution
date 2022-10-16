# Question #3 Merge these two datasets so we can see impressions, clicks, 
# and revenue together by date and geo. Please ensure all records from each table are accounted for.

SELECT geo,t1.date,total_impressions,total_clicks,total_rev
FROM
(
SELECT date,geo, SUM(impressions) AS total_impressions, SUM(clicks) AS total_clicks
FROM marketing_data
GROUP BY date,geo
) t1
LEFT JOIN
(
SELECT date, RIGHT(store_location,2) AS location, SUM(revenue) AS total_rev
FROM store_revenue
GROUP BY date,store_location
) t2
ON t1.date = t2.date AND t1.geo = t2.location;
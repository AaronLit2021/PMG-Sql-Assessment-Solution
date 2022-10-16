# Question #4 In your opinion, what is the most efficient store and why?

SELECT geo,total_impressions,total_clicks,total_rev,
ROUND(total_clicks/total_impressions,3) AS click_per_impression,
ROUND(total_rev / total_clicks,3) AS rev_per_click
FROM
(
SELECT geo, SUM(impressions) AS total_impressions, SUM(clicks) AS total_clicks
FROM marketing_data
GROUP BY geo
) t1
LEFT JOIN
(
SELECT RIGHT(store_location,2) AS location, SUM(revenue) AS total_rev
FROM store_revenue
GROUP BY store_location
) t2
ON t1.geo = t2.location;

-- I calculated the click per impression and revenue per click, and found out that the 
-- CA store has the highest revenue per click rate and also very high click per impression, 
-- which means that The California store has a very high click conversion rate and the highest 
-- click-to-revenue efficiency. Since total revenue from the Minnesota store is missing, 
-- the California store is the most efficient  one based on current data.
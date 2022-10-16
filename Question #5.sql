# Question #5 (Challenge) Generate a query to rank in order the top 10 revenue producing states

SELECT store_location,
total_revenue,
rank() OVER (ORDER BY total_revenue DESC) AS ranking
FROM
(
SELECT store_location,
SUM(revenue) AS total_revenue
FROM store_revenue
GROUP BY store_location
) T
ORDER BY ranking;
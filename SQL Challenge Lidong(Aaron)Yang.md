# SQL Challenge

The database contains two tables, store_revenue and marketing_data. Refer to the two CSV files, store_revenue and marketing_data to understand how these tables have been created.

store_revenue contains revenue by date, brand ID, and location:

> create table store_revenue ( id int not null primary key auto_increment, date datetime, brand_id int, store_location varchar(250), revenue float);
> 

marketing_data contains ad impression and click data by date and location:

> create table marketing_data ( id int not null primary key auto_increment, date datetime, geo varchar(2), impressions float, clicks float );
> 

### **Please provide a SQL statement under each question.**

- Question #0 (Already done for you as an example) Select the first 2 rows from the marketing data

> select * from marketing_data limit 2;
> 
- Question #1 Generate a query to get the sum of the clicks of the marketing data

> SELECT SUM(clicks) AS total_clicks 
FROM marketing_data;
> 
- Question #2 Generate a query to gather the sum of revenue by store_location from the store_revenue table

> SELECT store_location,SUM(revenue) AS total_revenue 
FROM store_revenue 
GROUP BY store_location;
> 
- Question #3 Merge these two datasets so we can see impressions, clicks, and revenue together by date and geo. Please ensure all records from each table are accounted for.

> SELECT geo,t1.date,total_impressions,total_clicks,total_rev
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
> 
- Question #4 In your opinion, what is the most efficient store and why?

> SELECT geo,total_impressions,total_clicks,total_rev,
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
> 

I calculated the click per impression and revenue per click, and found out that the CA store has the highest revenue per click rate and also very high click per impression , which means that The California store has a very high click conversion rate and the highest click-to-revenue efficiency. Since total revenue from the Minnesota store is missing, the California store is the most efficient  one based on current data.

- Question #5 (Challenge) Generate a query to rank in order the top 10 revenue producing states

> SELECT store_location,
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
>
-- Analyzing Traffic Sources

SELECT utm_content,
       COUNT(DISTINCT website_sessions.website_session_id)                              as sessions,
       COUNT(DISTINCT o.order_id)                                                       AS orders,
       COUNT(DISTINCT o.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rt
FROM website_sessions
         LEFT JOIN orders o on website_sessions.website_session_id = o.website_session_id
WHERE website_sessions.website_session_id BETWEEN 1000 AND 2000 -- arbitrary
GROUP BY 1
ORDER BY 2 DESC;


-- Assignment +
SELECT utm_source,
       utm_campaign,
       http_referer,
       COUNT(website_session_id) AS sessions
FROM website_sessions
WHERE created_at < '2012-04-12'
GROUP BY utm_source,
         utm_campaign,
         http_referer
ORDER BY sessions DESC;

-- Assignment +
SELECT COUNT(DISTINCT website_sessions.website_session_id)                                   AS sessions,
       COUNT(DISTINCT orders.order_id)                                                       AS orders,
       COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rt
FROM website_sessions
         LEFT JOIN orders
                   ON orders.website_session_id
                       = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-04-14'
  AND utm_source = 'gsearch'
  AND utm_campaign = 'nonbrand';


-- Bid Optimization & Trend Analysis
SELECT YEAR(created_at)                   AS created_yr,
       WEEK(created_at)                   AS created_wk,
       COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 and 115000
GROUP BY YEAR(created_at),
         week(created_at);


-- Bid Optimization & Trend Analysis
SELECT primary_product_id,
       COUNT(DISTINCT IF(items_purchased = 1, order_id, NULL)) AS orders_w_1_item,
       COUNT(DISTINCT IF(items_purchased = 2, order_id, NULL)) AS orders_w2_items,
       COUNT(DISTINCT order_id)                                AS total_orders
FROM orders
WHERE order_id BETWEEN 31000 AND 32000
GROUP BY 1;


-- Assignment +
SELECT YEARWEEK(website_sessions.created_at)               AS year_week,
       MIN(DATE(created_at))                               AS week_start_date,
       COUNT(DISTINCT website_sessions.website_session_id) AS sessions
FROM website_sessions
WHERE website_sessions.created_at < '2012-05-10'
  AND website_sessions.utm_source = 'gsearch'
  AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(website_sessions.created_at);



SELECT website_sessions.device_type,
       COUNT(DISTINCT website_sessions.website_session_id)                                   AS sessions,
       COUNT(DISTINCT orders.order_id)                                                       AS orders,
       COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rt
FROM website_sessions
         LEFT JOIN orders
                   ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at < '2012-05-11'
  AND utm_source = 'gsearch'
  AND utm_campaign = 'nonbrand'
GROUP BY 1;



SELECT YEARWEEK(website_sessions.created_at)                                                  AS year_week,
       MIN(DATE(created_at))                                                                  AS week_start_date,
       COUNT(DISTINCT IF(device_type = 'desktop', website_sessions.website_session_id, NULL)) AS dtop_sessions,
       COUNT(DISTINCT IF(device_type = 'mobile', website_sessions.website_session_id, NULL))  AS mob_sessions
FROM website_sessions
WHERE website_sessions.created_at < '2012-06-09'
  AND website_sessions.created_at > '2012-04-15'
  AND website_sessions.utm_source = 'gsearch'
  AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(website_sessions.created_at);



SELECT pageview_url,
       COUNT(DISTINCT website_pageview_id) AS views
FROM website_pageviews
WHERE website_pageview_id < 1000
GROUP BY 1
ORDER BY 2 DESC;



SELECT pageview_url,
       COUNT(DISTINCT website_session_id) AS sessions
FROM website_pageviews
WHERE created_at < '2012-06-09'
GROUP BY pageview_url
ORDER BY sessions DESC;



CREATE TEMPORARY TABLE first_pageviews
SELECT website_session_id,
       MIN(website_pageview_id) AS min_pageview_id
FROM website_pageviews
WHERE created_at < '2012-06-12'
GROUP BY website_session_id;


SELECT website_pageviews.pageview_url            AS landing_page,
       COUNT(first_pageviews.website_session_id) AS sessions_hitting_this_landing_page
FROM first_pageviews
         LEFT JOIN website_pageviews
                   ON website_pageviews.website_pageview_id = first_pageviews.min_pageview_id
GROUP BY website_pageviews.pageview_url;

SELECT MIN(website_pageviews.created_at)          AS first_created_at,
       MIN(website_pageviews.website_pageview_id) AS first_pv_id
FROM website_pageviews
WHERE pageview_url = '/billing-2';



SELECT billing_version_seen,
       COUNT(DISTINCT website_session_id)                            AS sessions,
       COUNT(DISTINCT order_id)                                      AS orders,
       COUNT(DISTINCT order_id) / COUNT(DISTINCT website_session_id) AS billing_to_order_rt
FROM (SELECT website_pageviews.website_session_id,
             website_pageviews.pageview_url AS billing_version_seen,
             orders.order_id
      FROM website_pageviews
               LEFT JOIN orders
                         ON orders.website_session_id = website_pageviews.website_session_id
      WHERE website_pageviews.website_pageview_id >= 53550
        AND website_pageviews.created_at < '2012-11-10'
        AND website_pageviews.pageview_url IN ('/billing', '/billing-2')) AS billing_sessions_w_orders
GROUP BY billing_version_seen;



SELECT utm_content,
       COUNT(DISTINCT website_sessions.website_session_id)                                   AS sessions,
       COUNT(DISTINCT orders.order_id)                                                       AS orders,
       COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate
FROM website_sessions
         LEFT JOIN orders
                   ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at BETWEEN '2014-01-01' AND '2014-02-01'
GROUP BY 1
ORDER BY 2 DESC;


SELECT YEARWEEK(created_at)                                                 AS year_week,
       MIN(DATE(created_at))                                                AS week_start_date,
       COUNT(DISTINCT IF(utm_source = 'search', website_session_id, NULL))  AS gsearch_sessions,
       COUNT(DISTINCT IF(utm_source = 'bsearch', website_session_id, NULL)) AS bsearch_sessions
FROM website_sessions
WHERE created_at > '2012-08-22'
  AND created_at > '2012-11-29'
  AND utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(created_at);


SELECT utm_source,
       COUNT(DISTINCT website_session_id)       AS                          sessions,
       COUNT(DISTINCT IF(device_type = 'mobile', website_session_id, NULL)) mobile_sessions,
       COUNT(DISTINCT IF(device_type = 'mobile', website_session_id, NULL))
           / COUNT(DISTINCT website_session_id) AS                          pct_mobile_continued
FROM website_sessions
WHERE created_at > '2012-08-22'
  AND created_at < '2012-11-30'
  AND utm_campaign = 'nonbrand'
GROUP BY utm_source;



SELECT website_sessions.device_type,
       website_sessions.utm_source,
       COUNT(DISTINCT website_sessions.website_session_id)                                   AS sessions,
       COUNT(DISTINCT orders.order_id)                                                       AS orders,
       COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate
FROM website_sessions
         LEFT JOIN orders
                   ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at > '2012-08-22'
  AND website_sessions.created_at < '2012-09-19'
  AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY website_sessions.device_type,
         website_sessions.utm_source;


SELECT YEARWEEK(created_at)           AS year_week,
       MIN(DATE(created_at))          AS week_start_date,
       COUNT(DISTINCT IF(utm_source = 'gsearch' AND device_type = 'desktop', website_session_id,
                         NULL))       AS g_dtop_sessions,
       COUNT(DISTINCT IF(utm_source = 'bsearch' AND device_type = 'desktop', website_session_id,
                         NULL))       AS b_dtop_sessions,
       COUNT(DISTINCT IF(utm_source = 'bsearch' AND device_type = 'desktop', website_session_id, NULL))
           / COUNT(DISTINCT IF(utm_source = 'gsearch' AND device_type = 'desktop', website_session_id,
                               NULL)) AS b_pct_of_g_dtop,
       COUNT(DISTINCT IF(utm_source = 'gsearch' AND device_type = 'mobile', website_session_id,
                         NULL))       AS g_mob_sessions,
       COUNT(DISTINCT IF(utm_source = 'bsearch' AND device_type = 'mobile', website_session_id,
                         NULL))       AS b_mob_sessions,
       COUNT(DISTINCT IF(utm_source = 'bsearch' AND device_type = 'mobile', website_session_id, NULL))
           / COUNT(DISTINCT IF(utm_source = 'gsearch' AND device_type = 'mobile', website_session_id,
                               NULL)) AS b_pct_of_9_mob
FROM website_sessions
WHERE created_at > '2012-11-41'
  AND created_at < '2012 -12-22'
  AND utm_campaign = 'nonbrand'
GROUP BY YEARWEEK(created_at);

SELECT CASE
           WHEN http_referer IS NULL AND is_repeat_session = 0 THEN 'new_direct_type_in'
           WHEN http_referer IS NULL AND is_repeat_session = 1 THEN 'repeat_direct_type_in'
           WHEN http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') AND is_repeat_session = 0
               THEN 'new_organic'
           WHEN http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com') AND is_repeat_session = 1
               THEN 'repeat_organic'
           END                            AS segment,
       COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000
  AND utm_source IS NULL
GROUP BY 1;

SELECT YEAR(created_at)                                                                    AS yr,
       MONTH(created_at)                                                                   AS mo,
       COUNT(DISTINCT IF(channel_group = 'paid_nonbrand', website_session_id, NULL))       AS nonbrand,
       COUNT(DISTINCT IF(channel_group = 'paid_brand', website_session_id, NULL))          AS brand,
       COUNT(DISTINCT IF(channel_group = 'paid_brand', website_session_id, NULL))
           / COUNT(DISTINCT IF(channel_group = 'paid_nonbrand', website_session_id, NULL)) AS brand_pct_of_nonbrand,
       COUNT(DISTINCT IF(channel_group = 'direct_type_in', website_session_id, NULL))      AS direct,
       COUNT(DISTINCT IF(channel_group = 'direct_type_in', website_session_id, NULL))
           / COUNT(DISTINCT IF(channel_group = 'paid_nonbrand', website_session_id, NULL)) AS direct_pct_of_nonbrand,
       COUNT(DISTINCT IF(channel_group = 'organic_search', website_session_id, NULL))      AS organic,
       COUNT(DISTINCT IF(channel_group = 'organic_search', website_session_id, NULL))
           / COUNT(DISTINCT IF(channel_group = 'paid_nonbrand', website_session_id, NULL)) AS organic_pct_of_nonbrand
FROM (SELECT website_session_id,
             created_at,
             CASE
                 WHEN utm_source IS NULL AND http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com')
                     THEN 'organic_search'
                 WHEN utm_campaign = 'nonbrand' THEN 'paid_nonbrand'
                 WHEN utm_campaign = 'brand' THEN 'paid_brand'
                 WHEN utm_source IS NULL AND http_referer IS NULL THEN 'direct_type_in'
                 END AS channel_group
      FROM website_sessions
      WHERE created_at < '2012-12-23') AS sessions_w_channel_group
GROUP BY YEAR(created_at),
         MONTH(created_at);



SELECT WEEK(created_at)                   AS wk,
       DATE(created_at)                   AS dt,
       WEEKDAY(created_at)                AS wkday,
       HOUR(created_at)                   AS hr,
       COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE website_session_id BETWEEN 100000 AND 115000
GROUP BY 1, 2, 3, 4;


SELECT YEAR(website_sessions.created_at)                   AS yr,
       MONTH(website_sessions.created_at)                  AS mo,
       COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
       COUNT(DISTINCT orders.order_id)                     AS orders
FROM website_sessions
         LEFT JOIN orders
                   ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2013-01-01'
GROUP BY 1, 2;

SELECT hr,
       ROUND(AVG(IF(wkday = 0, website_sessions, NULL)), 1) AS mon,
       ROUND(AVG(IF(wkday = 1, website_sessions, NULL)), 1) AS tue,
       ROUND(AVG(IF(wkday = 2, website_sessions, NULL)), 1) AS wed,
       ROUND(AVG(IF(wkday = 3, website_sessions, NULL)), 1) AS thu,
       ROUND(AVG(IF(wkday = 4, website_sessions, NULL)), 1) AS fri,
       ROUND(AVG(IF(wkday = 5, website_sessions, NULL)), 1) AS sat,
       ROUND(AVG(IF(wkday = 6, website_sessions, NULL)), 1) AS sun
FROM (SELECT DATE(created_at)                   AS created_date,
             WEEKDAY(created_at)                AS wkday,
             HOUR(created_at)                   AS hr,
             COUNT(DISTINCT website_session_id) AS website_sessions
      FROM website_sessions
      WHERE created_at BETWEEN '2012 - 09 - 15 ' AND '2012-11-15'
      GROUP BY 1, 2, 3) daily_hourly_sessions
GROUP BY hr;

SELECT primary_product_id,
       COUNT(order_id)           AS orders,
       SUM(price_usd)            AS revenue,
       SUM(price_usd - cogs_usd) AS margin,
       AVG(price_usd)            AS average
FROM orders
WHERE order_id BETWEEN 10000 AND 11000
GROUP BY 1
ORDER BY 4 DESC;

SELECT YEAR(created_at)          AS yr,
       MONTH(created_at)         AS mo,
       COUNT(DISTINCT order_id)  AS number_of_sales,
       SUM(price_usd)            AS total_revenue,
       SUM(price_usd - cogs_usd) AS total_margin
FROM orders
WHERE created_at < '2013-01-04'
GROUP BY YEAR(created_at),
         MONTH(created_at);


SELECT YEAR(website_sessions.created_at)                                                     AS yr,
       MONTH(website_sessions.created_at)                                                    AS mo,
       - COUNT(DISTINCT website_sessions.website_session_id)                                 AS sessions,
       COUNT(DISTINCT orders.order_id)                                                       AS orders,
       COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate,
       SUM(orders.price_usd) / COUNT(DISTINCT website_sessions.website_session_id)           AS revenue_per_session,
       COUNT(DISTINCT IF(primary_product_id = 1, order_id, NULL))                            AS product_one_orders,
       COUNT(DISTINCT IF(primary_product_id = 2, order_id, NULL))                            AS product_two_orders
FROM website_sessions
         LEFT JOIN orders
                   ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2013-04-05'
  AND website_sessions.created_at > '2012-04-01'
GROUP BY 1, 2;

SELECT orders.primary_product_id,
       order_items.product_id          AS cross_sold_product_id,
       COUNT(DISTINCT orders.order_id) AS orders
FROM orders
         LEFT JOIN order_items
                   ON orders.order_id = order_items.order_id
                       AND order_items.is_primary_item = 0
WHERE orders.order_id BETWEEN 10000 AND 11000
GROUP BY 1.2
ORDER BY 3 DESC;

SELECT CASE
           WHEN website_sessions.created_at < '2013-12-12' THEN 'A. Pre_Birthday_Bear'
           WHEN website_sessions.created_at >= '12013-12-12' THEN 'B. Post Birthday Bear'
           ELSE 'uh oh. ..check logic'
           END                                                                               AS time_period,
       COUNT(DISTINCT website_sessions.website_session_id)                                   AS sessions,
       COUNT(DISTINCT orders.order_id)                                                       AS orders,
       COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate,
       SUM(orders.price_usd)                                                                 AS total_revenue,
       SUM(orders.items_purchased)                                                           AS total_products_sold,
       SUM(orders.price_usd) / COUNT(DISTINCT orders.order_id)                               AS average_order_value,
       SUM(orders.items_purchased) / COUNT(DISTINCT orders.order_id)                         AS products_per_order,
       SUM(orders.price_usd) / COUNT(DISTINCT website_sessions.website_session_id)           AS revenue_per_session
FROM website_sessions
         LEFT JOIN orders
                   ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at BETWEEN '2013-11-12' AND '2014-01-12'
GROUP BY 1;



SELECT order_items.order_id,
       order_items.order_item_id,
       order_items.price_usd AS price_paid_usd,
       order_items.created_at,
       order_item_refunds.order_item_refund_id,
       order_item_refunds.refund_amount_usd,
       order_item_refunds.created_at
FROM order_items
         LEFT JOIN order_item_refunds
                   ON
                           order_item_refunds.order_item_id =
                           order_items.order_item_id
WHERE order_items.order_id IN (3489, 32049, 27061);

SELECT YEAR(order_items.created_at)                                              AS yr,
       MONTH(order_items.created_at)                                             AS mo,
       COUNT(DISTINCT IF(product_id = 1, order_items.order_item_id, NULL))       AS p1_orders,
       COUNT(DISTINCT IF(product_id = 1, order_item_refunds.order_item_id, NULL))
           / COUNT(DISTINCT IF(product_id = 1, order_items.order_item_id, NULL)) AS p1_refund_rt,
       COUNT(DISTINCT IF(product_id = 2, order_items.order_item_id, NULL))       AS p2_orders,
       COUNT(DISTINCT IF(product_id = 2, order_item_refunds.order_item_id, NULL))
           /
       COUNT(DISTINCT IF(product_id = 2, order_items.order_item_id, NULL))       AS p2_refund_rt,
       COUNT(
               DISTINCT IF(product_id = 3, order_items.order_item_id, NULL))     AS p3_orders,
       COUNT(DISTINCT IF(product_id = 3, order_item_refunds.order_item_id, NULL))
           / COUNT(DISTINCT IF(product_id = 3, order_items.order_item_id, NULL)) AS p3_refund_rt,
       COUNT(DISTINCT IF(product_id = 4, order_items.order_item_id, NULL))       AS p4_orders,
       COUNT(DISTINCT IF(product_id = 4, order_item_refunds.order_item_id, NULL))
           / COUNT(DISTINCT IF(product_id = 4, order_items.order_item_id, NULL)) AS p4_refund_rt
FROM order_items
         LEFT JOIN order_item_refunds
                   ON order_items.order_item_id = order_item_refunds.order_item_id
WHERE order_items.created_at < '2014-10-15'
GROUP BY 1, 2;

SELECT order_items.order_id,
       order_items.order_item_id,
       order_items.price_usd                                           AS price_paid_usd,
       order_items.created_at,
       order_item_refunds.order_item_refund_id,
       order_item_refunds.refund_amount_usd,
       order_item_refunds.created_at,
       DATEDIFF(order_item_refunds.created_at, order_items.created_at) AS days_order_to_refund
FROM order_items
         LEFT JOIN order_item_refunds
                   ON order_item_refunds.order_item_id = order_items.order_item_id
WHERE order_items.order_id IN (3489, 32049, 27061);


SELECT CASE
           WHEN utm_source IS NULL AND http_referer IN ('https://www.gsearch.com', 'https://www.bsearch.com')
               THEN 'organic_search'
           WHEN utm_campaign = 'nonbrand' THEN 'paid nonbrand'
           WHEN utm_campaign = 'brand' THEN 'paid brand'
           WHEN utm_source IS NULL AND http_referer IS NULL THEN 'direct_type_in'
           WHEN utm_source = 'socialbook' THEN 'paid social'
           END                                                    AS channel_group,
       COUNT(IF(is_repeat_session = 0, website_session_id, NULL)) AS new_sessions,
       COUNT(IF(is_repeat_session = 1, website_session_id, NULL)) AS repeat_sessions
FROM website_sessions
WHERE created_at
    < '2014-11-05'
  AND created_at >= '2014-01-01'
GROUP BY 1
ORDER BY 3 DESC;

SELECT is_repeat_session,
       COUNT(DISTINCT website_sessions.website_session_id)                                   AS sessions,
       COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS conv_rate,
       SUM(price_usd) / COUNT(DISTINCT website_sessions.website_session_id)                  AS rev_per_session
FROM website_sessions
         LEFT JOIN orders
                   ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2014-11-08'
  AND website_sessions.created_at >= '2014-01-01'
GROUP BY 1;

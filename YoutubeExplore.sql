-- Count the total number of rows in the 'youtubers' table
SELECT COUNT(*) AS total_channels FROM youtubers;

-- Check for null values in the 'views' column
SELECT COUNT(*) AS missing_views FROM youtubers WHERE views IS NULL;

-- List unique join dates from the joined column 
SELECT DISTINCT joined FROM youtubers;

-- Basic statistics for the views 
SELECT MIN(views) AS min_views,
       MAX(views) AS max_views,
       AVG(views) AS average_views,
       SUM(views) AS total_views
FROM youtubers;

-- Counting which categories are most popular
SELECT category, COUNT(*) AS num_channels FROM youtubers GROUP BY category ORDER BY num_channels DESC;

-- Which language is most common among the top 50 channels?
SELECT primary_language, COUNT(*) AS num_channels FROM youtubers GROUP BY primary_language ORDER BY num_channels DESC;

-- Average amount of subscribers and views per country
SELECT country, AVG(subscribers) AS avg_subscribers, AVG(views) AS avg_views FROM youtubers GROUP BY country;

-- Comparing brand channels vs non-brand channels in terms of video count and views
SELECT brand_channel, AVG(videos) AS avg_videos, SUM(views) AS total_views FROM youtubers GROUP BY brand_channel;

-- What are the top channels in each category based on lifetime views?
SELECT y.category, y.name, y.views AS max_views
FROM youtubers y
INNER JOIN (
    SELECT category, MAX(views) AS max_views
    FROM youtubers
    GROUP BY category
) mv ON y.category = mv.category AND y.views = mv.max_views
ORDER BY y.views DESC;

-- What is the impact of languaage and category of channels on subscribers and viewer counts?
SELECT 
  primary_language, 
  category, 
  AVG(subscribers) AS avg_subscribers, 
  SUM(views) AS total_views,
  RANK() OVER (PARTITION BY primary_language ORDER BY AVG(subscribers) DESC) AS lang_subscriber_rank,
  RANK() OVER (PARTITION BY category ORDER BY SUM(views) DESC) AS cat_view_rank
FROM youtubers
GROUP BY primary_language, category;










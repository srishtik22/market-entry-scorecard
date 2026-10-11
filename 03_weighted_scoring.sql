WITH normalized AS (
    SELECT
        country_code,
        metric_name,
        metric_group,
        CASE
            WHEN direction = 'benefit' THEN
                (value - MIN(value) OVER (PARTITION BY metric_name))
                / (MAX(value) OVER (PARTITION BY metric_name) - MIN(value) OVER (PARTITION BY metric_name))
                * 100
            WHEN direction = 'cost' THEN
                (MAX(value) OVER (PARTITION BY metric_name) - value)
                / (MAX(value) OVER (PARTITION BY metric_name) - MIN(value) OVER (PARTITION BY metric_name))
                * 100
        END AS normalized_score
    FROM raw_metrics
),
weighted AS (
    SELECT
        country_code,
        metric_group,
        normalized_score,
        CASE metric_group
            WHEN 'attractiveness' THEN 0.30 / 3
            WHEN 'ease_of_entry' THEN 0.25 / 2
            WHEN 'competition' THEN 0.15 / 1
            WHEN 'risk' THEN 0.20 / 3
            WHEN 'india_link' THEN 0.10 / 3
        END AS metric_weight
    FROM normalized
)
SELECT
    country_code,
    SUM(normalized_score * metric_weight) AS final_score
FROM weighted
GROUP BY country_code
ORDER BY final_score DESC;
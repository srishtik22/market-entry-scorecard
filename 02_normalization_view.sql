CREATE VIEW normalized_scores AS
SELECT
    r.country_code,
    c.country_name,
    c.region,
    r.metric_name,
    r.metric_group,
    r.value AS raw_value,
    r.direction,
    CASE
        WHEN r.direction = 'benefit' THEN
            (r.value - MIN(r.value) OVER (PARTITION BY r.metric_name))
            / (MAX(r.value) OVER (PARTITION BY r.metric_name) - MIN(r.value) OVER (PARTITION BY r.metric_name))
            * 100
        WHEN r.direction = 'cost' THEN
            (MAX(r.value) OVER (PARTITION BY r.metric_name) - r.value)
            / (MAX(r.value) OVER (PARTITION BY r.metric_name) - MIN(r.value) OVER (PARTITION BY r.metric_name))
            * 100
    END AS normalized_score
FROM raw_metrics r
JOIN countries c ON r.country_code = c.country_code;
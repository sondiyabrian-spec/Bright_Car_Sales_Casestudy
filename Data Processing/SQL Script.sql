WITH base_data AS (
  SELECT
  manufacturingyear,
  odometer,
    state,
    vin,
    make,
    model,
    sale_date,

    -- Time dimensions
    YEAR(TRY_TO_DATE(sale_date, 'dd MMMM yyyy'))     AS sale_year,
    QUARTER(TRY_TO_DATE(sale_date, 'dd MMMM yyyy'))  AS sale_quarter,
    MONTH(TRY_TO_DATE(sale_date, 'dd MMMM yyyy'))    AS sale_month,

    -- Convert formatted selling price to numeric
    TRY_CAST(
      REGEXP_REPLACE(sellingprice_formatted, '[$,R]', '')
      AS DOUBLE
    ) AS sellingprice_numeric,

    mmr
  FROM workspace.default.car_sales_data
  WHERE mmr > 0),

aggregated_data AS (
  SELECT
    sale_year,
    sale_quarter,
    sale_month,
    state,
    manufacturingyear,
     odometer,
    make,
    model,

    COUNT(DISTINCT vin)        AS units_sold,
    SUM(sellingprice_numeric) AS total_revenue,
    AVG(sellingprice_numeric) AS avg_sellingprice,  
    SUM(mmr)                  AS total_mmr

  FROM base_data
  WHERE sellingprice_numeric > 0
  GROUP BY
    sale_year,
    sale_quarter,
    sale_month,
    state,
    manufacturingyear,
     odometer,
    make,
    model)

SELECT
  sale_year,
  sale_quarter,
  sale_month,
  state,
  manufacturingyear,
   odometer,
  make,
  model,
  units_sold,
  total_revenue,
  avg_sellingprice,

  -- Profit margin %
  ROUND(
    (total_revenue - total_mmr) / total_revenue * 100,
    2) AS profit_margin_pct,

  -- Performance tier
  CASE
    WHEN (total_revenue - total_mmr) / total_revenue >= 0.20 THEN 'High Margin'
    WHEN (total_revenue - total_mmr) / total_revenue >= 0.10 THEN 'Medium Margin'
    ELSE 'Low Margin'
  END AS performance_tier

FROM aggregated_data
ORDER BY sale_year, sale_month, total_revenue DESC;

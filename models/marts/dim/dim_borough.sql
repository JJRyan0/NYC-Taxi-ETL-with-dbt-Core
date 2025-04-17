SELECT DISTINCT pickup_borough AS borough FROM {{ ref('stg_nyc_taxi_trips') }}
UNION
SELECT DISTINCT dropoff_borough FROM {{ ref('stg_nyc_taxi_trips') }}

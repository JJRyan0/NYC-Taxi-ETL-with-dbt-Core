SELECT
    pickup_borough,
    dropoff_borough,
    COUNT(*) AS total_trips,
    ROUND(AVG(fare_amount), 2) AS avg_fare,
    ROUND(AVG(trip_duration_min), 2) AS avg_trip_duration
FROM {{ ref('stg_nyc_taxi_trips') }}
GROUP BY pickup_borough, dropoff_borough;
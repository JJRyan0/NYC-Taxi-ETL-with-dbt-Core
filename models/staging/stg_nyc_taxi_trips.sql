WITH base AS (
    SELECT *
    FROM {{ source('nyc_taxi_raw', 'raw_nyc_taxi_trips') }}
)
SELECT
    trip_id,
    pickup_datetime,
    dropoff_datetime,
    pickup_borough,
    dropoff_borough,
    fare_amount,
    passenger_count,
    payment_type,
    EXTRACT(EPOCH FROM (dropoff_datetime - pickup_datetime)) / 60 AS trip_duration_min
FROM base;
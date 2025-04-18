# NYC Taxi ETL with dbt Core

This is a sample dbt project for transforming NYC Taxi trip data using PostgreSQL.

<img width="430" alt="image" src="https://github.com/user-attachments/assets/35f5097e-4cbe-44af-a9bb-58b8f2662d85" />



## Database and dbt project set up

__1. Create Raw Schema in postgres CLI__

- Connect to the database.

```
bash

~ % psql -h localhost -U postgres -d nyc_taxi
```

- Create the new raw schema called nyc_taxi_raw

```
pgsql

nyc_taxi=#

create schema if not exists nyc_taxi_raw;

CREATE SCHEMA
```
- List schemas created:

```
pgsql

nyc_taxi=# 
\dn

     List of schemas
     Name     |  Owner   
--------------+----------
 nyc_taxi_raw | postgres
 public       | postgres
(2 rows)
```
- Create schema called nyc_taxi

```
pgsql

create schema nyc_taxi;

CREATE SCHEMA
```
- List schemas created:
  
```
pgsql

\dn
     List of schemas
     Name     |  Owner   
--------------+----------
 nyc_taxi     | postgres
 nyc_taxi_raw | postgres
 public       | postgres
(3 rows)

```

__2. Run new table DDLs & insert data__

- Create raw table for storing raw nyc data
  
```
pgsql

CREATE TABLE nyc_taxi_raw.raw_nyc_taxi_trips (
    trip_id SERIAL PRIMARY KEY,
    pickup_datetime TIMESTAMP,
    dropoff_datetime TIMESTAMP,
    pickup_borough TEXT,
    dropoff_borough TEXT,
    fare_amount NUMERIC,
    passenger_count INTEGER,
    payment_type TEXT
);
```

- Insert raw date to table:

```
pgsql

INSERT INTO nyc_taxi_raw.raw_nyc_taxi_trips
(pickup_datetime, dropoff_datetime, pickup_borough, dropoff_borough, fare_amount, passenger_count, payment_type)
VALUES 
('2023-01-01 08:00:00', '2023-01-01 08:25:00', 'Manhattan', 'Brooklyn', 23.5, 1, 'Credit'),
('2023-01-01 09:00:00', '2023-01-01 09:10:00', 'Queens', 'Manhattan', 17.2, 2, 'Cash'),
('2023-01-01 10:00:00', '2023-01-01 10:30:00', 'Brooklyn', 'Bronx', 29.7, 1, 'Credit');
INSERT 0 3
```


__3. Set up dbt project using bash__

- Create your models folder structure:
```
bash

(.ven)  nyc_taxi_dbt % mkdir -p models/staging
(.ven)  nyc_taxi_dbt % mkdir -p models/marts/dim
(.ven)  nyc_taxi_dbt % mkdir -p models/marts/facts

(.ven) % cd /Users/nyc_taxi_dbt
(.ven) nyc_taxi_dbt % cp /Users/Downloads/nyc_taxi_dbt_project/dbt_project.yml .

(.ven)  nyc_taxi_dbt % cd models/staging
(.ven)  staging % cp /Users/Downloads/nyc_taxi_dbt_project/models/staging/stg_nyc_taxi_trips.sql .

(.ven)  staging % cd /Users/nyc_taxi_dbt
(.ven)  nyc_taxi_dbt % cd models/marts/dim
(.ven)  dim % cp /Users/Downloads/nyc_taxi_dbt_project/models/marts/dim/dim_borough.sql .


(.ven) nyc_taxi_dbt % cd models/marts/facts
(.ven) facts % cp /Users/Downloads/nyc_taxi_dbt_project/models/marts/fact/fact_trip_summary.sql .
(.ven) facts % cp /Users/Downloads/nyc_taxi_dbt_project/models/schema.yml .

nyc_taxi_dbt/
├── models/
│   ├── staging/
│   │   └── stg_nyc_taxi_trips.sql
│   ├── marts/
│   │   ├── dim/
│   │   │   └── dim_borough.sql
│   │   └── fact/
│   │       └── fact_trip_summary.sql
│   └── schema.yml

```


__4.  Run and build the models in DBT__

- Run dbt models:

```
bash

dbt test

```

```
bash
nyc_taxi_dbt % dbt run

```

<img width="845" alt="image" src="https://github.com/user-attachments/assets/b9ff44b0-153d-4df6-ae47-2728d3c22f00" />


__5. Document the Models__

- Generate catalog for documentation

```
bash

nyc_taxi_dbt % dbt docs generate

```


- Generate documentation server

```
bash

 nyc_taxi_dbt % dbt docs serve

```

<img width="1412" alt="image" src="https://github.com/user-attachments/assets/fc88388d-280f-4a7c-b392-8ab25c76d59d" />



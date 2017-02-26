-- Run this sql script from the folder containing GTFS files


TRUNCATE TABLE agency;
TRUNCATE TABLE calendar;
TRUNCATE TABLE calendar_dates;
TRUNCATE TABLE fare_attributes;
TRUNCATE TABLE fare_rules;
TRUNCATE TABLE feed_info;
TRUNCATE TABLE frequencies;
TRUNCATE TABLE routes;
TRUNCATE TABLE shapes;
TRUNCATE TABLE stops;
TRUNCATE TABLE stop_times;
TRUNCATE TABLE transfers;
TRUNCATE TABLE trips;

SET @transit = "JUST_IMPORTED";

LOAD DATA LOCAL INFILE 'agency.txt' INTO TABLE agency
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (agency_id, agency_name, agency_url, agency_timezone, agency_lang, agency_phone, agency_fare_url, agency_email)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'calendar.txt' INTO TABLE calendar
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (service_id, monday, tuesday, wednesday, thursday, friday, saturday, sunday, start_date, end_date)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'calendar_dates.txt' INTO TABLE calendar_dates
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (service_id, `date`, exception_type)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'fare_attributes.txt' INTO TABLE fare_attributes
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (fare_id, price, currency_type, payment_method, transfers, transfer_duration)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'fare_rules.txt' INTO TABLE fare_rules
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (fare_id, route_id, origin_id, destination_id, contains_id)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'feed_info.txt' INTO TABLE feed_info
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (feed_publisher_name, feed_publisher_url, feed_lang, feed_start_date, feed_end_date, feed_version)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'frequencies.txt' INTO TABLE frequencies
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (trip_id, start_time, end_time, headway_secs, exact_times)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'routes.txt' INTO TABLE routes
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (route_id, agency_id, route_short_name, route_long_name, route_desc, route_type, route_url, route_color, route_text_color)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'shapes.txt' INTO TABLE shapes
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (shape_id, shape_pt_lat, shape_pt_lon, shape_pt_sequence, shape_dist_traveled)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'stops.txt' INTO TABLE stops
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (stop_id, stop_code, stop_name, stop_desc, stop_lat, stop_lon, zone_id, stop_url, location_type, parent_station, stop_timezone, wheelchair_boarding)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'stop_times.txt' INTO TABLE stop_times
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (trip_id, arrival_time, departure_time, stop_id, stop_sequence, stop_headsign, pickup_type, drop_off_type, shape_dist_traveled, timepoint)
    SET transit_system = @transit,
    arrival_time_seconds = TIME_TO_SEC(arrival_time),
    departure_time_seconds = TIME_TO_SEC(departure_time);

LOAD DATA LOCAL INFILE 'transfers.txt' INTO TABLE transfers
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (from_stop_id, to_stop_id, transfer_type, min_transfer_time)
    SET transit_system = @transit;

LOAD DATA LOCAL INFILE 'trips.txt' INTO TABLE trips
    FIELDS TERMINATED BY ',' IGNORE 1 LINES
    (route_id, service_id, trip_id, trip_headsign, trip_short_name, direction_id, block_id, shape_id, wheelchair_accessible, bikes_allowed)
    SET transit_system = @transit;


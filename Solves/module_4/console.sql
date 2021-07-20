-- 1
select city, count(city)
from dst_project.airports
group by 1
order by 2 desc
limit 3;

-- 4.2.1

select count(distinct status)
from dst_project.flights;

-- 4.2.2

select count(status)
from dst_project.flights
where status = 'Departed';

-- 4.2.3

select count(distinct seat_no)
from dst_project.seats
where aircraft_code = '773';

-- 4.2.4

select count(flight_id)
from dst_project.flights f
where (f.actual_arrival between '2017-04-01' and '2017-09-01')
  and (f.status = 'Arrived');


-- 4.3.1

select count(flight_id)
from dst_project.flights f
where f.status = 'Cancelled';

-- 4.3.2

select sum((model LIKE 'Boeing%')::int)
           Boeings,
       sum((model LIKE 'Sukhoi%')::int)
           Sukhoi,
       sum((model LIKE 'Airbus%')::int)
           Airbuses
from dst_project.aircrafts;

-- 4.3.3

select timezone, count(airport_code)
from dst_project.airports
group by timezone
order by 2 desc;

-- 4.3.4

select flight_id
from dst_project.flights
where actual_arrival is not null
order by actual_arrival - scheduled_arrival desc
limit 1;

-- 4.4.1

select min(scheduled_departure)
from dst_project.flights;

-- 4.4.2

select date_part('hour', scheduled_arrival - scheduled_departure) * 60 +
       date_part('minute', scheduled_arrival - scheduled_departure)
from dst_project.flights
order by scheduled_arrival - scheduled_departure desc
limit 1;


-- 4.4.3

select departure_airport, arrival_airport
from dst_project.flights
order by scheduled_arrival - scheduled_departure desc
limit 1;

-- 4.4.4

select avg(date_part('hour', scheduled_arrival - scheduled_departure) * 60 +
           date_part('minute', scheduled_arrival - scheduled_departure))
from dst_project.flights;


-- 4.5.1

select fare_conditions, count(1)
from dst_project.seats
where aircraft_code = 'SU9'
group by fare_conditions
order by 2 desc;

-- 4.5.2

select min(total_amount)
from dst_project.bookings;

-- 4.5.3

select seat_no
from dst_project.boarding_passes b
         join dst_project.tickets t on b.ticket_no = t.ticket_no
where t.passenger_id = '4313 788533';


-- 5.1.1

select count(*)
from dst_project.flights
where (arrival_airport = 'AAQ')
  and (status = 'Arrived')
  and (date_part('year', actual_arrival) = 2017);

-- 5.1.2

select count(1)
from dst_project.flights
where (departure_airport = 'AAQ')
  and (date_part('year', actual_departure) = 2017)
  and (date_part('month', actual_departure) in (12, 1, 2));

-- 5.1.3

select count(1)
from dst_project.flights
where (departure_airport = 'AAQ')
  and (status = 'Cancelled');

-- 5.1.4

select count(distinct flight_id)
from dst_project.flights
where (departure_airport = 'AAQ')
  and (arrival_airport not in ('DME', 'SVO', 'VKO'));

-- 5.1.5

select a.model, count(distinct s.seat_no)
from dst_project.flights f
         join dst_project.aircrafts a on a.aircraft_code = f.aircraft_code
         join dst_project.seats s on a.aircraft_code = s.aircraft_code
where (departure_airport = 'AAQ')
group by a.model
order by 2 desc;


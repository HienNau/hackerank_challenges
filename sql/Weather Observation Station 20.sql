--A median is defined as a number separating the higher half of a data set from the lower half. 
--Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to  decimal places.
--Input Format

--The STATION table is described as follows:

--Station.jpg

--where LAT_N is the northern latitude and LONG_W is the western longitude.

--Code:

with tmp as(
select LAT_N, row_number() over(order by LAT_N) rn, 
     count(*) over() _total
    from station 
)
select cast(tmp.LAT_N as decimal(10,4))  --,_total, ceiling( tmp._total/2)
from tmp 
where rn=   ceiling(cast(tmp._total as float)/2); 
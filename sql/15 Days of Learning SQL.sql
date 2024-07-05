--Julia conducted a  days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.
--Write a query to print total number of unique hackers who made at least  submission each day (starting on the first day of the contest), 
--and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has 
--a maximum number of submissions, print the lowest hacker_id. 
--The query should print this information for each day of the contest, sorted by the date.
with temp_data as
(select cast(S.submission_date as date) as 'submission_date', count(S.submission_id) as 'no_of_submission',  S.hacker_id , H.name, 
row_number() over (partition by submission_date order by count(S.submission_id) desc, S.hacker_id) as rank_num
from Submissions S join Hackers  H on S.hacker_id = H.hacker_id 
group by S.submission_date, S.hacker_id, H.name),
	cte1 as
(select submission_date, hacker_id, name from temp_data where rank_num = 1),
	recursive_cte as 
(select submission_date,  no_of_submission, hacker_id, name from temp_data  where submission_date = '2016-03-01'
union all
 select  td.submission_date,  td.no_of_submission, rc.hacker_id, rc.name from temp_data td join recursive_cte  rc on td.hacker_id = rc.hacker_id 
 where td.submission_date = dateadd(day,1,rc.submission_date)),
	cte2 as
(select submission_date, count(no_of_submission) as 'no_of_submission' from recursive_cte group by submission_date)
select cte1.submission_date,  cte2.no_of_submission, cte1.hacker_id, cte1.name from cte1 join cte2 on cte1.submission_date = cte2.submission_date
order by submission_date
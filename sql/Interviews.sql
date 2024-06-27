--Samantha interviews many candidates from different colleges using coding challenges and contests. 
--Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, 
--total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. 
--Exclude the contest from the result if all four sums are .
--Note: A specific contest can be used to screen candidates at more than one college, but each college only holds  screening contest.

--Code:
with T as
(select Con.contest_id,  Con.hacker_id, Con.name, C.challenge_id, S.Sum_total_submissions, S.Sum_total_accepted_submissions,
 V.Sum_total_views, V.Sum_total_unique_views
 from Contests Con left join
 Colleges Col on Con.contest_id = Col.contest_id 
left join Challenges C on Col.college_id  = C.college_id 
left join (select challenge_id, sum(total_views) as Sum_total_views,
            sum(total_unique_views) as Sum_total_unique_views 
            from View_Stats group by challenge_id) V
            on C.challenge_id  = V.challenge_id
left join (select challenge_id,  sum(total_submissions) as Sum_total_submissions, 
            sum(total_accepted_submissions) as Sum_total_accepted_submissions 
            from Submission_Stats group by challenge_id) S 
            on C.challenge_id  = S.challenge_id)
select T.contest_id, T.hacker_id, T.name, sum(T.Sum_total_submissions), sum(T.Sum_total_accepted_submissions), sum(T.Sum_total_views), sum(T.Sum_total_unique_views)
from T group by T.contest_id, T.hacker_id, T.name
having sum(T.Sum_total_submissions) > 0 and sum(T.Sum_total_accepted_submissions) > 0 and sum(T.Sum_total_views) >0 and sum(T.Sum_total_unique_views) >0
order by T.contest_id;
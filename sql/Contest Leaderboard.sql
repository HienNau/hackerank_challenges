--You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
--The total score of a hacker is the sum of their maximum scores for all of the challenges. 
--Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
--If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
--Exclude all hackers with a total score of  from your result.

--Code:
with T as
(select S.hacker_id as ID, H.name as Ten, S.challenge_id as C_ID, S.score as Diem_so, row_number()
over(partition by S.hacker_id, S.challenge_id order by S.score  DESC) as Rank
 from Hackers H inner join Submissions S on H.hacker_id = S.hacker_id)
select T.ID, T.Ten, sum(T.Diem_So) as Total from T 
where Rank = 1  group by T.ID, T.Ten having sum(T.Diem_So) >0 
order by sum(T.Diem_So) desc, T.ID ASC;
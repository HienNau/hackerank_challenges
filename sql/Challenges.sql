--Julia asked her students to create some coding challenges. 
--Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
--Sort your results by the total number of challenges in descending order. 
--If more than one student created the same number of challenges, then sort the result by hacker_id. 
--If more than one student created the same number of challenges and the count is less than 
--the maximum number of challenges created, then exclude those students from the result.

--Input Format

--The following tables contain challenge data:

--Hackers: The hacker_id is the id of the hacker, and name is the name of the hacker. 

--Challenges: The challenge_id is the id of the challenge, and hacker_id is the id of the student who created the challenge.

--Code:
with T as
(select C.hacker_id as ID, H.name as Ten, count(C.challenge_id) as Total, count(count(C.challenge_id)) over(partition by count(C.challenge_id) order by count(C.challenge_id)) as M_o_d
from Hackers H inner join Challenges C on H.hacker_id = C.hacker_id group by C.hacker_id, H.name)
select T.ID, T.Ten, T.Total
from T
where (M_o_d >1 and T.Total = (Select max(T.Total) from T)) or M_o_d =1
order by T.Total desc, T.ID;
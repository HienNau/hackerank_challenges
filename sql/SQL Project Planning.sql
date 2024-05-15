--You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference 
--between the End_Date and the Start_Date is equal to 1 day for each row in the table.
--If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total 
--number of different projects completed.
--Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending 
--order. If there is more than one project that have the same number of completion days, then order by the start date of the project.

-- Code:
with T1 as
(select *, case when
lag(End_Date,1) over(order by End_Date) = Start_Date  
 then  0
 else 1
 end
 as Pre_day
 from Projects),
 T2 as
 (select *,  sum(Pre_day) over(order by End_Date) as Gap
 from T1),
 T3 as
 (select min(Start_Date) as _Start, max(End_Date) as _End from T2 group by Gap)
 select _Start, _End from T3
 order by datediff(day,_Start, _End), _Start;

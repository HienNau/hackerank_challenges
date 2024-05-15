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

--You are given a table, Functions, containing two columns: X and Y.

--Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

--Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

--Code:
with T as (select X, Y,  count(* ) over(partition by X) as No_pair from Functions where X = Y)
select distinct X, Y from T where No_pair = 2
union
SELECT DISTINCT F1.X, F1.Y
FROM Functions F1
JOIN Functions  F2 ON F1.X = F2.Y AND F1.Y = F2.X AND F1.X < F1.Y
order by X;

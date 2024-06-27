--You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. 
--Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). 
--Packages contains two columns: ID and Salary (offered salary in $ thousands per month).

--Code:
with T as
(select S.ID, S.Name as Ten, P1.Salary as F_Salary, F.Friend_ID, P2.Salary as  My_Salary
 from Students S left join Friends F on S.ID = F.ID 
 left join Packages P1 on F.Friend_ID = P1.ID inner join Packages P2 on  S.ID = P2.ID)
select T.Ten from T where My_Salary < F_Salary order by F_Salary; 
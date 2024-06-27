--Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
--Hermione decides the best way to choose is by determining the minimum number of gold galleons needed 
--to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, 
--and power of the wands that Ron's interested in, sorted in order of descending power. 
--If more than one wand has same power, sort the result in order of descending age.
--Input Format
--The following tables contain data on the wands in Ollivander's inventory:
--Wands: The id is the id of the wand, code is the code of the wand, coins_needed is the total number of gold galleons needed 
--to buy the wand, and power denotes the quality of the wand (the higher the power, the better the wand is). 
--Wands_Property: The code is the code of the wand, age is the age of the wand, 
--and is_evil denotes whether the wand is good for the dark arts. If the value of is_evil is 0, it means that the wand is not evil. 
--The mapping between code and age is one-one, meaning that if there are two pairs,  and , then  and .

--Code:
with T as
(select W.ID, W.code, W.coins_needed, W.power, WP.age, WP.is_evil,
 row_number() over(partition by W.code, W.power  order by WP.age desc, W.coins_needed) as r_num
 from Wands W
left join Wands_Property WP
on W.code = WP.code where WP.is_evil = 0)
select id, age, coins_needed, power from T 
where r_num = 1
order by power desc, age desc;

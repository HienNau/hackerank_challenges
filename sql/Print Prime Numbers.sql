--Write a query to print all prime numbers less than or equal to . 
--Print your result on a single line, and use the ampersand () character as your separator (instead of a space).
--For example, the output for all prime numbers <=10 would be: 2&3&5&7.

--Code:
Declare @num int = 2;
Declare @k int;
Declare @Bool varchar(10);
Declare @list Table (KQ int);
while @num < =1000
    begin
    set @k  = @num - 1
    set @Bool= N'True'
            while  @k>1
            begin
            if @num % @k = 0
                begin
                set @Bool = N'False'
                break
            end
            set @k -=1
        end
        if @Bool = N'True'
            begin 
            Insert @list values(@num)
        end
    set @num += 1
end;
select STRING_AGG(KQ, '&') from @list;
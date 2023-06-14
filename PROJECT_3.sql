use project_3;

 SET SQL_SAFE_UPDATES = 0;
 
update main set Datekey_Opening = replace(Datekey_Opening, '_', '/') where Datekey_Opening like '%_%';
alter table main modify column Datekey_Opening date;
select*from main;

select year(Datekey_Opening) years,
month(Datekey_Opening)  months,
day(Datekey_Opening) day ,
monthname(Datekey_Opening) monthname,
Quarter(Datekey_Opening)as quarter,
concat(year(Datekey_Opening),'-',monthname(Datekey_Opening)) yearmonth, 
weekday(Datekey_Opening) weekday,
dayname(Datekey_Opening)dayname ,

case when monthname(Datekey_Opening) = 'April' then 'FM1'
when monthname(Datekey_Opening) = 'May' then 'FM2'
when monthname(Datekey_Opening) = 'June' then 'FM3'
when monthname(Datekey_Opening) = 'July' then 'FM4'
when monthname(Datekey_Opening) = 'August' then 'FM5'
when monthname(Datekey_Opening) = 'September' then 'FM6'
when monthname(Datekey_Opening) = 'October' then 'FM7'
when monthname(Datekey_Opening) = 'November' then 'FM8'
when monthname(Datekey_Opening) = 'December' then 'FM9'
when monthname(Datekey_Opening) = 'January' then 'FM10'
when monthname(Datekey_Opening) = 'February' then 'FM11'
when monthname(Datekey_Opening) = 'March' then 'FM12'
end Financial_months,

case when monthname(Datekey_Opening) in ('January' , 'February' , 'March') then 'Q4'
when monthname(Datekey_Opening) in ('April' , 'May' , 'June') then 'Q1'
when monthname(Datekey_Opening) in ('July' , 'August' , 'September') then 'Q2'
else 'Q3' 
end as financial_quarters
from main;

select country.Countryname,main.City,count(RestaurantID) no_of_restaurants
from main inner join country
on main.CountryCode = country.CountryID
group by country.Countryname,main.City;

select year(Datekey_Opening)year,quarter(Datekey_Opening)quarter,monthname(Datekey_Opening)monthname,count(RestaurantID)as no_of_restaurants 
from main group by year(Datekey_Opening),quarter(Datekey_Opening),monthname(Datekey_Opening) 
order by year(Datekey_Opening),quarter(Datekey_Opening),monthname(Datekey_Opening);

select case when Rating <=2 then "0-2" when Rating <=3 then "2-3" when Rating <=4 then "3-4" when Rating<=5 then "4-5" end Rating_range,count(RestaurantID) 
from main
group by rating_range 
order by rating_range;

select case when Price_range=1 then "0-500" when Price_range=2 then "500-3000" when Price_range=3 then "3000-10000" when Price_range=4 then ">10000" 
end Price_range,count(RestaurantID)
from main
group by price_range
order by Price_range;

select Has_Online_delivery,concat(round(count(Has_Online_delivery)/100,1),"%") percentage 
from main
group by has_online_delivery;

select Has_Table_booking,concat(round(count(Has_Table_booking)/100,1),"%") percentage from main group by Has_Table_booking;
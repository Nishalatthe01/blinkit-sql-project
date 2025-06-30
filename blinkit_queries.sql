select * from blinkit_data

select count(*) from blinkit_data

1] To clear insights in perticular format 
update blinkit_data
set Item_Fat_Content = 
case
when Item_Fat_Content IN ('LF','low fat') THEN 'Low Fat'
when Item_Fat_Content = 'reg' THEN 'Regular'
else Item_Fat_Content 
end

select cast (sum(Total_Sales)/1000000 AS decimal(10,2)) Total_Sales_Millions
from blinkit_data


select cast(AVG(Total_Sales) as decimal(10,0)) Avg_Sales from blinkit_data

select count(*) as No_Of_Items from blinkit_data

select cast(avg(rating) as decimal(10,2)) as avg_rating from blinkit_data


1]TOTAL SALES BY FAT CONTENT


select Item_Fat_Content, cast( CAST(SUM(Total_Sales) as decimal(10,2)) as varchar) + 'k' as Total_Sales ,
 cast(AVG(Total_Sales) as decimal(10,0)) Avg_Sales ,
 count(*) as No_Of_Items,cast(avg(rating) as decimal(10,2)) as avg_rating
from blinkit_data 
group by Item_Fat_Content 
order by total_Sales desc 

2]Total Sales By Item Type

select top 5 Item_Type, CAST(SUM(Total_Sales) as decimal(10,2)) as Total_Sales ,
 cast(AVG(Total_Sales) as decimal(10,1)) Avg_Sales ,
 count(*) as No_Of_Items,cast(avg(rating) as decimal(10,2)) as avg_rating
from blinkit_data 
group by Item_Type
order by total_Sales desc 


3] Fat Content By Outlet for Total Sales

SELECT Outlet_Location_Type, 
       ISNULL([Low Fat], 0) AS Low_Fat, 
       ISNULL([Regular], 0) AS Regular
FROM 
(
    SELECT Outlet_Location_Type, Item_Fat_Content, 
           CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit_data
    GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS SourceTable
PIVOT 
(
    SUM(Total_Sales) 
    FOR Item_Fat_Content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY Outlet_Location_Type;


4] outlet_Establishment_Year by total_sales

SELECT Outlet_Establishment_Year, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC

5] Percentage of sales by outlet size 

SELECT 
    Outlet_Size, 
    CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

6] Sales by Outlet Location

SELECT Outlet_Location_Type, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales
FROM blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC

7] All Metrics by Outlet Type

SELECT Outlet_Type, 
CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales,
		CAST(AVG(Total_Sales) AS DECIMAL(10,0)) AS Avg_Sales,
		COUNT(*) AS No_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avg_Rating,
		CAST(AVG(Item_Visibility) AS DECIMAL(10,2)) AS Item_Visibility
FROM blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC


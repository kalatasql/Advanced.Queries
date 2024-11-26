SELECT 
		RANK() OVER (ORDER BY COUNT(*) DESC) AS [Rank Counter], -- Get counted rows from the bigger to smaller data and show ranks (1,2,3.....1000)
		COUNT(*) AS [Total Sales], -- Counting sales for each date
    SUM(Product_Price) AS [Total Earnings], -- Sum Total Earnings for each date
		LOADDT
FROM Sales
WHERE LOADDT >= '2024-01-01' -- Get all dates after January 1, 2024 year
GROUP BY LOADDT -- Grouping rows by load date
ORDER BY [RANK COUNTER] -- Show rank orders from 1 to max

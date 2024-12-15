
-- Show average, total amount and total orders for each customer
SELECT * -- Select all columns from the Customers table and the virtual table
FROM Customers o -- From the Customers table
OUTER APPLY ( -- Use OUTER APPLY to join with a virtual table
                SELECT 
                    AVG(TotalAmount) AS TOTALAVG, -- Calculate the average order amount for the customer
                    SUM(TotalAmount) AS TOTALSUM, -- Calculate the total order amount for the customer
                    COUNT(*) AS TOTALORDERS -- Count the total number of orders for the customer
                FROM Orders o2 -- From the Orders table
                WHERE o.CustomerID = o2.CustomerID -- Match the current customer by CustomerID
            ) LFD -- Alias for the virtual table (Left Folded Data)
ORDER BY TOTALORDERS ASC -- Sort by total orders in ascending order; customers without orders will appear first (NULL values are sorted first).

-- Show orders with higher amount than average for each Customer :
SELECT *
FROM Orders o
OUTER APPLY (SELECT
					         AVG(TotalAmount) AS TOTALAVG
					         FROM Orders o2
					         WHERE o.CustomerID = o2.CustomerID
			      ) LFD
WHERE o.TotalAmount > LFD.TOTALAVG  

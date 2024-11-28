SELECT COUNT(*),
       [Delivery Date]
FROM
    (SELECT RANK() OVER (ORDER BY [DELIVERY DATE] DESC) AS RNK,
	    [Delivery Date]
     FROM OpenOrders ) TBL
WHERE RNK = 1
group by [delivery date]

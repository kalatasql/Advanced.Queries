Advanced SQL Tasks:

1. Identify the materials with the largest order quantities and their delivery status.
2. Create a report that shows total order quantity, delivered quantity, and pending quantity for each order and vendor.
3. Find the percentage of delivered quantities compared to the total ordered quantities for each order.
4. Update the Delivery Date for an order when the Pending QTY reaches 0.


1. SELECT Material,
       SUM([ORDER QTY]) AS [TOTAL ORDERS FOR MATERIAL], 
       (CASE 
            WHEN MAX([Delivery date]) < GETDATE() 
            THEN 'Delivered'
            ELSE 'Open'
        END) AS [Delivery Status]
  FROM OpenOrders
  GROUP BY Material
  ORDER BY [TOTAL ORDERS FOR MATERIAL] DESC

2. -- 2. Create a report that shows total order quantity, delivered quantity, and pending quantity for each order and vendor.
      My solution: It is not needed to grouping by vendor, because Vendor is same for each PO regardless item number 
      End solution: I will include both solutions.

SELECT
	  PurchasingOrder,
	  Vendor,
	  SUM([ORDER QTY]) AS [TOTAL ORDER QTY],
	  SUM([DELIVERED QTY]) AS [TOTAL DELIVERED QTY],
	  SUM([ORDER QTY] - [DELIVERED QTY]) AS [TOTAL PENDING QTY]
FROM OpenOrders
GROUP BY PurchasingOrder, Vendor
ORDER BY PurchasingOrder

SELECT
	  PurchasingOrder,
    MAX(Vendor), -- If we want to show the vendor for the PO
	  SUM([ORDER QTY]) AS [TOTAL ORDER QTY],
	  SUM([DELIVERED QTY]) AS [TOTAL DELIVERED QTY],
	  SUM([ORDER QTY] - [DELIVERED QTY]) AS [TOTAL PENDING QTY]
FROM OpenOrders
GROUP BY PurchasingOrder
ORDER BY PurchasingOrder

3. SELECT  PurchasingOrder,
		ItemLine,
		[Order QTY],
		[DELIVERED QTY],
	    CONVERT(NVARCHAR(10),
		CONVERT(DECIMAL(5,2), ([DELIVERED QTY] * 1.0) / [Order QTY] * 100)
		) + '%' AS [Delivered Percent from Order QTY]
    FROM OpenOrders

Important! - I will continue tommorow because here is 3:44 AM xD

4. CREATE TRIGGER t_updateDelivDate  
   ON OpenOrders
   AFTER UPDATE   
   AS 
   BEGIN
	IF UPDATE([Pending QTY])
	BEGIN
	      UPDATE OpenOrders 
	      SET [Delivery Date] = GETDATE()
	      FROM OpenOrders o
	      INNER JOIN Inserted I 
	      ON (o.PurchasingOrder + o.ItemLine)
	      = 
	      (I.PurchasingOrder + I.ItemLine)
	      WHERE I.[Pending QTY] = 0;
         END
    END
    GO

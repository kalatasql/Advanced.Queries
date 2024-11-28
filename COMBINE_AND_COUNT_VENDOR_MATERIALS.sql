-- Combine vendor and his materials, count each material for each vendor and show the total count of materials for each vendor
SELECT VENDOR,
		CASE WHEN grouping(Material) = 1 -- If the grouping is over for Material (i.e., this row is an aggregate row for the vendor) 
		THEN 'ALL' -- Show 'ALL' for the summary row of the vendor, aggregating all materials
		ELSE ISNULL(material, 'unknown') -- If Material is NULL, replace with 'unknown' for display purposes
		end as Material, -- Display the material (or 'unknown' for NULL)
		count(*) AS [Material Total Per Vendor With Nulls], -- Count all rows, including NULL values in Material
		count(Material) AS [Material Total Per Vendor] -- Count only rows where Material is not NULL
FROM
Invoices
GROUP BY Vendor, Material with rollup -- Group by Vendor and Material, and include a rollup summary for the vendor

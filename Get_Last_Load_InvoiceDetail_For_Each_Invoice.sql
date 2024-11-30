SELECT 
        *,
	    case 
	    when load_date_from_last = 1 then 'Last Load Date in group in each Invoice group'
	    else 'Smaller date' 
	    end as [desc]
FROM	
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY invoice_ID ORDER BY Loaddt DESC) as load_date_from_last -- Grouping by invoice_ID, then ordering results from the most recent to the earliest Load Date
FROM InvoicesDetails
) TBL

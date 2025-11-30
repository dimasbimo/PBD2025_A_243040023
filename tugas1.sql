USE RetailStoreDB;

-- jawaban 1
SELECT ProductID, SUM (LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
GROUP BY ProductID;

-- jawaban 2
SELECT ProductID, SUM (LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 2
GROUP BY ProductID;

--jawaban 3
SELECT ProductID, SUM (LineTotal) AS TotalUang
FROM Sales.SalesOrderDetail
WHERE OrderQty >= 2
GROUP BY ProductID;

-- jawaban 4
SELECT ProductID, SUM (LineTotal) AS TotalQty
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM (LineTotal) >= 2;

-- jawaban 5 
SELECT ProductID, LineTotal
FROM Sales.SalesOrderDetail
ORDER BY LineTotal DESC;


-- jawaban 6 
SELECT TOP 10 ProductID, LineTotal
FROM Sales.SalesOrderDetail
ORDER BY LineTotal DESC;
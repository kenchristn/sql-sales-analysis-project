-- 1. Total Revenue & Order Behavior
SELECT 
    COUNT(*) AS total_orders,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS avg_order_value
FROM Orders;

-- 2. Revenue per Customer (Customer Value)
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- 3. Produk Terlaris
SELECT 
    p.product_name,
    SUM(od.quantity) AS total_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- 4. Revenue per Product
SELECT 
    p.product_name,
    SUM(od.quantity * od.unit_price) AS revenue
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY revenue DESC;

-- 5. Analisis Kategori
SELECT 
    p.category,
    SUM(od.quantity * od.unit_price) AS total_revenue
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.category;

-- 6. Efek Discount
SELECT 
    p.product_name,
    p.discount,
    SUM(od.quantity) AS total_sold
FROM Products p
JOIN OrderDetails od ON p.product_id = od.product_id
GROUP BY p.product_name, p.discount
ORDER BY p.discount DESC;

-- 7. Support Ticket Analysis - Status distribusi
SELECT 
    status,
    COUNT(*) AS total
FROM SupportTickets
GROUP BY status;

-- 8. Support Ticket Analysis - Customer paling banyak komplain
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    COUNT(st.ticket_id) AS total_tickets
FROM SupportTickets st
JOIN Customers c ON st.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_tickets DESC;

-- 9. Support Ticket Analysis - Employee Workload
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    e.department,
    COUNT(st.ticket_id) AS handled_tickets
FROM SupportTickets st
JOIN Employees e ON st.employee_id = e.employee_id
GROUP BY e.employee_id, employee_name, e.department
ORDER BY handled_tickets DESC;

-- 10. Support Ticket Analysis - Resolution Rate
SELECT 
    e.employee_id,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    COUNT(st.ticket_id) AS total_tickets,
    SUM(CASE WHEN st.status = 'resolved' THEN 1 ELSE 0 END) AS resolved_tickets,
    ROUND(
        SUM(CASE WHEN st.status = 'resolved' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(st.ticket_id), 2
    ) AS resolution_rate_percent
FROM SupportTickets st
JOIN Employees e ON st.employee_id = e.employee_id
GROUP BY e.employee_id, employee_name
ORDER BY resolution_rate_percent DESC;

-- 11. Support Ticket Analysis - Resolution Time
SELECT 
    AVG(TIMESTAMPDIFF(HOUR, created_at, resolved_at)) AS avg_resolution_hours
FROM SupportTickets
WHERE resolved_at IS NOT NULL;
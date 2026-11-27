-- UT5. Comprobación administrativa de la tienda
-- Archivo: estado_tienda.sql

SELECT VERSION() AS version_mysql;
SELECT NOW() AS fecha_comprobacion;

SELECT COUNT(*) AS total_productos
FROM tienda_informatica.productos;

SELECT id_producto, nombre, stock
FROM tienda_informatica.productos
WHERE stock < 10
ORDER BY stock, nombre;

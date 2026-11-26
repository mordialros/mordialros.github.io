-- UT5 · Base de datos de ejemplo para automatización administrativa
-- MySQL 8.0 · Datos ficticios
-- Se puede ejecutar de nuevo sin duplicar los registros iniciales.

CREATE DATABASE IF NOT EXISTS tienda_informatica
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE tienda_informatica;

CREATE TABLE IF NOT EXISTS categorias (
    id_categoria INT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS productos (
    id_producto INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_categoria INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    CONSTRAINT fk_productos_categorias
      FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    CONSTRAINT chk_productos_precio CHECK (precio >= 0),
    CONSTRAINT chk_productos_stock CHECK (stock >= 0)
) ENGINE = InnoDB;

INSERT IGNORE INTO categorias (id_categoria, nombre) VALUES
(1, 'Componentes'),
(2, 'Perifericos'),
(3, 'Redes');

INSERT IGNORE INTO productos (id_producto, nombre, id_categoria, precio, stock) VALUES
(1, 'Memoria RAM 16 GB',       1, 54.90, 18),
(2, 'Disco SSD 1 TB',         1, 79.95, 12),
(3, 'Fuente de alimentacion', 1, 62.50,  7),
(4, 'Teclado USB',            2, 19.90, 25),
(5, 'Raton inalambrico',      2, 14.95, 30),
(6, 'Monitor 24 pulgadas',    2, 129.00, 6),
(7, 'Cable Ethernet 3 m',     3, 5.95, 40),
(8, 'Switch 8 puertos',       3, 32.90,  9),
(9, 'Adaptador Wi-Fi USB',    3, 18.50, 14);

-- Comprobaciones iniciales
SELECT COUNT(*) AS total_categorias FROM categorias;
SELECT COUNT(*) AS total_productos FROM productos;
SELECT p.id_producto, p.nombre, c.nombre AS categoria, p.precio, p.stock
FROM productos AS p
JOIN categorias AS c ON c.id_categoria = p.id_categoria
ORDER BY p.id_producto;

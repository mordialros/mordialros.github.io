-- Consultas de solo lectura. Resultados de referencia tras la carga inicial.
-- Los archivos están en UTF-8: indicamos al servidor cómo interpretar el texto.
SET NAMES utf8mb4;
SELECT VERSION() AS version_mysql, @@hostname AS servidor, @@port AS puerto;
USE centro_civico_asgbd;

-- Deben existir seis tablas.
SHOW TABLES;

-- Características de la base y valores por defecto del servidor.
-- La base usa utf8mb4_unicode_ci; el servidor puede tener otro cotejamiento.
SHOW CREATE DATABASE centro_civico_asgbd;
SELECT @@character_set_server AS juego_servidor, @@collation_server AS cotejamiento_servidor;
SELECT TABLE_NAME, ENGINE, TABLE_COLLATION
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'centro_civico_asgbd' AND TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Restricciones definidas: claves primarias, únicas, foráneas y CHECK.
SELECT TABLE_NAME, CONSTRAINT_NAME, CONSTRAINT_TYPE
FROM information_schema.TABLE_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'centro_civico_asgbd'
ORDER BY TABLE_NAME, CONSTRAINT_TYPE, CONSTRAINT_NAME;

-- Recuentos exactos: 2, 12, 3, 10, 20 y 0.
SELECT 'sede' AS tabla, COUNT(*) AS filas FROM sede
UNION ALL SELECT 'usuario', COUNT(*) FROM usuario
UNION ALL SELECT 'tipo_actividad', COUNT(*) FROM tipo_actividad
UNION ALL SELECT 'actividad', COUNT(*) FROM actividad
UNION ALL SELECT 'inscripcion', COUNT(*) FROM inscripcion
UNION ALL SELECT 'registro_cambio_inscripcion', COUNT(*) FROM registro_cambio_inscripcion;

-- Codificación de los textos: debe mostrar 'Iniciación a la informática',
-- con 27 caracteres y 29 bytes. Otros valores indican un problema de codificación.
SELECT nombre, CHAR_LENGTH(nombre) AS caracteres, LENGTH(nombre) AS bytes
FROM actividad
WHERE id_actividad = 1;

-- Oferta y ocupación. La cancelación no ocupa plaza.
-- El Club de lectura debe tener una plaza libre.
SELECT s.codigo AS sede, a.id_actividad, a.nombre, a.estado, a.plazas_maximas,
       COUNT(CASE WHEN i.estado = 'activa' THEN 1 END) AS inscripciones_activas,
       a.plazas_maximas - COUNT(CASE WHEN i.estado = 'activa' THEN 1 END) AS plazas_libres
FROM actividad AS a
JOIN sede AS s ON s.id_sede = a.id_sede
LEFT JOIN inscripcion AS i ON i.id_actividad = a.id_actividad
GROUP BY s.codigo, a.id_actividad, a.nombre, a.estado, a.plazas_maximas
ORDER BY s.codigo, a.id_actividad;

-- Participación en las dos sedes: el usuario 1 figura en Norte y Sur.
SELECT u.id_usuario, u.nombre, u.apellidos, s.codigo AS sede,
       a.nombre AS actividad, i.estado
FROM usuario AS u
JOIN inscripcion AS i ON i.id_usuario = u.id_usuario
JOIN actividad AS a ON a.id_actividad = i.id_actividad
JOIN sede AS s ON s.id_sede = a.id_sede
WHERE u.id_usuario = 1
ORDER BY s.codigo, a.id_actividad;

-- Comprobaciones del estado inicial: ambas consultas deben devolver cero filas.
SELECT id_usuario, id_actividad, COUNT(*) AS duplicados
FROM inscripcion
GROUP BY id_usuario, id_actividad
HAVING COUNT(*) > 1;

SELECT a.id_actividad, a.plazas_maximas, COUNT(*) AS inscripciones_activas
FROM actividad AS a
JOIN inscripcion AS i ON i.id_actividad = a.id_actividad
WHERE i.estado = 'activa'
GROUP BY a.id_actividad, a.plazas_maximas
HAVING COUNT(*) > a.plazas_maximas;

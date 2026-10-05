-- Consultas de solo lectura. Resultados de referencia tras la carga inicial.
SELECT VERSION() AS version_mysql, @@hostname AS servidor, @@port AS puerto;
USE centro_civico_asgbd;

-- Deben existir seis tablas.
SHOW TABLES;

-- Motores, cotejamientos y definicion de la base.
SHOW CREATE DATABASE centro_civico_asgbd;
SELECT TABLE_NAME, ENGINE, TABLE_COLLATION
FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'centro_civico_asgbd' AND TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

-- Recuentos exactos: 2, 12, 3, 10, 20 y 0.
SELECT 'sede' AS tabla, COUNT(*) AS filas FROM sede
UNION ALL SELECT 'usuario', COUNT(*) FROM usuario
UNION ALL SELECT 'tipo_actividad', COUNT(*) FROM tipo_actividad
UNION ALL SELECT 'actividad', COUNT(*) FROM actividad
UNION ALL SELECT 'inscripcion', COUNT(*) FROM inscripcion
UNION ALL SELECT 'registro_cambio_inscripcion', COUNT(*) FROM registro_cambio_inscripcion;

-- Oferta y ocupacion. La cancelacion no ocupa plaza.
SELECT s.codigo AS sede, a.id_actividad, a.nombre, a.estado, a.plazas_maximas,
       COUNT(CASE WHEN i.estado = 'activa' THEN 1 END) AS inscripciones_activas,
       a.plazas_maximas - COUNT(CASE WHEN i.estado = 'activa' THEN 1 END) AS plazas_libres
FROM actividad AS a
JOIN sede AS s ON s.id_sede = a.id_sede
LEFT JOIN inscripcion AS i ON i.id_actividad = a.id_actividad
GROUP BY s.codigo, a.id_actividad, a.nombre, a.estado, a.plazas_maximas
ORDER BY s.codigo, a.id_actividad;

-- Participacion en las dos sedes: el usuario 1 figura en Norte y Sur.
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

-- Datos ficticios. Ejecutamos una sola vez, después de 01-crear-centro-civico.sql.
-- Lo ejecutamos desde cmd.exe para que se DETENGA ante el primer error (ver LEEME):
--   mysql -u root -p < 02-cargar-datos.sql
-- Con SOURCE en el cliente interactivo, un error NO detiene el script y el
-- COMMIT final confirmaría una carga incompleta.
-- El estado 'abierta' es un dato de la simulación; no depende de la fecha actual.
-- registro_cambio_inscripcion comienza vacía. Se utilizará en UT7.
-- Los archivos están en UTF-8: indicamos al servidor cómo interpretar el texto.
SET NAMES utf8mb4;

USE centro_civico_asgbd;
START TRANSACTION;

INSERT INTO sede (id_sede, codigo, nombre, direccion, telefono, email) VALUES
    (1, 'NORTE', 'La Estación Norte', 'Calle del Andén, 12', '000000001', 'norte@laestacion.example'),
    (2, 'SUR', 'La Estación Sur', 'Avenida de los Talleres, 8', '000000002', 'sur@laestacion.example');

INSERT INTO usuario (id_usuario, nombre, apellidos, email, telefono, fecha_alta) VALUES
    (1, 'Ana', 'Ruiz', 'usuario01@laestacion.example', '000100001', '2026-09-01'),
    (2, 'Luis', 'Martín', 'usuario02@laestacion.example', '000100002', '2026-09-01'),
    (3, 'Marta', 'López', 'usuario03@laestacion.example', '000100003', '2026-09-01'),
    (4, 'Pablo', 'Sanz', 'usuario04@laestacion.example', NULL, '2026-09-01'),
    (5, 'Sara', 'Gil', 'usuario05@laestacion.example', '000100005', '2026-09-01'),
    (6, 'Diego', 'Vega', 'usuario06@laestacion.example', '000100006', '2026-09-01'),
    (7, 'Elena', 'Soto', 'usuario07@laestacion.example', '000100007', '2026-09-01'),
    (8, 'Hugo', 'León', 'usuario08@laestacion.example', NULL, '2026-09-01'),
    (9, 'Lucía', 'Rey', 'usuario09@laestacion.example', '000100009', '2026-09-01'),
    (10, 'Iván', 'Cano', 'usuario10@laestacion.example', '000100010', '2026-09-01'),
    (11, 'Nora', 'Vidal', 'usuario11@laestacion.example', '000100011', '2026-09-01'),
    (12, 'Bruno', 'Ibáñez', 'usuario12@laestacion.example', '000100012', '2026-09-01');

INSERT INTO tipo_actividad (id_tipo, nombre, descripcion) VALUES
    (1, 'Formación', 'Aprendizaje de habilidades y competencias'),
    (2, 'Cultura', 'Actividades de expresión y participación cultural'),
    (3, 'Deporte', 'Actividad física y bienestar');

-- El Club de lectura (5) queda con una sola plaza libre para las pruebas de UT7.
INSERT INTO actividad (id_actividad, nombre, id_tipo, id_sede, fecha_inicio, fecha_fin, plazas_maximas, estado) VALUES
    (1, 'Iniciación a la informática', 1, 1, '2026-10-20', '2026-12-15', 8, 'abierta'),
    (2, 'Taller de fotografía', 2, 1, '2026-10-22', '2026-12-10', 6, 'abierta'),
    (3, 'Gimnasia suave', 3, 1, '2026-10-21', '2026-12-16', 10, 'abierta'),
    (4, 'Trámites digitales', 1, 2, '2026-10-23', '2026-12-11', 8, 'abierta'),
    (5, 'Club de lectura', 2, 2, '2026-10-24', '2026-12-12', 4, 'abierta'),
    (6, 'Movilidad y bienestar', 3, 2, '2026-10-25', '2026-12-13', 10, 'abierta'),
    (7, 'Edición de imágenes', 1, 1, '2027-01-15', '2027-02-26', 8, 'prevista'),
    (8, 'Teatro participativo', 2, 2, '2027-01-16', '2027-02-27', 12, 'prevista'),
    (9, 'Correo electrónico', 1, 1, '2026-09-02', '2026-09-23', 8, 'finalizada'),
    (10, 'Cerámica creativa', 2, 2, '2026-11-03', '2026-12-15', 8, 'cancelada');

-- Las inscripciones activas de la actividad finalizada (9) indican participación.
INSERT INTO inscripcion (id_inscripcion, id_usuario, id_actividad, fecha_inscripcion, estado) VALUES
    (1, 1, 1, '2026-10-01 10:00:00', 'activa'),
    (2, 2, 1, '2026-10-01 10:00:00', 'activa'),
    (3, 3, 1, '2026-10-01 10:00:00', 'activa'),
    (4, 4, 1, '2026-10-01 10:00:00', 'cancelada'),
    (5, 1, 4, '2026-10-01 10:00:00', 'activa'),
    (6, 5, 4, '2026-10-01 10:00:00', 'activa'),
    (7, 6, 4, '2026-10-01 10:00:00', 'activa'),
    (8, 2, 2, '2026-10-01 10:00:00', 'activa'),
    (9, 7, 2, '2026-10-01 10:00:00', 'activa'),
    (10, 8, 2, '2026-10-01 10:00:00', 'cancelada'),
    (11, 3, 5, '2026-10-01 10:00:00', 'activa'),
    (12, 9, 5, '2026-10-01 10:00:00', 'activa'),
    (13, 10, 5, '2026-10-01 10:00:00', 'activa'),
    (14, 4, 3, '2026-10-01 10:00:00', 'activa'),
    (15, 11, 3, '2026-10-01 10:00:00', 'activa'),
    (16, 5, 6, '2026-10-01 10:00:00', 'activa'),
    (17, 12, 6, '2026-10-01 10:00:00', 'activa'),
    (18, 1, 9, '2026-09-01 10:00:00', 'activa'),
    (19, 6, 9, '2026-09-01 10:00:00', 'activa'),
    (20, 7, 9, '2026-09-01 10:00:00', 'activa');

COMMIT;

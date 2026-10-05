-- Datos ficticios. Ejecutamos una sola vez, despues de 01-crear-centro-civico.sql.
-- Si aparece un error, NO continuamos ni ejecutamos COMMIT: ejecutamos ROLLBACK.
-- El estado 'abierta' es un dato de la simulacion; no depende de la fecha actual.
-- REGISTRO_CAMBIO_INSCRIPCION comienza vacia. Se utilizara en UT7.
USE centro_civico_asgbd;
START TRANSACTION;

INSERT INTO sede (id_sede, codigo, nombre, direccion, telefono, email) VALUES
    (1, 'NORTE', 'La Estacion Norte', 'Calle del Anden, 12', '000000001', 'norte@laestacion.example'),
    (2, 'SUR', 'La Estacion Sur', 'Avenida de los Talleres, 8', '000000002', 'sur@laestacion.example');

INSERT INTO usuario (id_usuario, nombre, apellidos, email, fecha_alta) VALUES
    (1, 'Ana', 'Ruiz', 'usuario01@laestacion.example', '2026-09-01'),
    (2, 'Luis', 'Martin', 'usuario02@laestacion.example', '2026-09-01'),
    (3, 'Marta', 'Lopez', 'usuario03@laestacion.example', '2026-09-01'),
    (4, 'Pablo', 'Sanz', 'usuario04@laestacion.example', '2026-09-01'),
    (5, 'Sara', 'Gil', 'usuario05@laestacion.example', '2026-09-01'),
    (6, 'Diego', 'Vega', 'usuario06@laestacion.example', '2026-09-01'),
    (7, 'Elena', 'Soto', 'usuario07@laestacion.example', '2026-09-01'),
    (8, 'Hugo', 'Leon', 'usuario08@laestacion.example', '2026-09-01'),
    (9, 'Lucia', 'Rey', 'usuario09@laestacion.example', '2026-09-01'),
    (10, 'Ivan', 'Cano', 'usuario10@laestacion.example', '2026-09-01'),
    (11, 'Nora', 'Vidal', 'usuario11@laestacion.example', '2026-09-01'),
    (12, 'Bruno', 'Mora', 'usuario12@laestacion.example', '2026-09-01');

INSERT INTO tipo_actividad (id_tipo, nombre, descripcion) VALUES
    (1, 'Formacion', 'Aprendizaje de habilidades y competencias'),
    (2, 'Cultura', 'Actividades de expresion y participacion cultural'),
    (3, 'Deporte', 'Actividad fisica y bienestar');

INSERT INTO actividad (id_actividad, nombre, id_tipo, id_sede, fecha_inicio, fecha_fin, plazas_maximas, estado) VALUES
    (1, 'Iniciacion a la informatica', 1, 1, '2026-10-20', '2026-12-15', 8, 'abierta'),
    (2, 'Taller de fotografia', 2, 1, '2026-10-22', '2026-12-10', 6, 'abierta'),
    (3, 'Gimnasia suave', 3, 1, '2026-10-21', '2026-12-16', 10, 'abierta'),
    (4, 'Tramites digitales', 1, 2, '2026-10-23', '2026-12-11', 8, 'abierta'),
    (5, 'Club de lectura', 2, 2, '2026-10-24', '2026-12-12', 6, 'abierta'),
    (6, 'Movilidad y bienestar', 3, 2, '2026-10-25', '2026-12-13', 10, 'abierta'),
    (7, 'Edicion de imagenes', 1, 1, '2027-01-15', '2027-02-26', 8, 'prevista'),
    (8, 'Teatro participativo', 2, 2, '2027-01-16', '2027-02-27', 12, 'prevista'),
    (9, 'Correo electronico', 1, 1, '2026-09-02', '2026-09-23', 8, 'finalizada'),
    (10, 'Ceramica creativa', 2, 2, '2026-11-03', '2026-12-15', 8, 'cancelada');

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

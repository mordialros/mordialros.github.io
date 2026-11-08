-- UT4 · ASGBD · Base de datos de aprendizaje: gestor de incidencias
-- Ejecutar una sola vez desde una cuenta administrativa en MySQL Server (VM).
-- Este script prepara SOLO la BD soporte_tic. No crea cuentas de MySQL ni concede privilegios.
-- ATENCIÓN: si ya existen estas tablas en soporte_tic, las elimina y reinicia sus datos.

CREATE DATABASE IF NOT EXISTS soporte_tic
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;

USE soporte_tic;

-- Eliminación en orden inverso al de las referencias (para poder repetir la preparación).
DROP TABLE IF EXISTS incidencias;
DROP TABLE IF EXISTS tecnicos;
DROP TABLE IF EXISTS usuarios;

-- Personas que comunican incidencias: NO son cuentas de MySQL.
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    departamento VARCHAR(60) NOT NULL
) ENGINE = InnoDB;

-- Personal que atiende las incidencias.
CREATE TABLE tecnicos (
    id_tecnico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(80) NOT NULL,
    especialidad VARCHAR(60) NOT NULL
) ENGINE = InnoDB;

-- Incidencias notificadas. El técnico puede ser NULL si aún no se ha asignado.
CREATE TABLE incidencias (
    id_incidencia INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(120) NOT NULL,
    descripcion VARCHAR(255) NOT NULL,
    estado ENUM('abierta', 'en_proceso', 'resuelta') NOT NULL DEFAULT 'abierta',
    prioridad ENUM('baja', 'media', 'alta') NOT NULL DEFAULT 'media',
    fecha_apertura DATE NOT NULL,
    id_usuario INT NOT NULL,
    id_tecnico INT NULL,
    CONSTRAINT fk_incidencia_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),
    CONSTRAINT fk_incidencia_tecnico FOREIGN KEY (id_tecnico)
        REFERENCES tecnicos(id_tecnico)
) ENGINE = InnoDB;

INSERT INTO usuarios (nombre, email, departamento) VALUES
('Laura Martín', 'laura.martin@example.org', 'Administración'),
('Javier Torres', 'javier.torres@example.org', 'Biblioteca'),
('Ana López', 'ana.lopez@example.org', 'Secretaría'),
('Marcos Ruiz', 'marcos.ruiz@example.org', 'Conserjería'),
('Sara Gómez', 'sara.gomez@example.org', 'Coordinación'),
('Pablo Vega', 'pablo.vega@example.org', 'Administración');

INSERT INTO tecnicos (nombre, especialidad) VALUES
('Lucía Fernández', 'Sistemas'),
('Diego Romero', 'Redes'),
('Elena Castro', 'Soporte de equipos');

INSERT INTO incidencias
(titulo, descripcion, estado, prioridad, fecha_apertura, id_usuario, id_tecnico)
VALUES
('No se puede iniciar sesión', 'El equipo de recepción rechaza las credenciales.', 'abierta', 'alta', '2026-10-19', 1, 1),
('Impresora sin conexión', 'La impresora de biblioteca no responde.', 'en_proceso', 'media', '2026-10-20', 2, 3),
('Red lenta', 'La conexión de secretaría presenta cortes.', 'en_proceso', 'alta', '2026-10-21', 3, 2),
('Actualización pendiente', 'Un equipo necesita instalar actualizaciones.', 'resuelta', 'baja', '2026-10-22', 4, 1),
('Correo no sincroniza', 'No se reciben nuevos mensajes en el cliente.', 'abierta', 'media', '2026-10-23', 5, NULL),
('Pantalla sin imagen', 'El monitor permanece apagado tras el arranque.', 'resuelta', 'media', '2026-10-26', 6, 3),
('Acceso a carpeta compartida', 'Se deniega el acceso a una carpeta de red.', 'abierta', 'alta', '2026-10-27', 1, 2),
('Aplicación se bloquea', 'La aplicación se cierra al abrir un informe.', 'en_proceso', 'media', '2026-10-28', 3, 1),
('Teclado defectuoso', 'Varias teclas no responden.', 'resuelta', 'baja', '2026-10-29', 4, 3),
('Equipo sin conectividad', 'Un ordenador no obtiene acceso a la red.', 'abierta', 'alta', '2026-11-02', 2, NULL),
('Error al guardar archivo', 'No se puede guardar en la unidad compartida.', 'en_proceso', 'media', '2026-11-03', 5, 2),
('Espacio insuficiente', 'El equipo muestra un aviso de disco lleno.', 'abierta', 'media', '2026-11-04', 6, 1);

-- Comprobaciones de preparación (deben mostrar 6 usuarios, 3 técnicos y 12 incidencias).
SELECT 'usuarios' AS tabla, COUNT(*) AS registros FROM usuarios
UNION ALL
SELECT 'tecnicos', COUNT(*) FROM tecnicos
UNION ALL
SELECT 'incidencias', COUNT(*) FROM incidencias;

SELECT id_incidencia, titulo, estado, prioridad
FROM incidencias
ORDER BY id_incidencia;

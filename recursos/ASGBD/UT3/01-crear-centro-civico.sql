-- Centro Civico La Estacion · laboratorio ASGBD.
-- MySQL 8.0.16 o posterior (incluido 8.4): CHECK se aplica desde 8.0.16.
-- Ejecutamos en el servidor de la VM, con una cuenta de administracion local.
-- No elimina ni modifica una base previa. Si centro_civico_asgbd ya existe,
-- DETENEMOS la ejecucion y consultamos la guia; no continuamos tras el error.
-- No crea cuentas, roles, vistas, rutinas, eventos ni disparadores.

CREATE DATABASE centro_civico_asgbd
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE centro_civico_asgbd;

CREATE TABLE sede (
    id_sede INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(80) NOT NULL,
    direccion VARCHAR(150) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(120) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    fecha_alta DATE NOT NULL
) ENGINE=InnoDB;

CREATE TABLE tipo_actividad (
    id_tipo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(60) NOT NULL UNIQUE,
    descripcion VARCHAR(200) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE actividad (
    id_actividad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    id_tipo INT NOT NULL,
    id_sede INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    plazas_maximas INT NOT NULL,
    estado VARCHAR(12) NOT NULL DEFAULT 'prevista',
    CONSTRAINT fk_actividad_tipo FOREIGN KEY (id_tipo) REFERENCES tipo_actividad (id_tipo),
    CONSTRAINT fk_actividad_sede FOREIGN KEY (id_sede) REFERENCES sede (id_sede),
    CONSTRAINT ck_actividad_fechas CHECK (fecha_fin >= fecha_inicio),
    CONSTRAINT ck_actividad_plazas CHECK (plazas_maximas > 0),
    CONSTRAINT ck_actividad_estado CHECK (estado IN ('prevista', 'abierta', 'finalizada', 'cancelada'))
) ENGINE=InnoDB;

CREATE TABLE inscripcion (
    id_inscripcion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_actividad INT NOT NULL,
    fecha_inscripcion DATETIME NOT NULL,
    estado VARCHAR(10) NOT NULL DEFAULT 'activa',
    CONSTRAINT uq_inscripcion_usuario_actividad UNIQUE (id_usuario, id_actividad),
    CONSTRAINT fk_inscripcion_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_inscripcion_actividad FOREIGN KEY (id_actividad) REFERENCES actividad (id_actividad),
    CONSTRAINT ck_inscripcion_estado CHECK (estado IN ('activa', 'cancelada'))
) ENGINE=InnoDB;

CREATE TABLE registro_cambio_inscripcion (
    id_cambio INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_inscripcion INT NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_anterior VARCHAR(10) NOT NULL,
    estado_nuevo VARCHAR(10) NOT NULL,
    cuenta_ejecutora VARCHAR(288) NOT NULL,
    CONSTRAINT fk_registro_inscripcion FOREIGN KEY (id_inscripcion) REFERENCES inscripcion (id_inscripcion),
    CONSTRAINT ck_registro_anterior CHECK (estado_anterior IN ('activa', 'cancelada')),
    CONSTRAINT ck_registro_nuevo CHECK (estado_nuevo IN ('activa', 'cancelada')),
    CONSTRAINT ck_registro_distinto CHECK (estado_anterior <> estado_nuevo)
) ENGINE=InnoDB;

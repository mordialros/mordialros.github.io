-- Centro Cívico La Estación · laboratorio ASGBD.
-- UT3. Cuenta limitada de laboratorio para las pruebas de conexión.
-- Ejecutamos en el servidor de la VM, con root conectado localmente:
--   mysql -u root -p < 04-cuenta-laboratorio.sql
--
-- Una cuenta de MySQL es usuario + equipo de origen. Creamos dos cuentas
-- con el mismo usuario y la misma contraseña:
--   'lab_consulta'@'localhost'   -> pruebas desde la propia VM
--   'lab_consulta'@'192.168.%'   -> conexiones desde el anfitrión (red NAT de VMware)
-- Solo pueden consultar la base centro_civico_asgbd. No pueden administrar.
-- root permanece exclusivamente local. Las cuentas y permisos se desarrollan en UT4.
--
-- La contraseña es exclusiva del laboratorio. Cumple la política MEDIUM
-- de validate_password por si el componente está instalado.

SELECT @@hostname AS servidor, @@port AS puerto, VERSION() AS version_mysql;

CREATE USER 'lab_consulta'@'localhost' IDENTIFIED BY 'Lab-Estacion-26';
CREATE USER 'lab_consulta'@'192.168.%' IDENTIFIED BY 'Lab-Estacion-26';

GRANT SELECT ON centro_civico_asgbd.* TO 'lab_consulta'@'localhost';
GRANT SELECT ON centro_civico_asgbd.* TO 'lab_consulta'@'192.168.%';

-- Comprobación: dos cuentas, solo con SELECT sobre la base del caso.
SELECT user, host, account_locked FROM mysql.user WHERE user = 'lab_consulta';
SHOW GRANTS FOR 'lab_consulta'@'localhost';
SHOW GRANTS FOR 'lab_consulta'@'192.168.%';

-- Recuperación, solo si se indica:
--   DROP USER 'lab_consulta'@'localhost', 'lab_consulta'@'192.168.%';

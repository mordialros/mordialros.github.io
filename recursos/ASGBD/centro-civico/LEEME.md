# Recursos del Centro Cívico La Estación

## Preparación

Utilizamos **MySQL Server 8.4 LTS** dentro de la VM del laboratorio. Antes de ejecutar los scripts, comprobamos la versión y que estamos conectados al servidor de la VM, no a otra instalación de MySQL del anfitrión.

Descargamos los archivos **dentro de la VM** y los guardamos juntos en una misma carpeta.

| Archivo | Uso |
|---|---|
| **01-crear-centro-civico.sql** | Crea la base, las tablas, las claves y las restricciones. |
| **02-cargar-datos.sql** | Carga los datos ficticios iniciales. Se ejecuta una sola vez. |
| **03-comprobar-centro-civico.sql** | Consultas de solo lectura para verificar el resultado. |
| **00-reiniciar-centro-civico.sql** | Recuperación: elimina la base para volver a crearla. Solo cuando se indique. |
| **modelo-relacional-centro-civico.png** | Modelo relacional de la base. |

## Cómo ejecutamos los scripts

Abrimos el **Símbolo del sistema** (`cmd.exe`) en la carpeta de los scripts y ejecutamos, en este orden:

```
mysql -u root -p < 01-crear-centro-civico.sql
mysql -u root -p < 02-cargar-datos.sql
mysql -u root -p -t < 03-comprobar-centro-civico.sql
```

Si `mysql` no se reconoce, utilizamos la ruta completa, por ejemplo `"C:\Program Files\MySQL\MySQL Server 8.4\bin\mysql.exe"`, o añadimos esa carpeta `bin` al PATH.

De esta forma, el cliente se detiene en el primer error. Si falla la carga, la conexión se cierra y MySQL deshace automáticamente la transacción: no queda ningún dato cargado.

> **No utilizamos PowerShell para este paso**: no admite la redirección `<`.
>
> **No utilizamos SOURCE para la carga.** En el cliente interactivo (`mysql>`), `SOURCE` continúa después de un error y ejecuta el `COMMIT` final. Podríamos confirmar una carga incompleta sin darnos cuenta.

## Si algo falla

Los scripts 01 y 02 no contienen `DROP DATABASE` ni eliminan datos. Si la base **centro_civico_asgbd** ya existe o aparece un error, detenemos el trabajo y anotamos el mensaje.

Si la base ha quedado incompleta y la práctica o el profesorado lo indican, ejecutamos **00-reiniciar-centro-civico.sql** y repetimos 01 y 02:

```
mysql -u root -p < 00-reiniciar-centro-civico.sql
```

Este script elimina la base y todo su contenido. Antes de ejecutarlo, comprobamos el servidor al que estamos conectados.

## Estado inicial esperado

| Tabla | Filas |
|---|---:|
| sede | 2 |
| usuario | 12 |
| tipo_actividad | 3 |
| actividad | 10 |
| inscripcion | 20 |
| registro_cambio_inscripcion | 0 |

El script 03 comprueba además la codificación: «Iniciación a la informática» debe aparecer con **27 caracteres y 29 bytes**. Si los valores son distintos o las tildes aparecen deformadas, los textos se han cargado con una codificación incorrecta. Los scripts están guardados en UTF-8; no los abrimos ni los guardamos con otra codificación.

Los nombres y contactos son ficticios; los correos utilizan el dominio reservado `.example`. Algunos usuarios no tienen teléfono: es un dato opcional. Las fechas y los estados corresponden a una simulación y no se actualizan con la fecha del ordenador.

## Qué incluye la base

La base incluye relaciones, claves alternativas y restricciones de valores y fechas. No incluye cuentas, roles, vistas, procedimientos, eventos ni disparadores. El control de plazas, la admisión solo en actividades abiertas y el registro automático de cambios se implementarán en UT7. Tampoco incluye índices de rendimiento expresos; MySQL crea los necesarios para claves y relaciones.

El modelo relacional muestra todas las columnas, las claves primarias, foráneas y únicas, y las cardinalidades. La clave única compuesta de INSCRIPCION aparece debajo del diagrama. Los tipos de datos y las restricciones completas se encuentran en el script de creación.

-- Centro Cívico La Estación · laboratorio ASGBD.
-- RECUPERACIÓN. Elimina la base centro_civico_asgbd y TODO su contenido.
-- Solo lo utilizamos cuando lo indique el profesorado o la práctica:
-- por ejemplo, después de una carga incompleta.
-- Después ejecutamos de nuevo 01-crear-centro-civico.sql y 02-cargar-datos.sql.
-- Comprobamos antes que estamos conectados al servidor de la VM del laboratorio.

SELECT @@hostname AS servidor, @@port AS puerto;

DROP DATABASE IF EXISTS centro_civico_asgbd;

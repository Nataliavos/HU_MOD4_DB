====================================================
PROYECTO: GESTIÓN ACADÉMICA UNIVERSIDAD
====================================================

1. DESCRIPCIÓN GENERAL

Este proyecto consiste en el diseño e implementación de una base de datos académica
denominada "gestion_academica_universidad", desarrollada en PostgreSQL.

La base de datos permite administrar información relacionada con:

- Estudiantes
- Docentes
- Cursos
- Inscripciones

Se aplicaron conceptos de SQL incluyendo:

DDL (Data Definition Language)
DML (Data Manipulation Language)
DQL (Data Query Language)
DCL (Data Control Language)
TCL (Transaction Control Language)

Además, se implementaron consultas analíticas con agregaciones, subconsultas,
vistas, control de acceso y manejo de transacciones.

----------------------------------------------------

2. ESTRUCTURA DE LA BASE DE DATOS

Tablas creadas:

- estudiantes
- docentes
- cursos
- inscripciones

Restricciones implementadas:

- PRIMARY KEY
- FOREIGN KEY
- NOT NULL
- UNIQUE
- CHECK
- ON DELETE (CASCADE y SET NULL)

Relaciones principales:

- Un docente puede dictar varios cursos.
- Un estudiante puede inscribirse en varios cursos.
- Cada inscripción relaciona un estudiante con un curso.

----------------------------------------------------

3. DATOS INSERTADOS

Se insertaron datos mínimos requeridos:

- 5 estudiantes
- 3 docentes
- 4 cursos
- 8 inscripciones

----------------------------------------------------

4. CONSULTAS IMPLEMENTADAS (TASK 3)

✔ JOIN entre estudiantes, cursos e inscripciones
✔ Cursos dictados por docentes con más de 5 años de experiencia
✔ Promedio de calificaciones por curso (AVG + GROUP BY)
✔ Estudiantes inscritos en más de un curso (HAVING)
✔ ALTER TABLE para agregar columna estado_academico
✔ Validación del comportamiento ON DELETE
✔ Cursos con más de 2 estudiantes inscritos

----------------------------------------------------

5. SUBCONSULTAS Y FUNCIONES (TASK 4)

✔ Estudiantes con promedio superior al promedio general
✔ Carreras con estudiantes inscritos en cursos del semestre >= 2 (EXISTS)
✔ Uso de funciones agregadas: ROUND, SUM, MAX, MIN, COUNT

----------------------------------------------------

6. VISTA CREADA (TASK 5)

Se creó la vista:

vista_historial_academico

La vista muestra:

- Nombre del estudiante
- Nombre del curso
- Nombre del docente
- Semestre
- Calificación final

----------------------------------------------------

7. CONTROL DE ACCESO (TASK 6)

Se creó el rol:

revisor_academico

Permisos otorgados:

- SELECT sobre vista_historial_academico

Permisos revocados:

- INSERT
- UPDATE
- DELETE sobre inscripciones

Se verificó el funcionamiento mediante:

- Consulta de privilegios
- SET ROLE
- Intento fallido de modificación

----------------------------------------------------

8. TRANSACCIONES (TASK 6)

Se simuló una actualización de calificaciones utilizando:

BEGIN
SAVEPOINT
ROLLBACK
COMMIT

Se demostró la reversión parcial de cambios utilizando SAVEPOINT.

----------------------------------------------------

9. TECNOLOGÍAS UTILIZADAS

- PostgreSQL
- DBeaver
- SQL estándar

----------------------------------------------------

10. INSTRUCCIONES DE EJECUCIÓN

1. Crear la base de datos gestion_academica_universidad.
2. Ejecutar los scripts SQL en el siguiente orden:

   - Creación de tablas
   - Inserción de datos
   - Consultas
   - Vista
   - Permisos y transacciones

----------------------------------------------------

Proyecto desarrollado como parte de práctica académica
de modelado y administración de bases de datos.
====================================================
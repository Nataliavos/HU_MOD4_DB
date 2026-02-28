# Bases de Datos – Historias de Usuario (Semanas 1, 2 y 3)

Repositorio correspondiente a las prácticas académicas de Bases de Datos,
enfocadas en modelado relacional e implementación en SQL y MongoDB.

---

## 📌 Semana 1 – Diseño Conceptual y Lógico  
**Caso: Hospital "Vida Sana"**

### Objetivo
Diseñar una base de datos relacional normalizada hasta Tercera Forma Normal (3FN) 
para gestionar:

- Pacientes  
- Médicos  
- Citas  
- Diagnósticos  

### Entregables
- DER (Diagrama Entidad–Relación)
- Modelo Relacional con tipos de datos

> No incluye implementación en SQL.

---

## 📌 Semana 2 – Implementación en PostgreSQL  
**Caso: Gestión Académica Universidad**

### Objetivo
Diseñar e implementar una base de datos académica aplicando:

- DDL, DML, DQL
- DCL (permisos)
- TCL (transacciones)
- Consultas analíticas
- Subconsultas
- Vistas

### Funcionalidades implementadas
- Restricciones: PK, FK, NOT NULL, UNIQUE, CHECK
- Inserción de datos
- JOIN, GROUP BY, HAVING
- Funciones agregadas (AVG, COUNT, SUM, MAX, MIN)
- Vista `vista_historial_academico`
- Rol `revisor_academico` con permisos de solo lectura
- Uso de BEGIN, SAVEPOINT, ROLLBACK y COMMIT

---

## 📌 Semana 3 – MongoDB  
**Caso: StreamHub – Gestión de Contenido y Usuarios**

### Objetivo
Modelar e implementar colecciones en MongoDB para gestionar:

- Usuarios
- Contenido audiovisual (películas/series)
- Valoraciones y métricas de uso

Aplicando:

- CRUD (insertOne, find, update, delete)
- Índices (createIndex, getIndexes)
- Agregaciones (aggregate con $match, $group, $sort, $project, $unwind)
- Operadores de consulta ($gt, $lt, $eq, $in, $and, $or, $regex)

### Alcance
- Diseño de documentos JSON con estructuras anidadas
- Inserción de datos variados
- Consultas con operadores lógicos y comparadores
- Actualizaciones y eliminaciones
- Creación y verificación de índices
- ≥ 2 pipelines de agregación para métricas

---

## 🛠 Tecnologías utilizadas

- PostgreSQL
- MongoDB
- DBeaver
- MongoDB Compass
- draw.io (modelado DER)
- drawDB (modelo relacional)
- SQL estándar

---

## 📂 Estructura del repositorio

- `/HU_1/`
- `/HU_"/`
- `/HU_#/`
  
---

Proyecto desarrollado como práctica formativa en Bases de Datos.

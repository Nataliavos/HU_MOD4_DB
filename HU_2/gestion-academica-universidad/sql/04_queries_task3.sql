-- CONSULTAS BÁSICAS Y MANIPULACIÓN

-- Listar todos los estudiantes con sus inscripciones y cursos (JOIN).
SELECT
  e.id_estudiante,
  e.nombre_completo AS estudiante,
  c.codigo,
  c.nombre          AS curso,
  i.fecha_inscripcion,
  i.calificacion_final
FROM estudiantes e
JOIN inscripciones i ON i.id_estudiante = e.id_estudiante
JOIN cursos c        ON c.id_curso = i.id_curso
ORDER BY e.id_estudiante, c.codigo;


-- Listar cursos dictados por docentes con > 5 años de experiencia.
SELECT
  c.codigo,
  c.nombre AS curso,
  d.nombre_completo AS docente,
  d.anios_experiencia
FROM cursos c
JOIN docentes d ON d.id_docente = c.id_docente
WHERE d.anios_experiencia > 5
ORDER BY d.anios_experiencia DESC, c.codigo;

-- Obtener promedio de calificaciones por curso (GROUP BY + AVG).
SELECT
  c.codigo,
  c.nombre,
  ROUND(AVG(i.calificacion_final), 2) AS promedio_curso
FROM cursos c
JOIN inscripciones i ON i.id_curso = c.id_curso
GROUP BY c.id_curso, c.codigo, c.nombre
ORDER BY c.codigo;

-- Mostrar estudiantes inscritos en más de un curso (HAVING COUNT(*) > 1).
SELECT
  e.id_estudiante,
  e.nombre_completo,
  COUNT(*) AS cantidad_cursos
FROM estudiantes e
JOIN inscripciones i ON i.id_estudiante = e.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
HAVING COUNT(*) > 1
ORDER BY cantidad_cursos DESC, e.id_estudiante;

-- ALTER TABLE: agregar columna estado_academico a estudiantes.
ALTER TABLE estudiantes
ADD COLUMN estado_academico VARCHAR(20) NOT NULL DEFAULT 'ACTIVO';

ALTER TABLE estudiantes
ADD CONSTRAINT chk_estado_academico
CHECK (estado_academico IN ('ACTIVO', 'SUSPENDIDO', 'GRADUADO', 'RETIRADO'));


-- Eliminar un docente y observar el efecto en cursos (revisar ON DELETE en la FK).
-- Ver antes
SELECT id_curso, codigo, nombre, id_docente FROM cursos ORDER BY id_curso;
-- Eliminamos al docente 1
DELETE FROM docentes WHERE id_docente = 1;
-- Ver después: cursos BD101 y PRG101 deben quedar con id_docente = NULL
SELECT id_curso, codigo, nombre, id_docente FROM cursos ORDER BY id_curso;


-- Consultar cursos con más de 2 estudiantes inscritos (GROUP BY + COUNT + HAVING).
SELECT
  c.codigo,
  c.nombre,
  COUNT(i.id_inscripcion) AS total_inscritos
FROM cursos c
JOIN inscripciones i ON i.id_curso = c.id_curso
GROUP BY c.id_curso, c.codigo, c.nombre
HAVING COUNT(i.id_inscripcion) > 2
ORDER BY total_inscritos DESC, c.codigo;
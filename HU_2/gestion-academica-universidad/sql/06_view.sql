-- VISTA HISTORIAL ACADÉMICO

-- Crea vista_historial_academico que muestre: 
-- nombre del estudiante, del curso y del docente
-- semestre y calificación final
CREATE OR REPLACE VIEW vista_historial_academico AS
SELECT
  e.nombre_completo AS estudiante,
  c.nombre          AS curso,
  COALESCE(d.nombre_completo, 'SIN DOCENTE') AS docente,
  c.semestre,
  i.calificacion_final
FROM inscripciones i
JOIN estudiantes e ON e.id_estudiante = i.id_estudiante
JOIN cursos c      ON c.id_curso = i.id_curso
LEFT JOIN docentes d ON d.id_docente = c.id_docente;

-- Visualizar
SELECT * FROM vista_historial_academico ORDER BY estudiante, semestre, curso;
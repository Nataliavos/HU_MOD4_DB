-- SUBCONSULTAS Y FUNCIONES

-- Estudiantes cuya calificación promedio sea > promedio general (AVG() + subconsulta).
SELECT
  e.id_estudiante,
  e.nombre_completo,
  ROUND(AVG(i.calificacion_final), 2) AS promedio_estudiante
FROM estudiantes e
JOIN inscripciones i ON i.id_estudiante = e.id_estudiante
GROUP BY e.id_estudiante, e.nombre_completo
HAVING AVG(i.calificacion_final) >
  (SELECT AVG(calificacion_final) FROM inscripciones)
ORDER BY promedio_estudiante DESC;


-- Nombres de carreras con estudiantes inscritos en cursos del semestre ≥ 2 (IN o EXISTS).
SELECT DISTINCT e.carrera
FROM estudiantes e
WHERE EXISTS (
  SELECT 1
  FROM inscripciones i
  JOIN cursos c ON c.id_curso = i.id_curso
  WHERE i.id_estudiante = e.id_estudiante
    AND c.semestre >= 2
)
ORDER BY e.carrera;


-- Usar ROUND, SUM, MAX, MIN, COUNT para obtener indicadores.
SELECT
  COUNT(*) AS total_inscripciones,
  COUNT(DISTINCT id_estudiante) AS estudiantes_con_inscripcion,
  COUNT(DISTINCT id_curso) AS cursos_con_inscripcion,
  ROUND(AVG(calificacion_final), 2) AS promedio_general,
  MAX(calificacion_final) AS max_calificacion,
  MIN(calificacion_final) AS min_calificacion,
  ROUND(SUM(calificacion_final), 2) AS suma_calificaciones
FROM inscripciones;
-- CONTROL DE ACCESO Y TRANSACCIONES

-- Otorga permisos de solo lectura a un rol revisor_academico sobre la vista (GRANT SELECT).
DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'revisor_academico') THEN
    CREATE ROLE revisor_academico;
  END IF;
END $$;

GRANT SELECT ON vista_historial_academico TO revisor_academico;


-- Revoca permisos de modificación de datos en inscripciones para ese rol (REVOKE).
REVOKE INSERT, UPDATE, DELETE ON inscripciones FROM revisor_academico;


-- Simula actualización de calificaciones usando BEGIN, SAVEPOINT, ROLLBACK y COMMIT.
BEGIN;

-- Primer cambio
UPDATE inscripciones
SET calificacion_final = 4.80
WHERE id_estudiante = 2 AND id_curso = 3;

SAVEPOINT sp1;

-- Segundo cambio (simulamos que fue un error)
UPDATE inscripciones
SET calificacion_final = 1.00
WHERE id_estudiante = 4 AND id_curso = 1;

-- Revisa y decide deshacer SOLO el segundo cambio
ROLLBACK TO SAVEPOINT sp1;

-- Confirma lo que quedó (solo el primer update)
COMMIT;

-- Verificación
SELECT id_inscripcion, id_estudiante, id_curso, calificacion_final
FROM inscripciones
ORDER BY id_inscripcion;
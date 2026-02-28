-- CREACIÓN DE TABLAS

-- TABLA: estudiantes
CREATE TABLE estudiantes (
  id_estudiante        SERIAL PRIMARY KEY,
  nombre_completo      VARCHAR(120) NOT NULL,
  correo_electronico   VARCHAR(120) NOT NULL UNIQUE,
  genero               VARCHAR(20)  NOT NULL,
  identificacion       VARCHAR(30)  NOT NULL UNIQUE,
  carrera              VARCHAR(80)  NOT NULL,
  fecha_nacimiento     DATE         NOT NULL,
  fecha_ingreso        DATE         NOT NULL,
  CHECK (genero IN ('F', 'M', 'NB', 'Otro')),
  CHECK (fecha_nacimiento <= (CURRENT_DATE - INTERVAL '15 years')),
  CHECK (fecha_ingreso >= DATE '2000-01-01')
);

-- TABLA: docentes
CREATE TABLE docentes (
  id_docente             SERIAL PRIMARY KEY,
  nombre_completo        VARCHAR(120) NOT NULL,
  correo_institucional   VARCHAR(120) NOT NULL UNIQUE,
  departamento_academico VARCHAR(80)  NOT NULL,
  anios_experiencia      INT          NOT NULL,
  CHECK (anios_experiencia >= 0)
);

-- TABLA: cursos
CREATE TABLE cursos (
  id_curso     SERIAL PRIMARY KEY,
  nombre       VARCHAR(120) NOT NULL,
  codigo       VARCHAR(20)  NOT NULL UNIQUE,
  creditos     INT          NOT NULL,
  semestre     INT          NOT NULL,
  id_docente   INT,
  CHECK (creditos BETWEEN 1 AND 10),
  CHECK (semestre BETWEEN 1 AND 12),
  CONSTRAINT fk_cursos_docente
    FOREIGN KEY (id_docente)
    REFERENCES docentes(id_docente)
    ON DELETE SET NULL
);

-- TABLA: inscripciones
CREATE TABLE inscripciones (
  id_inscripcion     SERIAL PRIMARY KEY,
  id_estudiante      INT  NOT NULL,
  id_curso           INT  NOT NULL,
  fecha_inscripcion  DATE NOT NULL,
  calificacion_final NUMERIC(4,2),
  CONSTRAINT fk_insc_estudiante
    FOREIGN KEY (id_estudiante)
    REFERENCES estudiantes(id_estudiante)
    ON DELETE CASCADE,
  CONSTRAINT fk_insc_curso
    FOREIGN KEY (id_curso)
    REFERENCES cursos(id_curso)
    ON DELETE CASCADE,
  CONSTRAINT uq_inscripcion UNIQUE (id_estudiante, id_curso),
  CHECK (calificacion_final IS NULL OR (calificacion_final BETWEEN 0 AND 5))
);
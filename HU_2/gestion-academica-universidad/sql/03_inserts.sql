-- INSERCIÓN DE DATOS

-- DOCENTES (3)
INSERT INTO docentes (nombre_completo, correo_institucional, departamento_academico, anios_experiencia) VALUES
('Laura Martínez', 'laura.martinez@uni.edu', 'Ingeniería', 8),
('Carlos Gómez',   'carlos.gomez@uni.edu',  'Ciencias',   4),
('Ana Torres',     'ana.torres@uni.edu',    'Humanidades',12);

-- ESTUDIANTES (5)
INSERT INTO estudiantes (nombre_completo, correo_electronico, genero, identificacion, carrera, fecha_nacimiento, fecha_ingreso) VALUES
('Sofía Ramírez',  'sofia.ramirez@mail.com',  'F',  'CC1001', 'Ingeniería Civil',   '2003-04-12', '2022-01-15'),
('Mateo Sánchez',  'mateo.sanchez@mail.com',  'M',  'CC1002', 'Ingeniería Sistemas','2002-10-03', '2021-08-10'),
('Valentina Ríos', 'valentina.rios@mail.com', 'F',  'CC1003', 'Matemáticas',        '2004-01-30', '2023-01-20'),
('Juan Pérez',     'juan.perez@mail.com',     'M',  'CC1004', 'Administración',     '2001-07-18', '2020-02-01'),
('Alex Mora',      'alex.mora@mail.com',      'NB', 'CC1005', 'Psicología',         '2003-11-25', '2022-08-01');

-- CURSOS (4)
INSERT INTO cursos (nombre, codigo, creditos, semestre, id_docente) VALUES
('Bases de Datos I',     'BD101', 3, 1, 1),  -- Laura (8 años)
('Programación I',       'PRG101',4, 1, 1),  -- Laura
('Cálculo II',           'MAT201',4, 2, 2),  -- Carlos (4 años)
('Ética Profesional',    'HUM210',2, 2, 3);  -- Ana (12 años)

-- INSCRIPCIONES (8)
INSERT INTO inscripciones (id_estudiante, id_curso, fecha_inscripcion, calificacion_final) VALUES
(1, 1, '2024-02-01', 4.50),
(1, 2, '2024-02-02', 4.20),
(2, 1, '2024-02-01', 3.80),
(2, 3, '2024-02-05', 3.40),
(3, 3, '2024-02-06', 4.70),
(3, 4, '2024-02-07', 4.10),
(4, 1, '2024-02-03', 2.90),
(5, 4, '2024-02-08', 3.60);
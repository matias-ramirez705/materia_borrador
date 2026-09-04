/* ============================================================
ACTIVIDAD PRÁCTICA DE SQL
Tema: Sistema de citas médicas de una clínica
Tablas: pacientes, doctores, citas, recetas
============================================================ */
/* ============================================================
PARTE 1: CREACIÓN DE TABLAS (con llaves primarias y foráneas)
============================================================ */
DROP TABLE IF EXISTS recetas;
DROP TABLE IF EXISTS citas;
DROP TABLE IF EXISTS doctores;
DROP TABLE IF EXISTS pacientes;
-- Tabla 1: PACIENTES
CREATE TABLE pacientes (
id_paciente INT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
email VARCHAR(100),
ciudad VARCHAR(50),
fecha_nacimiento DATE
);
-- Tabla 2: DOCTORES
CREATE TABLE doctores (
id_doctor INT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
especialidad VARCHAR(50),
valor_consulta DECIMAL(10,2) NOT NULL
);
-- Tabla 3: CITAS (se conecta a pacientes y a doctores)
CREATE TABLE citas (
id_cita INT PRIMARY KEY,
id_paciente INT NOT NULL,
id_doctor INT NOT NULL,
fecha_cita DATE NOT NULL,
estado VARCHAR(20), -- 'pendiente', 'confirmada', 'realizada', 'cancelada'
FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
FOREIGN KEY (id_doctor) REFERENCES doctores(id_doctor)
);
-- Tabla 4: RECETAS (se conecta a citas)
CREATE TABLE recetas (
id_receta INT PRIMARY KEY,
id_cita INT NOT NULL,
medicamento VARCHAR(100) NOT NULL,
dosis VARCHAR(50),
precio DECIMAL(10,2) NOT NULL,
FOREIGN KEY (id_cita) REFERENCES citas(id_cita)
);
/* ============================================================
PARTE 2: DATOS DE EJEMPLO
============================================================ */
INSERT INTO pacientes (id_paciente, nombre, apellido, email, ciudad, fecha_nacimiento)
VALUES
(1, 'Camila', 'Rojas', 'camila.rojas@gmail.com', 'Santiago', '1990-04-12'),
(2, 'Matías', 'Fernández','matias.fernandez@mail.com','Valparaíso', '1985-09-23'),
(3, 'Valentina','Soto', 'valentina.soto@mail.com', 'Concepción', '1998-01-30'),
(4, 'Benjamín', 'Muñoz', 'benjamin.munoz@gmail.com', 'Santiago', '1979-11-05'),
(5, 'Isidora', 'Contreras','isidora.contreras@mail.com','La Serena', '2000-06-18'),
(6, 'Joaquín', 'Vergara', 'joaquin.vergara@gmail.com', 'Santiago', '1993-03-27'),
(7, 'Antonia', 'Reyes', 'antonia.reyes@mail.com', 'Temuco', '1988-08-14'),
(8, 'Diego', 'Araya', 'diego.araya@gmail.com', 'Valparaíso', '1995-12-02');
INSERT INTO doctores (id_doctor, nombre, apellido, especialidad, valor_consulta) VALUES
(1, 'Francisca', 'López', 'Medicina General', 25000),
(2, 'Rodrigo', 'Castro', 'Pediatría', 30000),
(3, 'Constanza', 'Herrera', 'Dermatología', 35000),
(4, 'Sebastián', 'Torres', 'Traumatología', 40000),
(5, 'Javiera', 'Morales', 'Cardiología', 45000);
INSERT INTO citas (id_cita, id_paciente, id_doctor, fecha_cita, estado) VALUES
(1, 1, 1, '2024-08-01', 'realizada'),
(2, 2, 3, '2024-08-03', 'realizada'),
(3, 1, 4, '2024-08-10', 'confirmada'),
(4, 3, 2, '2024-08-12', 'pendiente'),
(5, 4, 5, '2024-08-15', 'realizada'),
(6, 5, 1, '2024-08-18', 'cancelada'),
(7, 2, 3, '2024-08-20', 'confirmada'),
(8, 6, 4, '2024-08-22', 'pendiente'),
(9, 1, 5, '2024-08-25', 'realizada'),
(10,7, 2, '2024-08-28', 'realizada');
-- Nota: el paciente 8 (Diego Araya) no tiene ninguna cita registrada.
INSERT INTO recetas (id_receta, id_cita, medicamento, dosis, precio) VALUES
(1, 1, 'Paracetamol', '500 mg cada 8 horas', 3500),(2, 1, 'Ibuprofeno', '400 mg cada 12 horas', 4200),
(3, 2, 'Crema hidratante','Aplicar 2 veces al día',8900),
(4, 5, 'Atorvastatina', '20 mg cada noche', 12500),
(5, 5, 'Aspirina', '100 mg cada día', 3200),
(6, 9, 'Losartán', '50 mg cada día', 9800),
(7, 10,'Amoxicilina', '500 mg cada 8 horas', 6700);
-- Nota: las citas 3, 4, 6, 7 y 8 no tienen receta asociada
-- (no se ha realizado la consulta o no requirió medicamentos).
/* ============================================================
PARTE 3: EJERCICIOS PRÁCTICOS
============================================================ */
-- --- 1. SELECT básico ---
-- 1.1 Mostrar todos los pacientes
SELECT * FROM pacientes;

-- 1.2 Mostrar solo nombre, apellido y especialidad de los doctores
SELECT nombre, apellido, especialidad FROM doctores;

-- --- 2. WHERE (filtros) ---
-- 2.1 Pacientes que viven en Santiago
SELECT nombre, apellido, ciudad
FROM pacientes
WHERE ciudad = 'Santiago';

-- 2.2 Doctores cuyo valor de consulta es mayor a 30000
SELECT nombre, apellido, valor_consulta
FROM doctores
WHERE valor_consulta > 30000;

-- 2.3 Citas que están en estado 'realizada'
SELECT * FROM citas
WHERE estado = 'realizada';

-- 2.4 WHERE con condición compuesta (AND)
SELECT nombre, apellido, especialidad, valor_consulta
FROM doctores
WHERE especialidad = 'Pediatría' AND valor_consulta < 35000;

-- --- 3. LIKE (búsqueda de patrones) ---
-- 3.1 Pacientes cuyo nombre empieza con "M"
SELECT nombre, apellido
FROM pacientes
WHERE nombre LIKE 'M%';

-- 3.1.2 Pacientes cuyo nombre termina con "N"
SELECT nombre, apellido
FROM pacientes
WHERE nombre LIKE '%N';

-- 3.2 Medicamentos que contienen la palabra "cillin"/"amina" (ejemplo genérico)
SELECT medicamento
FROM recetas
WHERE medicamento LIKE '%ina';

-- 3.3 Pacientes con email de dominio "mail.com"
SELECT nombre, email
FROM pacientes
WHERE email LIKE '%@mail.com';

-- --- 4. DISTINCT (valores únicos) ---
-- 4.1 Listar las ciudades únicas donde hay pacientes
SELECT DISTINCT ciudad FROM pacientes;

-- 4.2 Listar las especialidades únicas de los doctores
SELECT DISTINCT especialidad FROM doctores;

-- 4.3 Listar los distintos estados de citas
SELECT DISTINCT estado FROM citas;

-- --- 5. ORDER BY (ordenamiento) ---
-- 5.1 Doctores ordenados de mayor a menor valor de consulta
SELECT nombre, apellido, valor_consulta
FROM doctores
ORDER BY valor_consulta DESC;

-- 5.2 Pacientes ordenados alfabéticamente por apellido
SELECT nombre, apellido
FROM pacientes
ORDER BY apellido ASC;

-- --- 6. FUNCIONES DE AGREGACIÓN: COUNT, MIN, MAX, AVG, SUM ---
-- 6.1 Contar cuántos pacientes hay en total
SELECT COUNT(*) AS total_pacientes FROM pacientes;

-- 6.1.2 Contar cuántos pacientes distintos hay en total
SELECT DISTINCT COUNT(*) AS total_pacientes FROM pacientes;

-- 6.2 Contar cuántos doctores hay por especialidad
SELECT especialidad, COUNT(*) AS cantidad_doctores
FROM doctores
GROUP BY especialidad;

-- 6.3 Valor mínimo y máximo de consulta entre los doctores
SELECT MIN(valor_consulta) AS consulta_minima, MAX(valor_consulta) AS
consulta_maxima
FROM doctores;

-- 6.4 Precio promedio de los medicamentos recetados
SELECT AVG(precio) AS precio_promedio_medicamento
FROM recetas;

-- 6.4.1 Precio promedio de los medicamentos recetados redondeado a 2 decimales
SELECT ROUND(AVG(precio),2) AS precio_promedio_medicamento
FROM recetas;

-- 6.5 Suma total facturada en medicamentos
SELECT SUM(precio) AS total_facturado_recetas FROM recetas;

-- 6.6 Cantidad de citas por doctor
SELECT id_doctor, COUNT(*) AS cantidad_citas
FROM citas
GROUP BY id_doctor;

-- --- 7. GROUP BY + HAVING (filtrar grupos) ---
-- 7.1 Ciudades con más de 1 paciente registrado
SELECT ciudad, COUNT(*) AS cantidad_pacientes
FROM pacientes
GROUP BY ciudad
HAVING COUNT(*) > 1;

-- 7.2 Doctores que han atendido más de 1 cita
SELECT id_doctor, COUNT(*) AS cantidad_citas
FROM citas
GROUP BY id_doctor
HAVING COUNT(*) > 1;

-- --- 8. INNER JOIN (solo registros que coinciden en ambas tablas) ---
-- 8.1 Ver el nombre del paciente junto con sus citas
-- (Solo pacientes que SÍ tienen al menos una cita)
SELECT p.nombre, p.apellido, c.id_cita, c.fecha_cita, c.estado
FROM pacientes p
INNER JOIN citas c ON p.id_paciente = c.id_paciente;

-- 8.2 Ver el doctor, la fecha y el paciente de cada cita
SELECT c.id_cita, p.nombre AS paciente, d.nombre AS doctor, d.especialidad, c.fecha_cita, c.estado
FROM citas c
INNER JOIN pacientes p ON c.id_paciente = p.id_paciente
INNER JOIN doctores d ON c.id_doctor = d.id_doctor;

-- 8.3 Ver el detalle de medicamentos recetados en cada cita realizada
SELECT c.id_cita, p.nombre AS paciente, r.medicamento, r.dosis, r.precio
FROM citas c
INNER JOIN pacientes p ON c.id_paciente = p.id_paciente
INNER JOIN recetas r ON c.id_cita = r.id_cita;

-- 8.3.2 Ver el detalle de medicamentos recetados en cada cita ya sea realizada o no
SELECT c.id_cita, p.nombre AS paciente, r.medicamento, r.dosis, r.precio
FROM citas c
INNER JOIN pacientes p ON c.id_paciente = p.id_paciente
LEFT JOIN recetas r ON c.id_cita = r.id_cita;

-- 8.4 Total gastado en medicamentos por cada paciente
SELECT p.nombre, p.apellido, SUM(r.precio) AS total_gastado_medicamentos
FROM pacientes p
INNER JOIN citas c ON p.id_paciente = c.id_paciente
INNER JOIN recetas r ON c.id_cita = r.id_cita
GROUP BY p.nombre, p.apellido
ORDER BY total_gastado_medicamentos DESC;

-- --- 9. LEFT JOIN (todos los registros de la tabla izquierda,
-- aunque no tengan coincidencia en la tabla derecha) ---
-- 9.1 Mostrar TODOS los pacientes, tengan o no citas registradas
-- (Diego Araya aparecerá con valores NULL en las columnas de cita)
SELECT p.nombre, p.apellido, c.id_cita, c.fecha_cita, c.estado
FROM pacientes p
LEFT JOIN citas c ON p.id_paciente = c.id_paciente;

-- 9.2 Encontrar los pacientes que NO tienen ninguna cita registrada
SELECT p.nombre, p.apellido
FROM pacientes p
LEFT JOIN citas c ON p.id_paciente = c.id_paciente
WHERE c.id_cita IS NULL;

-- 9.3 Mostrar TODAS las citas, indicando si tienen o no receta asociada
-- (las citas pendientes/canceladas aparecerán con NULL en medicamento)
SELECT c.id_cita, c.fecha_cita, c.estado, r.medicamento, r.precio
FROM citas c
LEFT JOIN recetas r ON c.id_cita = r.id_cita;

-- 9.4 Encontrar las citas que NO generaron ninguna receta
SELECT c.id_cita, c.fecha_cita, c.estado
FROM citas c
LEFT JOIN recetas r ON c.id_cita = r.id_cita
WHERE r.id_receta IS NULL;

/* ============================================================
PARTE 4: DESAFÍOS PROPUESTOS PARA LOS ESTUDIANTES
(sin solución, para que los resuelvan ellos)
============================================================ */
-- 1. Usando LEFT JOIN, mostrar todos los doctores y la cantidad de citas
-- que tiene cada uno (incluyendo doctores con 0 citas, si los hubiera).
-- 2. Mostrar la cita con el monto total más alto en recetas.
-- 3. Usando INNER JOIN, contar cuántas citas ha tenido cada paciente,
-- mostrando solo los que tienen 2 o más citas.
-- 4. Mostrar los doctores cuya especialidad sea "Pediatría" o "Cardiología".-- 5. Listar las citas realizadas en el mes de agosto de 2024.
-- 6. Mostrar el nombre del paciente y su ciudad, para los pacientes
-- cuyo apellido termine en "z" (usar LIKE '%z').
-- 7. Calcular cuántas citas hay en cada estado (pendiente, confirmada,
-- realizada, cancelada) usando GROUP BY.
-- 8. Usando LEFT JOIN, encontrar los pacientes que nunca han recibido
-- una receta médica.
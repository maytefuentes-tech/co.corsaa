CREATE DATABASE CentroOdontologicoCorsa;
USE CentroOdontologicoCorsa;

CREATE TABLE Odontologos (
    id_odontologo INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(100),
    horario_inicio TIME,
    horario_fin TIME,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Pacientes (
    id_paciente INT PRIMARY KEY AUTO_INCREMENT,
    rut VARCHAR(12) UNIQUE NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    fecha_nacimiento DATE,
    telefono VARCHAR(20),
    email VARCHAR(100),
    direccion TEXT,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Citas (
    id_cita INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    id_odontologo INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    duracion_estimada INT DEFAULT 60,
    estado VARCHAR(20) DEFAULT 'agendada',
    tipo_consulta VARCHAR(100),
    observaciones TEXT,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_confirmacion DATETIME,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente),
    FOREIGN KEY (id_odontologo) REFERENCES Odontologos(id_odontologo)
);

CREATE TABLE Servicios (
    id_servicio INT PRIMARY KEY AUTO_INCREMENT,
    id_cita INT NOT NULL,
    tipo_servicio VARCHAR(20) NOT NULL,
    descripcion TEXT,
    costo DECIMAL(10,2),
    fecha_servicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cita) REFERENCES Citas(id_cita)
);

CREATE TABLE Fichas_Clinicas (
    id_ficha INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    antecedentes_medicos TEXT,
    alergias TEXT,
    medicamentos_actuales TEXT,
    observaciones_generales TEXT,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)
);

CREATE TABLE Inventario (
    id_insumo INT PRIMARY KEY AUTO_INCREMENT,
    nombre_insumo VARCHAR(100) NOT NULL,
    descripcion TEXT,
    categoria VARCHAR(20) NOT NULL,
    stock_actual INT DEFAULT 0,
    stock_minimo INT DEFAULT 5,
    unidad_medida VARCHAR(20),
    precio_unitario DECIMAL(10,2),
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE Consumos_Insumos (
    id_consumo INT PRIMARY KEY AUTO_INCREMENT,
    id_insumo INT NOT NULL,
    id_cita INT NOT NULL,
    cantidad_utilizada INT NOT NULL,
    fecha_consumo DATETIME DEFAULT CURRENT_TIMESTAMP,
    observaciones TEXT,
    FOREIGN KEY (id_insumo) REFERENCES Inventario(id_insumo),
    FOREIGN KEY (id_cita) REFERENCES Citas(id_cita)
);

CREATE TABLE Recordatorios (
    id_recordatorio INT PRIMARY KEY AUTO_INCREMENT,
    id_cita INT NOT NULL,
    tipo_recordatorio VARCHAR(20) NOT NULL,
    mensaje TEXT,
    fecha_envio DATETIME,
    estado VARCHAR(20) DEFAULT 'pendiente',
    respuesta_paciente TEXT,
    fecha_respuesta DATETIME,
    FOREIGN KEY (id_cita) REFERENCES Citas(id_cita)
);

CREATE TABLE Indicadores (
    id_indicador INT PRIMARY KEY AUTO_INCREMENT,
    fecha DATE NOT NULL,
    id_odontologo INT NOT NULL,
    total_citas_agendadas INT DEFAULT 0,
    total_citas_completadas INT DEFAULT 0,
    total_citas_canceladas INT DEFAULT 0,
    total_inasistencias INT DEFAULT 0,
    tasa_ocupacion DECIMAL(5,2) DEFAULT 0,
    tiempo_promedio_confirmacion DECIMAL(5,2) DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_odontologo) REFERENCES Odontologos(id_odontologo)
);

CREATE TABLE Sesiones_Pacientes (
    id_sesion INT PRIMARY KEY AUTO_INCREMENT,
    id_paciente INT NOT NULL,
    token_sesion VARCHAR(100) UNIQUE NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_expiracion DATETIME NOT NULL,
    activa BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_paciente) REFERENCES Pacientes(id_paciente)
);

INSERT INTO Odontologos (nombre, especialidad, telefono, email, horario_inicio, horario_fin) VALUES
('Dr. Juan Carlos Huerta Badilla', 'Odontología General', '+5672231612', 'dr.huerta@corsaodontologico.cl', '09:00:00', '19:00:00');

INSERT INTO Pacientes (rut, nombre, apellido, fecha_nacimiento, telefono, email, direccion) VALUES
('12.345.678-9', 'Ana', 'González Pérez', '1985-03-15', '+56912345678', 'ana.gonzalez@email.com', 'Av. Libertador 123, Rancagua'),
('23.456.789-0', 'Carlos', 'Martínez Rojas', '1978-07-22', '+56923456789', 'carlos.martinez@email.com', 'Los Aromos 456, Rancagua'),
('34.567.890-1', 'María', 'Silva López', '1990-11-30', '+56934567890', 'maria.silva@email.com', 'Paseo Independencia 789, Rancagua'),
('45.678.901-2', 'Roberto', 'Fuentes Díaz', '1982-05-18', '+56945678901', 'roberto.fuentes@email.com', 'Bueras 234, Rancagua'),
('56.789.012-3', 'Isidora', 'Vargas Mora', '1995-09-08', '+56956789012', 'isidora.vargas@email.com', 'Plaza Los Héroes 567, Rancagua'),
('67.890.123-4', 'Patricio', 'Mendoza Soto', '1975-12-12', '+56967890123', 'patricio.mendoza@email.com', 'San Martín 890, Rancagua'),
('78.901.234-5', 'Camila', 'Rojas González', '1988-04-25', '+56978901234', 'camila.rojas@email.com', 'Av. Millán 321, Rancagua'),
('89.012.345-6', 'Fernando', 'López Silva', '1992-08-14', '+56989012345', 'fernando.lopez@email.com', 'Los Plátanos 654, Rancagua'),
('90.123.456-7', 'Daniela', 'Mora Martínez', '1980-11-03', '+56990123456', 'daniela.mora@email.com', 'Paseo Estación 987, Rancagua'),
('01.234.567-8', 'Ricardo', 'Soto Fuentes', '1972-06-19', '+56901234567', 'ricardo.soto@email.com', 'Bueras 111, Rancagua'),
('11.222.333-4', 'Valentina', 'Díaz Rojas', '1993-02-28', '+56911222333', 'valentina.diaz@email.com', 'Libertador 222, Rancagua'),
('22.333.444-5', 'Javier', 'Pérez Mendoza', '1987-09-15', '+56922333444', 'javier.perez@email.com', 'Aromos 333, Rancagua'),
('33.444.555-6', 'Carolina', 'Gómez Silva', '1979-12-07', '+56933444555', 'carolina.gomez@email.com', 'Independencia 444, Rancagua'),
('44.555.666-7', 'Miguel', 'Herrera López', '1984-03-22', '+56944555666', 'miguel.herrera@email.com', 'Bueras 555, Rancagua'),
('55.666.777-8', 'Paula', 'Torres Díaz', '1991-07-11', '+56955666777', 'paula.torres@email.com', 'Plaza 666, Rancagua'),
('66.777.888-9', 'Alejandro', 'Castro Rojas', '1976-10-30', '+56966777888', 'alejandro.castro@email.com', 'San Martín 777, Rancagua'),
('77.888.999-0', 'Natalia', 'Vega Martínez', '1989-05-18', '+56977888999', 'natalia.vega@email.com', 'Millán 888, Rancagua'),
('88.999.000-1', 'Sebastián', 'Ruiz González', '1983-01-25', '+56988999000', 'sebastian.ruiz@email.com', 'Plátanos 999, Rancagua'),
('99.000.111-2', 'Gabriela', 'Flores Silva', '1994-08-08', '+56999000111', 'gabriela.flores@email.com', 'Estación 111, Rancagua'),
('00.111.222-3', 'Diego', 'Ramírez Fuentes', '1981-04-12', '+56900111222', 'diego.ramirez@email.com', 'Bueras 222, Rancagua'),
('11.222.333-9', 'Constanza', 'Navarro Díaz', '1977-11-05', '+56911222339', 'constanza.navarro@email.com', 'Libertador 333, Rancagua'),
('22.333.444-0', 'Francisco', 'Ortega Rojas', '1996-06-28', '+56922333440', 'francisco.ortega@email.com', 'Aromos 444, Rancagua'),
('33.444.555-1', 'Marcela', 'Pizarro Silva', '1986-02-14', '+56933444551', 'marcela.pizarro@email.com', 'Independencia 555, Rancagua'),
('44.555.666-2', 'Héctor', 'Salazar López', '1974-09-09', '+56944555662', 'hector.salazar@email.com', 'Bueras 666, Rancagua'),
('55.666.777-3', 'Verónica', 'Miranda Díaz', '1990-12-23', '+56955666773', 'veronica.miranda@email.com', 'Plaza 777, Rancagua'),
('66.777.888-4', 'Rodrigo', 'Araya Rojas', '1988-03-17', '+56966777884', 'rodrigo.araya@email.com', 'San Martín 888, Rancagua'),
('77.888.999-5', 'Sofía', 'Contreras Martínez', '1982-07-04', '+56977888995', 'sofia.contreras@email.com', 'Millán 999, Rancagua'),
('88.999.000-6', 'Mauricio', 'Bustos González', '1979-10-19', '+56988999006', 'mauricio.bustos@email.com', 'Plátanos 111, Rancagua'),
('99.000.111-7', 'Elena', 'Tapia Silva', '1995-01-31', '+56999000117', 'elena.tapia@email.com', 'Estación 222, Rancagua'),
('00.111.222-8', 'Arturo', 'Parra Fuentes', '1980-08-26', '+56900111228', 'arturo.parra@email.com', 'Bueras 333, Rancagua'),
('11.111.111-1', 'Ana', 'Test Pérez','2003-03-12 ','+56911111111', 'ana.test@email.com','Bueras 333, Rancagua');

-- Insertar citas FUTURAS para los próximos 7 días
INSERT INTO Citas (id_paciente, id_odontologo, fecha_hora, estado, tipo_consulta) VALUES
-- Día 1 (mañana)
(1, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL '09:00' HOUR_MINUTE, 'agendada', 'Limpieza dental'),
(2, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL '10:00' HOUR_MINUTE, 'agendada', 'Consulta general'),
(3, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL '11:00' HOUR_MINUTE, 'agendada', 'Control'),
(4, 1, DATE_ADD(CURDATE(), INTERVAL 1 DAY) + INTERVAL '12:00' HOUR_MINUTE, 'agendada', 'Obturación'),

-- Día 2
(5, 1, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL '09:00' HOUR_MINUTE, 'agendada', 'Extracción'),
(6, 1, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL '10:00' HOUR_MINUTE, 'agendada', 'Tratamiento conducto'),
(7, 1, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL '11:00' HOUR_MINUTE, 'agendada', 'Limpieza dental'),
(8, 1, DATE_ADD(CURDATE(), INTERVAL 2 DAY) + INTERVAL '16:00' HOUR_MINUTE, 'agendada', 'Consulta general'),

-- Día 3
(9, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL '09:30' HOUR_MINUTE, 'agendada', 'Control'),
(10, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL '10:30' HOUR_MINUTE, 'agendada', 'Obturación'),
(11, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL '11:30' HOUR_MINUTE, 'agendada', 'Extracción'),
(12, 1, DATE_ADD(CURDATE(), INTERVAL 3 DAY) + INTERVAL '16:30' HOUR_MINUTE, 'agendada', 'Tratamiento conducto'),

-- Día 4
(13, 1, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL '09:00' HOUR_MINUTE, 'agendada', 'Limpieza dental'),
(14, 1, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL '10:00' HOUR_MINUTE, 'agendada', 'Consulta general'),
(15, 1, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL '11:00' HOUR_MINUTE, 'agendada', 'Control'),
(16, 1, DATE_ADD(CURDATE(), INTERVAL 4 DAY) + INTERVAL '12:00' HOUR_MINUTE, 'agendada', 'Obturación'),

-- Día 5
(17, 1, DATE_ADD(CURDATE(), INTERVAL 5 DAY) + INTERVAL '09:00' HOUR_MINUTE, 'agendada', 'Extracción'),
(18, 1, DATE_ADD(CURDATE(), INTERVAL 5 DAY) + INTERVAL '10:00' HOUR_MINUTE, 'agendada', 'Tratamiento conducto'),
(19, 1, DATE_ADD(CURDATE(), INTERVAL 5 DAY) + INTERVAL '11:00' HOUR_MINUTE, 'agendada', 'Limpieza dental'),
(20, 1, DATE_ADD(CURDATE(), INTERVAL 5 DAY) + INTERVAL '16:00' HOUR_MINUTE, 'agendada', 'Consulta general'),

-- Día 6
(21, 1, DATE_ADD(CURDATE(), INTERVAL 6 DAY) + INTERVAL '09:30' HOUR_MINUTE, 'agendada', 'Control'),
(22, 1, DATE_ADD(CURDATE(), INTERVAL 6 DAY) + INTERVAL '10:30' HOUR_MINUTE, 'agendada', 'Obturación'),
(23, 1, DATE_ADD(CURDATE(), INTERVAL 6 DAY) + INTERVAL '11:30' HOUR_MINUTE, 'agendada', 'Extracción'),
(24, 1, DATE_ADD(CURDATE(), INTERVAL 6 DAY) + INTERVAL '16:30' HOUR_MINUTE, 'agendada', 'Tratamiento conducto'),

-- Día 7
(25, 1, DATE_ADD(CURDATE(), INTERVAL 7 DAY) + INTERVAL '09:00' HOUR_MINUTE, 'agendada', 'Limpieza dental'),
(26, 1, DATE_ADD(CURDATE(), INTERVAL 7 DAY) + INTERVAL '10:00' HOUR_MINUTE, 'agendada', 'Consulta general'),
(27, 1, DATE_ADD(CURDATE(), INTERVAL 7 DAY) + INTERVAL '11:00' HOUR_MINUTE, 'agendada', 'Control'),
(28, 1, DATE_ADD(CURDATE(), INTERVAL 7 DAY) + INTERVAL '12:00' HOUR_MINUTE, 'agendada', 'Obturación');

INSERT INTO Servicios (id_cita, tipo_servicio, descripcion, costo) VALUES
(1, 'limpieza', 'Limpieza dental completa y profilaxis', 35000),
(2, 'consulta', 'Consulta general y diagnóstico', 25000),
(3, 'control', 'Control post-tratamiento', 15000),
(4, 'obturacion', 'Obturación composite en molar', 45000),
(5, 'exodoncia', 'Extracción de cordal inferior', 60000),
(6, 'tratamiento', 'Tratamiento de conducto en premolar', 120000),
(7, 'limpieza', 'Limpieza dental completa', 35000),
(8, 'consulta', 'Consulta de urgencia', 30000),
(9, 'control', 'Control rutinario', 15000),
(10, 'obturacion', 'Obturación en diente anterior', 40000),
(11, 'exodoncia', 'Extracción simple', 55000),
(12, 'tratamiento', 'Tratamiento de conducto', 120000),
(13, 'limpieza', 'Limpieza y pulido dental', 35000),
(14, 'consulta', 'Consulta general', 25000),
(15, 'control', 'Control de ortodoncia', 20000),
(16, 'obturacion', 'Obturación profunda', 50000),
(17, 'exodoncia', 'Extracción quirúrgica', 80000),
(18, 'tratamiento', 'Tratamiento endodóntico', 130000),
(19, 'limpieza', 'Profilaxis dental', 35000),
(20, 'consulta', 'Segunda opinión', 28000),
(21, 'control', 'Control post-operatorio', 15000),
(22, 'obturacion', 'Obturación con resina', 45000),
(23, 'exodoncia', 'Extracción de molar', 65000),
(24, 'tratamiento', 'Tratamiento de conducto complejo', 140000),
(25, 'limpieza', 'Limpieza dental completa', 35000),
(26, 'consulta', 'Consulta inicial', 25000),
(27, 'control', 'Control periódico', 15000),
(28, 'obturacion', 'Obturación multiple', 60000);

INSERT INTO Fichas_Clinicas (id_paciente, antecedentes_medicos, alergias, medicamentos_actuales) VALUES
(1, 'Hipertensión controlada', 'Penicilina', 'Enalapril 10mg'),
(2, 'Diabetes tipo 2', 'Ninguna', 'Metformina 500mg'),
(3, 'Asma leve', 'Ácaros', 'Salbutamol según necesidad'),
(4, 'Ninguno', 'Ninguna', 'Ninguno'),
(5, 'Hipotiroidismo', 'Yodo', 'Levotiroxina 50mcg'),
(6, 'Ninguno', 'Mariscos', 'Ninguno'),
(7, 'Ninguno', 'Ninguna', 'Ninguno'),
(8, 'Hipertensión', 'Ninguna', 'Losartán 50mg'),
(9, 'Ninguno', 'Polvo', 'Ninguno'),
(10, 'Diabetes tipo 1', 'Ninguna', 'Insulina'),
(11, 'Ninguno', 'Ninguna', 'Ninguno'),
(12, 'Arritmia cardíaca', 'Ninguna', 'Digoxina'),
(13, 'Ninguno', 'Látex', 'Ninguno'),
(14, 'Ninguno', 'Ninguna', 'Ninguno'),
(15, 'Epilepsia', 'Ninguna', 'Carbamazepina'),
(16, 'Ninguno', 'Ninguna', 'Ninguno'),
(17, 'Ninguno', 'Aspirina', 'Ninguno'),
(18, 'Ninguno', 'Ninguna', 'Ninguno'),
(19, 'Ninguno', 'Polen', 'Antihistamínicos'),
(20, 'Ninguno', 'Ninguna', 'Ninguno'),
(21, 'Ninguno', 'Ninguna', 'Ninguno'),
(22, 'Ninguno', 'Metales', 'Ninguno'),
(23, 'Ninguno', 'Ninguna', 'Ninguno'),
(24, 'Ninguno', 'Ninguna', 'Ninguno'),
(25, 'Ninguno', 'Frutos secos', 'Ninguno'),
(26, 'Ninguno', 'Ninguna', 'Ninguno'),
(27, 'Ninguno', 'Ninguna', 'Ninguno'),
(28, 'Ninguno', 'Ninguna', 'Ninguno'),
(29, 'Ninguno', 'Ninguna', 'Ninguno'),
(30, 'Ninguno', 'Ninguna', 'Ninguno');

INSERT INTO Inventario (nombre_insumo, descripcion, categoria, stock_actual, stock_minimo, unidad_medida, precio_unitario) VALUES
('Anestesia Lidocaína', 'Anestésico local', 'medicamento', 50, 10, 'ampollas', 1500),
('Guantes Latex', 'Guantes estériles talla M', 'material_consumible', 200, 50, 'unidades', 250),
('Jeringas Carpule', 'Jeringas para anestesia', 'material_consumible', 100, 20, 'unidades', 800),
('Resina composite', 'Resina para obturaciones', 'material_consumible', 30, 10, 'kit', 25000),
('Agujas 30G', 'Agujas para anestesia', 'material_consumible', 150, 30, 'unidades', 300),
('Gasas Estériles', 'Gasas 5x5 cm estériles', 'material_consumible', 500, 100, 'unidades', 50);

INSERT INTO Consumos_Insumos (id_insumo, id_cita, cantidad_utilizada) VALUES
(1, 1, 1), (2, 1, 2), (3, 1, 1),
(1, 2, 1), (2, 2, 1),
(1, 4, 2), (2, 4, 2), (4, 4, 1),
(1, 5, 2), (2, 5, 2), (3, 5, 1),
(1, 6, 3), (2, 6, 3), (3, 6, 2),
(1, 7, 1), (2, 7, 2), (3, 7, 1),
(1, 10, 2), (2, 10, 2), (4, 10, 1),
(1, 11, 2), (2, 11, 2), (3, 11, 1),
(1, 16, 2), (2, 16, 2), (4, 16, 1),
(1, 18, 3), (2, 18, 3), (3, 18, 2),
(1, 22, 2), (2, 22, 2), (4, 22, 1),
(1, 23, 2), (2, 23, 2), (3, 23, 1),
(1, 24, 3), (2, 24, 3), (3, 24, 2),
(1, 28, 2), (2, 28, 2), (4, 28, 1);

INSERT INTO Recordatorios (id_cita, tipo_recordatorio, mensaje, fecha_envio, estado, respuesta_paciente) VALUES
(1, 'whatsapp', 'Recordatorio: Su cita dental está agendada para mañana a las 09:00 hrs.', DATE_SUB((SELECT fecha_hora FROM Citas WHERE id_cita = 1), INTERVAL 1 DAY), 'pendiente', NULL),
(2, 'whatsapp', 'Recordatorio: Su cita dental está agendada para mañana a las 10:00 hrs.', DATE_SUB((SELECT fecha_hora FROM Citas WHERE id_cita = 2), INTERVAL 1 DAY), 'pendiente', NULL),
(3, 'sms', 'Recordatorio: Su cita dental está agendada para mañana a las 11:00 hrs.', DATE_SUB((SELECT fecha_hora FROM Citas WHERE id_cita = 3), INTERVAL 1 DAY), 'pendiente', NULL),
(4, 'whatsapp', 'Recordatorio: Su cita dental está agendada para mañana a las 12:00 hrs.', DATE_SUB((SELECT fecha_hora FROM Citas WHERE id_cita = 4), INTERVAL 1 DAY), 'pendiente', NULL),
(5, 'sms', 'Recordatorio: Su cita dental está agendada para mañana a las 16:00 hrs.', DATE_SUB((SELECT fecha_hora FROM Citas WHERE id_cita = 5), INTERVAL 1 DAY), 'pendiente', NULL),
(6, 'whatsapp', 'Recordatorio: Su cita dental está agendada para mañana a las 17:00 hrs.', DATE_SUB((SELECT fecha_hora FROM Citas WHERE id_cita = 6), INTERVAL 1 DAY), 'pendiente', NULL);

INSERT INTO Indicadores (fecha, id_odontologo, total_citas_agendadas, total_citas_completadas, total_inasistencias, tasa_ocupacion) VALUES
(DATE_SUB(CURDATE(), INTERVAL 7 DAY), 1, 6, 6, 0, 85.00),
(DATE_SUB(CURDATE(), INTERVAL 6 DAY), 1, 5, 5, 0, 80.00),
(DATE_SUB(CURDATE(), INTERVAL 5 DAY), 1, 6, 5, 1, 75.00),
(DATE_SUB(CURDATE(), INTERVAL 4 DAY), 1, 5, 5, 0, 83.00),
(DATE_SUB(CURDATE(), INTERVAL 3 DAY), 1, 6, 4, 2, 70.00),
(DATE_SUB(CURDATE(), INTERVAL 2 DAY), 1, 2, 2, 0, 90.00);

DELIMITER //

CREATE PROCEDURE sp_autenticar_paciente_web(
    IN p_rut VARCHAR(12),
    OUT p_token VARCHAR(100),
    OUT p_resultado VARCHAR(200)
)
BEGIN
    DECLARE v_id_paciente INT;
    DECLARE v_nombre_completo VARCHAR(200);
    DECLARE v_token VARCHAR(100);
    
    -- Buscar paciente por RUT
    SELECT id_paciente, CONCAT(nombre, ' ', apellido) 
    INTO v_id_paciente, v_nombre_completo
    FROM Pacientes 
    WHERE rut = p_rut AND activo = 1;
    
    IF v_id_paciente IS NOT NULL THEN
        -- Generar token único
        SET v_token = SHA2(CONCAT(p_rut, NOW(), RAND()), 256);
        
        -- Insertar sesión (válida por 24 horas)
        INSERT INTO Sesiones_Pacientes (id_paciente, token_sesion, fecha_expiracion)
        VALUES (v_id_paciente, v_token, DATE_ADD(NOW(), INTERVAL 24 HOUR));
        
        SET p_token = v_token;
        SET p_resultado = CONCAT('AUTENTICACION_EXITOSA:', v_nombre_completo);
    ELSE
        SET p_token = NULL;
        SET p_resultado = 'RUT_NO_ENCONTRADO';
    END IF;
END//

CREATE PROCEDURE sp_get_citas_paciente(
    IN p_id_paciente INT
)
BEGIN
    SELECT 
        c.id_cita,
        c.fecha_hora,
        c.estado,
        c.tipo_consulta,
        s.costo,
        o.nombre as nombre_odontologo
    FROM Citas c
    LEFT JOIN Servicios s ON c.id_cita = s.id_cita
    LEFT JOIN Odontologos o ON c.id_odontologo = o.id_odontologo
    WHERE c.id_paciente = p_id_paciente
    AND c.fecha_hora >= CURDATE()
    ORDER BY c.fecha_hora ASC;
END//

CREATE PROCEDURE sp_confirmar_cita(
    IN p_id_cita INT,
    IN p_id_paciente INT,
    OUT p_resultado VARCHAR(100)
)
BEGIN
    DECLARE v_count INT;
    
    -- Verificar que la cita pertenece al paciente
    SELECT COUNT(*) INTO v_count
    FROM Citas 
    WHERE id_cita = p_id_cita AND id_paciente = p_id_paciente;
    
    IF v_count > 0 THEN
        UPDATE Citas 
        SET estado = 'confirmada', fecha_confirmacion = NOW()
        WHERE id_cita = p_id_cita;
        
        SET p_resultado = 'CITA_CONFIRMADA';
    ELSE
        SET p_resultado = 'CITA_NO_ENCONTRADA';
    END IF;
END//

DELIMITER ;
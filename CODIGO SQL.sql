CREATE DATABASE IF NOT EXISTS CentroOdontologicoCorsa;
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

INSERT INTO Odontologos (nombre, especialidad, telefono, email) VALUES
('Dr. Juan Carlos Huerta Badilla', 'Odontología General', '+5672231612', 'dr.huerta@corsa.cl');

INSERT INTO Pacientes (rut, nombre, apellido, telefono) VALUES
('12.345.678-9', 'Ana', 'González Pérez', '+56912345678'),
('23.456.789-0', 'Carlos', 'Martínez Rojas', '+56923456789'),
('99.999.999-K', 'Paciente', 'Prueba', '+56900000000');

INSERT INTO Citas (id_paciente, id_odontologo, fecha_hora, estado, tipo_consulta) VALUES
(1, 1, '2025-11-20 10:00:00', 'agendada', 'Limpieza dental'),
(2, 1, '2025-11-20 11:00:00', 'agendada', 'Consulta general');
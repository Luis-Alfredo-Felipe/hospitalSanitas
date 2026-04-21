/******* 1. DB Creación del Contenedor Principal *********/
CREATE DATABASE IF NOT EXISTS Hospital_Sanitas;
USE Hospital_Sanitas;

/******* 2. Tabla de Catálogo: Prioridades (Triaje) *******/
CREATE TABLE prioridades (
    id_prioridad INT PRIMARY KEY,
    nivel VARCHAR(50) NOT NULL, /***** Ej: Rojo (Inmediato) *****/
    tiempo_max_espera INT NOT NULL /*****  En minutos *****/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/******* 3. Tabla de Entidad: Pacientes *******/
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    dpi_cedula VARCHAR(20) UNIQUE, 
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    es_anonimo BOOLEAN DEFAULT FALSE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/******* 4. Tabla de Entidad: Médicos *******/
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    especialidad VARCHAR(50),
    estado VARCHAR(20) DEFAULT 'DISPONIBLE' /******* DISPONIBLE, OCUPADO, AUSENTE *******/
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/******* 5. Tabla de Transacción: Atenciones *******/
CREATE TABLE atenciones (
    id_atencion INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_prioridad INT NOT NULL,
    id_medico INT DEFAULT NULL, /***** NULL mientras está en cola de espera *****/
    motivo_emergencia TEXT,
    estado_atencion VARCHAR(20) DEFAULT 'ESPERA', /***** ESPERA, EN_ATENCION, FINALIZADO *****/
    fecha_ingreso DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_cierre DATETIME DEFAULT NULL,
    
/******* Relaciones e Integridad *******/
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente) ON DELETE CASCADE,
    FOREIGN KEY (id_prioridad) REFERENCES prioridades(id_prioridad),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/******* 6. Carga de Datos Iniciales (Indispensable para el Triaje) *******/
INSERT INTO prioridades (id_prioridad, nivel, tiempo_max_espera) VALUES
(1, 'Rojo (Resucitación)', 0),
(2, 'Naranja (Emergencia)', 15),
(3, 'Amarillo (Urgencia)', 60),
(4, 'Verde (Urgencia Menor)', 120),
(5, 'Azul (Sin Urgencia)', 240);
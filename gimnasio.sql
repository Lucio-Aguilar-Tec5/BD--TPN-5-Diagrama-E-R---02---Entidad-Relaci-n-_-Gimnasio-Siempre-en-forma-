SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

CREATE TABLE `aparatos` (
  `id_aparato` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `estado_conservacion` enum('bueno','regular','malo') NOT NULL,
  `id_sala` int(11) NOT NULL,
  `id_tipo_aparato` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `asistenciaclase` (
  `id_asistencia` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `id_clase` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


CREATE TABLE `clases` (
  `id_clase` int(11) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `dia_hora` datetime NOT NULL,
  `id_sala` int(11) NOT NULL,
  `dni_monitor` int(11) NOT NULL,
  `capacidad_maxima` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `monitor` (
  `dni` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `telefono` int(11) NOT NULL,
  `titulacion` tinyint(1) NOT NULL,
  `experiencia_profesional` varchar(255) NOT NULL,
  `especialidad` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pago` (
  `id_pago` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `fecha` date NOT NULL,
  `monto` decimal(10,0) NOT NULL,
  `metodo_pago` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `pistasquash` (
  `id_pista` int(11) NOT NULL,
  `estado` enum('disponible','ocupada','mentinimiento') NOT NULL,
  `id_sala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `reserva` (
  `id_reserva` int(11) NOT NULL,
  `id_socio` int(11) NOT NULL,
  `id_pista` int(11) NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `duracion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `salas` (
  `id_sala` int(11) NOT NULL,
  `metros_cuadrados` decimal(10,0) NOT NULL,
  `ubicacion` varchar(50) NOT NULL,
  `tipo_sala` enum('cardio','general','muscular','squash') NOT NULL,
  `tiene_aparato` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `socio` (
  `id_socio` int(11) NOT NULL,
  `nombre` text NOT NULL,
  `direccion` varchar(30) NOT NULL,
  `telefono` int(11) NOT NULL,
  `profesion` text NOT NULL,
  `datos_bancarios` varchar(155) NOT NULL,
  `fecha_alta` date NOT NULL,
  `estado` enum('activo','inactivo') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `tipoaparatos` (
  `id_tipo_aparato` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `descripcion` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

ALTER TABLE `aparatos`
  ADD PRIMARY KEY (`id_aparato`),
  ADD KEY `aparatos_id_sala_salas_id_sala` (`id_sala`),
  ADD KEY `aparatos_id_tipo_aparato_TipoAparatos_id_tipo_aparato` (`id_tipo_aparato`);

ALTER TABLE `asistenciaclase`
  ADD PRIMARY KEY (`id_asistencia`),
  ADD KEY `AsistenciaClase_id_socio_socio_id_socio` (`id_socio`),
  ADD KEY `AsistenciaClase_id_clase_clases_id_clase` (`id_clase`);


ALTER TABLE `clases`
  ADD PRIMARY KEY (`id_clase`),
  ADD KEY `clases_id_sala_salas_id_sala` (`id_sala`),
  ADD KEY `clases_dni_monitor_monitor_dni` (`dni_monitor`);


ALTER TABLE `monitor`
  ADD PRIMARY KEY (`dni`);

ALTER TABLE `pago`
  ADD PRIMARY KEY (`id_pago`),
  ADD KEY `pago_id_socio_socio_id_socio` (`id_socio`);

ALTER TABLE `pistasquash`
  ADD PRIMARY KEY (`id_pista`),
  ADD KEY `PistaSquash_id_sala_salas_id_sala` (`id_sala`);

ALTER TABLE `reserva`
  ADD PRIMARY KEY (`id_reserva`),
  ADD KEY `reserva_id_socio_socio_id_socio` (`id_socio`),
  ADD KEY `reserva_id_pista_salas_id_sala` (`id_pista`);

ALTER TABLE `salas`
  ADD PRIMARY KEY (`id_sala`);

ALTER TABLE `socio`
  ADD PRIMARY KEY (`id_socio`);

ALTER TABLE `tipoaparatos`
  ADD PRIMARY KEY (`id_tipo_aparato`);

ALTER TABLE `aparatos`
  ADD CONSTRAINT `aparatos_id_sala_salas_id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`),
  ADD CONSTRAINT `aparatos_id_tipo_aparato_TipoAparatos_id_tipo_aparato` FOREIGN KEY (`id_tipo_aparato`) REFERENCES `tipoaparatos` (`id_tipo_aparato`);

ALTER TABLE `asistenciaclase`
  ADD CONSTRAINT `AsistenciaClase_id_clase_clases_id_clase` FOREIGN KEY (`id_clase`) REFERENCES `clases` (`id_clase`),
  ADD CONSTRAINT `AsistenciaClase_id_socio_socio_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);

ALTER TABLE `clases`
  ADD CONSTRAINT `clases_dni_monitor_monitor_dni` FOREIGN KEY (`dni_monitor`) REFERENCES `monitor` (`dni`),
  ADD CONSTRAINT `clases_id_sala_salas_id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`);

ALTER TABLE `pago`
  ADD CONSTRAINT `pago_id_socio_socio_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);

ALTER TABLE `pistasquash`
  ADD CONSTRAINT `PistaSquash_id_sala_salas_id_sala` FOREIGN KEY (`id_sala`) REFERENCES `salas` (`id_sala`);

ALTER TABLE `reserva`
  ADD CONSTRAINT `reserva_id_pista_salas_id_sala` FOREIGN KEY (`id_pista`) REFERENCES `salas` (`id_sala`),
  ADD CONSTRAINT `reserva_id_socio_socio_id_socio` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`);
COMMIT;
-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 05-03-2026 a las 16:53:47
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_libro` (`id` INT)   BEGIN
	DELETE FROM libro
    WHERE codigo_libro = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_act_tel_dir` (`id` INT, `telefono` INT(10), `direccion` VARCHAR(255))   BEGIN	
    UPDATE socio SET id_socio=id,telefono_socio=telefono,direccion_socio=direccion
    WHERE id_socio=id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_insertarSocio` (`id` INT, `nombre` VARCHAR(45), `apellido` VARCHAR(45), `direccion` VARCHAR(255), `telefono` INT(10))   BEGIN
	INSERT INTO socio(id_socio, nombre_socio, apellido_socio, direccion_socio, telefono_socio) VALUES (id,nombre, apellido, direccion, telefono);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_librosPrestamos` ()   BEGIN
	SELECT s.nombre_socio As Nombre_Socio, p.codigo_libro AS Codigo_Libro FROM socio s
	INNER JOIN prestamo p ON s.id_socio=p.id_socio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_listaAutores` ()   SELECT codigo_autor, nombre_autor
FROM autor
ORDER BY nombre_autor DESC$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_nombre_libro` (IN `nombre` VARCHAR(50))   BEGIN
	SELECT titulo_libro FROM libro
	WHERE titulo_libro LIKE CONCAT('%',nombre,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_socio_prestamo` ()   BEGIN
	SELECT * FROM socio s
	LEFT JOIN prestamo p ON s.id_socio=p.id_socio;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_tipoAutor` (`variable` VARCHAR(20))   SELECT nombre_autor as 'Autor', tipoAutor
FROM autor a
INNER JOIN tipo_autor t
ON a.codigo_autor=t.codigo_autor
WHERE tipoAutor=variable$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inserta_libro` (`codigo` BIGINT(20), `titulo` VARCHAR(255), `genero` VARCHAR(20), `paginas` INT(11), `diaspres` TINYINT(4))   BEGIN
	INSERT INTO libro(codigo_libro,titulo_libro,genero_libro,numeroPaginas_libro,diasPrestados_libro)
	VALUES (codigo, titulo , genero, paginas , diaspres);
END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `contar_socio` () RETURNS INT(11) DETERMINISTIC BEGIN
	DECLARE contador INT;
    SELECT COUNT(id_socio) AS cantidad_socios INTO contador
    FROM socio;
    RETURN contador;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `dias_prestados` (`fecha_devolucion` DATE, `fecha_prestamo` DATE) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE dias_prestados INT;
    SET dias_prestados = DATEDIFF(fecha_devolucion, fecha_prestamo);
    RETURN dias_prestados;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_libro`
--

CREATE TABLE `audi_libro` (
  `id_audi` int(10) NOT NULL,
  `codigo_libro_audi` int(11) DEFAULT NULL,
  `titulo_libro_anterior` varchar(45) DEFAULT NULL,
  `genero_libro_anterior` varchar(45) DEFAULT NULL,
  `diasPrestados_libro_anterior` varchar(255) DEFAULT NULL,
  `numeroPaginas_libro_anterior` varchar(10) DEFAULT NULL,
  `titulo_libro_nuevo` varchar(45) DEFAULT NULL,
  `genero_libro_nuevo` varchar(45) DEFAULT NULL,
  `diasPrestados_libro_nuevo` varchar(255) DEFAULT NULL,
  `numeroPaginas_libro_nuevo` varchar(10) DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(10) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_libro`
--

INSERT INTO `audi_libro` (`id_audi`, `codigo_libro_audi`, `titulo_libro_anterior`, `genero_libro_anterior`, `diasPrestados_libro_anterior`, `numeroPaginas_libro_anterior`, `titulo_libro_nuevo`, `genero_libro_nuevo`, `diasPrestados_libro_nuevo`, `numeroPaginas_libro_nuevo`, `audi_fechaModificacion`, `audi_usuario`, `audi_accion`) VALUES
(1, 5646, NULL, NULL, NULL, NULL, 'Caperucita Roja', 'Aventura', '20', '500', '2026-03-05 10:19:57', 'root@local', 'Libro insertado'),
(2, 5646, 'Caperucita Roja', 'Aventura', '20', '500', 'Caperucita Roja 2', 'Aventura', '20', '520', '2026-03-05 10:24:05', 'root@local', 'Actualización');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `audi_socio`
--

CREATE TABLE `audi_socio` (
  `id_audi` int(10) NOT NULL,
  `id_socio_audi` int(11) DEFAULT NULL,
  `nombre_socio_anterior` varchar(45) DEFAULT NULL,
  `apellido_socio_anterior` varchar(45) DEFAULT NULL,
  `direccion_socio_anterior` varchar(255) DEFAULT NULL,
  `telefono_socio_anterior` varchar(10) DEFAULT NULL,
  `nombre_socio_nuevo` varchar(45) DEFAULT NULL,
  `apellido_socio_nuevo` varchar(45) DEFAULT NULL,
  `direccion_socio_nuevo` varchar(255) DEFAULT NULL,
  `telefono_socio_nuevo` varchar(10) DEFAULT NULL,
  `audi_fechaModificacion` datetime DEFAULT NULL,
  `audi_usuario` varchar(10) DEFAULT NULL,
  `audi_accion` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `audi_socio`
--

INSERT INTO `audi_socio` (`id_audi`, `id_socio_audi`, `nombre_socio_anterior`, `apellido_socio_anterior`, `direccion_socio_anterior`, `telefono_socio_anterior`, `nombre_socio_nuevo`, `apellido_socio_nuevo`, `direccion_socio_nuevo`, `telefono_socio_nuevo`, `audi_fechaModificacion`, `audi_usuario`, `audi_accion`) VALUES
(3, 3, 'Juan', 'González', 'Calle 30 #52 sur - 35A', '1111111111', 'Juan', 'González', 'Calle 30 #52 sur - 35A', '3215445574', '2026-03-05 09:13:29', 'root@local', 'Actualización'),
(4, 17, NULL, NULL, NULL, NULL, 'Daniel', 'Medina', 'calle 7', '46549848', '2026-03-05 09:46:22', 'root@local', 'Datos Insertados');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `autor`
--

CREATE TABLE `autor` (
  `codigo_autor` int(11) NOT NULL,
  `nombre_autor` varchar(45) NOT NULL,
  `nacimiento_autor` date NOT NULL,
  `muerte_autor` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `autor`
--

INSERT INTO `autor` (`codigo_autor`, `nombre_autor`, `nacimiento_autor`, `muerte_autor`) VALUES
(98, 'Smith', '1974-12-21', '2018-07-21'),
(123, 'Taylor', '1980-04-15', '0000-00-00'),
(234, 'Medina', '1977-06-21', '2005-09-12'),
(345, 'Wilson', '1975-08-29', '0000-00-00'),
(432, 'Miller', '1981-10-26', '0000-00-00'),
(456, 'García', '1978-09-27', '2021-12-09'),
(567, 'Davis', '1983-03-04', '2010-03-28'),
(678, 'Silva', '1986-02-02', '0000-00-00'),
(765, 'López', '1976-07-08', '2025-02-23'),
(789, 'Rodríguez', '1985-12-10', '0000-00-00'),
(890, 'Brown', '1982-11-17', '0000-00-00'),
(901, 'Soto', '1979-05-13', '2015-11-05');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `codigo_libro` bigint(20) NOT NULL,
  `titulo_libro` varchar(50) NOT NULL,
  `genero_libro` varchar(20) NOT NULL,
  `numeroPaginas_libro` int(11) NOT NULL,
  `diasPrestados_libro` tinyint(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`codigo_libro`, `titulo_libro`, `genero_libro`, `numeroPaginas_libro`, `diasPrestados_libro`) VALUES
(5646, 'Caperucita Roja 2', 'Aventura', 520, 20),
(1234567890, 'El Sueño de los Susurros', 'novela', 275, 7),
(1357924680, 'El Jardín de las Mariposas Perdidas', 'novela', 536, 7),
(2468135790, 'La Melodía de la Oscuridad', 'romance', 189, 7),
(2718281828, 'El Bosque de los Suspiros', 'novela', 387, 2),
(3141592653, 'El Secreto de las Estrellas Olvidadas', 'Misterio', 203, 7),
(5555555555, 'La Última Llave del Destino', 'cuento', 503, 7),
(7777777777, 'El Misterio de la Luna Plateada', 'Misterio', 422, 7),
(8642097531, 'El Reloj de Arena Infinito', 'novela', 321, 7),
(8888888888, 'La Ciudad de los Susurros', 'Misterio', 274, 1),
(9517530862, 'Las Crónicas del Eco Silencioso', 'fantasía', 448, 7),
(9876543210, 'El Laberinto de los Recuerdos', 'cuento', 412, 7),
(9999999999, 'El Enigma de los Espejos Rotos', 'romance', 156, 7),
(9788426721006, 'sql', 'ingenieria', 384, 15);

--
-- Disparadores `libro`
--
DELIMITER $$
CREATE TRIGGER `Eliminar_libro` BEFORE DELETE ON `libro` FOR EACH ROW BEGIN

INSERT INTO audi_libro(
    codigo_libro_audi ,
    titulo_libro_anterior ,
    genero_libro_anterior ,
    diasPrestados_libro_anterior ,
    numeroPaginas_libro_anterior ,
    audi_fechaModificacion,
    audi_usuario ,
    audi_accion
)
VALUES (
    OLD.codigo_libro ,
    OLD.titulo_libro ,
    OLD.genero_libro ,
    OLD.diasPrestados_libro ,
    OLD.numeroPaginas_libro ,
    NOW(),
    CURRENT_USER(),
    'Libro Eliminado'
);

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insert_libro` BEFORE INSERT ON `libro` FOR EACH ROW BEGIN

INSERT INTO audi_libro(
    codigo_libro_audi,
    titulo_libro_nuevo,
    genero_libro_nuevo,
    diasPrestados_libro_nuevo,
    numeroPaginas_libro_nuevo,
    audi_fechaModificacion,
    audi_usuario,
    audi_accion
)
VALUES (
    NEW.codigo_libro,
    NEW.titulo_libro,
    NEW.genero_libro,
    NEW.diasPrestados_libro,
    NEW.numeroPaginas_libro,
    NOW(),
    CURRENT_USER(),
    'Libro insertado'
);

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `libro_before_update` BEFORE UPDATE ON `libro` FOR EACH ROW BEGIN

INSERT INTO audi_libro(
    codigo_libro_audi,
    titulo_libro_anterior,
    genero_libro_anterior,
    diasPrestados_libro_anterior,
    numeroPaginas_libro_anterior,
    titulo_libro_nuevo,
    genero_libro_nuevo,
    diasPrestados_libro_nuevo,
    numeroPaginas_libro_nuevo,
    audi_fechaModificacion,
    audi_usuario,
    audi_accion
)
VALUES(
    OLD.codigo_libro,
    OLD.titulo_libro,
    OLD.genero_libro,
    OLD.diasPrestados_libro,
    OLD.numeroPaginas_libro,
    NEW.titulo_libro,
    NEW.genero_libro,
    NEW.diasPrestados_libro,
    NEW.numeroPaginas_libro,
    NOW(),
    CURRENT_USER(),
    'Actualización'
);

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `id_prestamo` varchar(20) NOT NULL,
  `fechaPrestamo` date NOT NULL,
  `fechaDevolucion` date NOT NULL,
  `id_socio` int(11) NOT NULL,
  `codigo_libro` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`id_prestamo`, `fechaPrestamo`, `fechaDevolucion`, `id_socio`, `codigo_libro`) VALUES
('pres2', '2023-02-03', '2023-02-04', 2, 9999999999),
('pres3', '2023-04-09', '2023-04-11', 6, 2718281828),
('pres4', '2023-06-14', '2023-06-15', 9, 8888888888),
('pres5', '2023-07-02', '2023-07-09', 10, 5555555555),
('pres6', '2023-08-19', '2023-08-26', 12, 5555555555),
('pres7', '2023-10-24', '2023-10-27', 3, 1357924680);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `id_socio` int(11) NOT NULL,
  `nombre_socio` varchar(45) NOT NULL,
  `apellido_socio` varchar(45) NOT NULL,
  `direccion_socio` varchar(255) NOT NULL,
  `telefono_socio` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`id_socio`, `nombre_socio`, `apellido_socio`, `direccion_socio`, `telefono_socio`) VALUES
(2, 'Andrés Felipe', 'Galindo Luna', 'Avenida del Sol 456, Pueblo Nuevo, Madrid', '2123456789'),
(3, 'Juan', 'González', 'Calle 30 #52 sur - 35A', '3215445574'),
(5, 'Pedro', 'Martínez', 'Calle del Bosque 654, Los Pinos, Málaga', '1234567812'),
(6, 'Ana', 'López', 'Avenida Central 987, Villa Hermosa, Bilbao', '6123456781'),
(7, 'Carlos', 'Sánchez', 'Calle de la Luna 234, El Prado, Alicante', '1123456781'),
(8, 'Laura', 'Ramírez', 'Carrera del Mar 567, Playa Azul, Palma de Mallorca', '1312345678'),
(9, 'Luis', 'Hernández', 'Avenida de la Montaña 890, Monte Verde, Granada', '6101234567'),
(10, 'Andrea', 'García', 'Calle del Sol 432, La Colina, Zaragoza', '1112345678'),
(11, 'Alejandro', 'Torres', 'Carrera del Oeste 765, Ciudad Nueva, Murcia', '4951234567'),
(12, 'Sofía', 'Morales', 'Avenida del Mar 098, Costa Brava, Gijón', '5512345678'),
(13, 'Fabian', 'Paguana', 'Calle 30 # 60 sur 56', '2147483647'),
(17, 'Daniel', 'Medina', 'calle 7', '46549848');

--
-- Disparadores `socio`
--
DELIMITER $$
CREATE TRIGGER `insert_socio` BEFORE INSERT ON `socio` FOR EACH ROW BEGIN

INSERT INTO audi_socio(
    id_socio_audi,
    nombre_socio_nuevo,
    apellido_socio_nuevo,
    direccion_socio_nuevo,
    telefono_socio_nuevo,
    audi_fechaModificacion,
    audi_usuario,
    audi_accion
)
VALUES(
    NEW.id_socio,
    NEW.nombre_socio,
    NEW.apellido_socio,
    NEW.direccion_socio,
    NEW.telefono_socio,
    NOW(),
    CURRENT_USER(),
    'Datos Insertados'
);

END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `socio_after_delete` AFTER DELETE ON `socio` FOR EACH ROW SET FOREIGN_KEY_CHECKS = 0
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `socios_before_update` BEFORE UPDATE ON `socio` FOR EACH ROW BEGIN

INSERT INTO audi_socio(
    id_socio_audi,
    nombre_socio_anterior,
    apellido_socio_anterior,
    direccion_socio_anterior,
    telefono_socio_anterior,
    nombre_socio_nuevo,
    apellido_socio_nuevo,
    direccion_socio_nuevo,
    telefono_socio_nuevo,
    audi_fechaModificacion,
    audi_usuario,
    audi_accion
)
VALUES(
    OLD.id_socio,
    OLD.nombre_socio,
    OLD.apellido_socio,
    OLD.direccion_socio,
    OLD.telefono_socio,
    NEW.nombre_socio,
    NEW.apellido_socio,
    NEW.direccion_socio,
    NEW.telefono_socio,
    NOW(),
    CURRENT_USER(),
    'Actualización'
);

END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_autor`
--

CREATE TABLE `tipo_autor` (
  `codigo_libro` bigint(20) NOT NULL,
  `codigo_autor` int(11) NOT NULL,
  `tipoAutor` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `tipo_autor`
--

INSERT INTO `tipo_autor` (`codigo_libro`, `codigo_autor`, `tipoAutor`) VALUES
(1357924680, 123, 'Traductor'),
(1234567890, 123, 'Autor'),
(1234567890, 456, 'Coautor'),
(2718281828, 789, 'Traductor'),
(8888888888, 234, 'Autor'),
(2468135790, 234, 'Autor'),
(9876543210, 567, 'Autor'),
(1234567890, 890, 'Autor'),
(8642097531, 345, 'Autor'),
(8888888888, 345, 'Coautor'),
(5555555555, 678, 'Autor'),
(3141592653, 901, 'Autor'),
(9517530862, 432, 'Autor'),
(7777777777, 765, 'Autor'),
(9999999999, 98, 'Autor');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `audi_libro`
--
ALTER TABLE `audi_libro`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  ADD PRIMARY KEY (`id_audi`);

--
-- Indices de la tabla `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`codigo_autor`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`codigo_libro`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `id_socio` (`id_socio`),
  ADD KEY `codigo_libro` (`codigo_libro`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`id_socio`);

--
-- Indices de la tabla `tipo_autor`
--
ALTER TABLE `tipo_autor`
  ADD KEY `codigo_autor` (`codigo_autor`),
  ADD KEY `codigo_libro` (`codigo_libro`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `audi_libro`
--
ALTER TABLE `audi_libro`
  MODIFY `id_audi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `audi_socio`
--
ALTER TABLE `audi_socio`
  MODIFY `id_audi` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_ibfk_1` FOREIGN KEY (`id_socio`) REFERENCES `socio` (`id_socio`),
  ADD CONSTRAINT `prestamo_ibfk_2` FOREIGN KEY (`codigo_libro`) REFERENCES `libro` (`codigo_libro`);

--
-- Filtros para la tabla `tipo_autor`
--
ALTER TABLE `tipo_autor`
  ADD CONSTRAINT `tipo_autor_ibfk_1` FOREIGN KEY (`codigo_autor`) REFERENCES `autor` (`codigo_autor`),
  ADD CONSTRAINT `tipo_autor_ibfk_2` FOREIGN KEY (`codigo_libro`) REFERENCES `libro` (`codigo_libro`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

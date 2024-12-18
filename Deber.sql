create database deber;
use deber;
CREATE TABLE cliente (
    ClienteID INT AUTO_INCREMENT PRIMARY KEY,  -- Campo para el ID único del cliente
    Nombre VARCHAR(100),                      -- Campo para el nombre del cliente
    Estatura DECIMAL(5,2),                    -- Campo para la estatura del cliente con dos decimales
    FechaNacimiento DATE,                     -- Campo para la fecha de nacimiento del cliente
    Sueldo DECIMAL(10,2)                      -- Campo para el sueldo del cliente con dos decimales
);

INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo) VALUES
('Carlos López', 1.75, '1985-03-15', 25000.50),
('María Pérez', 1.68, '1990-07-22', 32000.00),
('Juan García', 1.82, '1978-11-12', 28000.75),
('Ana Torres', 1.60, '1995-05-30', 30000.00),
('Pedro Martínez', 1.90, '1988-01-18', 27000.25);

/*1. Procedimiento de Inserción (INSERT)*/
DELIMITER //

-- Crear el procedimiento de inserción
CREATE PROCEDURE InsertarCliente(
    IN p_Nombre VARCHAR(100),
    IN p_Estatura DECIMAL(5,2),
    IN p_FechaNacimiento DATE,
    IN p_Sueldo DECIMAL(10,2)
)
BEGIN
    INSERT INTO cliente (Nombre, Estatura, FechaNacimiento, Sueldo)
    VALUES (p_Nombre, p_Estatura, p_FechaNacimiento, p_Sueldo);
END;
//

DELIMITER ;
/*Llamar al Procedimiento para Insertar un Nuevo Cliente*/
CALL InsertarCliente('Luis Gómez', 1.80, '1992-06-14', 35000.00);
/*Verificar la Inserción*/
SELECT * FROM cliente;

/*2. Procedimiento de Actualización*/
DELIMITER //

-- Crear el procedimiento de actualización
CREATE PROCEDURE ActualizarCliente(
    IN p_ClienteID INT,           -- ID del cliente a actualizar
    IN p_Nombre VARCHAR(100),     -- Nuevo nombre
    IN p_Estatura DECIMAL(5,2),   -- Nueva estatura
    IN p_Sueldo DECIMAL(10,2)     -- Nuevo sueldo
)
BEGIN
    -- Actualizar los datos del cliente específico
    UPDATE cliente
    SET Nombre = p_Nombre,
        Estatura = p_Estatura,
        Sueldo = p_Sueldo
    WHERE ClienteID = p_ClienteID;
END;
//

DELIMITER ;

/*Llamar al Procedimiento para Actualizar un Cliente*/
CALL ActualizarCliente(2, 'María González', 1.70, 34000.00);

/*Verificar la Actualización*/
SELECT * FROM cliente;

/*3. Procedimiento de Eliminación (DELETE)
Eliminar un cliente de la base de datos usando su ClienteID:
*/
DELIMITER //

CREATE PROCEDURE EliminarCliente(
    IN p_ClienteID INT -- ID del cliente a eliminar
)
BEGIN
    DELETE FROM cliente
    WHERE ClienteID = p_ClienteID;
END;
//

DELIMITER ;

/*Llamar al procedimiento*/
CALL EliminarCliente(3);
/*Verificar*/
SELECT * FROM cliente;
 
 
 /*Ejemplo de procedimiento para la edad*/
 DELIMITER //

CREATE PROCEDURE VerificarEdadCliente(
    IN p_ClienteID INT
)
BEGIN
    DECLARE edad INT;
    -- Calcular la edad del cliente
    SELECT TIMESTAMPDIFF(YEAR, FechaNacimiento, CURDATE()) INTO edad
    FROM cliente
    WHERE ClienteID = p_ClienteID;

    -- Verificar si la edad es mayor o igual a 22
    IF edad >= 22 THEN
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', edad, ' años y es mayor o igual a 22.');
    ELSE
        SELECT CONCAT('El cliente con ID ', p_ClienteID, ' tiene ', edad, ' años y es menor a 22.');
    END IF;
END;
//

DELIMITER ;
CALL VerificarEdadCliente(2);
/*Tabla Ordenes*/
CREATE TABLE ordenes (
    OrdenID INT AUTO_INCREMENT PRIMARY KEY,      
    ClienteID INT,                                
    FechaOrden DATE,                              
    MontoTotal DECIMAL(10,2),                     
    FOREIGN KEY (ClienteID) REFERENCES cliente(ClienteID) 
);

DELIMITER //

CREATE PROCEDURE InsertarOrden(
    IN p_ClienteID INT,
    IN p_FechaOrden DATE,
    IN p_MontoTotal DECIMAL(10,2)
)
BEGIN
    INSERT INTO ordenes (ClienteID, FechaOrden, MontoTotal)
    VALUES (p_ClienteID, p_FechaOrden, p_MontoTotal);
END;
//

DELIMITER ;
CALL InsertarOrden(2, '2024-12-17', 500.00);

DELIMITER //

CREATE PROCEDURE ActualizarOrden(
    IN p_OrdenID INT,
    IN p_FechaOrden DATE,
    IN p_MontoTotal DECIMAL(10,2)
)
BEGIN
    UPDATE ordenes
    SET FechaOrden = p_FechaOrden,
        MontoTotal = p_MontoTotal
    WHERE OrdenID = p_OrdenID;
END;
//

DELIMITER ;
CALL ActualizarOrden(1, '2024-12-18', 600.00);


DELIMITER //

CREATE PROCEDURE EliminarOrden(
    IN p_OrdenID INT
)
BEGIN
    DELETE FROM ordenes
    WHERE OrdenID = p_OrdenID;
END;
//

DELIMITER ;
CALL EliminarOrden(1);



















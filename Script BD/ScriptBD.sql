/*============================================================
                        CREACION DE BD
============================================================*/
CREATE DATABASE BD_Farmacia;
USE BD_Farmacia;

/*CREACION DE TABLA CLIENTE*/
CREATE TABLE IF NOT EXISTS cliente(
    id_cliente CHAR(8) NOT NULL,
    nombres VARCHAR(80) NOT NULL,
    apellidos VARCHAR (80) NOT NULL,
    direccion VARCHAR(150),
    fecha_nacimiento DATE,
    telefono CHAR(9),
    email VARCHAR(25),
    PRIMARY KEY (id_cliente) 
) ENGINE=InnoDB;

/*CREACION DE TABLA CATERGORIA*/
CREATE TABLE IF NOT EXISTS categoria(
    id_categoria CHAR(3) NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100),
    PRIMARY KEY(id_categoria)
) ENGINE=InnoDB;

/*CREACTION DE TABLA FACTURA*/
CREATE TABLE IF NOT EXISTS factura(
    num_factura CHAR(5) NOT NULL,
    Id_cliente CHAR(8),
    fecha DATE,
    PRIMARY KEY (num_factura),
    FOREIGN KEY (Id_cliente) REFERENCES cliente (id_cliente)
) ENGINE=InnoDB;

/*CREACION DE TABLA PRODUCTO*/
CREATE TABLE IF NOT EXISTS producto(
    id_producto CHAR(4) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    precio DOUBLE,
    stock INT,
    id_categoria CHAR(3),
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
) ENGINE=InnoDB;

/*CREACION DE TABLA DETALLE*/
CREATE TABLE IF NOT EXISTS detalle(
    num_detalle CHAR(5) NOT NULL,
    id_factura CHAR(5) NOT NULL,
    id_producto CHAR(4),
    cantidad INT,
    PRIMARY KEY (num_detalle, id_factura),
    FOREIGN KEY (id_factura) REFERENCES factura (num_factura),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto)
) ENGINE=InnoDB;
/*============================================================
                    INSERCIÓN DE DATOS
============================================================*/

/*INSERCION EN TABLA CLIENTE*/
INSERT INTO cliente (id_cliente, nombres, apellidos, direccion,fecha_nacimiento, telefono, email) VALUES
(90453612, 'Sofia', 'Rodriguez', 'Calle Los Pinos #123, Urbanización Las Casuarinas, Arequipa', '1997-12-03', '998765432', 'srodriguez@gmail.com'),
(23657849, 'Alejandro', 'Hernandez', 'Avenida Dolores #456, Urbanización Los Cedros, Yanahuara, Arequipa', '1995-06-21', '995678521', 'ahernandez@hotmail.com'),
(75891236, 'Valeria', 'Castro', 'Calle Francisco Bolognesi #678, Urbanización Las Condes, Sachaca, Arequipa', '1999-09-05', '954221345', 'vcastro@gmail.com'),
(12345678, 'David', 'Garcia', 'Calle Mariscal Castilla #210, Distrito De Challapampa, Arequipa', '2000-11-17', '994536187', 'dgarcia@hotmail.com'),
(89765432, 'Paula', 'Martinez', 'Avenida Ejercito #1234, Urbanización Vila Real, Cayma, Arequipa', '2002-04-02', '958765432', 'pmartinez@hotmail.com'),
(65412789, 'Juan', 'Gonzalez', 'Calle Lima #567, Urbanización San Lazaro, Arequipa', '1996-08-28', '948765212', 'jgonzalez@gmail.com'),
(43219876, 'Natalia', 'Diaz', 'Avenida Andres Avelino Caceres #890, Distrito De Hunter, Arequipa', '1998-02-14', '955678123', 'ndiaz@hotmail.com'),
(56473829, 'Alonso', 'Hernandez', 'Calle Avenida De La Cultura #456, Urbanización Las Vizcachas, Arequipa', '2001-05-30', '948635184', 'ahernandez@gmail.com'),
(21897543, 'Karla', 'Perez', 'Avenida La Marina #789, Distrito De Cerro Colorado, Arequipa', '1995-10-11', '955786123', 'kperez@hotmail.com'),
(98765431, 'Miguel', 'Reyes', 'Calle Juanita #234, Urbanización Los Pinos, Arequipa', '2003-07-07', '998734123', 'mreyes@gmail.com');

INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES
('001', 'Medicamentos', 'Productos para el tratamiento de enfermedades'),
('002', 'Cuidado Personal', 'Productos para la higiene y cuidado personal'),
('003', 'Vitaminas y Suplementos', 'Productos para complementar la alimentación');

INSERT INTO factura (num_factura, id_cliente, fecha) VALUES
('00001', 90453612, '2022-01-15'),
('00002', 23657849, '2022-01-15'),
('00003', 75891236, '2022-01-16'),
('00004', 12345678, '2022-01-17'),
('00005', 89765432, '2022-01-17'),
('00006', 65412789, '2022-01-18'),
('00007', 43219876, '2022-01-19'),
('00008', 56473829, '2022-01-20'),
('00009', 21897543, '2022-01-20'),
('00010', 98765431, '2022-01-21');

INSERT INTO producto (id_producto, nombre, precio, stock, id_categoria) VALUES
('0001', 'Paracetamol', 3.50, 500, '001'),
('0002', 'Ibuprofeno', 5.75, 300, '001'),
('0003', 'Shampoo', 8.50, 150, '002'),
('0004', 'Acondicionador', 7.75, 150, '002'),
('0005', 'Jabón corporal', 3.25, 200, '002'),
('0006', 'Vitamina C', 6.25, 100, '003'),
('0007', 'Calcio', 4.50, 75, '003'),
('0008', 'Magnesio', 5.75, 100, '003'),
('0009', 'Hierro', 8.25, 50, '003'),
('0010', 'Vitamina B12', 7.50, 75, '003');

INSERT INTO detalle (num_detalle, id_factura, id_producto, cantidad) VALUES
('00001', '00001', '0001', 2),
('00002', '00001', '0003', 1),
('00003', '00002', '0002', 3),
('00004', '00003', '0005', 2),
('00005', '00003', '0006', 1),
('00006', '00003', '0007', 1),
('00007', '00004', '0002', 1),
('00008', '00004', '0004', 1),
('00009', '00005', '0001', 1),
('00010', '00005', '0003', 2);

SELECT * FROM cliente;
SELECT * FROM categoria;
SELECT * FROM factura;
SELECT * FROM producto;
SELECT * FROM detalle;

CREATE PROCEDURE `sp_listar_producto`()
SELECT producto.id_producto, producto.nombre, producto.precio, producto.stock, categoria.nombre
FROM producto INNER JOIN categoria 
WHERE producto.id_categoria = categoria.id_categoria;

CALL sp_listar_producto;

CREATE PROCEDURE `sp_listar_clientes`()
SELECT * FROM cliente;

CALL sp_listar_clientes;

CREATE PROCEDURE `sp_listar_facturas`()
SELECT factura.num_factura, cliente.nombres, factura.fecha
FROM factura INNER JOIN cliente
WHERE factura.id_cliente = cliente.id_cliente;

CALL sp_listar_facturas;




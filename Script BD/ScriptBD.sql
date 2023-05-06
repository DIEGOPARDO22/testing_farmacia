/*============================================================
                        CREACION DE BD
============================================================*/
CREATE DATABASE BD_Farmacia;
USE BD_Farmacia;

/*CREACION DE TABLA CLIENTE*/
CREATE TABLE IF NOT EXISTS cliente(
    ruc CHAR(11) NOT NULL,
    nombresorazon VARCHAR(100) NOT NULL,
    direccion VARCHAR(150),
    fecha_nacimiento DATE,
    telefono CHAR(9),
    email VARCHAR(25),
    PRIMARY KEY (ruc) 
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
    ruc CHAR(11),
    fecha DATE,
    PRIMARY KEY (num_factura),
    FOREIGN KEY (ruc) REFERENCES cliente (ruc)
) ENGINE=InnoDB;

/*CREACION DE TABLA PRODUCTO*/
CREATE TABLE IF NOT EXISTS producto(
    id_producto SMALLINT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    precio DOUBLE,
    stock INT,
    id_categoria CHAR(3),
    PRIMARY KEY (id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria)
) ENGINE=InnoDB;
ALTER TABLE producto AUTO_INCREMENT=1000;

/*CREACION DE TABLA DETALLE*/
CREATE TABLE IF NOT EXISTS detalle(
    num_detalle CHAR(5) NOT NULL,
    id_factura CHAR(5) NOT NULL,
    id_producto SMALLINT,
    cantidad INT,
    PRIMARY KEY (num_detalle, id_factura),
    FOREIGN KEY (id_factura) REFERENCES factura (num_factura),
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON UPDATE CASCADE
) ENGINE=InnoDB;

/*============================================================
                    INSERCIÓN DE DATOS
============================================================*/

/*INSERCION EN TABLA CLIENTE*/
INSERT INTO cliente (ruc, nombresorazon, direccion,fecha_nacimiento, telefono, email) VALUES
(90453612111, 'Pfizer Inc.', 'Calle Los Pinos #123, Urbanización Las Casuarinas, Arequipa', '1997-12-03', '998765432', 'srodriguez@gmail.com'),
(23657849222, 'Novartis AG.', 'Avenida Dolores #456, Urbanización Los Cedros, Yanahuara, Arequipa', '1995-06-21', '995678521', 'ahernandez@hotmail.com'),
(75891236333, 'Johnson & Johnson', 'Calle Francisco Bolognesi #678, Urbanización Las Condes, Sachaca, Arequipa', '1999-09-05', '954221345', 'vcastro@gmail.com'),
(12345678444, 'Umbrella Corporation', 'Calle Mariscal Castilla #210, Distrito De Challapampa, Arequipa', '2000-11-17', '994536187', 'dgarcia@hotmail.com'),
(89765432555, 'AstraZeneca plc.', 'Avenida Ejercito #1234, Urbanización Vila Real, Cayma, Arequipa', '2002-04-02', '958765432', 'pmartinez@hotmail.com'),
(65412789666, 'Boehringer Ingelheim', 'Calle Lima #567, Urbanización San Lazaro, Arequipa', '1996-08-28', '948765212', 'jgonzalez@gmail.com'),
(43219876777, 'Roche Holding AG', 'Avenida Andres Avelino Caceres #890, Distrito De Hunter, Arequipa', '1998-02-14', '955678123', 'ndiaz@hotmail.com'),
(56473829888, 'Eli Lilly and Company', 'Calle Avenida De La Cultura #456, Urbanización Las Vizcachas, Arequipa', '2001-05-30', '948635184', 'ahernandez@gmail.com'),
(21897543999, 'Sanofi S.A.', 'Avenida La Marina #789, Distrito De Cerro Colorado, Arequipa', '1995-10-11', '955786123', 'kperez@hotmail.com'),
(98765431101, 'Merck & Co., Inc.', 'Calle Juanita #234, Urbanización Los Pinos, Arequipa', '2003-07-07', '998734123', 'mreyes@gmail.com');

INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES
('001', 'Medicamentos', 'Productos para el tratamiento de enfermedades'),
('002', 'Cuidado Personal', 'Productos para la higiene y cuidado personal'),
('003', 'Vitaminas y Suplementos', 'Productos para complementar la alimentación');

INSERT INTO factura (num_factura, ruc, fecha) VALUES
('00001', 90453612111, '2022-01-15'),
('00002', 23657849222, '2022-01-15'),
('00003', 75891236333, '2022-01-16'),
('00004', 12345678444, '2022-01-17'),
('00005', 89765432555, '2022-01-17'),
('00006', 65412789666, '2022-01-18'),
('00007', 43219876777, '2022-01-19'),
('00008', 56473829888, '2022-01-20'),
('00009', 21897543999, '2022-01-20'),
('00010', 98765431101, '2022-01-21');

INSERT INTO producto (nombre, precio, stock, id_categoria) VALUES
('Paracetamol', 3.50, 500, '001'),
('Ibuprofeno', 5.75, 300, '001'),
('Shampoo', 8.50, 150, '002'),
('Acondicionador', 7.75, 150, '002'),
('Jabón corporal', 3.25, 200, '002'),
('Vitamina C', 6.25, 100, '003'),
('Calcio', 4.50, 75, '003'),
('Magnesio', 5.75, 100, '003'),
('Hierro', 8.25, 50, '003'),
('Vitamina B12', 7.50, 75, '003');

INSERT INTO detalle (num_detalle, id_factura, id_producto, cantidad) VALUES
('00001', '00001', '1001', 2),
('00002', '00001', '1003', 1),
('00003', '00002', '1002', 3),
('00004', '00003', '1005', 2),
('00005', '00003', '1006', 1),
('00006', '00003', '1007', 1),
('00007', '00004', '1002', 1),
('00008', '00004', '1004', 1),
('00009', '00005', '1001', 1),
('00010', '00005', '1003', 2);

SELECT * FROM cliente;
SELECT * FROM categoria;
SELECT * FROM factura;
SELECT * FROM producto;
SELECT * FROM detalle;

/* =============================================================================================
											LISTAR
============================================================================================= */ 
CREATE PROCEDURE `sp_listar_producto`()
SELECT producto.id_producto, producto.nombre, producto.precio, producto.stock, categoria.nombre
FROM producto INNER JOIN categoria 
WHERE producto.id_categoria = categoria.id_categoria;

CREATE PROCEDURE `sp_listar_clientes`()
SELECT * FROM cliente;

CREATE PROCEDURE `sp_listar_facturas`()
SELECT factura.num_factura, cliente.nombresorazon, factura.fecha
FROM factura INNER JOIN cliente
WHERE factura.ruc = cliente.ruc;

CREATE PROCEDURE `sp_listar_categorias`()
SELECT id_categoria, nombre
FROM categoria;

/* =============================================================================================
											CREAR
============================================================================================= */ 

CREATE PROCEDURE `sp_crear_producto`(IN in_nombre VARCHAR(25), IN in_precio DOUBLE, IN in_stock INT, IN in_id_categoria CHAR(3))
INSERT INTO producto(nombre, precio, stock, id_categoria) VALUES(in_nombre, in_precio, in_stock, in_id_categoria);

/* =============================================================================================
											EDITAR
============================================================================================= */ 
CREATE PROCEDURE `sp_editar_producto`(IN in_id_producto SMALLINT, IN in_nombre VARCHAR(25), IN in_precio DOUBLE, IN in_stock INT, IN in_id_categoria CHAR(3))
UPDATE producto
SET nombre=in_nombre, precio=in_precio, stock=in_stock, id_categoria=in_id_categoria
WHERE id_producto=in_id_producto;

/* =============================================================================================
											BUSCAR
============================================================================================= */ 
CREATE PROCEDURE `sp_buscar_producto_por_id` (IN in_id_producto SMALLINT)
SELECT producto.id_producto, producto.nombre, producto.precio, producto.stock, producto.id_categoria, categoria.nombre
FROM producto INNER JOIN categoria WHERE id_producto=in_id_producto AND producto.id_categoria=categoria.id_categoria;
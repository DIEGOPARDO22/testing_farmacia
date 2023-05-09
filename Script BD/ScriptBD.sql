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
    telefono CHAR(9),
    email VARCHAR(50),
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
    num_factura SMALLINT NOT NULL AUTO_INCREMENT,
    ruc CHAR(11),
    fecha DATE,
    PRIMARY KEY (num_factura),
    FOREIGN KEY (ruc) REFERENCES cliente (ruc) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;
ALTER TABLE factura AUTO_INCREMENT=30001;

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
ALTER TABLE producto AUTO_INCREMENT=1001;

/*CREACION DE TABLA DETALLE*/
CREATE TABLE IF NOT EXISTS detalle(
    num_detalle SMALLINT NOT NULL AUTO_INCREMENT,
    id_factura SMALLINT NOT NULL,
    id_producto SMALLINT,
    cantidad INT,
    PRIMARY KEY (num_detalle, id_factura),
    FOREIGN KEY (id_factura) REFERENCES factura (num_factura) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB;
ALTER TABLE detalle AUTO_INCREMENT=20001;

/*============================================================
                    INSERCIÓN DE DATOS
============================================================*/

/*INSERCION EN TABLA CLIENTE*/
INSERT INTO cliente (ruc, nombresorazon, direccion, telefono, email) VALUES
(90453612111, 'Pfizer Inc.', 'Calle Los Pinos #123, Urbanización Las Casuarinas, Arequipa', '998765432', 'srodriguez@gmail.com'),
(23657849222, 'Novartis AG.', 'Avenida Dolores #456, Urbanización Los Cedros, Yanahuara, Arequipa', '995678521', 'ahernandez@hotmail.com'),
(75891236333, 'Johnson & Johnson', 'Calle Francisco Bolognesi #678, Urbanización Las Condes, Sachaca, Arequipa', '954221345', 'vcastro@gmail.com'),
(12345678444, 'Umbrella Corporation', 'Calle Mariscal Castilla #210, Distrito De Challapampa, Arequipa', '994536187', 'dgarcia@hotmail.com'),
(89765432555, 'AstraZeneca plc.', 'Avenida Ejercito #1234, Urbanización Vila Real, Cayma, Arequipa', '958765432', 'pmartinez@hotmail.com'),
(65412789666, 'Boehringer Ingelheim', 'Calle Lima #567, Urbanización San Lazaro, Arequipa', '948765212', 'jgonzalez@gmail.com'),
(43219876777, 'Roche Holding AG', 'Avenida Andres Avelino Caceres #890, Distrito De Hunter, Arequipa', '955678123', 'ndiaz@hotmail.com'),
(56473829888, 'Eli Lilly and Company', 'Calle Avenida De La Cultura #456, Urbanización Las Vizcachas, Arequipa', '948635184', 'ahernandez@gmail.com'),
(21897543999, 'Sanofi S.A.', 'Avenida La Marina #789, Distrito De Cerro Colorado, Arequipa', '955786123', 'kperez@hotmail.com'),
(98765431101, 'Merck & Co., Inc.', 'Calle Juanita #234, Urbanización Los Pinos, Arequipa', '998734123', 'mreyes@gmail.com');

INSERT INTO categoria (id_categoria, nombre, descripcion) VALUES
('001', 'Medicamentos', 'Productos para el tratamiento de enfermedades'),
('002', 'Cuidado Personal', 'Productos para la higiene y cuidado personal'),
('003', 'Vitaminas y Suplementos', 'Productos para complementar la alimentación');

INSERT INTO factura (ruc, fecha) VALUES
(90453612111, '2022-01-15'),
(23657849222, '2022-01-15'),
(75891236333, '2022-01-16'),
(12345678444, '2022-01-17'),
(89765432555, '2022-01-17'),
(65412789666, '2022-01-18'),
(43219876777, '2022-01-19'),
(56473829888, '2022-01-20'),
(21897543999, '2022-01-20'),
(98765431101, '2022-01-21');

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



INSERT INTO detalle (id_factura, id_producto, cantidad) VALUES
('30001', '1001', 2),
('30002', '1003', 1),
('30003', '1002', 3),
('30001', '1005', 2),
('30005', '1006', 1),
('30001', '1007', 1),
('30007', '1002', 1),
('30008', '1004', 1),
('30009', '1001', 1),
('30008', '1003', 2);

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

CREATE PROCEDURE `sp_crear_cliente`(IN in_ruc CHAR(11), IN in_razon VARCHAR(100), IN in_direccion VARCHAR(150), in_telefono CHAR(9), in_email VARCHAR(50))
INSERT INTO cliente(ruc, nombresorazon, direccion, telefono, email) VALUES(in_ruc, in_razon, in_direccion, in_telefono, in_email);

CREATE PROCEDURE `sp_crear_factura`(IN ruc CHAR(11), IN fecha DATE)
INSERT INTO factura(ruc, fecha) VALUES(ruc, fecha);

CREATE PROCEDURE `sp_crear_detalle`(in id_factura SMALLINT, in id_producto SMALLINT, in cantidad INT)
INSERT INTO detalle(id_factura, id_producto, cantidad) VALUES(id_factura, id_producto, cantidad);


/* =============================================================================================
											EDITAR
============================================================================================= */ 
CREATE PROCEDURE `sp_editar_producto`(IN in_id_producto SMALLINT, IN in_nombre VARCHAR(25), IN in_precio DOUBLE, IN in_stock INT, IN in_id_categoria CHAR(3))
UPDATE producto
SET nombre=in_nombre, precio=in_precio, stock=in_stock, id_categoria=in_id_categoria
WHERE id_producto=in_id_producto;

CREATE PROCEDURE `sp_editar_cliente`(IN in_ruc CHAR(11), IN in_razon VARCHAR(100), IN in_direccion VARCHAR(150), IN in_telefono CHAR(9), IN in_email VARCHAR(50))
UPDATE cliente
SET ruc=in_ruc, nombresorazon=in_razon, direccion=in_direccion, telefono=in_telefono, email=in_email
WHERE ruc = in_ruc;

/* =============================================================================================
											BORRAR
============================================================================================= */ 
CREATE PROCEDURE `sp_eliminar_producto`(IN in_id_producto SMALLINT)
DELETE FROM producto
WHERE id_producto = in_id_producto;

create procedure `sp_eliminar_factura`(IN in_id_factura SMALLINT)
delete from factura where factura.num_factura=in_id_factura;
call sp_eliminar_factura(30010);
CREATE PROCEDURE `sp_eliminar_cliente`(IN in_ruc_cliente CHAR(11))
DELETE FROM cliente
WHERE ruc = in_ruc_cliente;

/* =============================================================================================
											BUSCAR
============================================================================================= */ 
CREATE PROCEDURE `sp_buscar_producto_por_id` (IN in_id_producto SMALLINT)
SELECT producto.id_producto, producto.nombre, producto.precio, producto.stock, producto.id_categoria, categoria.nombre
FROM producto INNER JOIN categoria WHERE id_producto=in_id_producto AND producto.id_categoria=categoria.id_categoria;

CREATE PROCEDURE `sp_buscar_cliente_por_id`(IN in_ruc_cliente CHAR(11))
SELECT * FROM cliente WHERE in_ruc_cliente = cliente.ruc;

CREATE PROCEDURE `sp_buscar_factura_por_id`(IN in_id_factura SMALLINT)
SELECT factura.num_factura, factura.ruc, factura.fecha, detalle.id_producto, detalle.cantidad
FROM factura INNER JOIN detalle
WHERE factura.num_factura = detalle. id_factura AND factura.num_factura=in_id_factura;

call sp_buscar_factura_por_id(30004);
/* =============================================================================================
											MOSTRAR
============================================================================================= */

CREATE PROCEDURE `sp_ver_factura`(IN num_fac SMALLINT)
SELECT DISTINCT factura.num_factura, factura.fecha, cliente.nombresorazon, cliente.ruc, producto.nombre, detalle.cantidad, producto.precio, cliente.direccion
FROM detalle
INNER JOIN factura ON factura.num_factura = detalle.id_factura
INNER JOIN cliente ON cliente.ruc = factura.ruc
INNER JOIN producto ON producto.id_producto = detalle.id_producto WHERE
factura.num_factura = num_fac;

select * from factura;
call sp_ver_factura (30001);
/* =============================================================================================
											ULTIMA FACTURA
============================================================================================= */
create procedure `sp_ver_ultima_factura`() SELECT MAX(num_factura) FROM factura;
-- criação do banco de dados para o cenário de E-Commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        firstName varchar(15),
        lastName varchar(45),
        CPF char(15) not null,
        address varchar(50),
        birthDate date,
        constraint unique_cpf_client unique (CPF)        
);

-- criar tabela pagamentos;
create table payments(
		idPayment int auto_increment primary key,
        idClient int not null,
        paymentName varchar(10),
        typePayment enum('Boleto','Crédito','Débito','Pix'),
        constraint fk_payments_client foreign key (idClient) references clients(idClient)
);

-- criar tabela produto;
create table products(
		idProduct int auto_increment primary key,
        produtName varchar(10),
        category enum('Eletrônico', 'Vestimentas', 'Alimentos', 'Outros') not null,
        overview varchar(45),
        cost float,
        stars float,
        size varchar(10),
        availiability enum('Disponivel', 'Estotado')
);
-- criar tabela pedido;
create table orders(
		idOrder int auto_increment primary key,
        idClient int,
		idPayment int,
        overview varchar(255),
        OrderStatus enum('Processando, Cancelado, Confirmado') default('Processando'),
        shippingPrice float default 0,
        constraint fk_orders_client foreign key (idClient) references clients(idClient),
        constraint fk_orders_payment foreign key (idPayment) references payments(idPayment)
);

-- criar tabela estoque;
create table productStorage(
		idProductStorage int auto_increment primary key,
        quantity int not null
);

-- criar tabela fornecedor;
create table suppliers(
		idSupplier int auto_increment primary key,
		socialName varchar(255) not null,
		CNPJ char(15) not null,
		contact char(11) not null unique,
        location varchar(255) not null,
		constraint unique_supplier unique (CNPJ,socialName)
);

-- criar tabela de vendedores;
create table sellers(
		idSeller int auto_increment primary key,
        socialName varchar(255) not null,
        CNPJ char(15) not null,
        contact char(11) not null unique,
        location varchar(255) not null,
		constraint unique_seller unique (CNPJ,socialName)
);

-- criar tabela produtos por vendedor;
create table productSeller (
		idProduct int,
        idSeller int,
		quantity int default 1,
        primary key (idProduct, idSeller),
        constraint fk_idPSeller foreign key (idProduct) references products(idProduct),
        constraint fk_idSeller foreign key (idSeller) references sellers(idSeller)
);

-- criar tabela fornecedor disponibiliza produto;
create table productSupplier(
		idSupplier int,
        idProduct int,
        quantity int not null,
        primary key (idSupplier, idProduct),
        constraint fk_idPSupplier foreign key (idProduct) references products(idProduct),
        constraint fk_idSupplier foreign key (idSupplier) references suppliers(idSupplier)
);

-- criar tabela produto por pedido;
create table productOrder(
		idProduct int,
        idOrder int,
        quantity int not null,
        primary key (idProduct, idOrder),
        constraint fk_idPOrder foreign key (idProduct) references products(idProduct),
		constraint fk_idOrder foreign key (idOrder) references orders(idOrder)
);

-- criar tabela produto em estoque;
create table storageLocation(
		idProduct int,
        idStorage int,
		storageLocation varchar(20) not null,
        primary key (idProduct, idStorage),
        constraint fk_idProductStorage foreign key (idProduct) references products(idProduct),
        constraint fk_idStorage foreign key (idStorage) references productStorage(idProductStorage)
);

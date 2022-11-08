-- criando banco de dadtos
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
		idClient int auto_increment primary key,
        Fname varchar(10),
        Mnit Char(3),
        Lname varchar(20),
        CPF char(11) not null,
		Adress varchar(15), -- é sempre bom endereço como composto e juntar depois
        constraint unique_cpf_cliente unique (CPF)
        
    );

-- criar tabela produto
-- size dimensão
create table product(
		idProduct int auto_increment primary key,
        Pname varchar(10) not null,
        classification_kids bool default false,
        category enum('Eletrônico','Móveis','Vestimenta','Brinquedos','Alimentos') not null,
		adress varchar(15), -- é sempre bom endereço como composto e juntar depois
        size varchar(10),        
        valor float
);

-- criar tabela pagamento
create table payments(
		idClient int,
        id_payment int,
        typePayment enum ('Boleto','Cartão', 'Dois cartões'),
        limitAvailable float,
        primary key (idClient, id_payment)
);

-- criar tabela pedido
create table orders(
		idOrder int auto_increment primary key,
        idOrderClient int,
        orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
        orderDescription varchar(255),
        sendValue float default 10, -- frete
        paymentCash bool default false,
		constraint fk_orders_client foreign key (idOrderClient) references clients(idClient)
);

-- criar tabela estoque
create table productStorage(
		idProdStorage int auto_increment primary key,
        storageLocation varchar(255),
        quantity int default 0
);

-- fornecedor 
create table supplier(
		idSupplier int auto_increment primary key,
        socialName varchar(255) not null,
        CNPJ char(15) not null,
        contact varchar (11) not null,
		constraint unique_supplier unique (CNPJ)
);

-- vendedor 
create table seller(
		idSeller int auto_increment primary key,
        socialName varchar(255) not null,
        CNPJ char(15),
        CPF char(9),
        location varchar(255),
        contact varchar (11) not null,
		constraint unique_seller_cnpj unique (CNPJ),
		constraint unique_seller_cpf unique (CPF)
);

create table productSeller(
		idPseller int,
        idPproduct int,
        prodQuantity int default 1,
        primary key (idPseller, idPproduct),
        constraint fk_product_seller foreign key (idPseller) references seller (idSeller),
        constraint fk_product_product foreign key (idPproduct) references product (idProduct)
);

create table productOrder(
		idPOproduct int,
        idPOorder int,
        poQuantity int default 1,
        poStatus enum ('Disponível','Sem estoque') default 'Disponível',
        primary key (idPOproduct, idPOorder),
        constraint fk_POrder_product foreign key (idPOproduct) references product (idProduct),
        constraint fk_POrder_order foreign key (idPOorder) references orders (idOrder)
);

create table storageLocation(
		idLproduct int,
        idLstorage int,
        location varchar(255) not null,
        primary key (idLproduct, idLstorage),
        constraint fk_StorageLoct_product foreign key (idLproduct) references product (idProduct),
        constraint fk_StorageLoct_storage foreign key (idLstorage) references productStorage (idProdStorage)
);

create table productSupplier(
		idPSsupplier int,
        idPSproduct int,
        quantity int not null,
        primary key (idPSsupplier, idPSproduct),
        constraint fk_PSupplier_supplier foreign key (idPSsupplier) references supplier (idSupplier),
        constraint fk_PSupplier_product foreign key (idPSproduct) references product (idProduct)
);

show tables;
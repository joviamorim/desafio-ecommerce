-- Criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- Criando as tabelas

-- Cliente
create table clients(
	idClient int auto_increment primary key,
    fName varchar(25) not null,
    mInitial varchar(3),
    lName varchar(25) not null,
    adress char(50),
    birthDate date not null,
    clientType enum('Pessoa física','Pessoa Jurídica') not null
);

-- Pessoa física
create table pf(
	idClient int,
	cpf char(11) not null,
    constraint unique_cpf unique (cpf),
    constraint fk_pf_client foreign key (idClient) references clients(idClient)
);

-- Pessoa jurídica
create table pj(
	idClient int,
	cnpj char(14) not null,
    constraint unique_cnpj unique (cnpj),
    constraint fk_pj_client foreign key (idClient) references clients(idClient)
);

-- Pagamento
create table payment(
	idClient int,
	cNumber varchar(20) not null,
    pMethod enum('Crédito','Débito') not null,
    cName varchar(25) not null,
    cValidity date not null,
    primary key (idClient),
    constraint unique_cNumber unique(cNumber),
    constraint fk_payment_clients foreign key(idClient) references clients(idClient)
);

-- Produto
create table product(
	idProduct int auto_increment primary key,
    pName varchar(20) not null,
    pValue float not null,
    pCategory varchar(25) not null,
    pDesc varchar(255),
    pRating float default 0
);

-- Estoque
create table inventory(
	idInventory int auto_increment primary key,
    iLocation varchar(50) not null
);

-- Pedido
create table orders(
	idOrder int auto_increment primary key,
    order_idClient int,
    orderStatus enum('Em andamento','Enviado','Entregue','Processando') default 'Processando',
    orderDesc varchar(255),
    ShippingValue float default 0.0,
    cashPayment bool default false,
    constraint fk_orderClient foreign key (order_idClient) references clients(idClient)
);

-- Fornecedor
create table suplier(
	idSuplier int auto_increment primary key,
    socialName varchar(255) not null,
    cnpj char(15) not null,
    contact char(11) not null,
    constraint unique_suplier unique(cnpj)
);

-- Vendedor
create table seller(
	idSeller int auto_increment primary key,
    socialName varchar(255) not null,
    cnpj char(14),
    cpf char(11),
    contact char(11) not null,
    location varchar(255),
    constraint unique_cnpjSeller unique(cnpj),
    constraint unique_cpfSellerr unique(cpf)
);

-- Produtos por vendedor
create table productSeller(
	idPSeller int,
    idProduct int,
    quantity int default 1,
    primary key(idPSeller, idProduct),
    constraint fk_pSeller_seller foreign key (idPSeller) references seller(idSeller),
    constraint fk_pSeller_product foreign key (idProduct) references product(idProduct)
);

-- Disponibilizando um produto (produtos por fornecedor)
create table productSuplier(
	idPSuplier int,
    idProduct int,
    quantity int not null,
    primary key(idPSuplier, idProduct),
    constraint fk_pSuplier_suplier foreign key (idPSuplier) references suplier(idSuplier),
    constraint fk_pSuplier_product foreign key (idProduct) references product(idProduct)
);

-- Produto tem estoque
create table productInventory(
	idPInventory int,
    idProduct int,
    quantity int default 0,
    primary key(idPInventory,idProduct),
    constraint fk_pInventory_inventory foreign key (idPInventory) references inventory(idInventory),
    constraint fk_pInventory_product foreign key (idProduct) references product(idProduct)
);

-- Relação produto/pedido
create table productOrder(
	idPOrder int,
    idProduct int,
    quantity int default 1,
    poStatus enum('Disponível','Sem estoque') default 'Disponível',
	constraint fk_pOrder_order foreign key (idPOrder) references orders(idOrder),
    constraint fk_pOrder_product foreign key (idProduct) references product(idProduct)
);


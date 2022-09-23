-- Inserindo informações nas tabelas de ecommerce
use ecommerce;

-- Cliente
insert into clients (fName, mInitial, lName, adress, birthDate, clientType) values
	('João','V','Amorim','Rua 1, número 100, bairro Amanda','2002-08-19','Pessoa física'),
    ('Marcus',default,'Silva','Rua 2, número 220, bairro Amanda','1998-02-11','Pessoa jurídica'),
    ('Maria','E','Andrade','Rua 5, número 510, bairro Amanda','2000-06-08','Pessoa física'),
    ('Ruan','P','Silva','Rua 90, número 940, bairro Rosolém','2001-01-01','Pessoa física');


-- pf
insert into pf (idClient, cpf) values
	('1','11222333'),
    ('3','00888999'),
    ('4','10200300');

-- pj
insert into pj (idClient, cnpj) values
	('2','11122233344455');

-- Pagamento
insert into payment (idClient, cNumber, pMethod, cName, cValidity) values
	('1','111222333','Crédito','João','2024-09-09'),
    ('3','123123123','Débito','Maria','2025-10-12'),
    ('4','987987987','Crédito','Ruan','2023-12-03');
    
-- Produto
insert into product (pName, pValue, pCategory, pDesc, pRating) values
	('Geladeira','1000.0','Eletrodomésticos','Geladeira mais atual','5.0'),
    ('Mesa','60.0','Móveis','Mesa para 4 pessoas','4.0'),
    ('Mouse','200.0','Periféricos','Mouse profissional para jogos','4.4'),
    ('Violão','200.0','Instrumentos','Violão de cordas de nylon',default);
    
-- Estoque
insert into inventory (iLocation) values
	('SP'),
    ('MT'),
    ('MG'),
    ('RJ');
    
-- Pedido
insert into orders (order_idClient, orderStatus, orderDesc, ShippingValue, cashPayment) values
	('1',default,default,'40.0',default),
    ('1','Em andamento',default,'37.0',default),
    ('2','Enviado','Pedido para empresa de Marcus','40.0',default),
    ('4','Entregue',default,'40.0',true),
    ('4','Enviado',default,'40.0',true);

-- Fornecedor
insert into suplier (socialName, cnpj, contact) values
	('Fornecedora móveis ltda','88888888888888','19912345678'),
    ('Mega eletro','90909090909090','19998769876'),
    ('Fornecedoras eletroGames','12345671234567','19912341234');
    
-- Vendedor
insert into seller (socialName, cnpj, cpf, contact, location) values
	('Mega eletro', '90909090909090',default,'19998769876','Rua do girassol, número 10, quadra Q, São Paulo'),
    ('Classe M móveis', '80808080808080',default,'19998769876','Rua da rosa, número 90, quadra P, São Paulo'),
    ('Carlos', default,'51851851876','20912341234','Rua sumaré, número 1050, Hortolândia, São Paulo');

-- Produtos por vendedor
insert into productSeller (idPSeller, idProduct, quantity) values
	('2','1','100'),
    ('1','2','100'),
    ('3','3','100'),
    ('3','4','100');
    
-- Disponibilizando um produto (produtos por fornecedor)
insert into productSuplier (idPSuplier, IdProduct, quantity) values
	('1','2','500'),
    ('2','1','200'),
    ('3','3','400'),
    ('3','4','400');
    
-- Produto tem estoque
insert into productInventory (idPInventory, idProduct, quantity) values
	('1','1','1000'),
    ('1','2','400'),
    ('1','3','300'),
    ('2','4','200'),
    ('3','4','220');

-- Relação produto/pedido
insert into productOrder (idPOrder, idProduct, quantity, poStatus) values
	('1','1','1','Disponível'),
    ('1','4','2',default),
    ('2','3','2','Disponível'),
    ('3','3','1',default),
    ('4','2','1',default),
    ('5','1','3','Disponível');
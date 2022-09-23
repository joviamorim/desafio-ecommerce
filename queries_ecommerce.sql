-- Consultas do ecommerce
use ecommerce;

-- Quantidade de pedidos feitos por cada cliente
select idClient, concat(fName,' ',lName) as nome, count(*) as qtd_pedidos
	from orders inner join clients
		on order_idClient = idClient
		group by nome;

-- Algum vendedor também é fornecedor?
-- Está sendo verificado se o cnpj de um vendedor está presente na tabela de fornecedores, se estiver, então um vendedor é também fornecedor.
select se.socialName as vendedor_e_fornecedor
	from seller se inner join productSeller pse
		on (se.idSeller = pse.idPSeller)
	inner join suplier su
		on (su.cnpj = se.cnpj);

-- Relação de produtos, fornecedores e estoque
select pr.pName as nome_produto, su.socialName as fornecedor, i.iLocation as local_estoque
	from product pr inner join productSuplier psu
		using (idProduct)
	inner join suplier su
		on su.idSuplier = psu.idPSuplier
	inner join productInventory pi
		using (idProduct)
	inner join inventory i
		on i.idInventory = pi. idPInventory;
        
-- Relação do nome dos fornecedores e nome dos produtos
select su.socialName as nome_fornecedor, pr.pName as nome_produto , pr.idProduct as cod_produto
	from suplier su inner join productSuplier psu
		on su.idSuplier = psu.idPSuplier
	inner join product pr
		using (idProduct)
        order by (su.socialName);

-- Relação do nome dos fornecedores e nome dos produtos (restringindo a número produtos por fornecedor > 1)
select su.socialName as nome_fornecedor, count(*) as qtd_produtos
	from suplier su inner join productSuplier psu
		on su.idSuplier = psu.idPSuplier
	inner join product pr
		using (idProduct)
        group by (su.socialName)
        having qtd_produtos>1;
        
-- Consultando informações únicas do cliente (cpf e cnpj)
select c.idClient, concat(fname,' ',lName) as nome, f.cpf as cpf, j.cnpj as cnpj
	from clients c left join pf f 
		using (idClient)
	left join pj j
		using (idClient)
        order by (idClient);

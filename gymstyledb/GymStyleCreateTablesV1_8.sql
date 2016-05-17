
 CREATE TABLE IF NOT EXISTS categorias (
	id_categorias BIGSERIAL NOT NULL,
	nome VARCHAR(70) NOT NULL,
	ativo BOOLEAN DEFAULT TRUE,
	CONSTRAINT CATEGORIA_PK PRIMARY KEY (id_categorias)
);
 CREATE TABLE IF NOT EXISTS fornecedores (
	id_fornecedores BIGSERIAL NOT NULL,
	nome VARCHAR(70) NOT NULL,
	cidade VARCHAR(70) NOT NULL,
	estado VARCHAR(4) NOT NULL,
	telefone VARCHAR(15) NOT NULL,
	ativo BOOLEAN DEFAULT TRUE,
	CONSTRAINT FORNECEDOR_PK PRIMARY KEY (id_fornecedores)
);
	
 CREATE TABLE IF NOT EXISTS produtos (
	id_produtos BIGSERIAL NOT NULL,
	codigo BIGINT,
	nome VARCHAR(70) NOT NULL,
	preco_custo FLOAT,
	preco_venda FLOAT,
	estoque_atual INT,
	estoque_minimo INT,
	observacao VARCHAR(300),

        foto character varying(10000),
        alerta_estoque_minimo BOOLEAN DEFAULT TRUE,
        codigo_barras VARCHAR(120),

	ativo BOOLEAN DEFAULT TRUE,
	id_categoria_fk BIGINT,
	id_fornecedor_fk BIGINT,
	CONSTRAINT PRODUTO_PK PRIMARY KEY (id_produtos),
	CONSTRAINT PRODUTO_CATEGORIA_FK FOREIGN KEY (id_categoria_fk)
	   REFERENCES categorias(id_categorias)
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
    CONSTRAINT PRODUTO_FORNECEDOR_FK FOREIGN KEY (id_fornecedor_fk)
	   REFERENCES fornecedores(id_fornecedores)
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL
);
	
 CREATE TABLE IF NOT EXISTS vendas (
	id_vendas BIGSERIAL NOT NULL,
	data_hora TIMESTAMP DEFAULT NOW(),
	total FLOAT DEFAULT 0.0,
	valor_pago FLOAT DEFAULT 0.0,
	realizou_recebimento BOOLEAN DEFAULT TRUE,
	
	id_operador_fk BIGINT,
	id_formas_pagamento_fk BIGINT,
	
	CONSTRAINT VENDAS_PK PRIMARY KEY (id_vendas),
	CONSTRAINT VENDAS_FORMA_PAGAMENTO_FK FOREIGN KEY (id_formas_pagamento_fk)
	   REFERENCES formas_pagamento(id_formas_pagamento)
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
	CONSTRAINT VENDAS_USUARIO_FK FOREIGN KEY (id_operador_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL
);

 CREATE TABLE IF NOT EXISTS item_vendas (
	id_vendas BIGSERIAL NOT NULL,
	ordem TIMESTAMP DEFAULT NOW(),
	qtde FLOAT DEFAULT 0.0,
	preco_unitario FLOAT DEFAULT 0.0,
	total FLOAT DEFAULT 0.0,
	
	id_produto_fk BIGINT,
	
	CONSTRAINT ITEM_VENDAS_PK PRIMARY KEY (id_vendas),
	CONSTRAINT ITEM_VENDAS_PRODUTO_FK FOREIGN KEY (id_produto_fk)
	   REFERENCES produtos(id_produtos)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);


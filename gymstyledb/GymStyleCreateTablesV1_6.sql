
CREATE TABLE IF NOT EXISTS planos_contas (
	id_planos_contas BIGSERIAL NOT NULL,
	descricao VARCHAR(300),
	receita BOOLEAN,
	despesa BOOLEAN,
	ativo BOOLEAN,
	valor FLOAT DEFAULT 0.0,
	
	CONSTRAINT PLANOS_CONTAS_PK PRIMARY KEY (id_planos_contas)
);

CREATE TABLE IF NOT EXISTS planos_contas (
	id_planos_contas BIGSERIAL NOT NULL,
	descricao VARCHAR(300),
	receita BOOLEAN,
	despesa BOOLEAN,
	ativo BOOLEAN,
	valor FLOAT DEFAULT 0.0,
	
	CONSTRAINT PLANOS_CONTAS_PK PRIMARY KEY (id_planos_contas)
);

CREATE TABLE IF NOT EXISTS contas_pagar (
	id_contas_pagar BIGSERIAL NOT NULL,
	descricao VARCHAR(300),
	data_hora timestamp,
	valor_pagar FLOAT DEFAULT 0.0,
	valor_pago FLOAT DEFAULT 0.0,
	id_formas_pagamento_fk BIGINT,
	id_planos_contas_fk BIGINT,
	
	CONSTRAINT CONTAS_PAGAR_PK PRIMARY KEY (id_contas_pagar),
	CONSTRAINT CONTAS_PAGAR_PAGAMENTO_FK FOREIGN KEY (id_formas_pagamento_fk)
	   REFERENCES formas_pagamento(id_formas_pagamento)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT CONTAS_PAGAR_PLANOS_CONTAS_FK FOREIGN KEY (id_planos_contas_fk)
	   REFERENCES planos_contas(id_planos_contas)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION

);

CREATE TABLE IF NOT EXISTS contas_receber (
	id_contas_receber BIGSERIAL NOT NULL,
	descricao VARCHAR(300),
	data_hora timestamp,
	valor_receber FLOAT DEFAULT 0.0,
	valor_recebido FLOAT DEFAULT 0.0,
	id_formas_pagamento_fk BIGINT,
	id_planos_contas_fk BIGINT,

	CONSTRAINT CONTAS_RECEBER_PK PRIMARY KEY (id_contas_receber),
	CONSTRAINT CONTAS_RECEBER_FORMA_PAGAMENTO_FK FOREIGN KEY (id_formas_pagamento_fk)
	   REFERENCES formas_pagamento(id_formas_pagamento)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT CONTAS_PAGAR_PLANOS_CONTAS_FK FOREIGN KEY (id_planos_contas_fk)
	   REFERENCES planos_contas(id_planos_contas)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS caixas (
	id_caixas BIGSERIAL NOT NULL,
	nome VARCHAR(70) NOT NULL,
	CONSTRAINT CAIXAS_PK PRIMARY KEY (id_caixas)
);

CREATE TABLE IF NOT EXISTS fluxos_caixas (
	id_fluxos_caixas BIGSERIAL NOT NULL,
	abertura TIMESTAMP DEFAULT NOW(),
	fechamento TIMESTAMP,
	valor_inicial FLOAT DEFAULT 0.0,
	valor_final FLOAT DEFAULT 0.0,
	vi_dinheiro FLOAT DEFAULT 0.0,
	vi_cheque FLOAT DEFAULT 0.0,
	vi_cartao FLOAT DEFAULT 0.0,
	vi_boleto FLOAT DEFAULT 0.0,
	vi_deposito FLOAT DEFAULT 0.0,

	vf_dinheiro FLOAT DEFAULT 0.0,
	vf_cheque FLOAT DEFAULT 0.0,
	vf_cartao FLOAT DEFAULT 0.0,
	vf_boleto FLOAT DEFAULT 0.0,
	vf_deposito FLOAT DEFAULT 0.0,

	id_operador_fk BIGINT,
	id_caixa_fk BIGINT,
	
	CONSTRAINT FLUXOS_CAIXAS_PK PRIMARY KEY (id_fluxos_caixas),
	CONSTRAINT FLUXOS_CAIXAS_OPERADOR_FK FOREIGN KEY (id_operador_fk)
	   REFERENCES usuarios(id_usuarios),
	CONSTRAINT FLUXOS_CAIXAS_CAIXAS_FK FOREIGN KEY (id_caixa_fk)
	   REFERENCES caixas(id_caixas)
);

CREATE TABLE IF NOT EXISTS reg_caixas (
	id_reg_caixas BIGSERIAL NOT NULL,
	data_hora TIMESTAMP DEFAULT NOW(),
	valor FLOAT DEFAULT 0.0,
	descricao VARCHAR(300),
	entrada BOOLEAN,
	retirada BOOLEAN,
	edit BOOLEAN DEFAULT TRUE,

	id_formas_pagamento_fk BIGINT,
	id_parcela_fk BIGINT,
	id_produto_fk BIGINT,
	id_contas_pagar_fk BIGINT,
	id_contas_receber_fk BIGINT,
	id_fluxos_caixas_fk BIGINT,
	id_reg_contas_bancarias_fk BIGINT,
	
	CONSTRAINT REG_CAIXAS_PK PRIMARY KEY (id_reg_caixas),
	CONSTRAINT REG_CAIXAS_FORMA_PAGAMENTO_FK FOREIGN KEY (id_formas_pagamento_fk)
	   REFERENCES formas_pagamento(id_formas_pagamento)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REG_CAIXAS_PARCELA_FK FOREIGN KEY (id_parcela_fk)
	   REFERENCES pagamentos(id_pagamentos)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REG_CAIXAS_CONTAS_PAGAR_FK FOREIGN KEY (id_contas_pagar_fk)
	   REFERENCES contas_pagar(id_contas_pagar)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REG_CAIXAS_CONTAS_RECEBER_FK FOREIGN KEY (id_contas_receber_fk)
	   REFERENCES contas_receber(id_contas_receber)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REG_CAIXAS_FLUXOS_CAIXAS_FK FOREIGN KEY (id_fluxos_caixas_fk)
	   REFERENCES fluxos_caixas(id_fluxos_caixas)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS bancos (
	id_bancos BIGSERIAL NOT NULL,
	codigo VARCHAR(20) NOT NULL,
	nome VARCHAR(70),
	sigla VARCHAR(10),
	site VARCHAR(70),
	CONSTRAINT BANCOS_PK PRIMARY KEY (id_bancos)
);

CREATE TABLE IF NOT EXISTS contas_bancarias (
	id_contas_bancarias BIGSERIAL NOT NULL,
	agencia VARCHAR(10) ,
	numero_conta VARCHAR(20) ,
	titular VARCHAR(70) ,
	id_bancos_fk BIGINT,
	ativo BOOLEAN DEFAULT TRUE,

	CONSTRAINT CONTAS_BANCARIAS_PK PRIMARY KEY (id_contas_bancarias),
	CONSTRAINT CONTAS_BANCARIAS_BANCOS_FK FOREIGN KEY (id_bancos_fk)
	   REFERENCES bancos(id_bancos)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS reg_contas_bancarias (
	id_reg_contas_bancarias BIGSERIAL NOT NULL,
	data_hora TIMESTAMP DEFAULT NOW(),
	valor FLOAT DEFAULT 0.0,
	descricao VARCHAR(300),
	entrada BOOLEAN,
	retirada BOOLEAN,
	id_formas_pagamento_fk BIGINT,
	id_reg_caixas_fk BIGINT,
	id_contas_bancarias_fk BIGINT,
	edit BOOLEAN DEFAULT TRUE,
	
	CONSTRAINT REG_CONTAS_BANCARIAS_PK PRIMARY KEY (id_reg_contas_bancarias),
	CONSTRAINT REG_CAIXAS_BANCARIAS_FORMA_PAGAMENTO_FK FOREIGN KEY (id_formas_pagamento_fk)
	   REFERENCES formas_pagamento(id_formas_pagamento)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REG_CAIXAS_BANCARIAS_REG_CONTAS_BANCARIAS FOREIGN KEY (id_contas_bancarias_fk)
	   REFERENCES contas_bancarias(id_contas_bancarias)
   	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);


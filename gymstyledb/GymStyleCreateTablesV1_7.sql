

DROP TABLE IF EXISTS operadores_perfis_acesso CASCADE;

CREATE OR REPLACE FUNCTION atualizaUsuariosTipos() RETURNS text AS $$
        BEGIN
           IF ((SELECT column_name FROM information_schema.columns WHERE table_name = 'usuarios' and column_name = 'ativo_aluno') = 'ativo_aluno') THEN
              RETURN 'TABELA OK';
	    ELSE
			ALTER TABLE usuarios 
				ADD COLUMN aluno boolean DEFAULT FALSE,
				ADD COLUMN adm boolean DEFAULT FALSE,
				ADD COLUMN secretaria boolean DEFAULT FALSE,
				ADD COLUMN instrutor boolean DEFAULT FALSE,
				ADD COLUMN ativo_aluno boolean DEFAULT FALSE,
				ADD COLUMN ativo_funcionario boolean DEFAULT FALSE;
				
			update usuarios set aluno = false, adm = true, instrutor =false,secretaria =false, ativo_funcionario = true,ativo_aluno = false
			where id_usuarios in (select id_usuarios from usuarios where id_tipos_usuarios_fk = 1);

			update usuarios set aluno = false, adm = false, instrutor = true, secretaria =false, ativo_funcionario = true,ativo_aluno = false
			where id_usuarios in (select id_usuarios from usuarios where id_tipos_usuarios_fk = 3);

			update usuarios set aluno = false, adm = false, instrutor =false,secretaria =true, ativo_funcionario = true,ativo_aluno = false
			where id_usuarios in (select id_usuarios from usuarios where id_tipos_usuarios_fk = 4);

			update usuarios set aluno = true, adm = false, instrutor =false,secretaria =false, ativo_funcionario = false,ativo_aluno = true
			where id_usuarios not in (select id_usuarios from usuarios where id_tipos_usuarios_fk <> 2);
			
			ALTER TABLE usuarios DROP CONSTRAINT IF EXISTS usuarios_tipos_fk;
			ALTER TABLE usuarios DROP COLUMN IF EXISTS id_tipos_usuarios_fk;
			
			DROP TABLE IF EXISTS tipos_usuarios CASCADE;
			ALTER TABLE usuarios DROP COLUMN IF EXISTS ativo;
			
		RETURN 'ATUALIZADO';
           END IF;
        RETURN NULL;
        END;
$$ LANGUAGE plpgsql;

select atualizaUsuariosTipos();

drop function atualizaUsuariosTipos();
	
 CREATE TABLE IF NOT EXISTS configuracao_boleto (
	id_configuracao_boleto BIGSERIAL NOT NULL,
	cedente_razao_social VARCHAR(50) NOT NULL,
	cedente_cnpj VARCHAR(20) NOT NULL,

	sacado_nome VARCHAR(50),
	sacado_cpf VARCHAR(11),
	sacado_endereco_uf VARCHAR(3),
	sacado_endereco_localidade VARCHAR(70),
	sacado_endereco_cep VARCHAR(11),
	sacado_endereco_bairro VARCHAR(50),
	sacado_endereco_logradouro VARCHAR(50),
	sacado_endereco_numero VARCHAR(10),

	banco VARCHAR(50),
	banco_numero VARCHAR(15),
	banco_numero_digito VARCHAR(5),
	banco_agencia VARCHAR(5),
	banco_agencia_variacao VARCHAR(5),
	banco_carteira VARCHAR(100),

	titulo_numero_do_documento VARCHAR(50),
	titulo_nosso_numero VARCHAR(50),
	titulo_digito_nosso_numero VARCHAR(50),
	titulo_valor FLOAT DEFAULT 0.0,
	titulo_desconto FLOAT DEFAULT 0.0,
	titulo_deducao FLOAT DEFAULT 0.0,
	titulo_mora FLOAT DEFAULT 0.0,
	titulo_acrescimo FLOAT DEFAULT 0.0,
	titulo_valor_cobrado FLOAT DEFAULT 0.0,
	titulo_data_documento DATE DEFAULT now(),
	titulo_data_vencimento DATE DEFAULT now(),
	titulo_tipo_documento VARCHAR(50) NOT NULL,
	titulo_aceite VARCHAR(1) NOT NULL,

	boleto_local_pagamento VARCHAR(100),
	boleto_instrucao_sacado VARCHAR(100),
	boleto_instrucao_1 VARCHAR(100),
	boleto_instrucao_2 VARCHAR(100),
	boleto_instrucao_3 VARCHAR(100),
	boleto_instrucao_4 VARCHAR(100),
	boleto_instrucao_5 VARCHAR(100),
	boleto_instrucao_6 VARCHAR(100),
	boleto_instrucao_7 VARCHAR(100),
	boleto_instrucao_8 VARCHAR(100),
	CONSTRAINT CONFIGURACAO_BOLETO_PK PRIMARY KEY (id_configuracao_boleto)
);
	
 CREATE TABLE IF NOT EXISTS funcionarios_acesso (
	id_funcionarios_acesso BIGSERIAL NOT NULL,
	id_usuario_fk BIGINT,
	livre BOOLEAN DEFAULT TRUE,
	ativo BOOLEAN DEFAULT TRUE,
	
	CONSTRAINT FUNCIONARIO_ACESSO_FAIXAS_PK PRIMARY KEY (id_funcionarios_acesso),
	CONSTRAINT FUNCIONARIO_ACESSO_USUARIO_FK FOREIGN KEY (id_usuario_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
 
 CREATE TABLE IF NOT EXISTS acesso_faixas (
	id_acesso_faixas BIGSERIAL NOT NULL,
	id_acesso_fk BIGINT,
	id_faixas_fk BIGINT,
	
	CONSTRAINT ACESSO_FAIXAS_PK PRIMARY KEY (id_acesso_faixas),
	CONSTRAINT ACESSO_FAIXAS_FAIXAS_FK FOREIGN KEY (id_faixas_fk)
	   REFERENCES faixas(id_faixas)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT ACESSO_FAIXAS_ACESSO_FK FOREIGN KEY (id_acesso_fk)
	   REFERENCES funcionarios_acesso(id_funcionarios_acesso)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
 
 CREATE TABLE IF NOT EXISTS acesso_dispositivos (
	id_acesso_dispositivos BIGSERIAL NOT NULL,
	id_acesso_fk BIGINT,
	id_dispositivos_fk BIGINT,
	
	CONSTRAINT ACESSO_DISPOSITIVOS_PK PRIMARY KEY (id_acesso_dispositivos),
	CONSTRAINT ACESSO_DISPOSITIVOS_DISPOSITIVOS_FK FOREIGN KEY (id_dispositivos_fk)
	   REFERENCES dispositivos(id_dispositivos)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT ACESSO_DISPOSITIVOS_ACESSO_FK FOREIGN KEY (id_acesso_fk)
	   REFERENCES funcionarios_acesso(id_funcionarios_acesso)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE OR REPLACE FUNCTION atualizaFluxoCaixa() RETURNS text AS $$
        BEGIN
           IF ((SELECT column_name FROM information_schema.columns WHERE table_name = 'fluxos_caixas' and column_name = 'id_usu_fk_abriu') = 'id_usu_fk_abriu') THEN
              RETURN 'TABELA OK';
	    ELSE
			ALTER TABLE fluxos_caixas
				ADD COLUMN id_usu_fk_abriu BIGINT,
				ADD COLUMN id_usu_fk_fechou BIGINT,
				ADD CONSTRAINT FLUXOS_CAIXA_USUARIO_FK_ABRIU FOREIGN KEY (id_usu_fk_abriu)
					REFERENCES usuarios(id_usuarios)
					MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
				ADD CONSTRAINT FLUXOS_CAIXA_USUARIO_FK_FECHOU FOREIGN KEY (id_usu_fk_fechou)
					REFERENCES usuarios(id_usuarios)
					MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

			ALTER TABLE reg_caixas
				ADD COLUMN id_usu_fk_reg BIGINT,
				ADD CONSTRAINT REGISTOS_CAIXA_USUARIO_FK_REGISTROU FOREIGN KEY (id_usu_fk_reg)
					REFERENCES usuarios(id_usuarios)
					MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;

			ALTER TABLE reg_contas_bancarias
				ADD COLUMN id_usu_fk_reg BIGINT,
				ADD CONSTRAINT REGISTOS_CONTA_BANCARIAS_USUARIO_FK_REGISTROU FOREIGN KEY (id_usu_fk_reg)
					REFERENCES usuarios(id_usuarios)
					MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION;					
			ALTER TABLE fluxos_caixas DROP CONSTRAINT IF EXISTS fluxos_caixas_operador_fk;
			ALTER TABLE fluxos_caixas DROP COLUMN IF EXISTS id_operador_fk;
		RETURN 'ATUALIZADO';
           END IF;
        RETURN NULL;
        END;
$$ LANGUAGE plpgsql;

select atualizaFluxoCaixa();

drop function atualizaFluxoCaixa();


CREATE OR REPLACE FUNCTION atualizaGruposMusculares() RETURNS text AS $$
        BEGIN
           IF (
           ( SELECT nome FROM grupos_musculares WHERE TRUE AND nome = 'Abdutores' ) = 'Abdutores') THEN
              RETURN 'TABELA OK';
	    ELSE
        	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Isquiotibiais','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Isquiotibiais');
                INSERT INTO grupos_musculares(nome,tipo) SELECT 'Abdutores','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Abdutores');
                INSERT INTO grupos_musculares(nome,tipo) SELECT 'Sóleo','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Sóleo');

		UPDATE grupos_musculares SET nome='Quadríceps' WHERE id_grupos_musculares = 8;
		UPDATE grupos_musculares SET nome='Gastrocnêmicos' WHERE id_grupos_musculares = 11;
                
        	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Stiff', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Isquiotibiais'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Mesa Flexora', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Isquiotibiais'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Flexora', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Isquiotibiais'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Agachamento Total', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Isquiotibiais'));

            	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Abdutora', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdutores'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Abdutores com polia Baixa', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdutores'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Abdução Quadril Apolete', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdutores'));
        	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Abdução Quadril Caneleira', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdutores'));
        	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Abdução Quadril Aparelho', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdutores'));

                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Sentado Apa', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Sóleo'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Sent. Barra', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Sóleo'));

                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Quadril Apolete', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Qua. Polia Baixa', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Avanço', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));

                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Leg', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));
                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Hack', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));

                INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Livre Alter', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Gastrocnêmicos'));
		RETURN 'ATUALIZADO';
           END IF;
        RETURN NULL;
        END;
$$ LANGUAGE plpgsql;

select atualizaGruposMusculares();

drop function atualizaGruposMusculares();
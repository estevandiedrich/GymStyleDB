/******************************************************************************/
/*                         ACADEMIA WEB                                       */
/******************************************************************************/

/******************************************************************************/
/*                       DROPANDO O BANCO                                     */
/******************************************************************************/

/*

DROP TABLE IF EXISTS usuarios_fichas CASCADE;
DROP TABLE IF EXISTS usuarios_fichas CASCADE;
DROP TABLE IF EXISTS log_aplicacao CASCADE;
DROP TABLE IF EXISTS dedos CASCADE;
DROP TABLE IF EXISTS liberacoes CASCADE;
DROP TABLE IF EXISTS digitais CASCADE;
DROP TABLE IF EXISTS digitais_espelho CASCADE;
DROP TABLE IF EXISTS motivos_bloqueio CASCADE;
DROP TABLE IF EXISTS operadores_perfis_acesso CASCADE;
DROP TABLE IF EXISTS avaliacoes_fisicas CASCADE;
DROP TABLE IF EXISTS treinos CASCADE;
DROP TABLE IF EXISTS usuarios_fichas CASCADE;
DROP TABLE IF EXISTS requisicoes CASCADE;
DROP TABLE IF EXISTS respostas CASCADE;
DROP TABLE IF EXISTS tipos_requisicao_resposta CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS faixas CASCADE;
DROP TABLE IF EXISTS eventos CASCADE;
DROP TABLE IF EXISTS dispositivos CASCADE;
DROP TABLE IF EXISTS planos CASCADE;
DROP TABLE IF EXISTS duracoes_plano CASCADE;
DROP TABLE IF EXISTS plano_modalidade CASCADE;
DROP TABLE IF EXISTS planos_usuarios CASCADE;
DROP TABLE IF EXISTS pagamentos CASCADE;
DROP TABLE IF EXISTS formas_pagamento CASCADE;
DROP TABLE IF EXISTS modalidades CASCADE;
DROP TABLE IF EXISTS perfis_acesso CASCADE;
DROP TABLE IF EXISTS dias_semana CASCADE;
DROP TABLE IF EXISTS series CASCADE;
DROP TABLE IF EXISTS exercicios CASCADE;
DROP TABLE IF EXISTS aparelhos CASCADE;
DROP TABLE IF EXISTS grupos_musculares CASCADE;
DROP TABLE IF EXISTS tipos_usuarios CASCADE;
DROP TABLE IF EXISTS modos_operacao CASCADE;
DROP TABLE IF EXISTS modalidades_instrutor CASCADE;
DROP TABLE IF EXISTS perfis_acesso_faixas CASCADE;
DROP TABLE IF EXISTS faixas_dispositivos CASCADE;
DROP TABLE IF EXISTS configuracoes CASCADE;
DROP TABLE IF EXISTS estados_civis CASCADE;
DROP TABLE IF EXISTS redes_sociais CASCADE;
DROP TABLE IF EXISTS protocolos;
DROP TABLE IF EXISTS empresas;

DROP TABLE IF EXISTS planos_contas CASCADE;
DROP TABLE IF EXISTS planos_contas CASCADE;
DROP TABLE IF EXISTS contas_pagar CASCADE;
DROP TABLE IF EXISTS contas_receber CASCADE;
DROP TABLE IF EXISTS caixas CASCADE;
DROP TABLE IF EXISTS fluxos_caixas CASCADE;
DROP TABLE IF EXISTS reg_caixas CASCADE;
DROP TABLE IF EXISTS bancos CASCADE;
DROP TABLE IF EXISTS contas_bancarias CASCADE;
DROP TABLE IF EXISTS reg_contas_bancarias CASCADE;

DROP TABLE IF EXISTS configuracao_boleto CASCADE;
DROP TABLE IF EXISTS funcionarios_acesso CASCADE;
DROP TABLE IF EXISTS acesso_faixas CASCADE;
DROP TABLE IF EXISTS acesso_dispositivos CASCADE;

DROP TABLE IF EXISTS categorias CASCADE;
DROP TABLE IF EXISTS fornecedores CASCADE;
DROP TABLE IF EXISTS produtos CASCADE;
DROP TABLE IF EXISTS vendas CASCADE;
DROP TABLE IF EXISTS item_vendas CASCADE;

DROP FUNCTION IF EXISTS atualiza_status_sincronizado();
DROP FUNCTION IF EXISTS atualiza_status_usuario();
DROP FUNCTION IF EXISTS script_povoamento();
DROP FUNCTION IF EXISTS insercoes();
DROP FUNCTION IF EXISTS gymstyle_povoamento();
DROP FUNCTION IF EXISTS remove_requisicao_resposta();
DROP FUNCTION IF EXISTS removeacento(character varying);

*/

-------------------------------------------------------------------------------

/******************************************************************************/
/*                                   Tables                                   */
/******************************************************************************/

CREATE TABLE IF NOT EXISTS temp();
drop table if exists temp;

CREATE TABLE IF NOT EXISTS configuracoes (
	id_configuracoes BIGSERIAL NOT NULL,
	campo VARCHAR(70) NOT NULL,
	descricao VARCHAR(70) NOT NULL,
	valor VARCHAR(70) NOT NULL,
	CONSTRAINT CONFIGURACOES_PK PRIMARY KEY (id_configuracoes)
);

CREATE TABLE IF NOT EXISTS protocolos (
	id_protocolos BIGSERIAL NOT NULL,
	nome VARCHAR(70) NOT NULL,
	CONSTRAINT PROTOCOLO_PK PRIMARY KEY (id_protocolos)
);

CREATE TABLE IF NOT EXISTS tipos_usuarios (
	id_tipos_usuarios BIGSERIAL NOT NULL,
	nome VARCHAR(50) NOT NULL,
	CONSTRAINT TIPOS_USUARIOS_PK PRIMARY KEY (id_tipos_usuarios)
);

CREATE TABLE IF NOT EXISTS modos_operacao (
	id_modos_operacao BIGSERIAL NOT NULL,
	nome VARCHAR(35) NOT NULL,
	CONSTRAINT MODOS_OPERACAO_PK PRIMARY KEY (id_modos_operacao)
);

CREATE TABLE IF NOT EXISTS redes_sociais (
	id_redes_sociais BIGSERIAL NOT NULL,
	nome VARCHAR(35) NOT NULL,
	CONSTRAINT REDES_SOCIAS_PK PRIMARY KEY (id_redes_sociais)
);

CREATE TABLE IF NOT EXISTS estados_civis (
	id_estados_civis BIGSERIAL NOT NULL,
	nome VARCHAR(35) NOT NULL,
	CONSTRAINT ESTADO_CIVIL_PK PRIMARY KEY (id_estados_civis)
);

CREATE TABLE IF NOT EXISTS usuarios (
	id_usuarios BIGSERIAL NOT NULL,
	nome VARCHAR(52) NOT NULL,
	data_nascimento DATE,
	cpf CHAR(11),
	rg VARCHAR(15),
	foto VARCHAR(10000),
	sexo CHAR(1) NOT NULL,
	telefone CHAR(15),
	celular CHAR(15),
	email VARCHAR(255),
	data_cadastro DATE DEFAULT NOW(),
	endereco VARCHAR(255),
	bairro CHAR(60), 
	complemento CHAR(40),
	cidade VARCHAR(100),
	uf CHAR(2),
	cep CHAR(10),
	cartao_proximidade VARCHAR(20),
	cartao_proximidade_catraca VARCHAR(20),
	login VARCHAR(60),
	senha VARCHAR(60),
	profissao CHAR(40),
	estado_civil_fk BIGINT,
	numero_filhos CHAR(15),
	rede_social_fk BIGINT,
	observacao CHAR(255),
	sincronizado BOOLEAN DEFAULT FALSE,
	ativo BOOLEAN DEFAULT FALSE,
	matricula BIGINT,
	id_tipos_usuarios_fk BIGINT,
	CONSTRAINT USUARIOS_PK PRIMARY KEY (id_usuarios),
	CONSTRAINT USUARIOS_TIPOS_FK FOREIGN KEY (id_tipos_usuarios_fk)
	   REFERENCES tipos_usuarios(id_tipos_usuarios)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT USUARIOS_ESTADO_CIVIL_FK FOREIGN KEY (estado_civil_fk)
	   REFERENCES estados_civis(id_estados_civis)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT REDES_SOCIAIS_FK FOREIGN KEY (rede_social_fk)
	   REFERENCES redes_sociais(id_redes_sociais)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS empresas (
	id_empresas BIGSERIAL NOT NULL,
	razao_social VARCHAR(70) NOT NULL,
	nome_fantasia VARCHAR(70) NOT NULL,
	logo VARCHAR(10000),
	cnpj VARCHAR(70) NOT NULL,
	telefone CHAR(15) NOT NULL,
	endereco VARCHAR(150) NOT NULL,
	bairro CHAR(60), 
	cidade VARCHAR(100),
	uf CHAR(2),
	cep CHAR(10),

	CONSTRAINT EMPRESAS_PK PRIMARY KEY (id_empresas)
);

CREATE TABLE IF NOT EXISTS log_aplicacao (
	id_log_aplicacao BIGSERIAL NOT NULL,
	data_log TIMESTAMP DEFAULT NOW(),
	descricao VARCHAR(70) NOT NULL,
	tipo VARCHAR(40),
	parametro BIGINT,
	id_usuario_fk BIGINT NOT NULL,
	CONSTRAINT LOG_APLICACAO_PK PRIMARY KEY (id_log_aplicacao),
	CONSTRAINT LOG_APLICACAO_USUARIO_FK FOREIGN KEY (id_usuario_fk)
	   REFERENCES usuarios(id_usuarios) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS dedos (
	id_dedos BIGSERIAL NOT NULL,
	dedo VARCHAR(30) NOT NULL,
	CONSTRAINT DEDO_PK PRIMARY KEY (id_dedos)
);

CREATE TABLE IF NOT EXISTS digitais (
	id_digitais BIGSERIAL NOT NULL,
	template1 CHAR(806) NOT NULL,
	template2 CHAR(800) NOT NULL,

	id_dedos_fk BIGINT,
	id_usuarios_fk BIGINT NOT NULL,
	CONSTRAINT DIGITAIS_PK PRIMARY KEY (id_digitais),
	CONSTRAINT DIGITAIS_USUARIO_FK FOREIGN KEY (id_usuarios_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT DIGITAIS_DEDO_FK FOREIGN KEY (id_dedos_fk)
	   REFERENCES dedos(id_dedos)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS digitais_espelho (
	id_digitais BIGSERIAL NOT NULL,
	template1 CHAR(806) NOT NULL,
	template2 CHAR(800) NOT NULL,
	id_dedos_fk BIGINT,
	id_usuarios_fk BIGINT NOT NULL,
	CONSTRAINT DIGITAIS_ESPELHO_PK PRIMARY KEY (id_digitais),
	CONSTRAINT DIGITAIS_ESPELHO_USUARIO_FK FOREIGN KEY (id_usuarios_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT DIGITAIS_ESPELHO_DEDO_FK FOREIGN KEY (id_dedos_fk)
	   REFERENCES dedos(id_dedos)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS motivos_bloqueio (
	id_motivos_bloqueio BIGSERIAL NOT NULL,
	motivo VARCHAR(50) NOT NULL,
	CONSTRAINT MOTIVOS_BLOQUEIO_PK PRIMARY KEY (id_motivos_bloqueio)
);

CREATE TABLE IF NOT EXISTS dispositivos (
	id_dispositivos BIGSERIAL NOT NULL,
	nome VARCHAR(255),
	online BOOLEAN,
	endereco_ip VARCHAR(15),
	endereco_mac VARCHAR(17) UNIQUE,
	porta INTEGER,
	ativo BOOLEAN DEFAULT TRUE,
	imprime BOOLEAN DEFAULT FALSE,
	ultimo_evento INTEGER DEFAULT 0,
	entrada_dir_esq INTEGER DEFAULT 0,
	id_modos_operacao_fk BIGINT DEFAULT 2,
	modo_acesso BIGINT DEFAULT 1,
	CONSTRAINT DISPOSITIVOS_PK PRIMARY KEY (id_dispositivos),
	CONSTRAINT DIPOSITIVOS_MODO_OPERACAO FOREIGN KEY (id_modos_operacao_fk)
	   REFERENCES modos_operacao(id_modos_operacao)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS liberacoes (
	id_liberacoes BIGSERIAL NOT NULL,
	data_hora TIMESTAMP DEFAULT NOW(),
	justificativa VARCHAR(255),
	id_operador_fk BIGINT,
	id_dispositivos_fk BIGINT,
	CONSTRAINT LIBERACOES_PK PRIMARY KEY (id_liberacoes),
	CONSTRAINT LIBERACOES_OPERADOR_FK FOREIGN KEY (id_operador_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT LIBERACOES_DISPOSITIVOS_FK FOREIGN KEY (id_dispositivos_fk)
	   REFERENCES dispositivos(id_dispositivos)
	      MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS duracoes_plano (
	id_duracoes_plano BIGSERIAL NOT NULL,
	duracao VARCHAR(50) NOT NULL,
	
	CONSTRAINT DURACOES_PLANO_PK PRIMARY KEY (id_duracoes_plano)
);

CREATE TABLE IF NOT EXISTS planos (
	id_planos BIGSERIAL NOT NULL,
	nome VARCHAR(100),
	desconto_percentual FLOAT,
	desconto_real INT,
	valor_total FLOAT,
	valor_matricula FLOAT,
	valor FLOAT,
	observacao VARCHAR(300),
	ativo BOOLEAN DEFAULT TRUE,
	
	CONSTRAINT PLANOS_PK PRIMARY KEY (id_planos)
);

CREATE TABLE IF NOT EXISTS formas_pagamento (
	id_formas_pagamento BIGSERIAL NOT NULL,
	nome VARCHAR(50) NOT NULL,
	
	CONSTRAINT FORMAS_PAGAMENTO_PK PRIMARY KEY (id_formas_pagamento)
);

CREATE TABLE IF NOT EXISTS perfis_acesso (
	id_perfis_acesso BIGSERIAL NOT NULL,
	nome VARCHAR(50) NOT NULL,
	
	CONSTRAINT PERFIS_ACESSO_PK PRIMARY KEY (id_perfis_acesso)
);

CREATE TABLE IF NOT EXISTS modalidades (
	id_modalidades BIGSERIAL NOT NULL,
	nome VARCHAR(50) NOT NULL,
	valor1 FLOAT,
	valor2 FLOAT,
	valor3 FLOAT,
	valor4 FLOAT,
	valor5 FLOAT,
	valor6 FLOAT,
	valor7 FLOAT,
	ativo BOOLEAN DEFAULT TRUE,
	qtde_acessos INTEGER DEFAULT 0,
	id_perfis_acesso_fk BIGINT,
	
	CONSTRAINT MODALIDADES_PK PRIMARY KEY (id_modalidades),
	CONSTRAINT PERFIL_ACESSO_FK FOREIGN KEY (id_perfis_acesso_fk)
	   REFERENCES perfis_acesso(id_perfis_acesso) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS modalidades_instrutor (
	id_modalidades_instrutor BIGSERIAL NOT NULL,
	id_modalidades_fk BIGINT NOT NULL,
	id_instrutor_fk BIGINT NOT NULL,	
	
	CONSTRAINT MODALIDADES_INSTRUTOR_PK PRIMARY KEY (id_modalidades_instrutor),
	CONSTRAINT MODALIDADES_INSTRUTOR_MODALIDADE_FK FOREIGN KEY (id_modalidades_fk)
	   REFERENCES modalidades(id_modalidades) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT MODALIDADES_INSTRUTOR_INSTRUTOR_FK FOREIGN KEY (id_instrutor_fk)
	   REFERENCES usuarios(id_usuarios) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS operadores_perfis_acesso (
	id_operadores_perfis_acesso BIGSERIAL NOT NULL,
	id_operador_fk BIGINT NOT NULL,
	id_perfis_acesso_fk BIGINT NOT NULL,

	CONSTRAINT OPERADORES_PERFIS_ACESSO_PK PRIMARY KEY (id_operadores_perfis_acesso),
	CONSTRAINT OPERADORES_PERFIS_ACESSO_OPERADOR_FK FOREIGN KEY (id_operador_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT OPERADORES_PERFIS_ACESSO_PERFIS_ACESSO_FK FOREIGN KEY (id_perfis_acesso_fk)
	   REFERENCES perfis_acesso(id_perfis_acesso) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS dias_semana (
	id_dias_semana BIGSERIAL NOT NULL,
	nome VARCHAR(15) NOT NULL,
	CONSTRAINT DIAS_SEMANA_PK PRIMARY KEY (id_dias_semana)
);

CREATE TABLE IF NOT EXISTS faixas (
	id_faixas BIGSERIAL NOT NULL,
	horario_inicio TIME NOT NULL,
	horario_fim TIME NOT NULL,
	id_dias_semana_fk BIGINT NOT NULL,
	CONSTRAINT FAIXAS_PK PRIMARY KEY (id_faixas),
	CONSTRAINT FAIXAS_DIAS_SEMANA_FK FOREIGN KEY (id_dias_semana_fk)
	   REFERENCES dias_semana(id_dias_semana)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS faixas_dispositivos (
	id_faixas_dispositivos BIGSERIAL NOT NULL,
	id_faixas_fk BIGINT,
	id_dispositivos_fk BIGINT,
	
	CONSTRAINT FAIXAS_DISPOSITIVOS_PK PRIMARY KEY (id_faixas_dispositivos),
	CONSTRAINT FAIXAS_DISPOSITIVOS_FAIXAS_FK FOREIGN KEY (id_faixas_fk)
	   REFERENCES faixas(id_faixas) 
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
	CONSTRAINT FAIXAS_DISPOSITIVOS_DISPOSITIVOS_FK FOREIGN KEY (id_dispositivos_fk)
	   REFERENCES dispositivos(id_dispositivos) 
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS avaliacoes_fisicas (
	id_avaliacoes_fisicas BIGSERIAL NOT NULL,
	data_avaliacao DATE NOT NULL,
	descricao VARCHAR(255),
	peso FLOAT,
	altura FLOAT,
	imc FLOAT,
	braco_dir FLOAT,
	braco_esq FLOAT,
	coxa_dir FLOAT,
	coxa_esq FLOAT,
	panturrilha_dir FLOAT,
	panturrilha_esq FLOAT,
	torax FLOAT,
	quadril FLOAT,
	cintura FLOAT,
	abdomen FLOAT,
	subescapular FLOAT,
	tricipital FLOAT,
	peitoral FLOAT,
	abdominal FLOAT,
	supra_iliaca FLOAT,
	coxa FLOAT,
	panturrilha FLOAT,
	axilar_media FLOAT,
	gordura_atual FLOAT,
	gordura_ideal VARCHAR(30),
	massa_magra FLOAT,
	massa_gorda FLOAT,

	data_proxima_avaliacao DATE,
	id_aluno_fk BIGINT NOT NULL,
	id_instrutor_fk BIGINT NOT NULL,
	id_protocolo_fk BIGINT NOT NULL,
	CONSTRAINT AVALIACOES_FISICAS_PK PRIMARY KEY (id_avaliacoes_fisicas),
	CONSTRAINT AVALIACOES_FISICAS_ALUNO_FK FOREIGN KEY (id_aluno_fk)
	   REFERENCES usuarios(id_usuarios) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT AVALIACOES_FISICAS_INSTRUTOR_FK FOREIGN KEY (id_instrutor_fk)
	   REFERENCES usuarios(id_usuarios) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT AVALIACOES_FISICAS_PROTOCOLO_FK FOREIGN KEY (id_protocolo_fk)
	   REFERENCES protocolos (id_protocolos) 
	      MATCH SIMPLE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS plano_modalidade (
	id_plano_modalidade BIGSERIAL NOT NULL,
	id_planos_fk BIGINT NOT NULL,
	id_modalidades_fk BIGINT NOT NULL,
	qtde_acesso_semana INT DEFAULT 0,
	CONSTRAINT PLANO_MODALIDADE_PK PRIMARY KEY (id_plano_modalidade),
	CONSTRAINT PLANO_MODALIDADE_PLANOS_FK FOREIGN KEY (id_planos_fk)
	   REFERENCES planos(id_planos) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT PLANO_MODALIDADE_MODALIDADES_FK FOREIGN KEY (id_modalidades_fk)
	   REFERENCES modalidades(id_modalidades) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);
CREATE TABLE IF NOT EXISTS usuarios_fichas (
	id_usuarios_fichas BIGSERIAL NOT NULL,
	data DATE NOT NULL DEFAULT now(),
	ativa BOOLEAN,
	periodo_inicial DATE,
	periodo_final DATE,
	descricao VARCHAR(255),
	id_instrutor_fk BIGINT NOT NULL,
	id_usuarios_fk BIGINT NOT NULL,
	CONSTRAINT USUARIOS_FICHAS_PK PRIMARY KEY (id_usuarios_fichas),
	CONSTRAINT USUARIOS_FICHAS_INSTRUTOR_FK FOREIGN KEY (id_instrutor_fk)
	   REFERENCES usuarios(id_usuarios) 
	      	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
	CONSTRAINT USUARIOS_FICHAS_USUARIOS_FK FOREIGN KEY (id_usuarios_fk)
	   REFERENCES usuarios(id_usuarios) 
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL
);
CREATE TABLE IF NOT EXISTS planos_usuarios (
	id_planos_usuarios BIGSERIAL NOT NULL,
	id_planos_fk BIGINT NOT NULL,
	id_usuarios_fk BIGINT NOT NULL,
	id_duracoes_plano_fk BIGINT,
	valor_cancelado FLOAT,
	cancelado BOOLEAN DEFAULT FALSE,
	finalizado BOOLEAN DEFAULT FALSE,
	CONSTRAINT PLANOS_USUARIOS_PK PRIMARY KEY (id_planos_usuarios),
	CONSTRAINT PLANOS_USUARIOS_PLANO_FK FOREIGN KEY (id_planos_fk)
	   REFERENCES planos(id_planos) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT PLANOS_USUARIOS_USUARIO_FK FOREIGN KEY (id_usuarios_fk)
	   REFERENCES usuarios(id_usuarios) 
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE SET NULL,
	CONSTRAINT DURACAO_PLANO_FK FOREIGN KEY (id_duracoes_plano_fk)
	   REFERENCES duracoes_plano (id_duracoes_plano) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS pagamentos (
	id_pagamentos BIGSERIAL NOT NULL,
	inicio_acesso DATE NOT NULL,
	fim_acesso DATE NOT NULL,
	vencimento DATE NOT NULL,
	pagamento TIMESTAMP DEFAULT NOW(),
	numero_parcela INTEGER,
	tolerancia INTEGER,
	desconto FLOAT DEFAULT 0.0,
	multa FLOAT DEFAULT 0.0,
	justificativa VARCHAR(255),
	valor FLOAT NOT NULL,
	valor_pago FLOAT,
	postergar BOOLEAN,
	imprimir BOOLEAN DEFAULT false,
	imprimir_entrada BOOLEAN DEFAULT false,
	
	id_formas_pagamento_fk BIGINT,
	id_planos_usuarios_fk BIGINT,
	id_funcionarios_fk BIGINT,
	CONSTRAINT PAGAMENTOS_PK PRIMARY KEY (id_pagamentos),
	CONSTRAINT PAGAMENTOS_FORMA_PAGAMENTO_FK FOREIGN KEY (id_formas_pagamento_fk)
	   REFERENCES formas_pagamento(id_formas_pagamento)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT PAGAMENTOS_FUNCIONARIOS_FK FOREIGN KEY (id_funcionarios_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE SET NULL ON DELETE set null,
	CONSTRAINT PAGAMENTOS_PLANOS_USUARIOS_FK FOREIGN KEY (id_planos_usuarios_fk)
	   REFERENCES planos_usuarios(id_planos_usuarios)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE IF NOT EXISTS treinos (
	id_treinos BIGSERIAL NOT NULL,
	nome VARCHAR(50) NOT NULL,
	treino_domingo BOOLEAN DEFAULT false,
	treino_segunda BOOLEAN DEFAULT false,
	treino_terca BOOLEAN DEFAULT false,
	treino_quarta BOOLEAN DEFAULT false,
	treino_quinta BOOLEAN DEFAULT false,
	treino_sexta BOOLEAN DEFAULT false,
	treino_sabado BOOLEAN DEFAULT false,
	id_fichas_fk BIGINT NOT NULL,
	CONSTRAINT TREINOS_PK PRIMARY KEY (id_treinos),
	CONSTRAINT TREINOS_FICHA_FK FOREIGN KEY (id_fichas_fk)
	   REFERENCES usuarios_fichas(id_usuarios_fichas) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS aparelhos (
	id_aparelhos BIGSERIAL NOT NULL,
	nome VARCHAR(35) NOT NULL,
	descricao VARCHAR(255),
	CONSTRAINT APARELHOS_PK PRIMARY KEY (id_aparelhos)
);

CREATE TABLE IF NOT EXISTS grupos_musculares (
	id_grupos_musculares BIGSERIAL NOT NULL,
	nome VARCHAR(26),
	tipo VARCHAR(15),
	CONSTRAINT GRUPOS_MUSCULARES_PK PRIMARY KEY (id_grupos_musculares)
);

CREATE TABLE IF NOT EXISTS exercicios (
	id_exercicios BIGSERIAL NOT NULL,
	nome VARCHAR(25) NOT NULL,
	descricao VARCHAR(255),
	id_aparelhos_fk BIGINT ,
	id_grupos_musculares_fk BIGINT ,

	CONSTRAINT EXERCICIOS_PK PRIMARY KEY (id_exercicios),
	CONSTRAINT EXERCICIOS_APARELHOS_FK FOREIGN KEY (id_aparelhos_fk)
	   REFERENCES aparelhos(id_aparelhos)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT EXERCICIOS_GRUPOS_MUSCULARES_FK FOREIGN KEY (id_grupos_musculares_fk)
	   REFERENCES grupos_musculares(id_grupos_musculares) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS series (
	id_series BIGSERIAL NOT NULL,
	series VARCHAR(3) NOT NULL,
	repeticoes VARCHAR(11) NOT NULL,
	carga VARCHAR(15) NOT NULL,
	ordem BIGINT,

	id_treinos_fk BIGINT NOT NULL,
	id_exercicios_fk BIGINT NOT NULL,
	CONSTRAINT SERIES_PK PRIMARY KEY (id_series),
	CONSTRAINT SERIES_EXERCICIOS_FK FOREIGN KEY (id_exercicios_fk)
	   REFERENCES exercicios(id_exercicios) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT SERIES_TREINOS_FK FOREIGN KEY (id_treinos_fk)
	   REFERENCES treinos(id_treinos)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE

);

CREATE TABLE IF NOT EXISTS tipos_requisicao_resposta (
	id_tipos_requisicao_resposta BIGSERIAL NOT NULL,
	nome VARCHAR(50) NOT NULL,
	CONSTRAINT TIPO_REQUISICAO_RESPOSTA_PK PRIMARY KEY (id_tipos_requisicao_resposta)
);

CREATE TABLE IF NOT EXISTS requisicoes (
	id_requisicao BIGSERIAL NOT NULL,
	data_hora TIMESTAMP DEFAULT NOW(),
	parametro BIGINT,
	status BOOLEAN DEFAULT FALSE,
	destino BIGINT,
	referencia BIGINT,
	id_operador_fk BIGINT,
	tipo_requisicao_fk BIGINT NOT NULL,

	CONSTRAINT REQUISICOES_PK PRIMARY KEY (id_requisicao),
	CONSTRAINT REQUISICOES_DESTINO_FK FOREIGN KEY (destino)
	   REFERENCES dispositivos(id_dispositivos)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REQUISICOES_OPERADOR_FK FOREIGN KEY (id_operador_fk)
	   REFERENCES usuarios(id_usuarios)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REQUISICOES_TIPO_FK FOREIGN KEY (tipo_requisicao_fk)
	   REFERENCES tipos_requisicao_resposta(id_tipos_requisicao_resposta) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS respostas (
	id_respostas BIGSERIAL NOT NULL,
	destino BIGINT,
	mensagem_erro VARCHAR(255),
	data_hora TIMESTAMP DEFAULT NOW(),
	tipo_resposta_fk BIGINT NOT NULL,

	CONSTRAINT RESPOSTAS_PK PRIMARY KEY (id_respostas),
	CONSTRAINT RESPOSTAS_TIPO_FK FOREIGN KEY (tipo_resposta_fk)
	   REFERENCES tipos_requisicao_resposta(id_tipos_requisicao_resposta) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS eventos(
	id_eventos BIGSERIAL NOT NULL,
	data_hora TIMESTAMP NOT NULL,
	criado TIMESTAMP DEFAULT NOW(),
	realizado BOOLEAN,
	entrada BOOLEAN,
	offline BOOLEAN NOT NULL,
	posicao INTEGER,
	motivo BIGINT NOT NULL,
	id_dispositivos_fk BIGINT NOT NULL,
	id_usuarios_fk BIGINT,
	CONSTRAINT EVENTOS_PK PRIMARY KEY (id_eventos),
	CONSTRAINT EVENTOS_MOTIVOS_BLOQUEIO_FK FOREIGN KEY (motivo)
	   REFERENCES motivos_bloqueio(id_motivos_bloqueio)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT EVENTOS_DISPOSITIVOS_FK FOREIGN KEY (id_dispositivos_fk)
	   REFERENCES dispositivos(id_dispositivos) 
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);

CREATE TABLE IF NOT EXISTS perfis_acesso_faixas (
	id_perfis_acesso_faixas BIGSERIAL NOT NULL,
	id_perfis_acesso_fk BIGINT NOT NULL,
	id_faixas_fk BIGINT NOT NULL,

	CONSTRAINT PERFIS_ACESSO_FAIXAS_PK PRIMARY KEY (id_perfis_acesso_faixas),
	CONSTRAINT PERFIS_ACESSO_FAIXAS_PERFIS_ACESSO_FK FOREIGN KEY (id_perfis_acesso_fk)
	   REFERENCES perfis_acesso(id_perfis_acesso) 
	      MATCH SIMPLE ON DELETE CASCADE,
	CONSTRAINT PERFIS_ACESSO_FAIXAS_FAIXAS_FK FOREIGN KEY (id_faixas_fk)
	   REFERENCES faixas(id_faixas)
	      MATCH SIMPLE ON DELETE CASCADE
);

----------------------------------------------------------------------------------------------------------
------------------      VERSAO 1.6       -----------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS planos_contas (
	id_planos_contas BIGSERIAL NOT NULL,
	descricao VARCHAR(300),
	receita BOOLEAN,
	despesa BOOLEAN,
	ativo BOOLEAN,
	valor FLOAT,
	
	CONSTRAINT PLANOS_CONTAS_PK PRIMARY KEY (id_planos_contas)
);

CREATE TABLE IF NOT EXISTS contas_pagar (
	id_contas_pagar BIGSERIAL NOT NULL,
	descricao VARCHAR(300),
	data_hora timestamp,
	valor_pagar FLOAT,
	valor_pago FLOAT,
	id_formas_pagamento_fk bigint,
	id_planos_contas_fk bigint,
	
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
	valor_receber FLOAT,
	valor_recebido FLOAT,
	id_formas_pagamento_fk bigint,
	id_planos_contas_fk bigint,

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
	abertura timestamp,
	fechamento timestamp,
	valor_inicial FLOAT,
	valor_final FLOAT,
	vi_dinheiro FLOAT, -- valor inicial em dinheiro
	vi_cheque FLOAT,
	vi_cartao FLOAT,
	vi_boleto FLOAT,
	vi_deposito FLOAT,
	vf_dinheiro FLOAT, -- valor final em dinheiro
	vf_cheque FLOAT,
	vf_cartao FLOAT,
	vf_boleto FLOAT,
	vf_deposito FLOAT,
	id_operador_fk bigint,
	id_reg_contas_bancarias_fk bigint,
	
	CONSTRAINT FLUXOS_CAIXAS_PK PRIMARY KEY (id_fluxos_caixas),
	CONSTRAINT FLUXOS_CAIXAS_OPERADOR_FK FOREIGN KEY (id_operador_fk)
	   REFERENCES usuarios(id_usuarios)
);

CREATE TABLE IF NOT EXISTS reg_caixas (
	id_reg_caixas BIGSERIAL NOT NULL,
	valor FLOAT,
	descricao VARCHAR(300),
	recebimento boolean,
	retirada boolean,
	id_formas_pagamento_fk bigint,
	id_parcela_fk bigint,
	id_produto_fk bigint,
	id_contas_pagar_fk bigint,
	id_contas_receber_fk bigint,
	
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
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION

);

CREATE TABLE IF NOT EXISTS contas_bancarias (
	id_contas_bancarias BIGSERIAL NOT NULL,
	nome VARCHAR(70) NOT NULL,
	CONSTRAINT CONTAS_BANCACARIAS_PK PRIMARY KEY (id_contas_bancarias)
);

CREATE TABLE IF NOT EXISTS reg_contas_bancarias (
	id_reg_contas_bancarias BIGSERIAL NOT NULL,
	data_hora timestamp,
	valor FLOAT,
	descricao VARCHAR(300),
	recebimento boolean,
	retirada boolean,
	id_formas_pagamento_fk bigint,
	id_reg_caixas_fk bigint,
	
	CONSTRAINT REG_CONTAS_BANCARIAS_PK PRIMARY KEY (id_reg_contas_bancarias),
	CONSTRAINT REG_CAIXAS_BANCARIAS_FORMA_PAGAMENTO_FK FOREIGN KEY (id_formas_pagamento_fk)
	   REFERENCES formas_pagamento(id_formas_pagamento)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
	CONSTRAINT REG_CAIXAS_BANCARIAS_REG_CAIXAS_FK FOREIGN KEY (id_reg_caixas_fk)
	   REFERENCES reg_caixas(id_reg_caixas)
	      MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION

);

----------------------------------------------------------------------------------------------------------
------- Versão 1.7 ---------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

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

--------------------------------------------------------------------------------------------------------------------------------
----------------  Versao 1.8  --------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------

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


----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------




CREATE OR REPLACE FUNCTION insercoes() RETURNS TEXT AS $$
        BEGIN

	/******************************************************************************/
	/*                       INSERÇÕES PADRÃO                                     */
	/******************************************************************************/
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Bloqueado');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Liberado');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Fora da Faixa de Horário');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Falta de Pagamento');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Dupla Entrada / Saída');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Fora do Período de Acesso');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Cartão Inválido');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Senha Inválida');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Impressão Digital Inválida');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Obstrução da Catraca');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Violação da Catraca');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Dupla Passagem');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Acesso Realizado');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Acesso Bloqueado');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Acesso Bloqueado por Tempo Excedido');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Limite de Dias Excedido');
	INSERT INTO motivos_bloqueio (motivo) VALUES ('Sentido Bloqueado');

	/* Durações planos*/
	INSERT INTO duracoes_plano(duracao)VALUES ('Diário');
	INSERT INTO duracoes_plano(duracao)VALUES ('Semanal');
	INSERT INTO duracoes_plano(duracao)VALUES ('Mensal');
	INSERT INTO duracoes_plano(duracao)VALUES ('Bimestral');
	INSERT INTO duracoes_plano(duracao)VALUES ('Trimestral');
	INSERT INTO duracoes_plano(duracao)VALUES ('Quadrimestral');
	INSERT INTO duracoes_plano(duracao)VALUES ('Semestral');
	INSERT INTO duracoes_plano(duracao)VALUES ('Anual');

	INSERT INTO formas_pagamento (nome) VALUES ('Dinheiro');
	INSERT INTO formas_pagamento (nome) VALUES ('Boleto');
	INSERT INTO formas_pagamento (nome) VALUES ('Cartão (Débito)');
	INSERT INTO formas_pagamento (nome) VALUES ('Cartão (Crédito)');
	INSERT INTO formas_pagamento (nome) VALUES ('Cheque');

	INSERT INTO dias_semana (nome) VALUES ('Domingo');
	INSERT INTO dias_semana (nome) VALUES ('Segunda');
	INSERT INTO dias_semana (nome) VALUES ('Terça');
	INSERT INTO dias_semana (nome) VALUES ('Quarta');
	INSERT INTO dias_semana (nome) VALUES ('Quinta');
	INSERT INTO dias_semana (nome) VALUES ('Sexta');
	INSERT INTO dias_semana (nome) VALUES ('Sábado');
	INSERT INTO dias_semana (nome) VALUES ('Feriado');

	INSERT INTO tipos_requisicao_resposta (id_tipos_requisicao_resposta,nome) VALUES (0,'Descobrir Dispositivos na Rede');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Cadastrar Usuário');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Atualizar Usuário');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Excluir Usuário');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Liberar / Bloquear Acesso');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Verificar Eventos Offline');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Hora');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Modo de Operação');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Liberar Acesso Indefinidamente');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Bloquear Acesso Indefinidamente');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Liberar Um Acesso');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Obter Impressão Digital');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Cancelar Impressão Digital');

	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Alarme Usuário');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Alarme Violação');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Alarme Obstrução');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Alarme Tail Gate');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Ativação de Solenóide');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Tempo de Passagem');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Atividade Suspeita');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Reset');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('Configurar Sentido de Entrada');
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('CONFIGURAR_CATRACA');/* Antigo CONFIGURAR IMPRESSAO*/	
	INSERT INTO tipos_requisicao_resposta (nome) SELECT 'IMPRESSAO_PAGAMENTO' WHERE NOT EXISTS (SELECT id_tipos_requisicao_resposta FROM tipos_requisicao_resposta WHERE id_tipos_requisicao_resposta = 23);


	INSERT INTO modos_operacao (nome) VALUES ('Apenas Online');
	INSERT INTO modos_operacao (nome) VALUES ('Online / Offline');
	/* INSERT INTO modos_operacao (nome) VALUES ('Apenas Offline'); */

	INSERT INTO tipos_usuarios (nome) VALUES ('Administrador(a)');
	INSERT INTO tipos_usuarios (nome) VALUES ('Aluno(a)');
	INSERT INTO tipos_usuarios (nome) VALUES ('Instrutor(a)');
	INSERT INTO tipos_usuarios (nome) VALUES ('Secretário(a)');

	INSERT INTO usuarios(nome,data_nascimento, sexo, login, senha, id_tipos_usuarios_fk,cpf,matricula)
	    VALUES ('Administrador','1980-01-01', 'M', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1,'11111111111', 1);

	INSERT INTO configuracoes(campo, descricao, valor) VALUES ( 'diaVencimento', 'Dia de Vencimento', '10');
	INSERT INTO configuracoes(campo, descricao, valor) VALUES ( 'tolerancia', 'Tolerância', '5');
	INSERT INTO configuracoes(campo, descricao, valor) select 'rodapeRecibo', 'Rodapé Recibo', 'SEM VALOR FISCAL' WHERE NOT EXISTS (SELECT id_configuracoes FROM configuracoes WHERE campo = 'rodapeRecibo');

	INSERT INTO dedos(dedo) VALUES ('Polegar Direito');
	INSERT INTO dedos(dedo) VALUES ('Indicador Direito');
	INSERT INTO dedos(dedo) VALUES ('Médio Direito');
	INSERT INTO dedos(dedo) VALUES ('Anelar Direito');
	INSERT INTO dedos(dedo) VALUES ('Mínimo Direito');

	INSERT INTO dedos(dedo) VALUES ('Polegar Esquerdo');
	INSERT INTO dedos(dedo) VALUES ('Indicador Esquerdo');
	INSERT INTO dedos(dedo) VALUES ('Médio Esquerdo');
	INSERT INTO dedos(dedo) VALUES ('Anelar Esquerdo');
	INSERT INTO dedos(dedo) VALUES ('Mínimo Esquerdo');

	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Peitoral','Superior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Dorsal','Superior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Trapézio','Superior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Deltóide','Superior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Tríceps','Superior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Bíceps','Superior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Antebraço','Superior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Quadríceps e Isquiótibias','Inferior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Glúteos','Inferior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Adutores','Inferior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Gastrocnêmicos e Sóleo','Inferior');
	INSERT INTO grupos_musculares(nome,tipo) VALUES ('Abdomen','Centro');

	INSERT INTO empresas(razao_social, nome_fantasia, logo, cnpj, telefone, endereco) SELECT 'ACADEMIA', 'ACADEMIA', '', '', '', '' 
		WHERE NOT EXISTS (SELECT id_empresas FROM empresas WHERE id_empresas = 1);
			
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supino Reto', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supino Inclinado', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supino Declinado', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Fly', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Fly Inclinado', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pull Over', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cross Over', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pec Deck', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Crucifixo', '', null, 1);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Crucifixo Inclinado', '', null, 1);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pulley Costas', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pulley Frente Supinado', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pulley Frente Fechado', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Sentada Fechada', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Sentada Ponta', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Unilateral', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Curvada', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Barra Fixa', '', null, 2);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Puxada MMSS Est. P. Alta', '', null, 2);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Alta Barra', '', null, 3);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada ALta Polia Baixa', '', null, 3);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Ombros Barra', '', null, 3);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Ombros c/Rotação', '', null, 3);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Desenvolvimento Atrás Maq', '', null, 4);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Desenvolvimento Fre Maq', '', null, 4);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Desenvolvimento Alteres', '', null, 4);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Lateral Halteres', '', null, 4);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Frontal Halteres', '', null, 4);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Frontal Barra', '', null, 4);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pec Deck Invertido', '', null, 4);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Polia Alta', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps PA. Peg Invertida', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Unilateral PA', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Testa Barra', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Testa Halteres', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Kick Back', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Francês', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Francês Unil.', '', null, 5);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Mergulho', '', null, 5);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Polia B. Unilateral', '', null, 6);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Direta', '', null, 6);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Polia', '', null, 6);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Alternada', '', null, 6);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Concentrada', '', null, 6);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Scott', '', null, 6);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Martelo', '', null, 6);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Invertida', '', null, 7);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Punho', '', null, 7);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Punho Invertida', '', null, 7);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Agachamento', '', null, 8);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Avanço', '', null, 8);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Leg Press Horizontal', '', null, 8);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Leg Press 45°', '', null, 8);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Extensora', '', null, 8);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Flexora', '', null, 8);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Stiff', '', null, 8);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Quadril Aparelho', '', null, 9);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Quadril No Solo', '', null, 9);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação da Pelve', '', null, 9);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Abdutora', '', null, 9);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Abdução Quadril Aparelho', '', null, 9);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Adução Quadril Aparelho', '', null, 10);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Adutora', '', null, 10);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Pé Aparelho', '', null, 11);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Sentado Apa', '', null, 11);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plantar Leg', '', null, 11);

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supra', '', null, 12);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Oblíquo', '', null, 12);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Lateral', '', null, 12);
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Infra', '', null, 12);

	INSERT INTO estados_civis(nome) VALUES ('Solteiro(a)');
	INSERT INTO estados_civis(nome) VALUES ('Casado(a)');
	INSERT INTO estados_civis(nome) VALUES ('Viúvo(a)');
	INSERT INTO estados_civis(nome) VALUES ('Divorciado(a)');
	INSERT INTO estados_civis(nome) VALUES ('Outro');

	INSERT INTO redes_sociais(nome) VALUES ('Não');
	INSERT INTO redes_sociais(nome) VALUES ('Facebook');
	INSERT INTO redes_sociais(nome) VALUES ('Instagram');
	INSERT INTO redes_sociais(nome) VALUES ('Twitter');
	INSERT INTO redes_sociais(nome) VALUES ('Outro');

	INSERT INTO protocolos(nome) VALUES ('Pollock 3DC');
	INSERT INTO protocolos(nome) VALUES ('Pollock 7DC');
	
	--Forcando a iniciar a sequence em 1para no usuario
	ALTER SEQUENCE usuarios_id_usuarios_seq RESTART WITH 1;


	return 'povoado com sucesso';
        END;
$$ LANGUAGE plpgsql;
----------------------------------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION gymstyle_povoamento() RETURNS text AS $$
        BEGIN
           IF ((select id_usuarios from usuarios where id_usuarios = 1) = 1) THEN
              RETURN 'Banco ja povoado';
	   ELSE 
	      RETURN (select insercoes());
           END IF;
        RETURN NULL; 
        END;
$$ LANGUAGE plpgsql;

select gymstyle_povoamento();



-- =========================================================================================================================================
-- SE EXCLUI AS REQUISICOES DE USUÁRIO EXCLUI AS SUAS RESPOSTAS
--DROP TRIGGER IF EXISTS clear_requisicao_respostas();
--DROP FUNCTION IF EXISTS remove_requisao_resposta();

CREATE OR REPLACE FUNCTION remove_requisicao_resposta() RETURNS TRIGGER AS $requisicao$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            -- INSERT INTO emp_audit SELECT 'D', now(), user, OLD.*;
	    -- Se acaso foi excluída uma digital de um usuário, seu status de sincronizado vai para false
            -- UPDATE usuarios SET sincronizado=false WHERE id_usuarios = OLD.id_usuarios_fk;
            DELETE FROM respostas WHERE destino = OLD.id_requisicao;
	    RETURN OLD;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$requisicao$ LANGUAGE plpgsql;

--CREATE TRIGGER clear_requisicao_respostas
--AFTER INSERT OR UPDATE OR DELETE ON requisicoes
  --  FOR EACH ROW EXECUTE PROCEDURE remove_requisicao_resposta();




-- =========================================================================================================================================
-- SE ALTERAR AS DIGITAIS DE UM USUÁRIO ATUALIZA SEU STATUS PARA SER SINCRONIZADO
DROP TRIGGER IF EXISTS digitais_usuario on digitais;
DROP FUNCTION IF EXISTS atualiza_status_sincronizado();

CREATE OR REPLACE FUNCTION atualiza_status_sincronizado() RETURNS TRIGGER AS $digitais_usuario$
    BEGIN
        IF (TG_OP = 'DELETE') THEN
            -- INSERT INTO emp_audit SELECT 'D', now(), user, OLD.*;
	    -- Se acaso foi excluída uma digital de um usuário, seu status de sincronizado vai para false
            UPDATE usuarios SET sincronizado=false WHERE id_usuarios = OLD.id_usuarios_fk;
	    RETURN OLD;
        ELSIF (TG_OP = 'UPDATE') THEN
            -- INSERT INTO emp_audit SELECT 'U', now(), user, NEW.*;
            RETURN NEW;
        ELSIF (TG_OP = 'INSERT') THEN
            --INSERT INTO emp_audit SELECT 'I', now(), user, NEW.*;
	    -- Se foi incluido uma nova digital para um usuário, seu status de sincronizado vai para false para ser atualizado.
	    UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios_fk;
            RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$digitais_usuario$ LANGUAGE plpgsql;

CREATE TRIGGER digitais_usuario
AFTER INSERT OR UPDATE OR DELETE ON digitais
    FOR EACH ROW EXECUTE PROCEDURE atualiza_status_sincronizado();

-- =========================================================================================================================================

DROP TRIGGER IF EXISTS campos_usuarios on usuarios;
DROP FUNCTION IF EXISTS atualiza_status_usuario();

CREATE OR REPLACE FUNCTION atualiza_status_usuario() RETURNS TRIGGER AS $campos_usuarios$
    BEGIN
	IF (TG_OP = 'UPDATE') THEN
           IF (NEW.nome <> OLD.nome) THEN
	      -- Se foi alterado o nome, altera o status para false
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
	   ELSIF (NEW.cartao_proximidade != OLD.cartao_proximidade) THEN
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
	   ELSIF (NEW.cartao_proximidade is null AND OLD.cartao_proximidade is not null) THEN
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
	   ELSIF (NEW.cartao_proximidade is not null AND OLD.cartao_proximidade is null) THEN
	      UPDATE usuarios SET sincronizado=false WHERE id_usuarios = NEW.id_usuarios;
              RETURN NEW;
           END IF;
           RETURN NEW;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$campos_usuarios$ LANGUAGE plpgsql;

CREATE TRIGGER campos_usuarios
AFTER UPDATE ON usuarios
    FOR EACH ROW EXECUTE PROCEDURE atualiza_status_usuario();

-- =========================================================================================================================================

CREATE OR REPLACE FUNCTION removeAcento(character varying) 
  RETURNS text AS 
$BODY$ 
    select translate($1, 'áàâãäéèêëíìïóòôõöúùûüÁÀÂÃÄÉÈÊËÍÌÏÓÒÔÕÖÚÙÛÜçÇ', 
	'aaaaaeeeeiiiooooouuuuAAAAAEEEEIIIOOOOOUUUUcC'); 
$BODY$ 
  LANGUAGE 'sql'; 

-- =========================================================================================================================================


-- ALTER SEQUENCE usuarios_id_usuarios_seq RESTART WITH 1;
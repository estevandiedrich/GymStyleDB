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
	cnpj VARCHAR(18) NOT NULL,
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
	desconto_percentual FLOAT DEFAULT 0.0,
	desconto_real INT,
	valor_total FLOAT DEFAULT 0.0,
	valor_matricula FLOAT DEFAULT 0.0,
	valor FLOAT DEFAULT 0.0,
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
	valor1 FLOAT DEFAULT 0.0,
	valor2 FLOAT DEFAULT 0.0,
	valor3 FLOAT DEFAULT 0.0,
	valor4 FLOAT DEFAULT 0.0,
	valor5 FLOAT DEFAULT 0.0,
	valor6 FLOAT DEFAULT 0.0,
	valor7 FLOAT DEFAULT 0.0,
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
	peso FLOAT DEFAULT 0.0,
	altura FLOAT DEFAULT 0.0,
	imc FLOAT DEFAULT 0.0,
	braco_dir FLOAT DEFAULT 0.0,
	braco_esq FLOAT DEFAULT 0.0,
	coxa_dir FLOAT DEFAULT 0.0,
	coxa_esq FLOAT DEFAULT 0.0,
	panturrilha_dir FLOAT DEFAULT 0.0,
	panturrilha_esq FLOAT DEFAULT 0.0,
	torax FLOAT DEFAULT 0.0,
	quadril FLOAT DEFAULT 0.0,
	cintura FLOAT DEFAULT 0.0,
	abdomen FLOAT DEFAULT 0.0,
	subescapular FLOAT DEFAULT 0.0,
	tricipital FLOAT DEFAULT 0.0,
	peitoral FLOAT DEFAULT 0.0,
	abdominal FLOAT DEFAULT 0.0,
	supra_iliaca FLOAT DEFAULT 0.0,
	coxa FLOAT DEFAULT 0.0,
	panturrilha FLOAT DEFAULT 0.0,
	axilar_media FLOAT DEFAULT 0.0,
	gordura_atual FLOAT DEFAULT 0.0,
	gordura_ideal VARCHAR(30),
	massa_magra FLOAT DEFAULT 0.0,
	massa_gorda FLOAT DEFAULT 0.0,

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
	valor_cancelado FLOAT DEFAULT 0.0,
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
	valor_pago FLOAT DEFAULT 0.0,
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

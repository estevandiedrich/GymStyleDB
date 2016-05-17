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
	INSERT INTO tipos_requisicao_resposta (nome) VALUES ('CONFIGURAR_CATRACA');
	INSERT INTO tipos_requisicao_resposta (nome) SELECT 'IMPRESSAO_PAGAMENTO' WHERE NOT EXISTS (SELECT id_tipos_requisicao_resposta FROM tipos_requisicao_resposta WHERE id_tipos_requisicao_resposta = 23);


	INSERT INTO modos_operacao (nome) VALUES ('Apenas Online');
	INSERT INTO modos_operacao (nome) VALUES ('Online / Offline');

	INSERT INTO tipos_usuarios (nome) VALUES ('Administrador(a)');
	INSERT INTO tipos_usuarios (nome) VALUES ('Aluno(a)');
	INSERT INTO tipos_usuarios (nome) VALUES ('Instrutor(a)');
	INSERT INTO tipos_usuarios (nome) VALUES ('Secretário(a)');

	INSERT INTO usuarios(nome,data_nascimento, sexo, login, senha, id_tipos_usuarios_fk,cpf,matricula)
	    VALUES ('Administrador','1980-01-01', 'M', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1,'90611341964', 1);

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

	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Peitoral','Superior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Peitoral');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Dorsal','Superior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Dorsal');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Trapézio','Superior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Trapézio');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Deltóide','Superior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Deltóide');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Tríceps','Superior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Tríceps');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Bíceps','Superior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Bíceps');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Antebraço','Superior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Antebraço');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Quadríceps','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Isquiotibiais');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Glúteos','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Glúteos');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Adutores','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Adutores');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Gastrocnêmicos','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Gastrocnêmicos');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Abdomen','Centro' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Abdomen');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Isquiotibiais','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Isquiotibiais');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Abdutores','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Abdutores');
	INSERT INTO grupos_musculares(nome,tipo) SELECT 'Sóleo','Inferior' WHERE NOT EXISTS (SELECT id_grupos_musculares FROM grupos_musculares WHERE nome = 'Sóleo');


	INSERT INTO empresas(razao_social, nome_fantasia, logo, cnpj, telefone, endereco) SELECT 'ACADEMIA', 'ACADEMIA', '', '', '', '' 
		WHERE NOT EXISTS (SELECT id_empresas FROM empresas WHERE id_empresas = 1);
			
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supino Reto', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supino Inclinado', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supino Declinado', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Fly', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Fly Inclinado', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pull Over', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cross Over', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pec Deck', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Crucifixo', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Crucifixo Inclinado', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Peitoral'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pulley Costas', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pulley Frente Supinado', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pulley Frente Fechado', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Sentada Fechada', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Sentada Ponta', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Unilateral', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Curvada', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Barra Fixa', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Puxada MMSS Est. P. Alta', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Dorsal'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Alta Barra', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Trapézio'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Remada Alta Polia Baixa', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Trapézio'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Ombros Barra', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Trapézio'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Ombros c/Rotação', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Trapézio'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Desenvolvimento Atrás Maq', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Deltóide'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Desenvolvimento Fre Maq', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Deltóide'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Desenvolvimento Alteres', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Deltóide'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Lateral Halteres', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Deltóide'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Frontal Halteres', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Deltóide'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação Frontal Barra', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Deltóide'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Pec Deck Invertido', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Deltóide'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Polia Alta', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps PA. Peg Invertida', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Unilateral PA', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Testa Barra', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Testa Halteres', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Kick Back', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Francês', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Tríceps Francês Unil.', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Mergulho', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Tríceps'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Polia B. Unilateral', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Bíceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Direta', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Bíceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Polia', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Bíceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Alternada', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Bíceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Concentrada', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Bíceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Scott', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Bíceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Martelo', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Bíceps'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Invertida', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Antebraço'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Punho', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Antebraço'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Rosca Punho Invertida', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Antebraço'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Agachamento', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Avanço', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Leg', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Leg Press Horizontal', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Leg Press 45°', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Extensora', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Hack', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Quadríceps'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Quadril Aparelho', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Quadril No Solo', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Quadril Apolete', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Extensão Qua. Polia Baixa', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Elevação da Pelve', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Avanço', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Glúteos'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Adução Quadril Aparelho', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Adutores'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Cadeira Adutora', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Adutores'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Pé Aparelho', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Gastrocnêmicos'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Leg', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Gastrocnêmicos'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Flexão Plant. Livre Alter', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Gastrocnêmicos'));

	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Supra', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdomen'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Oblíquo', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdomen'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Lateral', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdomen'));
	INSERT INTO exercicios(nome, descricao, id_aparelhos_fk, id_grupos_musculares_fk) VALUES ('Infra', '', null, (select id_grupos_musculares from grupos_musculares where nome = 'Abdomen'));

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

	INSERT INTO estados_civis(nome) VALUES ('Solteiro(a)');
	INSERT INTO estados_civis(nome) VALUES ('Casado(a)');
	INSERT INTO estados_civis(nome) VALUES ('Viúvo(a)');
	INSERT INTO estados_civis(nome) VALUES ('Divorciado(a)');
	INSERT INTO estados_civis(nome) VALUES ('Outro');

	INSERT INTO redes_sociais(nome) VALUES ('Não');
	INSERT INTO redes_sociais(nome) VALUES ('Facebook');
	INSERT INTO redes_sociais(nome) VALUES ('Orkut');
	INSERT INTO redes_sociais(nome) VALUES ('Twitter');
	INSERT INTO redes_sociais(nome) VALUES ('Outro');

	INSERT INTO protocolos(nome) VALUES ('Pollock 3DC');
	INSERT INTO protocolos(nome) VALUES ('Pollock 7DC');
	
	ALTER SEQUENCE usuarios_id_usuarios_seq RESTART WITH 1;

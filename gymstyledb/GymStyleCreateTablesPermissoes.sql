
CREATE TABLE IF NOT EXISTS permissoes (
	nome VARCHAR(100),
	descricao VARCHAR(300),
	grupo VARCHAR(100),
	ativo BOOLEAN DEFAULT TRUE,
	CONSTRAINT PERMISSOES_PK PRIMARY KEY (nome)
);

CREATE TABLE IF NOT EXISTS usuario_permissoes (
    id_usuario_permissoes BIGSERIAL NOT NULL,
    id_usuario_fk BIGINT,
    nome_fk VARCHAR(100),
    CONSTRAINT USUARIO_PERMISSOES_PK PRIMARY KEY (id_usuario_permissoes),
    CONSTRAINT USUARIO_PERMISSOES_USUARIO_FK FOREIGN KEY (id_usuario_fk)
        REFERENCES usuarios(id_usuarios)
            MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT USUARIO_PERMISSOES_PERMISSOES_FK FOREIGN KEY (nome_fk)
	REFERENCES permissoes(nome)
            MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'abrirFluxoCaixa','Fluxo de Caixa - Abrir','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'abrirFluxoCaixa');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'autenticacaoPagamentoRead','Autenticar Recibo','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'autenticacaoPagamentoRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'avaliacaoFisicaDelete','Avaliação Física','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'avaliacaoFisicaDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'avaliacaoFisicaManager','Avaliação Física','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'avaliacaoFisicaManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'avaliacaoFisicaRead','Avaliação Física','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'avaliacaoFisicaRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'bancoBackupDelete','Backup - Excluir','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'bancoBackupDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'bancoBackupRead','Backup - Consultar','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'bancoBackupRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'bancoGerarBackup','Backup - Gerar','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'bancoGerarBackup');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'bancoRestaurarBackup','Backup - Restaurar','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'bancoRestaurarBackup');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'caixaReportPDF','Fluxo de Caixa - Imprimir (PDF)','relatorio','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'caixaReportPDF');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'caixaReportRead','Fluxo de Caixa - Consulta','relatorio','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'caixaReportRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'cancelarPlano','Plano - Cancelar','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'cancelarPlano');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'configuracaoBoletoRead','Configuração Boleto - Consultar ','configuracao','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'configuracaoBoletoRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'configuracaoManager','Configuração - Alterar','configuracao','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'configuracaoManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'configuracaoRead','Configuração - Consultar','configuracao','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'configuracaoRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'configurarBoleto','Configuração Boleto -  Configurar','configuracao','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'configurarBoleto');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'contaBancariaDelete','Conta Bancária','cadastro','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'contaBancariaDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'contaBancariaManager','Conta Bancária','cadastro','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'contaBancariaManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'contaBancariaRead','Conta Bancária','cadastro','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'contaBancariaRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'dispositivoDelete','Catraca','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'dispositivoDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'dispositivoManager','Catraca','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'dispositivoManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'dispositivoRead','Catraca','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'dispositivoRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'empresaDelete','Academia','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'empresaDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'empresaManager','Academia','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'empresaManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'empresaRead','Academia','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'empresaRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'entradaContaBancaria','Conta Bancária - Entrada','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'entradaContaBancaria');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'entradaFluxoCaixa','Fluxo de Caixa - Entrada','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'entradaFluxoCaixa');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'eventoRead','Acessos','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'eventoRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'eventoReport','Acessos - Imprimir (PDF)','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'eventoReport');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'exercicioDelete','Exercício','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'exercicioDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'exercicioManager','Exercício','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'exercicioManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'exercicioRead','Exercício','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'exercicioRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fecharFluxoCaixa','Fluxo de Caixa - Fechar','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fecharFluxoCaixa');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fichaDelete','Ficha','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fichaDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fichaManager','Ficha','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fichaManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fichaRead','Ficha','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fichaRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fichaReport','Ficha - Imprimir','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fichaReport');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fornecedorDelete','Fornecedor','cadastro','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fornecedorDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fornecedorManager','Fornecedor','cadastro','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fornecedorManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'fornecedorRead','Fornecedor','cadastro','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'fornecedorRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'funcionarioDelete','Funcionario','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'funcionarioDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'funcionarioManager','Funcionario','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'funcionarioManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'funcionarioRead','Funcionario','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'funcionarioRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'gerarRelatorio','','','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'gerarRelatorio');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'identificacaoSoftwareManager','Identificação - Software','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'identificacaoSoftwareManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'liberarDelete','Liberar Catraca - Excluir','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'liberarDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'liberarManager','Liberar Catraca - Cadastrar','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'liberarManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'liberarRead','Liberar Catraca - Consultar','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'liberarRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'logRead','Registros de Log','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'logRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'login','','','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'login');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'managerContaBancaria','Conta Bancária - Movimentar','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'managerContaBancaria');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'managerFluxoCaixa','Fluxo de Caixa - Movimentar','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'managerFluxoCaixa');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'modalidadeDelete','Modalidade','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'modalidadeDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'modalidadeManager','Modalidade','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'modalidadeManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'modalidadeRead','Modalidade','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'modalidadeRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'pagamentoRead','Pagamentos','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'pagamentoRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'pagamentoReport','Pagamento - Imprimir (PDF)','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'pagamentoReport');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'pagamentoReportRead','Pagamento - Consulta','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'pagamentoReportRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'pagamentoUltimoPlanosRead','Histórico','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'pagamentoUltimoPlanosRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'pagamentoUltimoPlanosRead','','','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'pagamentoUltimoPlanosRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'pagamentosPlanoUsuario','','','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'pagamentosPlanoUsuario');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'pagarParcelaManager','Pagar parcela(s)','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'pagarParcelaManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'planoDelete','Plano','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'planoDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'planoManager','Plano','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'planoManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'planoRead','Plano','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'planoRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'reciboReport','Recibo - Imprimir(PDF)','relatorio','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'reciboReport');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'registroCaixaDelete','Fluxo de Caixa - Excluir Registro','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'registroCaixaDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'registroContaBancariaDelete','Conta Bancária - Excluir Registro','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'registroContaBancariaDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'requisicaoManager','Atualizações','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'requisicaoManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'retiradaContaBancaria','Conta Bancária - Retirada','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'retiradaContaBancaria');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'retiradaFluxoCaixa','Fluxo de Caixa - Retirada','gerenciar','false' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'retiradaFluxoCaixa');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'usuarioDelete','Aluno','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'usuarioDelete');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'usuarioManager','Aluno','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'usuarioManager');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'usuarioPlanosRead','Planos dos Alunos','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'usuarioPlanosRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'usuarioRead','Aluno','cadastro','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'usuarioRead');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'usuarioReport','','','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'usuarioReport');
INSERT INTO permissoes(nome,descricao,grupo,ativo) SELECT 'vincularPlano','Plano - Vincular','gerenciar','true' WHERE NOT EXISTS (SELECT nome FROM permissoes WHERE nome = 'vincularPlano');
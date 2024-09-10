use Moviefy_Tickets;

-- Tabelas de logs

create table log_notificacoes (
	IDNotificacao int primary key auto_increment,
	Mensagem varchar(255),
    Data_Notificacao date
) DEFAULT CHARSET = utf8;

create table log_historico_clientes (
	IDCliente int primary key auto_increment,
    Nome VARCHAR(255),
    Sobrenome VARCHAR(255),
    Email VARCHAR(255),
    Status_Cliente VARCHAR(55)
) DEFAULT CHARSET = utf8;

create table log_historico_filmes (
	IDFilme INTEGER PRIMARY KEY AUTO_INCREMENT,
    Titulo VARCHAR(255),
    Data_Estreia DATE,
    Data_Saida DATE,
    Status_Filme VARCHAR(255)
) DEFAULT CHARSET = utf8;

create table log_historico_compras (
	IDCompra INTEGER PRIMARY KEY AUTO_INCREMENT,
	Numero_Compra INTEGER,
	Nome_Cliente VARCHAR(255),
    Sobrenome_Cliente VARCHAR(255),
    Email VARCHAR(255),
    Valor FLOAT
) DEFAULT CHARSET = utf8;

create table log_ingressos_vendidos (
	IDIngresso INTEGER PRIMARY KEY AUTO_INCREMENT,
    Numero_Compra int,
    Tipo_Ingresso VARCHAR(20),
    Titulo_Filme VARCHAR(255),
    Numero_Sala VARCHAR(10),
    Tres_D BIT,
    DataHorario DATETIME
) DEFAULT CHARSET = utf8;
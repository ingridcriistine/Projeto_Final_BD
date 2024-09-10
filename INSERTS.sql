insert into Genero values (default, 'Romance'),
(default, 'Comédia'),
(default, 'Terror'),
(default, 'Ação'),
(default, 'Aventura'),
(default, 'Ficção Científica'),
(default, 'Drama'),
(default, 'Fantasia');

insert into ClassificacaoIndicativa values 
(default, 'L'), 
(default, '10'), 
(default, '12'), 
(default, '16'), 
(default, '18');

insert into TipoIngresso values 
(default, 'Meia 3d', 50), 
(default, 'Meia 2d', 40), 
(default, 'Inteira 3d', 100), 
(default, 'Interira 2d', 80);

insert into Salas values 
(default, '1'), 
(default, '3'), 
(default, '2'), 
(default, '6'), 
(default, '4');

insert into Pagamento values 
(default, 'Pix'), 
(default, 'Crédito'), 
(default, 'Débito');

insert into Cliente values
(default, 'João', 'Silva', 'senha123', 'joao.silva@email.com', '123.456.789-00', '1990-01-15'),
(default, 'Maria', 'Oliveira', 'senha456', 'maria.oliveira@email.com', '234.567.890-11', '1985-06-22'),
(default, 'Pedro', 'Santos', 'senha789', 'pedro.santos@email.com', '345.678.901-22', '2000-12-30'),
(default, 'Ana', 'Costa', 'senha101', 'ana.costa@email.com', '456.789.012-33', '1993-09-10'),
(default, 'Lucas', 'Almeida', 'senha202', 'lucas.almeida@email.com', '567.890.123-44', '1988-04-05');

INSERT INTO Endereco VALUES
(default, '123', '12345-678', 'Rua das Flores', 'São Paulo'),
(default, '456', '23456-789', 'Avenida Paulista', 'São Paulo'),
(default, '789', '34567-890', 'Rua dos Jardins', 'Rio de Janeiro'),
(default, '101', '45678-901', 'Praça da República', 'Belo Horizonte'),
(default, '202', '56789-012', 'Rua das Acácias', 'Curitiba');

INSERT INTO Cinema VALUES
(default, 'Cineplex São Paulo', 25.00, 1),
(default, 'Cine Avenida', 30.00, 2),
(default, 'Cine Rio', 20.00, 3),
(default, 'Cine Belo Horizonte', 22.50, 4),
(default, 'Cine Curitiba', 18.00, 5);

INSERT INTO Filme VALUES
(DEFAULT, 'O Grande Romance', '2024-01-01', '2h30m', '2024-06-01', 1, 1),
(DEFAULT, 'Riso Certo', '2024-02-15', '1h45m', '2024-07-15', 2, 2),
(DEFAULT, 'Medo Sobrenatural', '2024-03-20', '1h40m', '2024-08-20', 3, 3),
(DEFAULT, 'Aventura no Espaço', '2024-04-25', '2h00m', '2024-09-25', 4, 5),
(DEFAULT, 'Drama em Paris', '2024-05-30', '2h10m', '2024-10-30', 3, 2);

INSERT INTO Assentos VALUES
(DEFAULT, 'A1', 1),
(DEFAULT, 'A2', 1),
(DEFAULT, 'B1', 2),
(DEFAULT, 'B2', 2),
(DEFAULT, 'C1', 3),
(DEFAULT, 'C2', 3),
(DEFAULT, 'D1', 4),
(DEFAULT, 'D2', 4),
(DEFAULT, 'E1', 5),
(DEFAULT, 'E2', 5);

INSERT INTO Sessao VALUES
(DEFAULT, 1, '2024-01-01 19:00:00', 11, 1, 1),
(DEFAULT, 0, '2024-02-15 20:00:00', 12, 2, 2),
(DEFAULT, 1, '2024-03-20 21:00:00', 13, 3, 3),
(DEFAULT, 0, '2024-04-25 18:00:00', 14, 4, 4),
(DEFAULT, 1, '2024-05-30 17:00:00', 15, 5, 5);

INSERT INTO Compra VALUES
(0001, 1, 1),
(0002, 2, 2),
(0003, 3, 3),
(0004, 4, 1),
(0005, 5, 2);

select * from sessao;

INSERT INTO Ingresso VALUES
(DEFAULT, '0001', 1, 1),
(DEFAULT, '0002', 2, 2),
(DEFAULT, '0003', 3, 3),
(DEFAULT, '0004', 4, 4),
(DEFAULT, '0005', 1, 2),
(default, '0005', 1, 1);

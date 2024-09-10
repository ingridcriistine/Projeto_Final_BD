use Moviefy_Tickets;

SET SQL_SAFE_UPDATES = 0;

--  CLIENTE ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_cliente_inserido
after insert on Cliente
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Cliente ', new.Nome, ' ', new.Sobrenome, ' inserido.'), CURDATE());
    
    insert into log_historico_clientes values
    (DEFAULT, new.Nome, new.Sobrenome, new.Email, 'Ativo');
end;
// DELIMITER ;

DELIMITER //
create trigger log_cliente_removido
before delete on Cliente
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Cliente ', old.Nome, ' ', old.Sobrenome, ' removido.'), CURDATE());
    
    update log_historico_clientes
    set Status_Cliente = 'Inativo'
    where Nome = old.Nome and Sobrenome = old.Sobrenome;
end;
// DELIMITER ;

DELIMITER //
create trigger log_cliente_editado
after update on Cliente
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Cliente ', new.Nome, ' ', new.Sobrenome, ' editado.'), CURDATE());
    
    update log_historico_clientes
    set Nome = new.Nome,
    Sobrenome = new.Sobrenome,
    Email = new.Email,
    Status_Cliente = 'Ativo'
    where Nome = old.Nome and Sobrenome = old.Sobrenome;
end;
// DELIMITER ;

-- TESTE:
select * from cliente;
select * from log_notificacoes;
select * from log_historico_clientes;
insert into Cliente values (default, 'Ingrid', 'Rocha', 'senha123', 'ingrid.rocha@email.com', '123.789.789-00', '2005-01-15');
delete from Cliente where id = 8;
update Cliente set senha = 'senha000' where id = 1;


-- FILME ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_filme_inserido
after insert on Filme
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Filme ', new.Titulo, ' inserido.'), CURDATE());
    
    insert into log_historico_filmes values
    (DEFAULT, new.Titulo, new.Data_Estreia, new.Data_Saida, 'Licença ativa');
end;
// DELIMITER ;

DELIMITER //
create trigger log_filme_removido
before delete on Filme
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Filme ', old.Titulo, ' removido.'), CURDATE());
    
	update log_historico_filmes
    set Status_Filme = 'Licença inativa'
    where Titulo = old.Titulo;
end;
// DELIMITER ;

DELIMITER //
create trigger log_filme_editado
after update on Filme
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Filme ', new.Titulo, ' editado.'), CURDATE());
    
    update log_historico_filmes
    set Titulo = new.Titulo,
    Data_Estreia = new.Data_Estreia,
    Data_Saida = new.Data_Saida,
    Status_Filme = 'Licença ativa'
    where Titulo = old.Titulo;
end;
// DELIMITER ;

-- TESTE:
select * from filme;
select * from log_notificacoes;
select * from log_historico_filmes;
INSERT INTO Filme VALUES (DEFAULT, 'Titanic', '2024-09-08', '3h00m', '2024-10-08', 1, 7);
delete from Filme where id = 17;
update Filme set duracao = '2h45m' where id = 11;


-- CINEMA ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_cinema_editado
after update on Cinema
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('As informações do cinema foram editadas.'), CURDATE());
end;
// DELIMITER ;

-- TESTE:
select * from cinema;
select * from log_notificacoes;
update cinema set PrecoIngresso = 50 where id = 1;


-- ENDEREÇO ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_endereco_inserido
after insert on Endereco
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Endereço ', new.Logradouro, 'CEP: ', new.Cep, ' inserido.'), CURDATE());
end;
// DELIMITER ;

DELIMITER //
create trigger log_endereco_removido
before delete on Endereco
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Endereço ', old.Logradouro, 'CEP: ', old.Cep, ' removido.'), CURDATE());
end;
// DELIMITER ;

DELIMITER //
create trigger log_endereco_editado
after update on Endereco
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Endereço ', new.Logradouro, ' CEP: ', new.Cep, ' editado.'), CURDATE());
end;
// DELIMITER ;

-- TESTE:
select * from endereco;
select * from log_notificacoes;
INSERT INTO Endereco VALUES (default, '131', '54321-678', 'Rua da rosa', 'Curitiba');
delete from Endereco where id = 6;
update Endereco set cep = '00000-000' where id = 1;


-- SESSÃO ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_sessao_inserida
after insert on Sessao
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Nova sessão do filme ', (select Titulo from filme where id = new.fk_Filme_id), ' inserida para a data ', new.DataHorario, '.'), CURDATE());
end;
// DELIMITER ;

DELIMITER //
create trigger log_sessao_removida
before delete on Sessao
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Sessão do filme ', (select Titulo from filme where id = old.fk_Filme_id), ' na data ', old.DataHorario, ' removida.'), CURDATE());
end;
// DELIMITER ;

DELIMITER //
create trigger log_sessao_editada
after update on Sessao
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Sessão do filme ', (select Titulo from filme where id = new.fk_Filme_id), ' na data ', new.DataHorario, ' editada.'), CURDATE());
end;
// DELIMITER ;

-- TESTE:
select * from sessao;
select * from log_notificacoes;
INSERT INTO Sessao VALUES (DEFAULT, 1, '2024-01-01 19:00:00', 11, 1, 3);
delete from Sessao where id = 6;
update Sessao set fk_Filme_id = 13 where id = 7;


-- COMPRA ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_nova_compra
after insert on Compra
for each row
begin
	DECLARE Nome_Cliente VARCHAR(255);
    DECLARE Sobrenome_Cliente VARCHAR(255);
    DECLARE Email VARCHAR(255);
    DECLARE Valor VARCHAR(255);
    
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Nova compra registrada'), CURDATE());
    

    SET @Nome_Cliente = (select Nome from Cliente where id = new.fk_Cliente_id);
    SET @Sobrenome_Cliente = (select Sobrenome from Cliente where id = new.fk_Cliente_id);
    SET @Email = (select Email from Cliente where id = new.fk_Cliente_id);
    SET @Valor = (select sum(CN.PrecoIngresso*(TI.porcentagem/100)) from Ingresso I 
                    inner join Sessao S on S.id = I.fk_Sessao_id
                    inner join Cinema CN on S.fk_Cinema_id = CN.id
                    inner join TipoIngresso TI on TI.id = I.fk_TipoIngresso_id
				where I.fk_Compra_Numero = new.numero);
    
    insert into log_historico_compras values
    (DEFAULT, new.Numero, @Nome_Cliente, @Sobrenome_Cliente, @Email, @Valor);
end
// DELIMITER ;

-- TESTE:
select * from compra;
select * from log_notificacoes;
select * from log_historico_compras;
INSERT INTO Compra VALUES (0006, 1, 1);


-- GÊNERO ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_genero_inserido
after insert on Genero
for each row
begin
	insert into log_notificacoes values
    (DEFAULT, CONCAT('Gênero ', new.Nome, ' inserido.'), CURDATE());
end;
// DELIMITER ;

-- TESTE:
select * from genero;
select * from log_notificacoes;
insert into Genero values (default, 'Comédia Romântica');


-- INGRESSO ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DELIMITER //
create trigger log_ingresso_inserido
after insert on Ingresso
for each row
begin
	DECLARE Numero_Compra int;
    DECLARE Tipo_Ingresso VARCHAR(20);
    DECLARE Titulo_Filme VARCHAR(255);
    DECLARE Numero_Sala VARCHAR(10);
    DECLARE Tres_D BIT;
    DECLARE DataHorario DATETIME;
    
    SET @Numero_Compra = (select Numero from Compra where Numero = new.fk_Compra_Numero);
    SET @Tipo_Ingresso = (select Tipo from TipoIngresso where id = new.fk_TipoIngresso_id);
    SET @Titulo_Filme = (select F.Titulo from Ingresso I
						 inner join Sessao S
                         on I.fk_Sessao_id = S.id
						 inner join Filme F
                         on F.id = S.fk_Filme_id
                         where S.id = new.fk_Sessao_id);
    SET @Numero_Sala = (select Salas.NumeroSala from Ingresso I
						 inner join Sessao S
                         on S.id = I.fk_Sessao_id
                         inner join Salas
                         on Salas.id = S.fk_Salas_id
                         where S.id = new.fk_Sessao_id);
    SET @Tres_D = (select TresD from Sessao where id = new.fk_Sessao_id);
    SET @DataHorario = (select DataHorario from Sessao where id = new.fk_Sessao_id);
       
	insert into log_ingressos_vendidos values
    (DEFAULT, @Numero_Compra, @Tipo_Ingresso, @Titulo_Filme, @Numero_Sala, @Tres_D, @DataHorario);
end;
// DELIMITER ;

drop trigger log_ingresso_inserido;

-- TESTE:
select * from ingresso;
select * from log_ingressos_vendidos;
INSERT INTO Ingresso VALUES (DEFAULT, '0001', 12, 1);

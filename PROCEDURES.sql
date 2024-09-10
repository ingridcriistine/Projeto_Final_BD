DELIMITER //
create procedure pr_cliente_compra ()
begin
	select C.Nome 'Cliente',
		I.fk_Sessao_id 'Sessão do ingresso',
        T.Tipo 'Tipo do ingresso',
		CN.precoIngresso*(T.porcentagem/100) 'Preço ingresso'
	from ingresso I
		inner join Compra CR on CR.numero = I.fk_Compra_Numero
		inner join Cliente C on CR.fk_Cliente_id = C.id
        inner join Sessao S on I.fk_Sessao_id = S.id
        inner join Cinema CN on CN.id = S.fk_Cinema_id
        inner join TipoIngresso T on I.fk_TipoIngresso_id = T.id;
end
// DELIMITER ;

call pr_cliente_compra();


SET autocommit = OFF;


DELIMITER //
create procedure pr_inserir_cliente (nomei varchar(255), sobrei varchar(255), senhai varchar(50), emaili varchar(255), cpfi varchar(20), nascimentoi date)
begin 
	DECLARE countCpf int;
    
    set countCPF = (select count(nome) from cliente where cpf = cpfi) ;

	start transaction;
		insert into cliente values (default, nomei, sobrei, senhai, emaili, cpfi, nascimentoi);
		if ( countCPF > 0) 
			THEN
				ROLLBACK;
                SELECT 'Erro na transação' AS Resultado;
			ELSE
				COMMIT;
				SELECT 'Transação efetivada com sucesso.' AS Resultado;
		end if; 
end
// DELIMITER ;


select * from cliente;
call pr_inserir_cliente ('Mari', 'Ana', '12345', 'xmarimarquesh@email.com', '123.456.789-00', '2006-08-20');
call pr_inserir_cliente ('Helena', 'Picinin', '1234', 'helena@email.com', '123.123.123-12', '2006-02-20');



DELIMITER // 
create procedure pr_valorTotal_compra()
begin
select CR.numero 'Número da compra',  
	concat(C.nome, ' ', C.sobrenome) 'Nome do cliente', 
    sum(CN.precoIngresso*(T.porcentagem/100)) 'Valor da compra'
from compra CR
	inner join cliente C on CR.fk_Cliente_id = C.id
    inner join ingresso I on CR.numero = I.fk_Compra_Numero
    inner join Sessao S on I.fk_Sessao_id = S.id 
	inner join Cinema CN on CN.id = S.fk_Cinema_id
	inner join TipoIngresso T on I.fk_TipoIngresso_id = T.id
group by CR.numero;
end
// DELIMITER ;

call pr_valorTotal_compra();


DELIMITER //
create procedure pr_inserir_sessao(tresDi bit, DataHorarioi datetime, filmei int, cinemai int, salasi int)
begin
	DECLARE countS int;
    
    set countS = (select count(id) from sessao where fk_Salas_id = salasi and DataHorario = DataHorarioi);

	start transaction;
		insert into sessao values (default, tresDi, DataHorarioi, filmei, cinemai, salasi);
		if (countS > 0) 
			THEN
				ROLLBACK;
                SELECT 'Erro na transação' AS Resultado;
			ELSE
				COMMIT;
				SELECT 'Transação efetivada com sucesso.' AS Resultado;
		end if; 
end
// DELIMITER ;

select * from sessao;
call pr_inserir_sessao (0, '2024-02-01 19:00:00', 1, 2, 1);

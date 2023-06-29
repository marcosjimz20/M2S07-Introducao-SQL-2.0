-- Ex. 1: Crie uma tabela chamada clientes, com os seguintes atributos: (Id, Nome, Telefone, Endereco).
-- Ex. 2: Crie um script para inserir os seguintes clientes:
--		Id: 1, Nome: Vinicius Silva , Telefone: 987654, Endereco: Rua Girassol
--		Id: 2, Nome: Maria Antonia , Telefone: 123456 , Endereco: Rua Rosas
--		Id: 3, Nome: Marcus Vinicius , Telefone: 654123, Endereco: Rua Itajai
-- Ex. 3: Crie um script que selecione todos os clientes.
-- Ex. 4: Crie um Script que selecione os clientes filtrando pelo campo Id.
-- Ex. 5: Selecione os clientes por nome utilizando Like '%%'
-- Ex. 6: Crie um Script para atualizar o endereço do Marcus Vinicius para : 'Rua do Limão'.
-- Ex. 7: Crie o Script para Excluir o cliente Id 2
-- Ex. 8: Com base na seguinte tabela de funcionarios realize a normalização dela até sua terceira forma normal e crie todos os scripts de criação das tabelas e inclusão dos registros.
-- Ex. 9: Com base na estrutura do exercicio 8 crie um script de select utilizando joins, para exibir todos os dados preenchidos de funcionarios.


--Ex. 1:
CREATE TABLE CLIENTES (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR(20) NOT NULL,
	TELEFONE VARCHAR(11),
	ENDERECO VARCHAR(100)
);


--Ex. 2:
INSERT INTO CLIENTES (NOME, TELEFONE, ENDERECO)
VALUES
('Vinicius Silva', '987654', 'Rua Girassol'),
('Maria Antonia', '123456', 'Rua Rosas'),
('Marcus Vinicius', '654123', 'Rua Itajai');


--Ex. 3:
SELECT * FROM CLIENTES;
-- ou
SELECT ID, NOME, TELEFONE, ENDERECO FROM CLIENTES;
-- ou
SELECT ID AS IDENTIFICACAO, NOME, TELEFONE, ENDERECO FROM CLIENTES;


--Ex. 4:
SELECT * FROM CLIENTES 
WHERE ID = 1;
-- ou
SELECT ID, NOME, TELEFONE, ENDERECO FROM CLIENTES 
WHERE ID = 2;
-- ou
SELECT ID AS IDENTIFICACAO, NOME, TELEFONE, ENDERECO FROM CLIENTES
WHERE ID = 3;


--Ex. 5:
SELECT * FROM CLIENTES 
WHERE NOME LIKE '%vinicius%';
-- ou
SELECT * FROM CLIENTES 
WHERE LOWER (NOME) LIKE '%vinicius%';
-- ou
SELECT * FROM CLIENTES
WHERE UPPER(NOME) LIKE '%VINICIUS%';


--Ex. 6:
UPDATE CLIENTES
SET ENDERECO = 'Rua do Limão'
WHERE NOME = 'Marcus Vinicius';

--Ex. 7:
BEGIN TRANSACTION;

DELETE FROM CLIENTES
WHERE ID = 2;

COMMIT;
-- usar ROLLBACK mostra o efeito da reversão de uma transação;


--Ex. 8:
CREATE TABLE CARGOS (
	ID SERIAL PRIMARY KEY,
	CARGO VARCHAR(20)
);

CREATE TABLE FUNCIONARIOS (
	ID SERIAL PRIMARY KEY,
	NOME VARCHAR(50),
	CARGO_ID INT REFERENCES CARGOS(ID)
);

CREATE TABLE TELEFONES (
	ID_FUNCIONARIO INT REFERENCES FUNCIONARIOS(ID),
	TELEFONE VARCHAR(11),
	PRIMARY KEY(ID_FUNCIONARIO, TELEFONE)
);

INSERT INTO CARGOS (CARGO) VALUES ('Gerente'), ('Atendente');

INSERT INTO FUNCIONARIOS (NOME, CARGO_ID)
VALUES 
('Marcos', 2),
('Maria', 1),
('Julia', 2);

SELECT * FROM TELEFONES;

INSERT INTO TELEFONES VALUES (1, '3654589'), (1, '36545987');
INSERT INTO TELEFONES VALUES (2, '3654698'), (2, '36524569');
INSERT INTO TELEFONES VALUES (3, '3654962'), (3, '12365458');

SELECT * FROM FUNCIONARIOS; 
SELECT * FROM CARGOS;
SELECT * FROM TELEFONES;


--Ex. 9:
SELECT * FROM FUNCIONARIOS
INNER JOIN CARGOS ON CARGOS.ID = FUNCIONARIOS.CARGO_ID
INNER JOIN TELEFONES ON TELEFONES.ID_FUNCIONARIO = FUNCIONARIOS.ID;
-- ou
SELECT F.ID, F.NOME, C.CARGO, TELEFONE FROM FUNCIONARIOS AS F
INNER JOIN CARGOS AS C ON C.ID = F.CARGO_ID
LEFT JOIN TELEFONES AS T ON T.ID_FUNCIONARIO = F.ID;
-- ou
SELECT F.*, C.CARGO, TELEFONE FROM FUNCIONARIOS AS F
INNER JOIN CARGOS AS C ON C.ID = F.CARGO_ID
LEFT JOIN TELEFONES AS T ON T.ID_FUNCIONARIO = F.ID;
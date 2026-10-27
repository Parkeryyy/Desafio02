-- Questão 01:
BEGIN;
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)
VALUES (1, 'João', 'Silva', 'exemplo@email.com', 1, 1);

INSERT INTO customer (store_id, first_name, last_name, email, address_id, active)
VALUES (NULL, 'Maria', 'Souza', 'outro@email.com', 2, 1);

ROLLBACK;

-- O cliente cadastrado no primeiro passo não vai mais existir no banco de dados. O comando ROLLBACK desfaz todas as alterações feitas na transação.
-- O banco de dados tem que esquecer todo o processo para garantir a integridade dos dados. Dados inconsistentes corrompem a integridade do banco. 

-- Questão 02:
BEGIN;
INSERT INTO inventory (film_id, store_id)
VALUES (10, 1);

SAVEPOINT estoque_atualizado;

INSERT INTO inventory (film_id, store_id)
VALUES (9999999, 1);

ROLLBACK TO SAVEPOINT estoque_atualizado;

INSERT INTO inventory (film_id, store_id)
VALUES (20, 1);

COMMIT;

-- Após o commit, a tabela possui apenas os registros válidos. O registro inválido foi descartado durante o ROLLBACK TO SAVEPOINT.
-- A vantagem é que o ponto de salvamento intermediário dentro de uma mesma transação evita desperdício de processamento e reexecução. Não precisa descartar o registro
-- inteiro por causa de um erro.

-- Questão 03:
-- Sessão A primeiro:
BEGIN;
SELECT * FROM inventory WHERE inventory_id = 500 FOR UPDATE;

UPDATE inventory SET store_id = 2 WHERE inventory_id = 500;

COMMIT;

BEGIN;
SELECT * FROM inventory WHERE inventory_id = 500 FOR UPDATE;

DELETE FROM inventory_id WHERE inventory_id = 500;

COMMIT;

-- Sessão B primeiro:
BEGIN;
SELECT * FROM inventory WHERE inventory_id = 500 FOR UPDATE;

DELETE FROM inventory_id WHERE inventory_id = 500;

COMMIT;

BEGIN;
SELECT * FROM inventory WHERE inventory_id = 500 FOR UPDATE;

UPDATE inventory SET store_id = 2 WHERE inventory_id = 500;

COMMIT;

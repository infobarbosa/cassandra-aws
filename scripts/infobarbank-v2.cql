CREATE KEYSPACE infobarbank 
WITH replication = {
    'class': 'SimpleStrategy', 
    'replication_factor': 1
};

/**************************************************************/
/*               CONTA_CORRENTE                               */
/**************************************************************/

DROP TABLE infobarbank.conta_corrente;

CREATE TABLE infobarbank.conta_corrente(
    num_conta           TEXT,
    apelido_cliente     TEXT,
    data_ultimo_acesso  DATE,
    saldo_disponivel    FLOAT,
    PRIMARY KEY(num_conta)
);

INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b162060', 'MARIVALDA', '2022-09-01', 100.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16242a', 'JUCILENE' , '2022-08-01', 500.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16256a', 'GRACIMAR' , '2022-09-04', 30.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16353c', 'ALDENORA' , '2022-09-03', 1500.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b1636ae', 'VERA'     , '2022-09-02', 70.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b16396a', 'IVONE'    , '2022-08-30', 400.00);
INSERT INTO infobarbank.conta_corrente(num_conta, apelido_cliente, data_ultimo_acesso, saldo_disponivel) VALUES('2b163bcc', 'LUCILIA'  , '2022-08-31', 350.00);

SELECT * FROM infobarbank.conta_corrente WHERE num_conta = '2b162060';

/* ### OUTPUT ###

 num_conta | apelido_cliente | data_ultimo_acesso | saldo_disponivel
-----------+-----------------+--------------------+------------------
  2b163bcc |         LUCILIA |         2022-08-31 |              350
  2b1636ae |            VERA |         2022-09-02 |               70
  2b16242a |        JUCILENE |         2022-08-01 |              500
  2b16256a |        GRACIMAR |         2022-09-04 |               30
  2b16353c |        ALDENORA |         2022-09-03 |             1500
  2b162060 |       MARIVALDA |         2022-09-01 |              100
  2b16396a |           IVONE |         2022-08-30 |              400

(7 rows)
cqlsh:infobarbank> 
*/

/**************************************************************/
/*               CARTAO_CREDITO                               */
/**************************************************************/

CREATE TABLE infobarbank.cartao_credito(
    id_cliente          TEXT,
    status              TEXT,
    id                  TEXT,
    num_cartao          TEXT,
    cvv	                TEXT,
    data_validade       DATE,
    limite_total        FLOAT,
    limite_disponivel   FLOAT,
    PRIMARY KEY((id_cliente), status, id)
);

INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '007c2c1c', '5450 3799 9172 8454', '423', '2030-02-21', 1000.00, 900.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '897199aa', '5576 8924 9861 7490', '336', '2030-07-21', 200.00 , 50.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'ATIVO', '9a748c3c', '5188 2716 2053 8850', '920', '2024-03-21', 500.00 , 100.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16242a', 'ATIVO', 'a2fab366', '5590 5738 5562 1778', '198', '2024-03-21', 5000.00, 4000.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b16256a', 'ATIVO', 'cd586ffb', '5412 2646 1222 3738', '273', '2030-02-21', 3000.00, 1500.00);

SELECT * FROM infobarbank.cartao_credito WHERE id_cliente = '2b16256a';
SELECT * FROM infobarbank.cartao_credito WHERE id_cliente = '2b162060';
SELECT * FROM infobarbank.cartao_credito WHERE id_cliente = '2b162060' AND status = 'ATIVO';
SELECT * FROM infobarbank.cartao_credito WHERE id_cliente = '2b162060' AND status IN ('ATIVO', 'INATIVO');
SELECT * FROM infobarbank.cartao_credito WHERE id_cliente = '2b162060' AND status IN ('ATIVO', 'INATIVO') and id = '9a748c3c';

UPDATE infobarbank.cartao_credito SET status = 'INATIVO' WHERE id_cliente = '2b162060' AND id = '897199aa';
UPDATE infobarbank.cartao_credito SET status = 'INATIVO' WHERE id_cliente = '2b162060' AND status = 'ATIVO' AND id = '897199aa';

INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'INATIVO', '897199aa', '5576 8924 9861 7490', '336', '2030-07-21', 200.00 , 50.00);
INSERT INTO infobarbank.cartao_credito(id_cliente, status, id, num_cartao, cvv, data_validade, limite_total, limite_disponivel) VALUES ('2b162060', 'INATIVO', '9a748c3c', '5188 **** **** 8850', null, '2024-03-21', 0.00 , 0.00);

DELETE FROM infobarbank.cartao_credito WHERE id_cliente = '2b162060' AND status = 'ATIVO' AND id = '897199aa';

/*'2b162060', 'MARIVALDA',*/
/*'2b16242a', 'JUCILENE' ,*/
/*'2b16256a', 'GRACIMAR' ,*/
/*'2b16353c', 'ALDENORA' ,*/
/*'2b1636ae', 'VERA'     ,*/
/*'2b16396a', 'IVONE'    ,*/
/*'2b163bcc', 'LUCILIA'  ,*/


/**************************************************************/
/*               LANCAMENTOS_CARTAO_CREDITO                   */
/**************************************************************/

CREATE TABLE infobarbank.lancamentos_cartao_credito(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id_produto      TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    id              TEXT,
    descricao       TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC) ;

/*LANÇAMENTOS MARIVALDA*/
INSERT INTO infobarbank.lancamentos_cartao_credito(id_cliente, competencia, data_hora, id_produto, status, tipo_lancamento, id, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-08 09:30:26.123', '007c2c1c', 'APROVADA', 'DEBITO', 'bd3106cd', 'Mister Donuts', null, 900.00);
INSERT INTO infobarbank.lancamentos_cartao_credito(id_cliente, competencia, data_hora, id_produto, status, tipo_lancamento, id, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-09 10:49:00.127', '897199aa', 'APROVADA', 'DEBITO', 'ea39faa1', 'Posto Canario', null, 50.00);
INSERT INTO infobarbank.lancamentos_cartao_credito(id_cliente, competencia, data_hora, id_produto, status, tipo_lancamento, id, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-10 20:00:10.000', '007c2c1c', 'APROVADA', 'DEBITO', '81460175', 'Mambo Superm.', null, 100.00);
INSERT INTO infobarbank.lancamentos_cartao_credito(id_cliente, competencia, data_hora, id_produto, status, tipo_lancamento, id, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', '2022-08-09 10:30:00.555', '007c2c1c', 'APROVADA', 'DEBITO', '8659c037', 'Posto Canario', null, 4000.00);

INSERT INTO infobarbank.lancamentos_cartao_credito(id_cliente, competencia, data_hora, id_produto, status, tipo_lancamento, id, descricao, estabelecimento, valor) VALUES ('2b16256a', '2022-07', '2022-07-23 22:20:00.050', 'cd586ffb', 'APROVADA', 'DEBITO', '711b0caf', 'Posto Canario', null, 1500.00);

SELECT id_cliente, competencia, data_hora, id_produto, status, descricao from lancamentos_cartao_credito ;

INSERT INTO infobarbank.lancamentos_cartao_credito(id_cliente, competencia, data_hora, id_produto, status, tipo_lancamento, id, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-01 09:30:00.000', '007c2c1c', 'APROVADA', 'DEBITO', '25d7cfe9', 'Dengosa Moema', null, 50.00);
INSERT INTO infobarbank.lancamentos_cartao_credito(id_cliente, competencia, data_hora, id_produto, status, tipo_lancamento, id, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-30 19:00:00.000', '007c2c1c', 'APROVADA', 'DEBITO', '422e3e09', 'Kopenhagen Mo', null, 39.00);

SELECT id_cliente, competencia, data_hora, id_produto, status, descricao 
FROM lancamentos_cartao_credito 
WHERE id_cliente = '2b162060' 
AND competencia = '2022-07';

SELECT id_cliente, competencia, data_hora, id_produto, status, descricao 
FROM lancamentos_cartao_credito 
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND data_hora > '2022-07-01 00:00:00.050000+0000'
AND data_hora < '2022-07-30 00:00:00.050000+0000';

SELECT id_cliente, competencia, data_hora, id_produto, status, descricao 
FROM lancamentos_cartao_credito 
WHERE id_cliente = '2b162060' 
AND competencia = '2022-07'
AND data_hora > '2022-07-01 00:00:00.050000+0000'
AND data_hora < '2022-07-30 00:00:00.050000+0000'
AND id_produto = '007c2c1c';

--InvalidRequest: Error from server: code=2200 [Invalid query] message="Clustering column "id_produto" cannot be restricted (preceding column "data_hora" is restricted by a non-EQ relation)"

SELECT id_cliente, competencia, data_hora, id_produto, status, descricao 
FROM lancamentos_cartao_credito 
WHERE id_cliente = '2b162060' 
AND competencia = '2022-07'
AND data_hora = '2022-07-01 00:00:00.050000+0000'
AND id_produto in( '007c2c1c');

SELECT id_cliente, competencia, data_hora, id_produto, status, descricao 
FROM lancamentos_cartao_credito 
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND data_hora IN('2022-07-01 00:00:00.050000+0000')
AND id_produto = '007c2c1c';

/*
    Não adianta tentar enganar o Cassandra trazendo o id_produto para outro ponto da consulta.
    Fisicamente o atributo id_produto ainda vem depois de data_hora
*/
SELECT id_cliente, competencia, data_hora, id_produto, status, descricao 
FROM lancamentos_cartao_credito 
WHERE id_cliente = '2b162060' 
AND competencia = '2022-07'
AND id_produto in( '007c2c1c')
AND data_hora > '2022-07-01 00:00:00.050000+0000'
AND data_hora < '2022-07-30 00:00:00.050000+0000';

/**************************************************************/
/*               LANCAMENTOS_POR_STATUS                      */
/**************************************************************/

CREATE TABLE infobarbank.lancamentos_por_status(
    id_cliente      TEXT,
    competencia     TEXT,
    status          TEXT,
    data_hora       TIMESTAMP,
    id              TEXT,
    id_produto      TEXT,
    tipo_lancamento TEXT,
    descricao       TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), status, data_hora, id)
) WITH CLUSTERING ORDER BY (status ASC, data_hora DESC, id ASC) ;

/*LANÇAMENTOS MARIVALDA*/
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'APROVADA', '2022-07-08 09:30:26.123', 'bd3106cd' , '007c2c1c', 'DEBITO' , 'Mister Donuts' , null, 900.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'APROVADA', '2022-07-09 10:49:00.127', 'ea39faa1' , '897199aa', 'DEBITO' , 'Posto Canario' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'APROVADA', '2022-07-10 20:00:10.000', '81460175' , '007c2c1c', 'DEBITO' , 'Mambo Superm.' , null, 100.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', 'APROVADA', '2022-08-09 10:30:00.555', '8659c037' , '007c2c1c', 'DEBITO' , 'Posto Canario' , null, 4000.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'APROVADA', '2022-07-01 09:30:00.000', '25d7cfe9' , '007c2c1c', 'DEBITO' , 'Dengosa Moema' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'APROVADA', '2022-07-30 19:00:00.000', '422e3e09' , '007c2c1c', 'DEBITO' , 'Kopenhagen Mo' , null, 39.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'APROVADA', '2022-07-30 19:00:00.000', '387a4710' , '2b162060', 'CREDITO', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', 'APROVADA', '2022-08-31 19:00:00.000', '68f68477' , '2b162060', 'CREDITO', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', 'RECUSADA', '2022-08-31 19:00:00.000', '39acbf27' , '2b162060', 'DEBITO' , 'Mercedes-Benz' , null, 5999.00);

/*LANÇAMENTOS GRACIMAR*/
INSERT INTO infobarbank.lancamentos_por_status(id_cliente, competencia, status, data_hora, id, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b16256a', '2022-07', 'APROVADA', '2022-07-23 22:20:00.050', '711b0caf' , 'cd586ffb', 'DEBITO' , 'Posto Canario' , null, 1500.00);

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_status
WHERE id_cliente = '2b16256a'
AND competencia = '2022-07';

/* ### OUTPUT ###
 id_cliente | data_hora                       | id_produto | status   | descricao
------------+---------------------------------+------------+----------+---------------
   2b16256a | 2022-07-23 22:20:00.050000+0000 |   cd586ffb | APROVADA | Posto Canario

(1 rows)
cqlsh:infobarbank> 
*/

SELECT id_cliente, data_hora, id_produto, status, valor, descricao
FROM infobarbank.lancamentos_por_status
WHERE id_cliente = '2b162060'
AND competencia = '2022-08'
AND status = 'APROVADA'
AND data_hora >= '2022-08-01';

/* ### OUTPUT ###
 id_cliente | data_hora                       | id_produto | status   | valor | descricao
------------+---------------------------------+------------+----------+-------+----------------
   2b162060 | 2022-08-31 19:00:00.000000+0000 |   2b162060 | APROVADA |  1000 | Depos. Salario
   2b162060 | 2022-08-09 10:30:00.555000+0000 |   007c2c1c | APROVADA |  4000 |  Posto Canario

(2 rows)
cqlsh:infobarbank> 
*/

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_status
WHERE id_cliente = '2b162060'
AND competencia = '2022-08'
AND status IN('APROVADA', 'RECUSADA')
AND data_hora > '2022-07-01';

/* ### OUTPUT ###
 id_cliente | data_hora                       | id_produto | status   | descricao
------------+---------------------------------+------------+----------+----------------
   2b162060 | 2022-08-31 19:00:00.000000+0000 |   2b162060 | APROVADA | Depos. Salario
   2b162060 | 2022-08-09 10:30:00.555000+0000 |   007c2c1c | APROVADA |  Posto Canario
   2b162060 | 2022-08-31 19:00:00.000000+0000 |   2b162060 | RECUSADA |  Mercedes-Benz

(3 rows)
cqlsh:infobarbank> 

*/

/*ERRO!*/
SELECT id_cliente,  data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_status
WHERE id_cliente = '2b162060'
AND competencia = '2022-08'
AND status = 'APROVADA'
AND floor(data_hora, 1M) = '2022-07-01';


/**************************************************************/
/*               LANCAMENTOS_POR_PERIODO                      */
/**************************************************************/

CREATE TABLE infobarbank.lancamentos_por_periodo(
    id_cliente      TEXT,
    competencia     TEXT,
    data_hora       TIMESTAMP,
    id              TEXT,
    status          TEXT,
    id_produto      TEXT,
    tipo_lancamento TEXT,
    descricao       TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), data_hora, id)
) WITH CLUSTERING ORDER BY (data_hora DESC, id ASC) ;

/*LANÇAMENTOS MARIVALDA*/
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-08 09:30:26.123', 'bd3106cd', 'APROVADA', '007c2c1c', 'DEBITO' , 'Mister Donuts' , null, 900.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-09 10:49:00.127', 'ea39faa1', 'APROVADA', '897199aa', 'DEBITO' , 'Posto Canario' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-10 20:00:10.000', '81460175', 'APROVADA', '007c2c1c', 'DEBITO' , 'Mambo Superm.' , null, 100.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', '2022-08-09 10:30:00.555', '8659c037', 'APROVADA', '007c2c1c', 'DEBITO' , 'Posto Canario' , null, 4000.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-01 09:30:00.000', '25d7cfe9', 'APROVADA', '007c2c1c', 'DEBITO' , 'Dengosa Moema' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-30 19:00:00.000', '422e3e09', 'APROVADA', '007c2c1c', 'DEBITO' , 'Kopenhagen Mo' , null, 39.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2022-07-30 19:00:00.000', '387a4710', 'APROVADA', '2b162060', 'CREDITO', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', '2022-08-31 19:00:00.000', '68f68477', 'APROVADA', '2b162060', 'CREDITO', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', '2022-08-31 19:00:00.000', '39acbf27', 'RECUSADA', '2b162060', 'DEBITO' , 'Mercedes-Benz' , null, 5999.00);

/*LANÇAMENTOS GRACIMAR*/
INSERT INTO infobarbank.lancamentos_por_periodo(id_cliente, competencia, data_hora, id, status, id_produto, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b16256a', '2022-07', '2022-07-23 22:20:00.050', '711b0caf', 'APROVADA', 'cd586ffb', 'DEBITO' , 'Posto Canario', null, 1500.00);

SELECT id_cliente, data_hora, id_produto, status, valor, descricao
FROM infobarbank.lancamentos_por_periodo
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND data_hora >= '2022-07-01'
AND data_hora < '2022-08-01';

/*
 id_cliente | data_hora                       | id_produto | status   | valor | descricao
------------+---------------------------------+------------+----------+-------+----------------
   2b162060 | 2022-07-30 19:00:00.000000+0000 |   2b162060 | APROVADA |  1000 | Depos. Salario
   2b162060 | 2022-07-30 19:00:00.000000+0000 |   007c2c1c | APROVADA |    39 |  Kopenhagen Mo
   2b162060 | 2022-07-10 20:00:10.000000+0000 |   007c2c1c | APROVADA |   100 |  Mambo Superm.
   2b162060 | 2022-07-09 10:49:00.127000+0000 |   897199aa | APROVADA |    50 |  Posto Canario
   2b162060 | 2022-07-08 09:30:26.123000+0000 |   007c2c1c | APROVADA |   900 |  Mister Donuts
   2b162060 | 2022-07-01 09:30:00.000000+0000 |   007c2c1c | APROVADA |    50 |  Dengosa Moema

(6 rows)
cqlsh:infobarbank> 

*/

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_periodo
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND data_hora >= '2022-07-01';

/*
 id_cliente | data_hora                       | id_produto | status   | descricao
------------+---------------------------------+------------+----------+----------------
   2b162060 | 2022-07-30 19:00:00.000000+0000 |   2b162060 | APROVADA | Depos. Salario
   2b162060 | 2022-07-30 19:00:00.000000+0000 |   007c2c1c | APROVADA |  Kopenhagen Mo
   2b162060 | 2022-07-10 20:00:10.000000+0000 |   007c2c1c | APROVADA |  Mambo Superm.
   2b162060 | 2022-07-09 10:49:00.127000+0000 |   897199aa | APROVADA |  Posto Canario
   2b162060 | 2022-07-08 09:30:26.123000+0000 |   007c2c1c | APROVADA |  Mister Donuts
   2b162060 | 2022-07-01 09:30:00.000000+0000 |   007c2c1c | APROVADA |  Dengosa Moema

(6 rows)
cqlsh:infobarbank> 

*/

/**************************************************************/
/*               LANCAMENTOS_POR_PRODUTO                      */
/**************************************************************/
CREATE TABLE infobarbank.lancamentos_por_produto(
    id_cliente      TEXT,
    competencia     TEXT,
    id_produto      TEXT,
    data_hora       TIMESTAMP,
    id              TEXT,
    status          TEXT,
    tipo_lancamento TEXT,
    descricao       TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), id_produto, data_hora, id)
) WITH CLUSTERING ORDER BY (id_produto ASC, data_hora DESC, id ASC) ;

/*LANÇAMENTOS MARIVALDA*/
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '007c2c1c', '2022-07-08 09:30:26.123', 'bd3106cd', 'APROVADA', 'DEBITO' , 'Mister Donuts' , null, 900.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '897199aa', '2022-07-09 10:49:00.127', 'ea39faa1', 'APROVADA', 'DEBITO' , 'Posto Canario' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '007c2c1c', '2022-07-10 20:00:10.000', '81460175', 'APROVADA', 'DEBITO' , 'Mambo Superm.' , null, 100.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', '007c2c1c', '2022-08-09 10:30:00.555', '8659c037', 'APROVADA', 'DEBITO' , 'Posto Canario' , null, 4000.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '007c2c1c', '2022-07-01 09:30:00.000', '25d7cfe9', 'APROVADA', 'DEBITO' , 'Dengosa Moema' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '007c2c1c', '2022-07-30 19:00:00.000', '422e3e09', 'APROVADA', 'DEBITO' , 'Kopenhagen Mo' , null, 39.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', '2b162060', '2022-07-30 19:00:00.000', '387a4710', 'APROVADA', 'CREDITO', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', '2b162060', '2022-08-31 19:00:00.000', '68f68477', 'APROVADA', 'CREDITO', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', '2b162060', '2022-08-31 19:00:00.000', '39acbf27', 'RECUSADA', 'DEBITO' , 'Mercedes-Benz' , null, 5999.00);

/*LANÇAMENTOS GRACIMAR*/
INSERT INTO infobarbank.lancamentos_por_produto(id_cliente, competencia, id_produto, data_hora, id, status, tipo_lancamento, descricao, estabelecimento, valor) VALUES ('2b16256a', '2022-07', 'cd586ffb', '2022-07-23 22:20:00.050', '711b0caf', 'APROVADA', 'DEBITO', 'Posto Canario', null, 1500.00);

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_produto
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND id_produto = '2b162060';

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_produto
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND id_produto = '2b162060'
AND data_hora >= '2022-07-01';

 id_cliente                           | data_hora                       | id_produto                           | status   | descricao
--------------------------------------+---------------------------------+--------------------------------------+----------+----------------
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-30 19:00:00.000000+0000 | 2b162060-1017-11ed-861d-0242ac120002 | APROVADA | Depos. Salario

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_produto
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND id_produto = '007c2c1c'
AND data_hora >= '2022-07-01';

 id_cliente                           | data_hora                       | id_produto                           | status   | descricao
--------------------------------------+---------------------------------+--------------------------------------+----------+---------------
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-30 19:00:00.000000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Kopenhagen Mo
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-10 20:00:10.000000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Mambo Superm.
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-08 09:30:26.123000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Mister Donuts
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-01 09:30:00.000000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Dengosa Moema


/***********************************************************/
/*               LANCAMENTOS_POR_TIPO                      */
/***********************************************************/
CREATE TABLE infobarbank.lancamentos_por_tipo(
    id_cliente      TEXT,
    competencia     TEXT,
    tipo_lancamento TEXT,
    data_hora       TIMESTAMP,
    id              TEXT,
    id_produto      TEXT,
    status          TEXT,
    descricao       TEXT,
    estabelecimento TEXT,
    valor           FLOAT,
    PRIMARY KEY((id_cliente, competencia), tipo_lancamento, data_hora, id)
) WITH CLUSTERING ORDER BY (tipo_lancamento ASC, data_hora DESC, id ASC) ;

/*LANÇAMENTOS MARIVALDA*/
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-08 09:30:26.123', 'bd3106cd', 'APROVADA', 'Mister Donuts' , null, 900.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'DEBITO' , '897199aa', '2022-07-09 10:49:00.127', 'ea39faa1', 'APROVADA', 'Posto Canario' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-10 20:00:10.000', '81460175', 'APROVADA', 'Mambo Superm.' , null, 100.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', 'DEBITO' , '007c2c1c', '2022-08-09 10:30:00.555', '8659c037', 'APROVADA', 'Posto Canario' , null, 4000.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-01 09:30:00.000', '25d7cfe9', 'APROVADA', 'Dengosa Moema' , null, 50.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-30 19:00:00.000', '422e3e09', 'APROVADA', 'Kopenhagen Mo' , null, 39.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-07', 'CREDITO', '2b162060', '2022-07-30 19:00:00.000', '387a4710', 'APROVADA', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', 'CREDITO', '2b162060', '2022-08-31 19:00:00.000', '68f68477', 'APROVADA', 'Depos. Salario', null, 1000.00);
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b162060', '2022-08', 'DEBITO' , '2b162060', '2022-08-31 19:00:00.000', '39acbf27', 'RECUSADA', 'Mercedes-Benz' , null, 5999.00);

/*LANÇAMENTOS GRACIMAR*/
INSERT INTO infobarbank.lancamentos_por_tipo(id_cliente, competencia, tipo_lancamento, id_produto, data_hora, id, status, descricao, estabelecimento, valor) VALUES ('2b16256a', '2022-07', 'DEBITO', 'cd586ffb', '2022-07-23 22:20:00.050', '711b0caf', 'APROVADA', 'Posto Canario', null, 1500.00);

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_tipo
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND tipo_lancamento = 'DEBITO';

 id_cliente                           | data_hora                       | id_produto                           | status   | descricao
--------------------------------------+---------------------------------+--------------------------------------+----------+---------------
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-30 19:00:00.000000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Kopenhagen Mo
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-10 20:00:10.000000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Mambo Superm.
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-09 10:49:00.127000+0000 | 897199aa-eec1-4e6b-a71b-fd79770084ce | APROVADA | Posto Canario
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-08 09:30:26.123000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Mister Donuts
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-01 09:30:00.000000+0000 | 007c2c1c-effc-42ab-a434-326d965654e9 | APROVADA | Dengosa Moema

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_tipo
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND tipo_lancamento = 'CREDITO';

 id_cliente                           | data_hora                       | id_produto                           | status   | descricao
--------------------------------------+---------------------------------+--------------------------------------+----------+----------------
 2b162060-1017-11ed-861d-0242ac120002 | 2022-07-30 19:00:00.000000+0000 | 2b162060-1017-11ed-861d-0242ac120002 | APROVADA | Depos. Salario


SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_por_produto
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND id_produto = '2b162060'
AND data_hora >= '2022-07-01';


/***********************************************************/
/*               LANCAMENTOS_DETALHE                       */
/***********************************************************/
CREATE TABLE infobarbank.lancamentos_detalhe(
    id                      TEXT,
    id_cliente              TEXT,
    competencia             TEXT,
    tipo_lancamento         TEXT,
    data_hora               TIMESTAMP,
    id_produto              TEXT,
    status                  TEXT,
    descricao               TEXT,
    estabelecimento         TEXT,
    valor                   FLOAT,
    codigo_autenticacao     TEXT,
    PRIMARY KEY(id)
);

/*LANÇAMENTOS MARIVALDA*/
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('bd3106cd', '2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-08 09:30:26.123', 'APROVADA', 'Mister Donuts' , null, 900.00  , 'bd3106cd-6b66-448f-b36c-44003675e352'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('ea39faa1', '2b162060', '2022-07', 'DEBITO' , '897199aa', '2022-07-09 10:49:00.127', 'APROVADA', 'Posto Canario' , null, 50.00   , 'ea39faa1-1213-46a7-a464-6de24f7e1829'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('81460175', '2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-10 20:00:10.000', 'APROVADA', 'Mambo Superm.' , null, 100.00  , '81460175-ed4d-4a7a-8721-dd15aa680d30'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('8659c037', '2b162060', '2022-08', 'DEBITO' , '007c2c1c', '2022-08-09 10:30:00.555', 'APROVADA', 'Posto Canario' , null, 4000.00 , '8659c037-c503-4f69-b86e-ea2468890595'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('25d7cfe9', '2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-01 09:30:00.000', 'APROVADA', 'Dengosa Moema' , null, 50.00   , '25d7cfe9-4708-49e7-a1bf-03da5f542cee'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('422e3e09', '2b162060', '2022-07', 'DEBITO' , '007c2c1c', '2022-07-30 19:00:00.000', 'APROVADA', 'Kopenhagen Mo' , null, 39.00   , '422e3e09-0703-4cba-b3af-5dde59de1a4c'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('387a4710', '2b162060', '2022-07', 'CREDITO', '2b162060', '2022-07-30 19:00:00.000', 'APROVADA', 'Depos. Salario', null, 1000.00 , '387a4710-4dca-4090-95ca-cc7b24e30de5'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('68f68477', '2b162060', '2022-08', 'CREDITO', '2b162060', '2022-08-31 19:00:00.000', 'APROVADA', 'Depos. Salario', null, 1000.00 , '68f68477-a37e-4627-a163-68c30d7a7675'  );
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('39acbf27', '2b162060', '2022-08', 'DEBITO' , '2b162060', '2022-08-31 19:00:00.000', 'RECUSADA', 'Mercedes-Benz' , null, 5999.00 , '39acbf27-c136-49e2-9aa6-01442d6c3177'  );

/*LANÇAMENTOS GRACIMAR*/
INSERT INTO infobarbank.lancamentos_detalhe(id, id_cliente, competencia, tipo_lancamento, id_produto, data_hora, status, descricao, estabelecimento, valor, codigo_autenticacao) VALUES ('711b0caf', '2b16256a', '2022-07', 'DEBITO' , 'cd586ffb', '2022-07-23 22:20:00.050', 'APROVADA', 'Posto Canario' , null, 1500.00 , '711b0caf-fa5c-4982-8cd9-a7fb7b33927e'  );

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_detalhe
WHERE id = '711b0caf';

SELECT id_cliente, data_hora, id_produto, status, descricao
FROM infobarbank.lancamentos_detalhe
WHERE id_cliente = '2b162060'
AND competencia = '2022-07'
AND tipo_lancamento = 'DEBITO';

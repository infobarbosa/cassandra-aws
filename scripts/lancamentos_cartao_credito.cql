DROP TABLE infobarbank.lancamentos_cc1;

CREATE TABLE infobarbank.lancamentos_cc1 (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY (id)
);

CREATE TABLE infobarbank.lancamentos_cc2 (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY (id_cliente)
);

CREATE TABLE infobarbank.lancamentos_cc3 (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY ((id_cliente), id)
) WITH CLUSTERING ORDER BY (id ASC)


CREATE TABLE infobarbank.lancamentos_cc4 (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY ((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC)

CREATE TABLE infobarbank.lancamentos_ccX (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY ((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC)

CREATE TABLE infobarbank.lancamentos_ccX (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY ((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC)

CREATE TABLE infobarbank.lancamentos_ccX (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY ((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC)

CREATE TABLE infobarbank.lancamentos_ccX (
    id_cliente text,
    competencia text,
    data_hora timestamp,
    id_produto text,
    status text,
    tipo_lancamento text,
    id text,
    estabelecimento text,
    valor float,
    PRIMARY KEY ((id_cliente, competencia), data_hora, id_produto, status, tipo_lancamento, id)
) WITH CLUSTERING ORDER BY (data_hora DESC, id_produto ASC, status ASC, tipo_lancamento ASC, id ASC)

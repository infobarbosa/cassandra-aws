# Compaction
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

A proposta agora é criar a tabela `cliente` e executar diversas operações de escrita de registros.
Desta vez, porém, a cada etapa vamos executar o comando `nodetool flush` e então observar o que acontece com os arquivos (sstables).

##### 1o. Ciclo

Criando a keyspace `infobarbank4`:
```plain
cqlsh --execute "CREATE KEYSPACE infobarbank4 
                    WITH replication = {
                        'class': 'SimpleStrategy', 
                        'replication_factor': 1};"
```{{exec}}

Criando a tabela `cliente`
```plain
cqlsh --execute "CREATE TABLE infobarbank4.cliente(
                    id text PRIMARY KEY, 
                    cpf text, 
                    nome text, 
                    sobrenome text, 
                    email text);"
```{{exec}}

Inserindo um registro:
```plain
cqlsh --execute "INSERT INTO infobarbank4.cliente(id, cpf) 
                VALUES ('1', '999999999-99');"
```{{exec}}

Conferindo o resultado:
```plain
cqlsh --execute "select * from infobarbank4.cliente where id = '1';"
```{{exec}}


Verifique os arquivos existentes:
```plain
cd /var/lib/cassandra/data/infobarbank4
```{{exec}}

```plain
ls -latr
```{{exec}}

**ATENÇÃO!** <br>
> Perceba que foi criado um diretório com o nome da tabela (cliente) concatenado com um UUID aleatório.
Vamos verificar os objetos dentro desse diretório:

```plain
cd $(eval ls)
```{{exec}}

```plain
pwd
```{{exec}}

```plain
ls -latr
```{{exec}}

Execute `nodetool flush`:
```plain
nodetool flush
```{{exec}}

```plain
ls -la
```{{exec}}

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```plain
cat nb-1-big-Data.db
```{{exec}}

##### 2o. Ciclo

Atualizando uma coluna da tabela:
```plain
cqlsh --execute "update infobarbank4.cliente set nome = 'marcelo' where id = '1';"
```{{exec}}

Conferindo o resultado:
```plain
cqlsh --execute "select * from infobarbank4.cliente where id = '1';"
```{{exec}}

Inspecione novamente o conteúdo da sstable `nb-1-big-Data.db`:
```plain
cat nb-1-big-Data.db
```{{exec}}

```plain
ls -latr
```{{exec}}

Perceba que `nb-1-big-Data.db` não tem o nome *marcelo* e ao mesmo tempo não houve modificação dos demais arquivos.

```plain
nodetool flush
```{{exec}}

```plain
ls -la
```{{exec}}

Uma nova sstable `nb-2-big-Data.db` foi gerada. Vamos inspecioná-la:
```plain
cat nb-2-big-Data.db
```{{exec}}

Apenas o atributo nome com valor *marcelo* foi encontrado.

##### 3o. Ciclo

Atualizando uma coluna da tabela:
```plain
cqlsh --execute "update infobarbank4.cliente set sobrenome = 'barbosa' where id = '1';"
```{{exec}}

```plain
cqlsh --execute "select * from infobarbank4.cliente where id = '1';"
```{{exec}}

```plain
ls -latr
```{{exec}}

```plain
nodetool flush
```{{exec}}

```plain
ls -la
```{{exec}}

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```plain
cat nb-3-big-Data.db
```{{exec}}

##### 4o. Ciclo

Atualizando uma coluna da tabela:
```plain
cqlsh --execute "update infobarbank4.cliente 
                    set email = 'marcelo@infobarbosa.com.br' 
                  where id = '1';"
```{{exec}}

```plain
cqlsh --execute "select * 
                   from infobarbank4.cliente 
                  where id = '1';"
```{{exec}}

```plain
ls -latr
```{{exec}}

```plain
nodetool flush
```{{exec}}

```plain
ls -latr
```{{exec}}

Perceba que sumiram as sstables anteriores e uma nova surgiu.<br>
Inspecione o conteúdo da sstable gerada `nb-5-big-Data.db`:
```plain
cat nb-5-big-Data.db
```{{exec}}


##### 5o. Ciclo

Inserindo um novo registro:
```plain
cqlsh --execute "insert into infobarbank4.cliente(id, cpf) values ('MINHA_CHAVE', '888888888-88');"

cqlsh --execute "select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```{{exec}}

```plain
ls -latr
```{{exec}}

```plain
nodetool flush
```{{exec}}

```plain
ls -latr
```{{exec}}

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```plain
cat nb-6-big-Data.db
```{{exec}}

##### 6o. Ciclo

Atualizando uma coluna da tabela:
```
cqlsh --execute "update infobarbank4.cliente set nome = 'PEDRO' where id = 'MINHA_CHAVE';"

cqlsh --execute "select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```{{exec}}

```plain
ls -latr
```{{exec}}

```plain
nodetool flush
```{{exec}}

```plain
ls -latr
```{{exec}}

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```plain
cat nb-7-big-Data.db
```{{exec}}

##### 7o. Ciclo

Atualizando uma coluna da tabela:
```plain
cqlsh --execute "update infobarbank4.cliente 
                    set sobrenome = 'ALCÂNTARA FRANCISCO ANTÔNIO JOÃO CARLOS XAVIER DE PAULA MIGUEL RAFAEL JOAQUIM JOSÉ GONZAGA PASCOAL CIPRIANO SERAFIM DE BRAGANÇA E BOURBON' 
                  where id = 'MINHA_CHAVE';"

cqlsh --execute "select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```{{exec}}

```plain
ls -latr
```{{exec}}

```plain
nodetool flush
```{{exec}}

```plain
ls -latr
```{{exec}}

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```plain
cat nb-9-big-Data.db
```{{exec}}

##### 8o. Ciclo

Atualizando uma coluna da tabela:
```plain
cqlsh --execute \
"delete from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```{{exec}}

```plain
cqlsh --execute \
"delete from infobarbank4.cliente where id = 'UMA_CHAVE_QUE_NUNCA_INSERI';"
```{{exec}}

```plain
cqlsh --execute \
"select * from infobarbank4.cliente where id = 'MINHA_CHAVE';"
```{{exec}}

```plain
ls -latr
```{{exec}}

```plain
nodetool flush
```{{exec}}

```plain
ls -latr
```{{exec}}

Inspecione o conteúdo da sstable gerada `nb-XX-big-Data.db`:
```plain
cat nb-10-big-Data.db
```{{exec}}

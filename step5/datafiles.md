# Observação de datafiles
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

### Objetivo
Observar como o cassandra gera sstables (data files) em disco.

### Método
A proposta agora é recriar a tabela e inserir, atualizar e deletar diversos registros.
A cada etapa vamos executar o comando `nodetool flush` e então observar como o Cassandra gerencia os arquivos (sstables) no sistema operacional.


Navegue para o diretório `/var/lib/cassandra/data`, local padrão de armazenamento de dados do Cassandra. 
```plain
cd /var/lib/cassandra/data
```{{exec}}

Liste os arquivos e subdiretórios presentes:
```plain
ls -la
```{{exec}}

Output:
```
ubuntu $ ls -la
total 28
drwxr-xr-x  7 cassandra cassandra 4096 Dec 18 23:47 .
drwxr-xr-x  7 cassandra cassandra 4096 Dec 18 23:46 ..
drwxr-xr-x 26 cassandra cassandra 4096 Dec 18 23:46 system
drwxr-xr-x  7 cassandra cassandra 4096 Dec 18 23:47 system_auth
drwxr-xr-x  6 cassandra cassandra 4096 Dec 18 23:47 system_distributed
drwxr-xr-x 12 cassandra cassandra 4096 Dec 18 23:46 system_schema
drwxr-xr-x  4 cassandra cassandra 4096 Dec 18 23:47 system_traces
ubuntu $ 
```
Perceba que o diretório `/var/lib/cassandra/data` contém apenas subdiretórios de sistema.<br>

### CREATE KEYSPACE
```plain
cqlsh -e "CREATE KEYSPACE infobarbank3
            WITH replication = {
                'class': 'SimpleStrategy',
                'replication_factor': 1};"
```{{exec}}

```plain
ls -la
```{{exec}}
Perceba que o output não mudou, mesmo após termos executado o comando `create keyspace ...`.<br>

Agora vamos criar uma tabela na Tab 1.
### `cqlsh` CREATE TABLE
```plain
cqlsh -e "CREATE TABLE infobarbank3.cliente(
            id uuid PRIMARY KEY,
            cpf text,
            nome text);"
```{{exec}}

### DESCRIBE TABLE
```plain
cqlsh -e "DESCRIBE TABLE infobarbank3.cliente;"
```{{exec}}

O output deve ser algo assim:
```
CREATE TABLE infobarbank3.cliente (
    id uuid PRIMARY KEY,
    cpf text,
    nome text
) WITH additional_write_policy = '99p'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND cdc = false
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.SizeTieredCompactionStrategy', 'max_threshold': '32', 'min_threshold': '4'}
    AND compression = {'chunk_length_in_kb': '16', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND extensions = {}
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99p';
```

Se você obteve o output acima então a tabela foi criada corretamente.

Agora vamos voltar ao `bash` e verificar o que ocorreu em disco.
```plain
ls -la
```{{exec}}

Output:
```
ubuntu $ ls -la
total 32
drwxr-xr-x  8 cassandra cassandra 4096 Dec 18 23:58 .
drwxr-xr-x  7 cassandra cassandra 4096 Dec 18 23:46 ..
drwxr-xr-x  3 cassandra cassandra 4096 Dec 18 23:58 infobarbank3
drwxr-xr-x 26 cassandra cassandra 4096 Dec 18 23:46 system
drwxr-xr-x  7 cassandra cassandra 4096 Dec 18 23:47 system_auth
drwxr-xr-x  6 cassandra cassandra 4096 Dec 18 23:47 system_distributed
drwxr-xr-x 12 cassandra cassandra 4096 Dec 18 23:46 system_schema
drwxr-xr-x  4 cassandra cassandra 4096 Dec 18 23:47 system_traces
ubuntu $ 
```

Perceba que o diretório da keyspace só foi criado em disco após criarmos efetivamente uma tabela.<br>
Vamos navegar para o diretório `/var/lib/cassandra/data/infobarbank3`:
```plain
cd /var/lib/cassandra/data/infobarbank3
```{{exec}}

Listando os subdiretórios
```plain
pwd
```{{exec}}

```plain
ls -la
```{{exec}}
Output:
```
ubuntu $ pwd
/var/lib/cassandra/data/infobarbank3
ubuntu $ 
ubuntu $ ls -la
total 12
drwxr-xr-x 3 cassandra cassandra 4096 Dec 18 23:58 .
drwxr-xr-x 8 cassandra cassandra 4096 Dec 18 23:58 ..
drwxr-xr-x 3 cassandra cassandra 4096 Dec 18 23:58 cliente-debd45d07f2f11edb98d19f478689749
```

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

Output:
```
ubuntu $ ls -la
total 12
drwxr-xr-x 3 cassandra cassandra 4096 Dec 18 23:58 .
drwxr-xr-x 3 cassandra cassandra 4096 Dec 18 23:58 ..
drwxr-xr-x 2 cassandra cassandra 4096 Dec 18 23:58 backups
```

Veja que não existem objetos além de uma pasta de backup.<br>
Agora vamos executar um primeiro lote de inserções na tabela.

### `cqlsh` INSERT
Inserindo primeiro lote de registros
```plain
cqlsh -e "
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b162060-1017-11ed-861d-0242ac120002, '***.568.112-**', 'MARIVALDA KANAMARY');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b16242a-1017-11ed-861d-0242ac120002, '***.150.512-**', 'JUCILENE MOREIRA CRUZ');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b16256a-1017-11ed-861d-0242ac120002, '***.615.942-**', 'GRACIMAR BRASIL GUERRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b16353c-1017-11ed-861d-0242ac120002, '***.264.482-**', 'ALDENORA VIANA MOREIRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b1636ae-1017-11ed-861d-0242ac120002, '***.434.715-**', 'VERA LUCIA RODRIGUES SENA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b16396a-1017-11ed-861d-0242ac120002, '***.777.135-**', 'IVONE GLAUCIA VIANA DUTRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b163bcc-1017-11ed-861d-0242ac120002, '***.881.955-**', 'LUCILIA ROSA LIMA PEREIRA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b163cda-1017-11ed-861d-0242ac120002, '***.580.583-**', 'FRANCISCA SANDRA FEITOSA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b163dde-1017-11ed-861d-0242ac120002, '***.655.193-**', 'BRUNA DE BRITO PAIVA');
insert into infobarbank3.cliente(id, cpf, nome) VALUES(2b163ed8-1017-11ed-861d-0242ac120002, '***.708.013-**', 'LUCILENE PAULO BARBOSA');"

```{{exec}}

```plain
cqlsh -e "SELECT COUNT(1) 
          FROM infobarbank3.cliente;"

```{{exec}}

```plain
ls -la
```{{exec}}

Provavelmente não houve alteração na disposição dos arquivos.
Agora vamos forçar o flush da **memtable** para o disco:
```plain
nodetool flush

```{{exec}}

Após a execução de `nodetool flush`, uma nova listagem de arquivos (`ls -la`) terá um output como:
```
ubuntu $ ls -la
total 48
drwxr-xr-x 3 cassandra cassandra 4096 Dec 19 00:22 .
drwxr-xr-x 3 cassandra cassandra 4096 Dec 18 23:58 ..
drwxr-xr-x 2 cassandra cassandra 4096 Dec 18 23:58 backups
-rw-r--r-- 1 cassandra cassandra   47 Dec 19 00:22 nb-1-big-CompressionInfo.db
-rw-r--r-- 1 cassandra cassandra  504 Dec 19 00:22 nb-1-big-Data.db
-rw-r--r-- 1 cassandra cassandra    9 Dec 19 00:22 nb-1-big-Digest.crc32
-rw-r--r-- 1 cassandra cassandra   24 Dec 19 00:22 nb-1-big-Filter.db
-rw-r--r-- 1 cassandra cassandra  208 Dec 19 00:22 nb-1-big-Index.db
-rw-r--r-- 1 cassandra cassandra 4790 Dec 19 00:22 nb-1-big-Statistics.db
-rw-r--r-- 1 cassandra cassandra   92 Dec 19 00:22 nb-1-big-Summary.db
-rw-r--r-- 1 cassandra cassandra   92 Dec 19 00:22 nb-1-big-TOC.txt
ubuntu $ 
```

Perceba que vários arquivos de dados foram criados. A importância de cada um será explicada em sala de aula.

Por ora vamos examinar o arquivo `nb-1-big-Data.db`:
```plain
cat nb-1-big-Data.db
```{{exec}}

O output será parecido com isso:
```
+;B#$***.881.955-*LUCILIA ROSA LIMA PEREIRAP/%jPR,O"Pp615.942PGRACIMAR BRASIL GUERM/ `M2&Ka568.11KMARIVALDA KANAMARY/$*GB*HR150.5H JaENE MOQ CRUZK/>KR,Lq708.013/LPAULO BARBOS,/6MR/Mb434.71|PVERA RDRIGUES SENP/=PR*wPa655.19BRUNA DE BRITO PAIVK9R/Kb777.13IVONE GLA0VIAY#UT/<ڛR.Pa580.58FRANCISCA SANDRA FEIT:/5<OR,pWOa264.48LDENORMOREIRAr
```

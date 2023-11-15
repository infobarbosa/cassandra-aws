# Instalação do Cassandra
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

**Instalando o Java 11**
```
sudo apt install -y openjdk-11-jdk-headless
```

**Instalando o Cassandra**
Vamos incluir a chave e link para o repositório para que o gerenciador de pacotes do Linux saiba onde buscar os binários.  

```
echo "deb https://debian.cassandra.apache.org 41x main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

```

Obtento chaves do repositório:
```
curl https://downloads.apache.org/cassandra/KEYS | sudo apt-key add -

```

Atualizando a lista de pacotes:
```
sudo apt update -y
```

Instalando o Cassandra:
```
sudo apt install -y cassandra
```

Caso o serviço não tenha iniciado, você pode inicializá-lo manualmente:
```
sudo systemctl start cassandra
```

Verifique o status do serviço
```
sudo systemctl status cassandra
```

Se tudo correu bem então será possível verificar o status do node:
```
nodetool status
```

O comando acima deve retornar algo assim:
```
ubuntu $ nodetool status
Datacenter: datacenter1
 =======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load        Tokens  Owns (effective)  Host ID                               Rack 
UN  127.0.0.1  104.36 KiB  16      100.0%            5e975627-fbad-4711-897e-d61a1186deb6  rack1
```

**Atenção!** Se retornar o erro erro abaixo, é provável que o serviço Cassandra ainda esteja em processo de inicialização.
```
java.lang.RuntimeException: No nodes present in the cluster. Has this node finished starting up?
        at org.apache.cassandra.dht.Murmur3Partitioner.describeOwnership(Murmur3Partitioner.java:294)
```
Espere alguns segundos até que a inicialização tenha terminado e execute o comando novamente.

# Instalação do Cassandra
Author: Prof. Barbosa<br>
Contact: infobarbosa@gmail.com<br>
Github: [infobarbosa](https://github.com/infobarbosa)

Nesta sessão vamos instalar o Apache Cassandra no servidor EC2 do Cloud9.<br>
Você pode optar pela instalação automática via script `scripts/setup_cassandra.sh` ou por fazer o passo-a-passo descrito a seguir.<br>
As duas instalações são exatamente iguais.

## Instalação via `setup_cassandra.sh`

> Atenção! Os comandos aqui descritos presumem que você esteja no diretório raiz do projeto clonado do Github.

```
sh scripts/setup_cassandra.sh
```

Output:
```
voclabs:~/environment/cassandra-aws (main) $ sh scripts/setup_cassandra.sh
Reading package lists... Done
Building dependency tree... Done
Reading state information... Done
openjdk-11-jdk-headless is already the newest version (11.0.20.1+1-0ubuntu1~22.04).
0 upgraded, 0 newly installed, 0 to remove and 7 not upgraded.
deb https://debian.cassandra.apache.org 41x main
...
...
The following NEW packages will be installed:
  cassandra
0 upgraded, 1 newly installed, 0 to remove and 7 not upgraded.
Need to get 48.3 MB of archives.
After this operation, 58.8 MB of additional disk space will be used.
...
```

## Instalação passo-a-passo

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

## Checando a instalação
Se tudo correu bem então será possível verificar o status do node:
```
nodetool status
```

O comando acima deve retornar algo assim:
```
voclabs:~/environment/cassandra-aws (main) $ nodetool status
Datacenter: datacenter1
=======================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address    Load       Tokens  Owns (effective)  Host ID                               Rack 
UN  127.0.0.1  94.87 KiB  16      100.0%            8632e0e0-4901-428f-9484-6e1cf0c44cf1  rack1

voclabs:~/environment/cassandra-aws (main) $ 
```

**Atenção!** Se retornar o erro erro abaixo, é provável que o serviço Cassandra ainda esteja em processo de inicialização.
```
java.lang.RuntimeException: No nodes present in the cluster. Has this node finished starting up?
        at org.apache.cassandra.dht.Murmur3Partitioner.describeOwnership(Murmur3Partitioner.java:294)
```
Espere alguns segundos até que a inicialização tenha terminado e execute o comando novamente.

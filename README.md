## DESAFIO TÉCNICO — P03 — ESPECIALISTA EM REDES DE COMUNICAÇÃO - ReNTAI - LAVID - 2026 

#### Topologia do ambiente de simulação e como reproduzi-lo

O ambiente foi implementado utilizando Docker Compose com três containers:

| Container | Função | Imagem | Rede |
|-----------|--------|--------|------|
| `teleconsulta` | Simula teleconsultoria (vídeo/áudio interativo) | Ubuntu 22.04 | bridge |
| `telemetria` | Simula envio contínuo de sinais vitais | Ubuntu 22.04 | bridge |
| `video_cirurgico` | Simula transmissão de vídeo cirúrgico 4K | Ubuntu 22.04 | bridge |

##### Como reproduzir


###### Clonar o repositório
git clone https://github.com/andreluizrcn/rentai-network-challenge.git
cd rentai-network-challenge

###### Subir os containers
docker-compose up -d

###### Instalar ferramentas
docker exec teleconsulta apt update && apt install -y iproute2 iputils-ping iperf3
docker exec telemetria apt update && apt install -y iproute2 iputils-ping iperf3
docker exec video_cirurgico apt update && apt install -y iproute2 iputils-ping iperf3

###### Testar comunicação
docker exec teleconsulta ping telemetria


#### Metodologia de medição e tabela de resultados
##### Metodologia

As medições foram realizadas utilizando as seguintes ferramentas e parâmetros:

| Ferramenta | Parâmetros | Métricas coletadas |
|------------|------------|-------------------|
| `ping` | 100 pacotes ICMP | RTT médio, mínimo, máximo, perda |
| `iperf3` (UDP) | 10 segundos, 5 Mbps | Jitter, perda, throughput |
| `iperf3` (TCP) | 10 segundos | Throughput |

Os testes foram executados entre os containers `teleconsulta`, `telemetria` e `video_cirurgico` na rede bridge do Docker.

##### Resultados Baseline

| Sessão | RTT médio (ms) | RTT min (ms) | RTT max (ms) | Jitter (ms) | Perda (%) | Throughput (Mbps) |
|--------|---------------|--------------|--------------|-------------|-----------|-------------------|
| Teleconsulta | 0.088 | 0.041 | 0.275 | 0.013 | 0% | 5.00 |
| Telemetria | 0.088 | 0.041 | 0.275 | 0.013 | 0% | 5.00 |
| Vídeo cirúrgico | 0.093 | 0.045 | 0.179 | N/A | 0% | 18.5* |

> *Valor em rede local Docker. Em produção, throughput real para vídeo 4K é 20-50 Mbps.

#### Análise dos cenários de falha e impactos por tipo de sessão clínica

#### Justificativa dos limiares de QoS com referência às fontes consultadas

#### Proposta de arquitetura com diagrama.

#### Seção "Ferramentas de IA utilizadas"

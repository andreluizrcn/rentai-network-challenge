#!/bin/bash

echo "=========================================="
echo "MEDIÇÃO BASELINE - ReNTAI"
echo "=========================================="
echo ""

# 1. Ping teleconsulta -> telemetria
echo "[1/6] Ping: teleconsulta -> telemetria (100 pacotes)"
docker exec teleconsulta ping -c 100 telemetria | tee results/baseline/ping_consulta_telemetria.txt
echo ""

# 2. Ping teleconsulta -> video
echo "[2/6] Ping: teleconsulta -> video (100 pacotes)"
docker exec teleconsulta ping -c 100 video_cirurgico | tee results/baseline/ping_consulta_video.txt
echo ""

# 3. Ping telemetria -> video
echo "[3/6] Ping: telemetria -> video (100 pacotes)"
docker exec telemetria ping -c 100 video_cirurgico | tee results/baseline/ping_telemetria_video.txt
echo ""

# 4. iperf3 UDP -> telemetria
echo "[4/6] iperf3 UDP: teleconsulta -> telemetria (5Mbps, 10s)"
docker exec telemetria iperf3 -s -D 2>/dev/null
sleep 2
docker exec teleconsulta iperf3 -c telemetria -u -b 5M -t 10 | tee results/baseline/iperf_udp_telemetria.txt
docker exec telemetria pkill iperf3 2>/dev/null
echo ""

# 5. iperf3 UDP -> teleconsulta
echo "[5/6] iperf3 UDP: teleconsulta -> teleconsulta (2Mbps, 10s)"
docker exec teleconsulta iperf3 -s -D 2>/dev/null
sleep 2
docker exec teleconsulta iperf3 -c teleconsulta -u -b 2M -t 10 | tee results/baseline/iperf_udp_teleconsulta.txt
docker exec teleconsulta pkill iperf3 2>/dev/null
echo ""

# 6. iperf3 TCP -> video
echo "[6/6] iperf3 TCP: teleconsulta -> video (10s)"
docker exec video_cirurgico iperf3 -s -D 2>/dev/null
sleep 2
docker exec teleconsulta iperf3 -c video_cirurgico -t 10 | tee results/baseline/iperf_tcp_video.txt
docker exec video_cirurgico pkill iperf3 2>/dev/null
echo ""

echo "=========================================="
echo "MEDIÇÃO CONCLUÍDA!"
echo "Resultados salvos em: results/baseline/"
echo "=========================================="


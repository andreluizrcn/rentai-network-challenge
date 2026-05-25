echo "=== CENÁRIO : Perda de pacotes (5%) ==="

cd ~/rentai-network-challenge

./tc-scripts/apply_losses.sh

echo "--- PING teleconsulta -> telemetria ---"
docker exec teleconsulta ping -c 100 telemetria | tee results/failures/cenario3_ping.txt

echo "--- PING teleconsulta -> video ---"
docker exec teleconsulta ping -c 100 video_cirurgico | tee -a results/failures/cenario3_ping.txt

echo "--- IPERF3 UDP ---"
docker exec telemetria iperf3 -s -D 2>/dev/null && sleep 2
docker exec teleconsulta iperf3 -c telemetria -u -b 10M -t 60 | tee results/failures/cenario3_udp.txt
docker exec telemetria pkill iperf3 2>/dev/null

echo "--- IPERF3 TCP ---"
docker exec video_cirurgico iperf3 -s -D 2>/dev/null && sleep 2
docker exec teleconsulta iperf3 -c video_cirurgico -t 10 | tee results/failures/cenario3_tcp.txt
docker exec video_cirurgico pkill iperf3 2>/dev/null

./scripts/clear.sh

echo "=== CENÁRIO 3 CONCLUÍDO ==="


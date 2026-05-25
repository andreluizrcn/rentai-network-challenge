docker exec teleconsulta tc qdisc del dev eth0 root 2>/dev/null
docker exec telemetria tc qdisc del dev eth0 root 2>/dev/null
docker exec video_cirurgico tc qdisc del dev eth0 root 2>/dev/null
echo "Todas as regras removidas"

chmod +x scripts/clear.sh

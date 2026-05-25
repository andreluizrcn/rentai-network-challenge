docker exec teleconsulta tc qdisc add dev eth0 root tbf rate 1mbit burst 32kbit latency 400ms
echo "Congestionamento (1Mbps) aplicado na teleconsulta"


chmod +x tc-scripts/apply_congestion.sh

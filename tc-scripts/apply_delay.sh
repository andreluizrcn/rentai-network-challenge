docker exec teleconsulta tc qdisc add dev eth0 root netem delay 50ms
echo "Delay de 50ms aplicado na teleconsulta"

chmod +x tc-scripts/apply_delay.sh

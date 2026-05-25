docker exec teleconsulta tc qdisc add dev eth0 root netem loss 5%
echo "Perda de 5% aplicada na teleconsulta"

chmod +x tc-scripts/apply_losses.sh

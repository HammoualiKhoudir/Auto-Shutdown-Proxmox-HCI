#!/bin/bash
# Define your Proxmox cluster nodes
NODES=("pve01" "pve03" "pve02")

echo "Enable all self-healing actions, and to allow any client IO in the Ceph"
ceph osd unset pause
ceph osd unset nodown
ceph osd unset nobackfill
ceph osd unset norebalance
ceph osd unset norecover
ceph osd unset noout

echo "======================Display Ceph Health Status========================"
ceph -s | grep -i 'health'
echo "========================================================================"

for NODE in "${NODES[@]}"; do
	echo " Disable ha-manager maintenance on Node: $NODE"
	ha-manager crm-command node-maintenance disable $NODE
done
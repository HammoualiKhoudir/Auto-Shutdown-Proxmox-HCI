#!/bin/bash
# This script assumes you have SSH keys set up for passwordless login between nodes. 
# Define your Proxmox cluster nodes
NODES=("pve01" "pve02" "pve03")

echo "========================================================================"
for NODE in "${NODES[@]}"; do
    #Suspend all VMs and Shutting down all containers
	echo "Suspend all VMs and Shutting down all containers on $NODE"
	ssh root@$NODE '/bin/bash /opt/script/suspend_qm_shutdown_pct.sh'
done

for NODE in "${NODES[@]}"; do
	echo "Enable ha-manager maintenance on Node: $NODE"
	ha-manager crm-command node-maintenance enable $NODE
done

echo "========================================================================"

echo "Disable all self-healing actions, and to pause any client IO in the Ceph"
ceph osd set noout
ceph osd set norecover
ceph osd set norebalance
ceph osd set nobackfill
ceph osd set nodown
ceph osd set pause

echo "======================Display Ceph Health Status========================"
ceph -s | grep -i 'health'


# Now, shutdown the Proxmox hosts themselves

for	NODE in "${NODES[@]}"; do
	echo "Shutdown Node: $NODE"
	ssh root@$NODE 'shutdown -h now'
done

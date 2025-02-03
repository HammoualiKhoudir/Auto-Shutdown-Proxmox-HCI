#!/bin/bash

# This script assumes you have SSH keys set up for passwordless login between nodes. 

# Define your Proxmox cluster nodes
NODES=("pve01" "pve02" "pve03")


for NODE in "${NODES[@]}"; do
    # Suspend all VMs and Shutting down all containers
echo " Suspend all VMs and Shutting down all containers on $NODE"
	ssh root@$NODE '/bin/bash /opt/script/suspend_qm_pct.sh'
done

# Now, shutdown the Proxmox hosts themselves
for NODE in "${NODES[@]}"; do
	ssh root@$NODE 'shutdown -h now'
done

#!/bin/bash
# Suspend all VMs
qm list | grep running | awk -F'[^0-9]*' '$0=$2' | while read -r vm_id; do qm suspend $vm_id --todisk 1; done;

# Shutting down all containers
pct list | grep running | awk -F'[^0-9]*' '$0=$1'  | while read -r ct_id; do pct shutdown $ct_id; done;

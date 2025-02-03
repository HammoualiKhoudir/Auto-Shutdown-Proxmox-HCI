# Auto-Shutdown-Proxmox-HCI
AutoShutdown for Proxmox Cluster is a script-based solution to automatically suspend virtual machines (VMs), shut down containers (CTs), and safely power off idle Proxmox VE nodes. This helps save energy and optimize resource usage in a clustered environment
Features

    VM & Container Suspension: Uses qm suspend to save VM states and pct shutdown to properly stop running containers.
    Cluster Node Shutdown: Iterates through Proxmox nodes and powers them down when not in use.
    SSH-Based Execution: Automates commands via SSH for seamless remote execution.
    Customizable Node List: Easily define which cluster nodes should be managed.
    Energy Efficiency: Helps reduce power consumption by shutting down idle nodes.

Requirements

    Proxmox VE (PVE) 6.x or later
    SSH key-based authentication set up between cluster nodes
    Scripts placed in /opt/script/ (or update paths accordingly)

Installation & Usage

    Clone the repository:

git clone https://github.com/HammoualiKhoudir/Auto-Shutdown-Proxmox-HCI.git
cd Auto-Shutdown-Proxmox-HCI

Ensure SSH keys are configured for passwordless access.
Modify the NODES array in auto_shutdown_pve.sh to match your cluster nodes.
Deploy the scripts to each node:

scp auto_shutdown_pve.sh root@<NODE>:/opt/script/
scp suspend_qm_pct.sh root@<NODE>:/opt/script/

Set up a cron job or systemd service to execute the shutdown script periodically

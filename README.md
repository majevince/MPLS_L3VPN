# MPLSL3VPN
The following setup involves using 2 playbooks in configuring an MPLS L3 VPN topology.

1. prouters.yml

   The P routers Ansible Playbook consists of multiple roles to allow us reuse roles across the entire topology.
   These roles are:
    - config_basic_interfaces
    - config_ospfv2
    - config_bgp
    - config_mpls

2. perouters.yml

   The PE routers Ansible Playbook consists of multiple roles to allow us reuse roles across
 the entire topology.
   These roles are:
    - config_basic_interfaces
    - config_ospfv2
    - config_bgp
    - config_mpls
    - vrf_management
## Diagram
![MPLS L3 VPN Topology](images/mplsautomationtopology.png)

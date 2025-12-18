# Architecture Technique - ESXi AFPABike

## Infrastructure
- VMware vSphere 6.7 (2 ESXi + vCenter)
- Ubuntu 24.04 LTS
- Docker CE

## Flux
1. Terraform → Provisioning VM
2. Ansible → Configuration + Docker
3. Validation → Tests

---
**Dernière mise à jour**: 19/12/2025

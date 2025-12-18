# Architecture Technique - ESXi AFPABike

## Vue d'ensemble

Déploiement d'une application web de gestion de location de vélos (AFPABike) sur infrastructure **VMware vSphere ESXi** via approche Infrastructure as Code (IaC).

Le flux de déploiement suit une chaîne automatisée : provisionnement de ressources cloud → configuration système → déploiement applicatif.

---

## 🏗️ Architecture d'Infrastructure

### Couche Virtualisation

```
┌─────────────────────────────────────────────────────────┐
│                     VMware vCenter 6.7                   │
│  (Gestion centralisée des ESXi et ressources)            │
└─────────────────────────────────────────────────────────┘
                              │
        ┌─────────────────────┴──────────────────────┐
        │                                            │
┌───────────────────────┐             ┌──────────────────────┐
│    ESXi 6.7 Node 1    │             │   ESXi 6.7 Node 2    │
│  (Host virtualisation)│             │  (Host virtualisation)│
└────────────┬──────────┘             └──────────┬───────────┘
```

### VM Provisionnée

- **Nom** : `lab-ubuntu-2404`
- **OS** : Ubuntu Server 24.04 LTS
- **CPUs** : 2 vCPU
- **RAM** : 4 GB
- **Disque** : 20 GB (thin provisioned, ajustable via variable)
- **Network** : Portgroup fourni en variable (`network_name`)
- **Provisionnement** : VM clonée depuis un template vSphere Ubuntu 24.04 (pas de boot ISO)
- **Préparation template** : utilisateur `ansible` + clé publique présents dans la golden-VM; netplan `dhcp4:true` si DHCP ESXi instable

---

## 🔄 Flux de Déploiement

1. **TERRAFORM (IaC)** : Provisionnement VM lab-ubuntu-2404 via vCenter
2. **ANSIBLE** : Installation Docker + déploiement rôle afpabike_docker
3. **DOCKER COMPOSE** : Orchestration stack (Apache, MariaDB, AFPABike)

---

## 📦 Stack Applicatif

### Services Docker Compose

| Service | Rôle | Image |
|---------|------|-------|
| Apache + PHP | Web server & runtime | php:8.2-apache |
| MySQL | Base de données | mysql:8.0 |
| AFPABike | Application web | Code PHP |

### Base de Données

Crebas_AfpaBike_v1-1_with_values.sql contient :
- Tables métier : velo, marque, piece, location, contrat, entretien, formation
- Données de test

---

## 🛠️ Outils & Versions

| Composant | Version |
|-----------|---------|
| Terraform | ~> 1.5 |
| Ansible | 2.15+ |
| vSphere | 6.7 |
| Ubuntu | 24.04 LTS |
| Docker | CE (latest) |
| PHP/Apache | php:8.2-apache |
| Base de données | MySQL 8.0 |

---

## 📝 Fichiers Clés

| Fichier | Responsable |
|---------|-------------|
| terraform/main.tf | James |
| ansible.cfg + inventory.ini | Yanis |
| deploy_afpabike.yml | Yanis |
| roles/afpabike_docker/ | Yanis |

---

**Dernière mise à jour** : 18 décembre 2025  
**Statut** : Périmètre ESXi/vSphere - Proxmox/Azure à venir

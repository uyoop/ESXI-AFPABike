# Matrice RACI - Pôle ESXi AFPABike

## Contexte

Répartition des responsabilités pour le **périmètre ESXi/vSphere + Terraform + Ansible + Docker Compose** (1 VM). Hors périmètre: Proxmox, Azure, Swarm, CI/CD.

## Équipe

| Membre | Rôle | Domaine |
|--------|------|---------|
| James | Infra & Terraform | ESXi, vCenter, IaC, réseau |
| Yanis | Automatisation & Docker | Ansible, Docker/Compose |
| Christopher | Documentation & Git | Doc, versioning, coordination |

## Légende

- R = Responsible (fait)
- A = Accountable (valide)
- C = Consulted (consulté)
- I = Informed (informé)

## 1️⃣ Infrastructure ESXi & vCenter

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| Installation ESXi/vCenter, clusters, réseaux, datastores | R | C | A |
| Sécurité infra (SSL, permissions) | R | C | A |

## 2️⃣ Terraform - Provisionnement VM

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| Code Terraform (main.tf, variables.tf, provider) | R | C | A |
| Paramétrage VM (CPU/RAM/disk/network) | R | C | I |
| Plan/apply Terraform | R | C | I |
| Documentation Terraform | C | I | R/A |

## 3️⃣ Ansible - Configuration & Automatisation

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| Inventaire, ansible.cfg | C | R | A |
| Rôle afpabike_docker, tasks (Docker, rsync) | C | R | A |
| Utilisateur ansible + clés SSH | C | R | A |
| Playbook deploy_afpabike.yml | C | R | A |
| Tests (ping, check, idempotence) | C | R | I |
| Documentation Ansible | C | I | R/A |

## 4️⃣ Docker & Docker Compose

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| Installation Docker CE | C | R | A |
| docker-compose.yml (php/apache + mysql) | C | R | A |
| Déploiement stack (`docker compose up -d`) | C | R | I |
| Logs/monitoring containers | C | R | I |
| Documentation Docker/Compose | C | I | R/A |

## 5️⃣ Application AFPABike

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| Synchronisation code app | C | R | I |
| Config Apache/PHP | C | R | I |
| Chargement base SQL | C | R | I |
| Tests app (fonctionnels) | C | R | I |
| Validation intégration globale | C | R | A |

## 6️⃣ Documentation & Versioning

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| README, architecture, deployment, troubleshooting, RACI | C | C | R/A |
| Repo GitHub (structure, tags) | I | I | R/A |
| Revue documentation | C | C | R/A |

## 7️⃣ Intégration & Tests

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| Tests E2E (Terraform → Ansible → App) | R | R | A |
| Validation services Docker | C | R | I |
| Validation application accessible | C | R | I |
| Résolution bugs infra | R | C | I |
| Résolution bugs automatisation | C | R | I |

## 8️⃣ Communication & Coordination

| Activité | James | Yanis | Christopher |
|----------|-------|-------|-------------|
| Points de sync quotidiens | R | R | R |
| Communication modifications infra | R | C | A |
| Communication modifications code Ansible/Compose | C | R | A |
| Alertes incidents / escalade | R | R | A |

## Workflow de validation

- Développement (R) → Tests individuels (R) → Point équipe → Validation finale (A) → Documentation (R/C) → Git commit/push (R)
- Checkpoints: infra (James R / Christopher A), Ansible (Yanis R / Christopher A), push GitHub (Christopher A)

## KPIs

| KPI | A | R |
|-----|---|---|
| Infra ESXi opérationnelle | James | Yanis, Christopher |
| Terraform fonctionnel | James | Christopher |
| Playbooks Ansible opérationnels | Yanis | James, Christopher |
| Docker Compose déployé | Yanis | James |
| Application accessible (8080) | Yanis | James |
| Documentation à jour | Christopher | Yanis, James |
| Repo GitHub clean/versionné | Christopher | Yanis, James |

## Gestion du document

- Responsable des mises à jour : Christopher (A), consultation Yanis & James (C)
- Version : 1.1 — Périmètre ESXi
- Historique : 18/12/2025 création v1.0 ; 18/12/2025 ajustement A unique v1.1


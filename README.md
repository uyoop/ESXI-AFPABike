# ESXI-AFPABike - Projet DevOps

## 📋 Vue d'ensemble

Projet de déploiement automatisé de l'application **AFPABike** (système de location de vélos) sur infrastructure **VMware vSphere ESXi** utilisant une approche Infrastructure as Code (IaC) et Configuration Management.

### Objectifs du projet

- ✅ Provisionnement automatisé de VMs via **Terraform**
- ✅ Configuration et déploiement automatisés via **Ansible**
- ✅ Conteneurisation de l'application avec **Docker Compose**
- ✅ Déploiement applicatif automatisé
- ✅ Documentation complète et versioning Git

---

## 👥 Équipe Pôle ESXi

| Membre | Rôle Principal | Responsabilités |
| ------ | -------------- | --------------- |
| **James** | Spécialiste Infrastructure & Terraform | ESXi, vCenter, IaC, Réseau |
| **Yanis** | Spécialiste Automatisation & Docker | Ansible, Docker, Orchestration |
| **Christopher** | Responsable Documentation & Git | Versioning, Documentation, Coordination |

> 📄 Consultez la [Matrice RACI détaillée](docs/RACI.md) pour la répartition complète des responsabilités.

---

## 🏗️ Architecture Technique

### Infrastructure

- **Hyperviseur** : VMware ESXi 6.7 + vCenter Server 6.7
- **OS VMs** : Ubuntu 24.04 LTS
- **Stockage** : SAN partagé (datastore1)
- **Réseau** : vSwitches avec VLANs
- **VMs provisionnées** : 1 VM (lab-ubuntu-2404)

### Stack Applicative

- **Web Server / Runtime** : php:8.2-apache
- **Base de données** : MySQL 8.0
- **Conteneurisation** : Docker CE
- **Orchestration** : Docker Compose
- **Application** : AFPABike (PHP/MySQL)

### Outils DevOps

- **IaC** : Terraform 1.5+
- **Configuration Management** : Ansible 2.15+
- **Versioning** : Git + GitHub
- **CI/CD** : (Pipeline à venir)

> 📐 Voir [Architecture détaillée](docs/architecture.md)

---

## 📁 Structure du Projet

```text
ESXI-AFPABike/
├── terraform/                   # Infrastructure as Code (Terraform)
│   ├── main.tf                 # Ressources vSphere (VM clonée depuis template)
│   └── variables.tf            # Variables vSphere (user/pass/server + datacenter/cluster/datastore/network/template/vm specs)
│
├── roles/                       # Rôles Ansible
│   └── afpabike_docker/        # Rôle : déploiement AFPABike + Docker
│       ├── tasks/
│       │   └── main.yml        # Tâches (installer Docker, déployer Compose)
│       ├── files/
│       │   └── afpabike/       # Fichiers de l'application (docker-compose.yml, app/)
│       └── defaults/
│           └── main.yml        # Variables par défaut (app_dest, app_src)
│
├── ansible.cfg                  # Configuration Ansible
├── inventory.ini                # Inventaire des hôtes (hosts vCenter)
├── deploy_afpabike.yml          # Playbook principal
│
├── docs/                        # Documentation
│   ├── architecture.md         # Architecture technique
│   ├── deployment.md           # Guide de déploiement
│   ├── troubleshooting.md      # Résolution de problèmes
│   ├── RACI.md                # Matrice RACI
│   └── TP-DEVOPS              # Énoncé du TP
│
├── ansible.cfg                 # Fichier de config Ansible
├── inventory.ini               # Inventaire Ansible
├── deploy_afpabike.yml         # Playbook de déploiement
├── README.md                   # Ce fichier
└── .gitignore
```

---

## 🚀 Déploiement Rapide

### Prérequis

**Logiciels requis :**

```bash
terraform --version   # ≥ 1.5.0
ansible --version     # ≥ 2.15.0
git --version         # ≥ 2.0
```

**Accès nécessaires :**

- vCenter Server (ex: 10.20.69.200)
- Credentials vSphere (user/password)
- Datastore et réseau configurés dans vCenter
- **Template vSphere Ubuntu Server** déjà disponible (ex: 24.04, NIC vmxnet3) avec la bonne datastore/network
- Accès SSH à la VM provisionnée (user `ansible`)

### Étape 1 : Configuration et application Terraform

```bash
cd terraform/

# Créer le fichier de variables
# À adapter avec tes credentials vSphere
cat > terraform.tfvars <<EOF
vsphere_user     = "root"
vsphere_password = "ton_password"
vsphere_server   = "10.20.69.200"

datacenter    = "DCDevops"
cluster       = "ClusterDevops"
datastore     = "datastore1"
network_name  = "VM Network"

template_name = "ubuntu-24.04-template"
vm_name       = "lab-ubuntu-2404"
vm_cpu        = 2
vm_memory     = 4096
vm_disk_gb    = 20
EOF

# Initialiser Terraform
terraform init

# Vérifier le plan
terraform plan

# Appliquer le provisionnement
terraform apply
```

**Résultat attendu :** 1 VM Ubuntu `lab-ubuntu-2404` créée et démarrée dans vCenter.

### Étape 2 : Configuration Ansible et déploiement

```bash
cd ..

# Adapter l'inventaire avec l'IP réelle de la VM
nano inventory.ini

# Exemple:
# [vcenter_vms]
# vm-afpabike ansible_host=10.20.69.20

# Tester la connectivité SSH
ansible all -m ping

# Déployer la configuration complète
ansible-playbook deploy_afpabike.yml
```

**Résultat attendu :** Docker installé, application AFPABike déployée via `docker compose up -d`.

### Étape 3 : Validation

```bash
# Vérifier Docker sur la VM
ssh ansible@<VM_IP>
docker ps

# Vérifier les logs de l'app
docker compose logs -f

# Tester l'application
curl http://<VM_IP>/afpabike
```

> 📖 Guide complet : [Documentation de déploiement](docs/deployment.md)

---

## 🔧 Utilisation Quotidienne

### Commandes Terraform Utiles

```bash
# Voir l'état de l'infrastructure
terraform show

# Lister les ressources
terraform state list

# Détruire l'infrastructure
terraform destroy

# Formater le code
terraform fmt

# Valider la syntaxe
terraform validate
```

### Commandes Ansible Utiles

```bash
# Exécuter une tâche ad-hoc
ansible all -m shell -a "uptime"

# Exécuter le playbook en mode check (dry-run)
ansible-playbook deploy_afpabike.yml --check

# Exécuter avec verbosité
ansible-playbook deploy_afpabike.yml -vvv

# Voir les tâches du playbook
ansible-playbook deploy_afpabike.yml --list-tasks
```

### Commandes Docker Compose Utiles

```bash
# Se connecter à la VM
ssh ansible@<VM_IP>

# Voir l'état des conteneurs
docker ps

# Voir les logs de l'application
docker compose logs -f

# Redémarrer l'application
docker compose restart

# Arrêter l'application
docker compose down

# Démarrer l'application
docker compose up -d
```

---

## 📚 Documentation

| Document | Description |
| -------- | ----------- |
| [Architecture](docs/architecture.md) | Architecture technique détaillée |
| [Déploiement](docs/deployment.md) | Guide de déploiement pas à pas |
| [Troubleshooting](docs/troubleshooting.md) | Résolution des problèmes courants |
| [RACI](docs/RACI.md) | Matrice RACI - Responsabilités équipe |

---

## 🐛 Dépannage Rapide

### Terraform

#### Erreur : Provider vsphere incompatible

```bash
# Le code utilise provider vsphere ~> 2.4 (vSphere 6.7)
terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.4"
    }
  }
}
```

#### Erreur : template introuvable

```bash
# Vérifier que template_name existe dans le bon datacenter/cluster/datastore
# et qu'il est visible par le compte vSphere.
```

### Ansible

#### Erreur : SSH connection refused

```bash
# L'ISO n'a pas cloud-init, attendre le démarrage (~5-10 min)
# Vérifier que la VM a une IP (check dans vCenter)
ping <VM_IP>

# Tester SSH manuellement
ssh -v ansible@<VM_IP>

# Si permission denied, vérifier les credentials Terraform
```

#### Erreur : ansible.posix.synchronize

```bash
# Installer rsync sur la VM si absent (Ubuntu minimal)
# Vérifier que l'utilisateur ansible existe et que la clé publique est en place.
```

### Docker

#### Erreur : Docker Compose ne démarre pas

```bash
# Voir les logs détaillés
cd /home/ansible/afpabike
docker compose logs

# Vérifier les variables d'env ou la config
cat docker-compose.yml

# Redémarrer
docker compose restart
```

#### Erreur : Container AFPABike ne répond pas

```bash
# Vérifier la présence de MariaDB
docker ps | grep mariadb

# Voir logs Apache
docker compose logs apache

# Vérifier la connectivité BD
docker compose exec php ping mariadb
```

> 🔍 Plus de solutions : [Guide de troubleshooting](docs/troubleshooting.md)

---

## 🔄 Workflow Git

### Branches principales

- `main` - Code stable de production
- `develop` - Développement en cours
- `feature/*` - Nouvelles fonctionnalités
- `fix/*` - Corrections de bugs

### Processus de contribution

```bash
# 1. Créer une branche
git checkout -b feature/nom-fonctionnalite

# 2. Faire les modifications
# ... éditer les fichiers ...

# 3. Commiter les changements
git add .
git commit -m "feat: description de la fonctionnalité"

# 4. Pousser la branche
git push origin feature/nom-fonctionnalite

# 5. Créer une Pull Request sur GitHub
# 6. Faire valider par l'équipe
# 7. Merger dans develop puis main
```

### Conventions de commit

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation
- `refactor:` Refactoring
- `test:` Ajout de tests
- `chore:` Maintenance

---

## 📊 KPIs du Projet

| Indicateur | Cible | Statut |
| ---------- | ----- | ------ |
| Infrastructure ESXi opérationnelle | 100% | ✅ |
| VM provisionnée automatiquement | 1 VM | ✅ |
| Code Terraform fonctionnel | `apply` OK | ✅ |
| Playbook Ansible opérationnel | Exécution OK | ✅ |
| Docker Compose déployé | Containers UP | ✅ |
| Stack AFPABike déployée | Services UP | ✅ |
| Documentation complète | 100% | ✅ |
| Repository GitHub structuré | Clean | ✅ |

---

## 🎯 Roadmap

### Phase 1 : Infrastructure ✅

- [x] Installation ESXi + vCenter
- [x] Configuration réseau et stockage
- [x] Cluster HA fonctionnel

### Phase 2 : Automatisation ✅

- [x] Code Terraform complet
- [x] Playbooks Ansible fonctionnels
- [x] Tests d'idempotence

### Phase 3 : Conteneurisation ✅

- [x] Docker installé sur la VM
- [x] Docker Compose configuré
- [x] Stack AFPABike déployée

### Phase 4 : Documentation ✅

- [x] README complet
- [x] Documentation technique
- [x] Matrice RACI
- [x] Guide de troubleshooting

### Phase 5 : CI/CD � (À venir)

- [ ] GitLab + Runner (cluster Proxmox)
- [ ] Harbor Registry
- [ ] Pipeline CI/CD
- [ ] Déploiement vers Azure

### Phase 6 : Monitoring 📅 (À venir)

- [ ] Prometheus + Grafana
- [ ] Logs centralisés
- [ ] Alerting

### Phase 7 : Évolution multi-environnements 📅 (À venir)

- [ ] Cluster Proxmox avec déploiement Terraform/Ansible
- [ ] Déploiement Azure avec Terraform
- [ ] Orchestration Docker Swarm (optionnel)

---

## 📞 Support & Contact

### En cas de problème

1. **Consulter la documentation** - [docs/](docs/)
2. **Vérifier les issues GitHub** - Problème déjà rencontré ?
3. **Créer une issue** - Décrire le problème en détail
4. **Contacter l'équipe** - Voir matrice RACI

### Responsables par domaine

| Domaine | Contact |
| ------- | ------- |
| Infrastructure ESXi / Terraform | James |
| Ansible / Docker | Yanis |
| Documentation / Git | Christopher |

---

## 📜 Licence

Projet pédagogique AFPA - Formation DevOps 2025

---

## 🙏 Remerciements

- **Formateurs AFPA** - Pour l'accompagnement
- **Équipe Pôle ESXi** - Pour la collaboration
- **Communauté DevOps** - Pour les ressources

---

## 📝 Notes de Version

### Version 1.0 - 18 décembre 2025

- ✅ Infrastructure ESXi + vCenter configurée
- ✅ Terraform IaC pour provisionnement VM vSphere
- ✅ Ansible pour configuration et déploiement
- ✅ Docker Compose pour application AFPABike
- ✅ Documentation technique complète

**Périmètre actuel :** Déploiement Pôle ESXi/vSphere  
**À venir :** Proxmox, Azure, CI/CD, Monitoring

---

**Dernière mise à jour** : 18 décembre 2025  
**Statut du projet** : En production  
**Équipe** : Yanis, James, Christopher  
**Organisation** : AFPA - Formation DevOps 2025

---

> 💡 **Tip** : Ce README est un document vivant. N'hésitez pas à le mettre à jour au fur et à mesure de l'évolution du projet !

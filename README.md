# ESXI-AFPABike - Projet DevOps

## 📋 Vue d'ensemble

Projet de déploiement automatisé de l'application **AFPABike** (système de location de vélos) sur infrastructure **VMware vSphere ESXi** utilisant une approche Infrastructure as Code (IaC) et Configuration Management.

### Objectifs du projet

- ✅ Provisionnement automatisé de VMs via **Terraform**
- ✅ Configuration et déploiement automatisés via **Ansible**
- ✅ Conteneurisation de l'application avec **Docker**
- ✅ Orchestration avec **Docker Swarm**
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

- **Hyperviseur** : VMware ESXi 6.7 (2 nœuds)
- **Gestion** : vCenter Server 6.7
- **OS VMs** : Ubuntu 24.04 LTS
- **Stockage** : SAN partagé
- **Réseau** : vSwitches avec VLANs

### Stack Applicative

- **Web Server** : Apache 2.4
- **Base de données** : MariaDB 10.x
- **Conteneurisation** : Docker CE
- **Orchestration** : Docker Swarm
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
├── terraform/                  # Infrastructure as Code
│   └── esxi/                  # Configuration vSphere
│       ├── main.tf            # Ressources principales
│       ├── variables.tf       # Variables
│       ├── outputs.tf         # Sorties
│       └── terraform.tfvars   # Valeurs (non versionné)
│
├── ansible/                   # Configuration Management
│   ├── ansible.cfg           # Configuration Ansible
│   ├── inventori.ini         # Inventaire des hôtes
│   ├── playbooks/            # Playbooks principaux
│   │   └── site.yml         # Playbook principal
│   └── roles/                # Rôles Ansible
│
├── roles/                    # Rôles pour l'application
│   └── afpabike_docker/     # Déploiement AFPABike
│       ├── tasks/           # Tâches Ansible
│       ├── files/           # Fichiers de l'app
│       └── defaults/        # Variables par défaut
│
├── docs/                    # Documentation
│   ├── architecture.md     # Architecture technique
│   ├── deployment.md       # Guide de déploiement
│   ├── troubleshooting.md  # Résolution de problèmes
│   └── RACI.md            # Matrice RACI
│
└── README.md              # Ce fichier
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

- vCenter Server (<https://vcenter.local>)
- Credentials vSphere (user/password)
- Accès SSH aux VMs provisionnées
- Template Ubuntu 24.04 dans vCenter

### Étape 1 : Configuration Terraform

```bash
cd terraform/esxi/

# Copier et éditer les variables
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars

# Initialiser Terraform
terraform init

# Vérifier le plan
terraform plan

# Appliquer le provisionnement
terraform apply
```

**Résultat attendu :** 3 VMs Ubuntu créées et démarrées dans vCenter.

### Étape 2 : Configuration Ansible

```bash
cd ../../

# Vérifier l'inventaire
cat inventori.ini

# Tester la connectivité
ansible all -m ping

# Déployer la configuration complète
ansible-playbook ansible/playbooks/site.yml

# Ou déploiement étape par étape
ansible-playbook ansible/playbooks/site.yml --tags "docker"
ansible-playbook ansible/playbooks/site.yml --tags "swarm"
ansible-playbook ansible/playbooks/site.yml --tags "afpabike"
```

**Résultat attendu :** Docker installé, Swarm configuré, application déployée.

### Étape 3 : Validation

```bash
# Vérifier Docker sur les VMs
ansible all -m shell -a "docker --version"

# Vérifier Docker Swarm
ansible managers -m shell -a "docker node ls"

# Vérifier les services déployés
ansible managers -m shell -a "docker service ls"

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

# Exécuter un playbook en mode check (dry-run)
ansible-playbook playbooks/site.yml --check

# Exécuter avec verbosité
ansible-playbook playbooks/site.yml -vvv

# Exécuter uniquement certains tags
ansible-playbook playbooks/site.yml --tags "docker,swarm"

# Lister les tâches
ansible-playbook playbooks/site.yml --list-tasks
```

### Commandes Docker Swarm

```bash
# Se connecter au manager
ssh ansible@<manager-ip>

# Voir l'état du cluster
docker node ls

# Voir les services
docker service ls

# Voir les logs d'un service
docker service logs afpabike_web

# Scaler un service
docker service scale afpabike_web=3

# Mettre à jour un service
docker service update afpabike_web
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

#### Erreur : Provider incompatible

```bash
# Utiliser une version compatible
terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "2.2.0"  # Compatible vSphere 6.7
    }
  }
}
```

#### Erreur : Template introuvable

```bash
# Vérifier le nom exact dans vCenter
# Mettre à jour dans terraform.tfvars
```

### Ansible

#### Erreur : SSH Connection refused

```bash
# Attendre que cloud-init termine (2-3 min)
# Vérifier la connectivité
ping <VM_IP>
ssh ansible@<VM_IP>
```

#### Erreur : Permission denied sur Docker

```bash
# Se déconnecter et reconnecter pour charger le groupe docker
exit
ssh ansible@<VM_IP>
```

### Docker

#### Erreur : Container ne démarre pas

```bash
# Voir les logs détaillés
docker service ps afpabike_web --no-trunc

# Inspecter le service
docker service inspect afpabike_web
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
| VMs provisionnées automatiquement | 3 VMs | ✅ |
| Code Terraform fonctionnel | `apply` OK | ✅ |
| Playbooks Ansible opérationnels | Tests OK | ✅ |
| Docker Swarm déployé | Cluster actif | ✅ |
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

- [x] Docker installé sur toutes les VMs
- [x] Docker Swarm cluster actif
- [x] Stack AFPABike déployée

### Phase 4 : Documentation ✅

- [x] README complet
- [x] Documentation technique
- [x] Matrice RACI
- [x] Guide de troubleshooting

### Phase 5 : CI/CD 🚧 (À venir)

- [ ] GitLab + Runner
- [ ] Harbor Registry
- [ ] Pipeline CI/CD
- [ ] Déploiement vers Azure

### Phase 6 : Monitoring 📅 (Planifié)

- [ ] Prometheus + Grafana
- [ ] Logs centralisés
- [ ] Alerting

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

- ✅ Infrastructure ESXi déployée
- ✅ Terraform opérationnel
- ✅ Ansible opérationnel
- ✅ Docker Swarm déployé
- ✅ Documentation complète

---

**Dernière mise à jour** : 18 décembre 2025  
**Statut du projet** : En production  
**Équipe** : Yanis, James, Christopher  
**Organisation** : AFPA - Formation DevOps 2025

---

> 💡 **Tip** : Ce README est un document vivant. N'hésitez pas à le mettre à jour au fur et à mesure de l'évolution du projet !

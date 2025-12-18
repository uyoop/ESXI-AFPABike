# Matrice RACI - Pôle ESXi AFPABike

## Équipe Pôle ESXi
- **Yanis** - Spécialiste Ansible & Docker
- **James** - Spécialiste Terraform & Infrastructure
- **Christopher** - Responsable Documentation & Versioning

---

## Légende RACI

- **R (Responsible)** : Réalise l'activité et exécute le travail
- **A (Accountable)** : Responsable final, valide et approuve le travail
- **C (Consulted)** : Consulté pour expertise, donne son avis
- **I (Informed)** : Informé des résultats et de l'avancement

---

## Infrastructure ESXi & vCenter

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Installation ESXi | I | R/A | I |
| Configuration vCenter | I | R/A | I |
| Configuration Cluster HA | C | R/A | I |
| Configuration Datastores | I | R/A | C |
| Configuration Réseau (vSwitches/VLANs) | C | R/A | I |
| Sécurité infrastructure | C | R/A | C |
| Tests infrastructure | C | R/A | I |

---

## Terraform - Provisionnement VMs

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Développement code Terraform | C | R/A | I |
| Configuration provider vSphere | I | R/A | C |
| Définition templates VMs | C | R/A | I |
| Configuration réseau VMs | C | R/A | I |
| Tests `terraform plan` | C | R/A | I |
| Exécution `terraform apply` | C | R/A | I |
| Validation provisionnement | C | R/A | I |
| Documentation code Terraform | I | C | R/A |
| Versioning code Terraform | I | C | R/A |

---

## Ansible - Configuration & Automatisation

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Création structure Ansible | R/A | I | C |
| Configuration `ansible.cfg` | R/A | C | I |
| Configuration `inventory.ini` | R/A | C | I |
| Développement playbooks | R/A | C | I |
| Développement rôles Ansible | R/A | C | I |
| Configuration utilisateur ansible | R/A | I | I |
| Configuration SSH | R/A | C | I |
| Installation Python sur VMs | R/A | I | I |
| Tests playbooks | R/A | C | I |
| Tests idempotence | R/A | C | I |
| Documentation playbooks | R/A | I | C |

---

## Docker & Containerisation

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Installation Docker CE | R/A | C | I |
| Configuration Docker daemon | R/A | C | I |
| Création Docker Swarm cluster | R/A | C | I |
| Configuration manager nodes | R/A | C | I |
| Configuration worker nodes | R/A | C | I |
| Déploiement stack AFPABike | R/A | C | I |
| Configuration docker-compose | R/A | C | C |
| Tests services Docker | R/A | C | I |
| Monitoring containers | R/A | C | I |
| Documentation Docker | R/A | I | C |

---

## Application AFPABike

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Configuration Apache | R/A | I | C |
| Configuration MariaDB | R/A | I | C |
| Déploiement base de données | R/A | I | C |
| Configuration réseau applicatif | C | R/A | I |
| Tests application | R/A | C | I |
| Validation connectivité BDD | R/A | I | C |
| Documentation application | C | I | R/A |

---

## Documentation & Versioning

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Création repository GitHub | I | I | R/A |
| Structure repository | C | C | R/A |
| Rédaction README.md | C | C | R/A |
| Documentation architecture | C | C | R/A |
| Documentation déploiement | C | C | R/A |
| Documentation troubleshooting | C | C | R/A |
| Documentation RACI | C | C | R/A |
| Versioning code | I | C | R/A |
| Commits & Push | C | C | R/A |
| Création tags versions | I | I | R/A |
| Revue documentation | C | C | R/A |

---

## Intégration & Tests

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Tests bout-en-bout infrastructure | C | R/A | I |
| Tests provisionnement complet | C | R/A | C |
| Tests configuration automatisée | R/A | C | C |
| Tests déploiement application | R/A | C | I |
| Validation services Docker | R/A | C | I |
| Tests de charge | R/A | C | I |
| Validation complète | C | R/A | C |
| Résolution bugs infrastructure | C | R/A | I |
| Résolution bugs automatisation | R/A | C | I |

---

## Communication & Coordination

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Points de synchronisation quotidiens | R | R | R |
| Communication modifications infra | I | R/A | C |
| Communication modifications code | R/A | C | C |
| Alertes incidents | R | R | R |
| Escalade problèmes techniques | C | R/A | C |
| Partage connaissances | R | R | R |

---

## Planning & Deadlines

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Planification tâches | C | C | R/A |
| Suivi avancement | C | C | R/A |
| Gestion deadlines | C | C | R/A |
| Coordination équipe | R | R | R/A |
| Reporting avancement | C | C | R/A |

---

## Présentation & Démonstration

| Activité | Yanis | James | Christopher |
|----------|-------|-------|-------------|
| Préparation slides | C | C | R/A |
| Démonstration Terraform | I | R/A | C |
| Démonstration Ansible | R/A | C | C |
| Démonstration Docker | R/A | C | C |
| Présentation architecture | C | R/A | C |
| Présentation workflow | C | C | R/A |
| Q&A technique | R | R | R |

---

## Points de Synchronisation Obligatoires

### Quotidiens
- **12h00** : Point avant pause déjeuner (10 min)
- **15h00** : Point milieu après-midi (10 min)

### Critiques
- **Avant modifications infrastructure** : Validation James
- **Avant modifications code Ansible** : Validation Yanis
- **Avant push GitHub** : Validation Christopher

---

## Workflow de Validation

```
Développement → Tests individuels → Point équipe → Validation finale → Documentation → Git commit/push
```

### Processus de validation par composant

**Terraform:**
1. James développe (R)
2. Yanis revoit (C)
3. Christopher documente (R)
4. James valide (A)

**Ansible:**
1. Yanis développe (R)
2. James revoit (C)
3. Christopher documente (R)
4. Yanis valide (A)

**Docker:**
1. Yanis développe (R)
2. James teste infra (C)
3. Christopher documente (R)
4. Yanis valide (A)

---

## Règles de Communication

### Avant intervention sur infrastructure
- ✅ Annoncer dans le canal équipe
- ✅ Attendre confirmation des autres membres
- ✅ Documenter l'intervention
- ✅ Informer de la fin d'intervention

### Avant commit Git
- ✅ Tests locaux réussis
- ✅ Documentation à jour
- ✅ Message de commit descriptif
- ✅ Notification équipe si changement majeur

---

## KPIs & Responsabilités

| KPI | Responsable (A) | Support (R) |
|-----|-----------------|-------------|
| Infrastructure opérationnelle 100% | James | Yanis, Christopher |
| Code Terraform fonctionnel | James | Christopher |
| Playbooks Ansible opérationnels | Yanis | James, Christopher |
| Docker Swarm déployé | Yanis | James |
| Documentation complète | Christopher | Yanis, James |
| Repository GitHub à jour | Christopher | Yanis, James |
| Présentation réussie | Tous (R/A) | Tous |

---

## Escalade & Résolution Problèmes

### Niveau 1 - Problème technique individuel
- Tenter résolution (15 min max)
- Consulter documentation
- Googler l'erreur

### Niveau 2 - Blocage technique
- Alerter équipe immédiatement
- Pair programming si nécessaire
- Consulter (C) selon domaine

### Niveau 3 - Blocage critique
- Point équipe d'urgence
- Décision collective
- Documentation de la solution

---

## Domaines d'Expertise

**James - Infrastructure & Virtualisation**
- ESXi / vCenter
- Terraform / IaC
- Réseau & Stockage
- Clusters HA/DRS

**Yanis - Automatisation & Conteneurs**
- Ansible / Configuration Management
- Docker / Containerisation
- Docker Swarm / Orchestration
- Scripting

**Christopher - Documentation & Gestion**
- Git / Versioning
- Documentation technique
- Markdown / Rédaction
- Coordination projet

---

**Date de création** : 18 décembre 2025  
**Dernière mise à jour** : 18 décembre 2025  
**Version** : 1.0  
**Statut** : Document vivant - À mettre à jour en continu

---

## Notes de Mise à Jour

Ce document RACI doit être mis à jour :
- ✅ Après chaque changement d'organisation
- ✅ Lors de l'ajout de nouvelles tâches
- ✅ Suite aux retours d'expérience
- ✅ En cas de réaffectation de responsabilités

**Responsable des mises à jour** : Christopher (A) avec consultation Yanis & James (C)

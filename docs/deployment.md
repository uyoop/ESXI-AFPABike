# Guide de Déploiement - ESXi AFPABike

## Prérequis

### Logiciels requis

```bash
terraform --version    # ≥ 1.5.0
ansible --version      # ≥ 2.15.0
git --version          # ≥ 2.0
```

### Accès & Ressources

- **vCenter Server** : 10.20.69.200 (ou IP réelle)
- **Credentials vSphere** : user/password (root recommandé)
- **Datastore** et **réseau** existants dans vCenter
- **Template vSphere Ubuntu Server** (ex: 24.04 avec NIC vmxnet3) prêt à être cloné
- **SSH** : Key-pair générée (~/.ssh/id_rsa)

### Préparer (ou vérifier) le template / golden-VM

- Sur la VM avant conversion en template:
	- Créer l'utilisateur ansible: `sudo adduser ansible && sudo usermod -aG sudo ansible`
	- Copier la clé publique: `ssh-copy-id -i ~/.ssh/id_ed25519.pub ansible@<IP_VM>`
	- Corriger permissions SSH: `chown -R ansible:ansible /home/ansible/.ssh && chmod 700 /home/ansible/.ssh && chmod 600 /home/ansible/.ssh/authorized_keys`
	- Fixer DHCP si nécessaire (ESXi libère mal l'IP): `/etc/netplan/99-custom.yaml` + `sudo netplan apply` avec:
		```yaml
		network:
			version: 2
			ethernets:
				ens192:
					dhcp4: true
					dhcp6: false
		```
- Conversion VM ↔ template: clic droit vSphere « convertir en modèle » / « convertir en VM » et attendre la fin.

---

## 🚀 Étapes de Déploiement

### Étape 1 : Préparation Terraform

```bash
cd terraform/

# Créer le fichier de variables (à adapter)
cat > terraform.tfvars <<'TFVARS'
vsphere_user     = "root"
vsphere_password = "ton_password_vcenter"
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
TFVARS

# Initialiser Terraform
terraform init

# Vérifier le plan de provisionnement
terraform plan

# Appliquer le provisionnement
terraform apply

# Noter l'IP de la VM créée (affichée après apply)
```

**Résultat attendu** : VM `lab-ubuntu-2404` créée dans vCenter, accessible via son IP.

---

### Étape 2 : Configuration Ansible

```bash
cd ..

# 1. Récupérer l'IP de la VM
# (vérifier dans vCenter ou via terraform show)
VM_IP="10.20.69.20"  # À adapter

# 2. Mettre à jour inventory.ini
cat > inventory.ini <<EOF
[vcenter_vms]
vm-afpabike ansible_host=$VM_IP

[all:vars]
ansible_user=ansible
ansible_ssh_private_key_file=~/.ssh/ansible_devops
ansible_python_interpreter=/usr/bin/python3

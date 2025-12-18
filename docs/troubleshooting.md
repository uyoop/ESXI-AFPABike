# Guide de Dépannage

## Terraform (vSphere)

- Provider: le code utilise `vsphere ~> 2.4` (compatible vSphere 6.7). Mettre à jour `terraform init -upgrade` si erreur de version.
- Template introuvable: vérifier que `template_name` existe dans le datacenter/cluster/datastore renseignés et qu’il est visible par le compte vSphere.
- IP non retournée: `wait_for_guest_ip_timeout = 0`, aucun output IP. Récupérer l’IP dans vCenter ou via la console, puis mettre à jour `inventory.ini`.

## Golden-VM / Template Ubuntu 24.04

- Préparation manuelle recommandée avant conversion en template:
	- Créer l’utilisateur ansible: `sudo adduser ansible && sudo usermod -aG sudo ansible`
	- Ajouter la clé publique: `ssh-copy-id -i ~/.ssh/id_ed25519.pub ansible@IP_DE_LA_VM`
	- Fixer les permissions SSH: `chown -R ansible:ansible /home/ansible/.ssh && chmod 700 /home/ansible/.ssh && chmod 600 /home/ansible/.ssh/authorized_keys`
	- Corriger le DHCP ESXi (si IP non attribuée): `/etc/netplan/99-custom.yaml` puis `sudo netplan apply`:

```yaml
network:
  version: 2
  ethernets:
    ens192:
      dhcp4: true
      dhcp6: false
```
- Conversion VM ↔ template: clic droit sur la VM → « convertir en modèle », et inversement sur la template → « convertir en VM ». Attendre la fin de conversion avant de relancer.

## Ansible

- SSH refused / permission denied:
	- Vérifier que l’IP est correcte dans `inventory.ini` (récupérée dans vCenter).
	- Vérifier que l’utilisateur `ansible` existe et que la clé publique est en place (voir section Golden-VM).
	- Vérifier que `~/.ssh` a les bonnes permissions (700) et `authorized_keys` en 600.
- `ansible.posix.synchronize` échoue: installer `rsync` sur la VM (non présent par défaut sur Ubuntu minimal).
- Vérifier rsync/python3 présents sur la VM (sinon installer via apt):

```bash
ssh ansible@<IP_VM> "which rsync && python3 --version"
```

## Docker / AFPABike- Application non joignable sur port 80: l’expo est `8080:80`. Tester `http://<IP>:8080/afpabike`.
- Logs: `docker compose logs -f` dans le répertoire de l’app.

---

# Notes techniques & retours (James)

## Accès SSH de base
- Utilisateur: ansible / Mot de passe: ansible
- Clés: utiliser une paire dédiée (ex: ~/.ssh/ansible_devops).
- Ne pas oublier les permissions après import de clé publique sur la VM:
  - chown -R USER:USER /home/USER/.ssh
  - chmod 700 /home/USER/.ssh
  - chmod 600 /home/USER/.ssh/authorized_keys
- Connexion SSH sans mot de passe:
  - ssh -i ~/.ssh/ansible_devops ansible@10.20.69.4 (IP vue dans vSphere)

## Création/Préparation de la VM de base (golden-VM)
- VM Ubuntu Server 24.04 (image légère, python3 natif).
- Création initiale sur poste de dev, puis passage en template dans vSphere.
- Étapes manuelles sur la VM avant conversion en template:
  - sudo adduser ansible
  - sudo usermod -aG sudo ansible
  - Générer une clé locale si besoin: ssh-keygen -t ed25519 -f ~/.ssh/ansible_devops
  - Copier la clé publique sur la VM: ssh-copy-id -i ~/.ssh/id_ed25519.pub ansible@IP_DE_LA_VM
  - Fixer Netplan si DHCP ESXi ne rend pas l'IP:
    - Fichier /etc/netplan/99-custom.yaml :
```
network:
  version: 2
  ethernets:
    ens192:
      dhcp4: true
      dhcp6: false
```
    - sudo netplan apply

## Conversion VM ↔ template
- Pour convertir une VM en template: clic droit sur la VM -> "convertir en modèle".
- Pour repasser en golden-VM: clic droit sur la template -> "convertir en VM".
- Attendre la fin de conversion (changement d'emplacement/état dans vSphere) avant de relancer.

## Problème DHCP (ESXi)
- Symptôme: DHCP libère mal l'IP liée à la MAC, la VM ne récupère pas toujours d'adresse.
- Solution adoptée: ajouter le Netplan ci-dessus pour forcer dhcp4 sur ens192, puis reboot/apply; plusieurs conversions/reboots ont été nécessaires.

## Notes diverses
- VM observée: Agpa-bike-01 (IP 10.20.69.4), mot de passe sudo appliqué (Afpa*).
- Terraform: pas d’observation bloquante, les fichiers parlent d’eux-mêmes.

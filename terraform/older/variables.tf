variable "vsphere_user" {
  type        = string
  description = "Utilisateur vSphere/ESXi (ex: root)"
}

variable "vsphere_password" {
  type        = string
  sensitive   = true
  description = "Mot de passe vSphere/ESXi"
}

variable "vsphere_server" {
  type        = string
  description = "Adresse du serveur vSphere/ESXi (ex: 10.20.69.8 ou 10.20.69.200)"
}

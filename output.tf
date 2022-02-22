output "public_ip" {
  description = "Fortigate pulbic IP addresses for management access (HTTPS:443)"
  value = module.pip_management.public_ip
}


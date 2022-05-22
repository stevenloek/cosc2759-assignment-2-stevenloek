public_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQkOY59BNa050eQ2KfTO0w8iV8sMz+4T/RFgcRlzzgOaDfDrH1UuJXaCMLDfgiDzPK9iS4OO95enWv3VeMuU6C5dHBVfLC3kwuOTNRS9MatqROXlbPnobo3Uv/ack/rXMGhOeFRvgL0vC6c03vO9EFdFu+JG1hayaMbHuSGfOrniyrdWAB1mtOhA8A/DDkiWda4i/CQs0nmFNs9IJ5tqtFKqGdlFr2+qjVhsh6ptxzkRCcl0fqQgFLA7Wfpdet+o7hZp+2Kj1eb+ZJPNymc3iI/hKI6m33VZ957gKS4NzLKAdVXbSXEe2UrfL5ugmxnYGEaFNITQ7iEQemZu0Qh8gpCw2ck1JEd/lr3iQRGRwi330ceEnrtcdUH8NrstV0GMMF2goqHamd+DJx5DHu2Afs99a3hfoiT1SNlxQwcqMGgcKhyn8rwLLKviQfU5GFvlKIUg4yYhl/5eYkCnGGoDqcN8ZmJBXKlPZPB2YDlT4EXgOhgEIBqivWBFU43NOJtRU= s3808553@student.rmit.edu.au"
variable "public_key" {
  value = string
}
ami_id="ami-0022f774911c1d690"
variable "ami_id" {
  type = string
}

output "web_public_ip" {
  value = aws_instance.web.public_ip
}
output "db_public_ip" {
  value = aws_instance.db.public_ip
}

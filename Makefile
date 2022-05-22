.PHONY: help all-up infra-up ansible-up all-down infra-validate infra-plan bootstrap ssh-gen infra-init pack

help:
	@echo "Specify a target\n"

all-up:
	make infra-up
	make ansible-up

infra-up:
	cd infra && terraform apply --auto-approve
	cd infra && terraform output

ansible-up:
	cd ansible/scripts && ./run-ansible.sh

infra-down:
	cd infra && terraform destroy --auto-approve --force

#

infra-validate:
	cd infra && terraform validate && terraform fmt

infra-plan:
	cd infra && terraform plan

infra-apply:
	cd infra && terraform apply

bootstrap:
	cd bootstrap && terraform init && terraform apply --auto-approve

ssh-gen:
	mkdir -p /tmp/keys
	yes | ssh-keygen -t rsa -b 4096 -f /tmp/keys/ec2-key -P ''
	chmod 0644 /tmp/keys/ec2-key.pub
	chmod 0600 /tmp/keys/ec2-key

infra-init:
	cd infra && terraform init

#
ansible-up:
	cd ansible/scripts %% ./run-ansible.sh

pack:
	cd src && npm pack
	mkdir -p "ansible/files"
	mv src/notes-1.0.0.tgz ansible/files

infra-down:
	cd infra && terraform destroy --auto-approve
infra-up:
	cd infra && terraform apply --auto-approve

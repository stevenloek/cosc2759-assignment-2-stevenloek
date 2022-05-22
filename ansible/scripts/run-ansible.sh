#!/bin/bash
set +ex

echo "  all:" >> inventory.yml
echo "web:" > inventory.yml
echo "    $(cd ../../infra && "web-public-ip"):" >> inventory.yml
echo "db:" >> inventory.yml
echo "    $(cd ../../infra && "db-public-ip"):" >> inventory.yml

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -v -i inventory.yml \
"record_host_keys=true"-u ec2-user --private-key /tmp/keys/ec2-key ../playbook.yml -e \
  "web_url=$(cd ../../infra && terraform output "web-public-ip")"

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -v -i inventory.yml \
"record_host_keys=true"-u ec2-user --private-key /tmp/keys/ec2-key ../playbook.yml -e \
  "db_url=$(cd ../../infra && terraform output "db-public-ip")"
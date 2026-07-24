# Justfile for Automating Gitea Deployment

# Display available commands
default:
    @just --list

# Deploy Gitea using Ansible
deploy:
    ansible-playbook -i inventory site.yml

# Check server connectivity
ping:
    ansible all -i inventory -m ping

# Syntax check for the playbook
check:
    ansible-playbook -i inventory site.yml --syntax-check

# Dry-run the deployment to see what would change
dry-run:
    ansible-playbook -i inventory site.yml --check

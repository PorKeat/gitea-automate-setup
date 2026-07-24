# Gitea Automated Infrastructure

This repository contains the infrastructure-as-code to deploy a production-ready, fully secure Gitea instance on any cloud provider. It is entirely automated using **Ansible** and managed via **Justfile**.

## 🚀 Features

- **Automated Deployment**: Single command deployment to any server.
- **Dynamic Configuration**: Variables are centralized in `roles/gitea/defaults/main.yml`.
- **Secure Networking**: Uses Traefik v3.6 to automatically provision Let's Encrypt SSL certificates.
- **Custom Branding**: Automatically uploads custom logos and assets (like `logo.png`) on startup.

---

## 🛠 Prerequisites

Before deploying, ensure you have the following installed on your local machine:
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (`brew install ansible`)
- [Just](https://github.com/casey/just) (`brew install just`)

## 📂 Project Structure

```text
.
├── Justfile                      # Command runner
├── inventory                     # Your server IP and SSH key configuration
├── site.yml                      # Main Ansible playbook entry point
└── roles/
    └── gitea/
        ├── defaults/main.yml     # Central configuration (Domain, Email, DB Passwords)
        ├── files/logo.png        # Drop your custom logo here to apply it to Gitea
        ├── tasks/main.yml        # Automation logic
        └── templates/
            └── docker-compose.yml.j2 # Dynamic Docker Compose template
```

## ⚙️ Configuration

1. **Edit the Inventory**: Open the `inventory` file and replace the IP address and SSH key path with your actual server details.
2. **Set Variables**: Open `roles/gitea/defaults/main.yml` and configure your:
   - Domain Name
   - Let's Encrypt Email
   - Database Passwords
3. **Custom Branding**: Place a `logo.png` inside the `roles/gitea/files/` directory.

## 🚀 Deployment

You can use the built-in `just` commands to manage your infrastructure:

```bash
# Display all available commands
just

# Ping the server to verify connectivity
just ping

# Deploy Gitea to your server
just deploy
```

That's it! In a few moments, your Gitea server will be completely set up, branded, and secured with SSL.

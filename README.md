# PES EXPO Gitea Automation

This repository contains the fully automated Infrastructure-as-Code (IaC) deployment for the **PES EXPO Code Repository** using Ansible and Docker.

It automatically provisions the server, sets up the database, injects custom UI themes (Light/Dark mode), applies the PES EXPO branding, and bypasses the manual Gitea installation screens.

## 🚀 Quick Start

To deploy or update the server, simply run:

```bash
just deploy
```

> **Note:** This command automatically runs the Ansible playbook (`site.yml`) against the target server defined in the `inventory` file.

## ⚙️ Configuration

All configuration is centralized in a single variables file. To change passwords, domains, or admin users, edit:

👉 **`roles/gitea/defaults/main.yml`**

### Key Variables

- `gitea_domain`: The domain name where Gitea will be hosted (e.g., `gitea.sengporkeat.com`).
- `gitea_default_theme`: Default theme for new users (`gitea-dark`, `gitea-light`, or `gitea-auto`).
- `gitea_auto_init`: Set to `true` to bypass the web install screen and auto-create the admin user.
- `gitea_admin_user` / `gitea_admin_password`: The credentials for the auto-created admin account.
- `enable_tailscale`: Set to `true` to take the server off the public internet and lock it down via a Tailscale zero-trust VPN mesh.
- `tailscale_auth_key`: Your Tailscale authentication key (required if `enable_tailscale` is `true`).

## 🎨 UI & Branding

The PES EXPO branding is applied automatically during deployment:

- **Logos:** Located in `roles/gitea/files/logo.png`. (Converted to SVG automatically by the deployment script).
- **Themes & Colors:** Custom CSS overrides are injected via `roles/gitea/files/header.tmpl`. This forces Gitea to use a sleek monochromatic palette and intelligently inverts the logo based on the user's Light/Dark mode preference.
- **Landing Page:** The default Gitea homepage is completely overridden by `roles/gitea/files/home.tmpl`.

## 🛠 Prerequisites

To run this deployment from your local machine, you need:

1. **Just:** A handy command runner (`brew install just`).
2. **Ansible:** The automation engine (`brew install ansible`).
3. **SSH Access:** Your local machine must have SSH access to the target GCP server.

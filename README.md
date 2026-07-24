# Gitea Automation

This repository contains the fully automated Infrastructure-as-Code (IaC) deployment for the **PES EXPO Code Repository**.

It uses Ansible to automatically provision a Google Cloud server, install Docker, configure Gitea and PostgreSQL, inject custom UI branding, and optionally lock the server down behind a military-grade Tailscale Zero-Trust network with automated HTTPS.

---

## 🚀 How to Setup from Scratch

Follow these steps to deploy the server.

### Step 1: Install Prerequisites on your Mac

You need two tools installed on your local computer to run this automation. Open your Terminal and run:

```bash
# Install 'just' (a command runner) and 'ansible' (the automation engine)
brew install just ansible
```

*Note: Your Mac must have SSH access to the GCP server (`34.21.129.81`) via `~/.ssh/google_compute_engine`.*

### Step 2: Get a Tailscale Auth Key (Required for Security)

To lock the server off the public internet, you need a secret key from Tailscale.

1. Go to your [Tailscale Admin Console](https://login.tailscale.com/admin/settings/keys).
2. Click **Generate auth key...** (Check "Reusable" and "Ephemeral").
3. Copy the `tskey-auth-...` secret code it gives you.
4. Go to the **DNS** tab in Tailscale and click **Enable MagicDNS** and **Enable HTTPS Certificates**.

### Step 3: Configure the Variables

Open the configuration file in your code editor. This is the "control center" for the entire server. The file is located at:

**`roles/gitea/defaults/main.yml`**

You must fill in your Tailscale key here:

```yaml
enable_tailscale: true
tailscale_auth_key: "PASTE-YOUR-SECRET-KEY-HERE"
```

*(You can also change the default admin passwords and database credentials in this file if you wish).*

### Step 4: Deploy

Open your terminal in this repository and run:

```bash
just deploy
```

Ansible will automatically connect to the server, install everything, apply the Tailscale security lockdown, inject the PES EXPO UI theme, and fetch the native SSL certificates.

When it finishes, you can access your secure code repository at your Tailscale MagicDNS link! (e.g., `https://gitea.tail20d75a.ts.net`).

---

## 🎨 UI & Branding Details

The PES EXPO branding is applied automatically during deployment:

- **Logos:** Located in `roles/gitea/files/logo.svg`.
- **Themes & Colors:** Custom CSS overrides are injected via `roles/gitea/files/header.tmpl`. This forces Gitea to use a sleek monochromatic palette and intelligently inverts the logo based on the user's Light/Dark mode preference.
- **Landing Page:** The default Gitea homepage is completely overridden by `roles/gitea/files/home.tmpl`.

If you ever want to change the CSS or the landing page text, simply edit those files and run `just deploy` again.

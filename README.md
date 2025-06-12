# Azure VM Deployment via Bicep and Shell Automation

This project provisions a complete Azure virtual machine environment using Infrastructure-as-Code (IaC) practices. It automates the creation of an Ubuntu VM, configures networking and security, mounts a persistent data disk, and installs NGINX to serve a static site cloned from GitHub.

## Project Objectives

- Use Azure Bicep to define and deploy VM infrastructure
- Automate VM setup with `customData` shell scripts (cloud-init)
- Mount and configure a persistent Azure managed disk
- Configure NGINX to serve a GitHub-hosted static site
- Enable NSG firewall rules (SSH, HTTP, HTTPS)
- Make the VM disposable and re-deployable

## Tools Used

- Azure CLI
- Azure Bicep
- Bash / cloud-init scripting
- NGINX
- Git
- Ubuntu 22.04 LTS

## Architecture

- 1x Public IP with dynamic DNS label
- 1x Network Security Group with custom rules
- 1x Ubuntu VM with admin SSH access
- 1x Managed Disk (formatted and auto-mounted)
- GitHub project cloned and served by NGINX

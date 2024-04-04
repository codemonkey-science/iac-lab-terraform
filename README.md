# Infrastructure as Code (IaC) Lab with Terraform

Terraform configuration for the lab.

[![Terraform Create Lab](https://github.com/codemonkey-science/iac-lab-terraform/actions/workflows/terraform-apply.yml/badge.svg)](https://github.com/codemonkey-science/iac-lab-terraform/actions/workflows/terraform-apply.yml)

![Terraform Logo](docs/images/terraform.png)

This is a repository of Terraform configuration to stand up our lab infrstructure. To use this repository, you must [install Terraform](#installing-terraform). After that:

```bash
# Initialize providers and cache
terraform init

# Verify that the configuration seems valid
terraform plan

# Execute the plan
terraform apply

# Reverse, or destroy what was created
terraform destroy
```

## What does this provision?

For our lab environment, this creates clones of Ubuntu Cloud Images on ProxMoxand configures the needed hardware/resources for those VMs. Below is a summary:

| #   |                           Name | vCPU  | RAM (MB) | Usage                                                                                               |
| --- | -----------------------------: | :---: | -------: | --------------------------------------------------------------------------------------------------- |
| 1.  |    idp.east.codemonkey.science |  12   |    2,048 | [Authentik](https://goauthentik.io/) AuthN/AuthZ/SSO                                                |
| 2.  |    cti.east.codemonkey.science |  12   |   12,288 | [OpenCTI](https://opencti.io/)                                                                      |
| 3.  |   misp.east.codemonkey.science |  12   |    2,048 | [MISP](https://misp-project.org)                                                                    |
| 4.  |    sim.east.codemonkey.science |  12   |    2,048 | [Graylog](https://graylog.org/) syslogd and log aggregation                                         |
| 5.  |   siem.east.codemonkey.science |  12   |    2,048 | [Wazuh](https://wazuh.com/) full-stack SIEM                                                         |
| 6.  | status.east.codemonkey.science |  12   |    2,048 | [Uptime-Kuma](https://github.com/louislam/uptime-kuma) Uptime monitoring and incident/outage status |

> **NOTE:** This will use 22,528 GB of RAM if you do not choose "Ballooning" in ProxMox.

There is a VLAN 50 where these machines live, and DNS entries as follows:

|                                 Hostname |    IP Address |
| ---------------------------------------: | ------------: |
|           *pve1.east.codemonkey.science* |  192.168.60.6 |
|           *pve2.east.codemonkey.science* |  192.168.60.7 |
| *github-runner1.east.codemonkey.science* | 192.168.60.10 |
|    *cloudflared.east.codemonkey.science* | 192.168.60.11 |
|             auth.east.codemonkey.science | 192.168.60.12 |
|              cti.east.codemonkey.science | 192.168.60.13 |
|             misp.east.codemonkey.science | 192.168.60.14 |
|              sim.east.codemonkey.science | 192.168.60.15 |
|             siem.east.codemonkey.science | 192.168.60.16 |
|           status.east.codemonkey.science | 192.168.60.17 |

Servers in *italics* will be managed outside of the Terraform process.

## Installing Terraform

Here are instructions on how to install Terraform on Windows, macOS, and Linux:

### Windows

1. Download the Terraform binary for Windows from the official website: [Terraform Downloads](https://www.terraform.io/downloads.html)
1. Extract the downloaded ZIP file to a directory of your choice.
1. Add the directory where the Terraform executable is located to your system's PATH environment variable. This step allows you to run Terraform from any command prompt.
1. Open a Command Prompt or PowerShell window and verify the installation by running the following command:

```powershell
terraform --version
```

### macOS

1. Install [Homebrew](https://brew.sh), a popular package manager for macOS, if you haven't already. You can install Homebrew by running the following command in your terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

2. Once Homebrew is installed, use it to install Terraform by running:

```bash
brew install terraform
```

3. Verify the installation by running:

```bash
terraform --version
```

### Linux:

1. Download the Terraform binary for Linux from the official website: [Terraform Downloads](https://www.terraform.io/downloads.html)
1. Extract the downloaded archive to a directory of your choice.
1. Move the Terraform executable to a directory included in your system's PATH environment variable or add the directory where the executable is located to the PATH.
1. Open a terminal and verify the installation by running:

```bash
terraform --version
```

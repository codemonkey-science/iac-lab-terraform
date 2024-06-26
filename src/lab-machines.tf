locals {
  connection_pve1 = {
    type        = "ssh"
    user        = "root"
    private_key = var.ssh_private_key
    host        = "pve1.east.codemonkey.science"
  }
  connection_pve2 = {
    type        = "ssh"
    user        = "root"
    private_key = var.ssh_private_key
    host        = "pve2.east.codemonkey.science"
  }
}

##########
# auth.east.codemonkey.science
##########
resource "proxmox_vm_qemu" "auth" {
  target_node = "pve1"
  # boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "auth.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.12/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, auth, keycloak, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  clone_wait   = 15
  agent        = 1
  balloon      = 2048
  memory       = 8196
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"
}

resource "null_resource" "disk_resize_auth" {
  depends_on = [proxmox_vm_qemu.auth]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.auth.id), 2)} scsi0 100G"
    ]

    connection {
      type        = local.connection_pve1.type
      user        = local.connection_pve1.user
      private_key = local.connection_pve1.private_key
      host        = local.connection_pve1.host
      timeout     = "10s"
    }
  }
}


# ###########
# # cti.east.codemonkey.science
# ###########
resource "proxmox_vm_qemu" "cti" {
  # depends_on = [proxmox_vm_qemu.auth]
  target_node  = "pve1"
  boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "cti.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.13/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, cti, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  agent        = 1
  balloon      = 2048
  memory       = 4096
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"
}
resource "null_resource" "disk_resize_cti" {
  depends_on = [proxmox_vm_qemu.cti]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.cti.id), 2)} scsi0 400G"
    ]

    connection {
      type        = local.connection_pve1.type
      user        = local.connection_pve1.user
      private_key = local.connection_pve1.private_key
      host        = local.connection_pve1.host
      timeout     = "10s"
    }
  }
}

###########
# misp.east.codemonkey.science
###########
resource "proxmox_vm_qemu" "misp" {
  # depends_on = [proxmox_vm_qemu.cti]
  target_node  = "pve1"
  boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "misp.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.14/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, misp, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  agent        = 1
  balloon      = 2048
  memory       = 4096
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"
}
resource "null_resource" "disk_resize_misp" {
  depends_on = [proxmox_vm_qemu.misp]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.misp.id), 2)} scsi0 200G"
    ]

    connection {
      type        = local.connection_pve1.type
      user        = local.connection_pve1.user
      private_key = local.connection_pve1.private_key
      host        = local.connection_pve1.host
      timeout     = "10s"
    }
  }
}

###########
# monitor.east.codemonkey.science
###########
resource "proxmox_vm_qemu" "monitor" {
  # depends_on = [proxmox_vm_qemu.cti]
  target_node  = "pve1"
  boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "monitor.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.19/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, monitor, nagios, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  agent        = 1
  balloon      = 2048
  memory       = 4096
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"
}
resource "null_resource" "disk_resize_monitor" {
  depends_on = [proxmox_vm_qemu.monitor]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.monitor.id), 2)} scsi0 200G"
    ]

    connection {
      type        = local.connection_pve1.type
      user        = local.connection_pve1.user
      private_key = local.connection_pve1.private_key
      host        = local.connection_pve1.host
      timeout     = "10s"
    }
  }
}

###########
# sim.east.codemonkey.science
###########
resource "proxmox_vm_qemu" "sim" {
  target_node  = "pve2"
  boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "sim.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.15/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, sim, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  agent        = 1
  balloon      = 2048
  memory       = 4096
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"
}
resource "null_resource" "disk_resize_sim" {
  depends_on = [proxmox_vm_qemu.sim]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.sim.id), 2)} scsi0 400G"
    ]

    connection {
      type        = local.connection_pve2.type
      user        = local.connection_pve2.user
      private_key = local.connection_pve2.private_key
      host        = local.connection_pve2.host
      timeout     = "10s"
    }
  }
}

###########
# siem.east.codemonkey.science
###########
resource "proxmox_vm_qemu" "siem" {
  # depends_on = [proxmox_vm_qemu.sim]
  target_node  = "pve2"
  boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "siem.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.16/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, siem, graylog, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  agent        = 1
  balloon      = 2048
  memory       = 8192
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", self.id), 2)} scsi0 300G"
    ]

    connection {
      type        = local.connection_pve2.type
      user        = local.connection_pve2.user
      private_key = local.connection_pve2.private_key
      host        = local.connection_pve2.host
      timeout     = "10s"
    }
  }
}
resource "null_resource" "disk_resize_siem" {
  depends_on = [proxmox_vm_qemu.siem]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.siem.id), 2)} scsi0 300G"
    ]

    connection {
      type        = local.connection_pve2.type
      user        = local.connection_pve2.user
      private_key = local.connection_pve2.private_key
      host        = local.connection_pve2.host
      timeout     = "10s"
    }
  }
}

###########
# status.east.codemonkey.science
###########
resource "proxmox_vm_qemu" "status" {
  # depends_on = [proxmox_vm_qemu.siem]
  target_node  = "pve2"
  boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "status.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.17/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, status, uptime-kuma, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  agent        = 1
  balloon      = 2048
  memory       = 4096
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"
}
resource "null_resource" "disk_resize_status" {
  depends_on = [proxmox_vm_qemu.status]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.status.id), 2)} scsi0 100G"
    ]

    connection {
      type        = local.connection_pve2.type
      user        = local.connection_pve2.user
      private_key = local.connection_pve2.private_key
      host        = local.connection_pve2.host
      timeout     = "10s"
    }
  }
}

###########
# ntfy.east.codemonkey.science
###########
resource "proxmox_vm_qemu" "ntfy" {
  # depends_on = [proxmox_vm_qemu.siem]
  target_node  = "pve2"
  boot         = "order=scsi0"
  bootdisk     = "scsi0"
  name         = "ntfy.east.codemonkey.science"
  ipconfig0    = "ip=192.168.60.18/24,gw=192.168.60.1"
  tags         = "cloud-image, ubuntu, ubuntu-22.04, ubuntu-jammy, ntfy, codemonkey.science, lab"
  clone        = "ubuntu-cloud-jammy"
  agent        = 1
  balloon      = 2048
  memory       = 4096
  cpu          = "host"
  cores        = 6
  sockets      = 1
  onboot       = true
  tablet       = false
  force_create = false
  full_clone   = true
  os_type      = "cloud-init"
  scsihw       = "virtio-scsi-pci"
}
resource "null_resource" "disk_resize_ntfy" {
  depends_on = [proxmox_vm_qemu.ntfy]

  provisioner "remote-exec" {
    inline = [
      "qm disk resize ${element(split("/", proxmox_vm_qemu.ntfy.id), 2)} scsi0 40G"
    ]

    connection {
      type        = local.connection_pve2.type
      user        = local.connection_pve2.user
      private_key = local.connection_pve2.private_key
      host        = local.connection_pve2.host
      timeout     = "10s"
    }
  }
}

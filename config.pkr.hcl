packer {
  required_plugins {
    qemu = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/qemu"
    }
  }
}

source "qemu" "ubuntu" {
  iso_urls        = ["ubuntu-22.04.5-live-server-amd64.iso"]
  iso_checksum    = "sha256:9BC6028870AEF3F74F4E16B900008179E78B130E6B0B9A140635434A46AA98B0"
  http_directory  = "http"
  disk_size       = "8192"
  disk_interface  = "virtio-scsi"
  memory          = "2048"
  cpus            = "6"
  format          = "raw"
  headless        = true
  boot_wait       = "1s"
  cd_files        = ["./http/user-data", "./http/meta-data"]
  cd_label        = "cidata"
  boot_command = [
    "c",
    "linux /casper/vmlinuz --- ",
    "autoinstall ds=nocloud;s=/cdrom/http/",
    "<enter>",
    "initrd /casper/initrd",
    "<enter><wait5>",
    "<enter>",
    "boot",
    "<enter>"
  ]
  
  # VNC settings
  vnc_bind_address = "0.0.0.0"  # Allows access from all network interfaces
  vnc_port_min = 5901           # Set a specific VNC port
  vnc_port_max = 5901           # Ensures only this port is used

  ssh_username    = "ubuntu"
  ssh_password    = "ubuntu"
  ssh_timeout     = "10000s"
  shutdown_command = "echo 'vagrant' | sudo -S shutdown -P now"
}

build {
  sources = ["source.qemu.ubuntu"]
  post-processor "compress" {
  compression_level = 9
  output = "test.tar"
  keep_input_artifact = true
    }
}


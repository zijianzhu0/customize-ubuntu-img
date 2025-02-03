# Ubuntu Autoinstall with Packer

This repository contains configuration files for automating the installation of **Ubuntu Server** using **Packer** and `cloud-init`. The goal is to generate a **customized ISO** that includes pre-configured users, SSH access, and other custom settings for an unattended installation.

## 📌 Features
- Uses **Packer** to automate Ubuntu image creation.
- Supports **cloud-init** for user data and SSH setup.
- Configures an **autoinstallation** process using `user-data`.
- **Ignores unnecessary files** using `.gitignore`.

---

## 🚀 Getting Started

### **1️⃣ Install Dependencies**
Before using Packer, ensure you have the required tools installed:

#### **📌 Windows**
1. Install [Packer](https://developer.hashicorp.com/packer/downloads).
2. Install [Windows ADK](https://learn.microsoft.com/en-us/windows-hardware/get-started/adk-install) to get `oscdimg.exe`.
3. Add `oscdimg.exe` to your system `PATH`.

#### **📌 Linux (Ubuntu/Debian)**
```bash
sudo apt update
sudo apt install -y packer xorriso cloud-init
```

#### **📌 macOS**
```bash
brew install packer xorriso
```

---

### **2️⃣ Clone the Repository**
```bash
git clone https://github.com/your-repo/ubuntu-packer-autoinstall.git
cd ubuntu-packer-autoinstall
```

---

### **3️⃣ Customize the Cloud-Init Configuration**
Modify the `user-data` file to customize your Ubuntu installation:

```yaml
#cloud-config
autoinstall:
  version: 1
  hostname: "ubuntu-test"
  identity:
    realname: "init user"
    username: "ubuntu"
    password: "$5$bh1xvoockM3kluca$7zg6n7BGdyT5s8k27sbzw0xVqG68TIv/SoKYo0gTreB"
  ssh:
    install-server: true
    password_authentication: true
    permit_root_login: true
```
- **Change username and password** as needed.
- **Enable/disable SSH login** for security.
- **Modify additional settings** in `cloud-init`.

---

### **4️⃣ Build the Image with Packer**
Run the following command to generate a custom Ubuntu image:

```bash
packer build ubuntu.pkr.hcl
```

This will:
1. Download the official Ubuntu ISO.
2. Inject the **unattended installation configuration** (`user-data`).
3. Build a **custom ISO** that automatically installs Ubuntu.

---

### **5️⃣ Use the Generated Image**
- **For VirtualBox:** Import and run the image.
- **For VMware/QEMU:** Boot from the ISO.
- **For Cloud Deployments:** Upload the ISO to your cloud provider.

---

## 📂 File Structure
```
.
├── packer.pkr.hcl      # Packer template for building Ubuntu images
├── user-data           # Cloud-init configuration for Ubuntu autoinstall
├── meta-data           # Required for NoCloud datasource
├── .gitignore          # Files and folders ignored by Git
├── README.md           # This file
```

---

## 🛠 **Troubleshooting**
**🔹 Packer exits immediately with an error?**  
Ensure you have `xorriso` or `oscdimg` installed.

**🔹 Autoinstall not working?**  
Check `/var/log/installer` inside the VM.

**🔹 SSH login fails?**  
Ensure `permit_root_login: true` in `user-data`.

---

## 📜 License
This project is licensed under the **MIT License**.

---

## 🤝 Contributing
Pull requests are welcome! Feel free to submit issues or feature requests.

---

## ⭐ Acknowledgments
- [Packer Documentation](https://developer.hashicorp.com/packer/docs)
- [Ubuntu Autoinstall](https://ubuntu.com/server/docs/install/autoinstall)
- [Cloud-Init Docs](https://cloudinit.readthedocs.io/en/latest/)


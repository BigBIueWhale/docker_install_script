# docker_install_script

## 🚀 Introduction

Welcome to the `docker_install_script` project, an unapologetically smart solution for Docker enthusiasts who want to dive into containerization without wreaking havoc on their primary system. This script is finely tuned for a Pop!_OS 22.04 virtual machine running atop VMWare Workstation Pro 17.5 on a Windows 11 host.

## Simple
Really this is just a script to install Docker on Ubuntu-based systems.

## 📋 Purpose

The essence of this project is to address a critical conflict that arises when Docker and VMWare Workstation coexist on the same host. A standard Docker installation on a system already running VMWare can lead to a complete blockade of VMWare's ability to launch any virtual machine. This isn't just an inconvenience; it's a full-blown operational conflict due to the overlapping use of hypervisor resources. By confining Docker within a virtual machine, we contain this "evil" and prevent it from interfering with VMWare's functionality, thus maintaining the integrity and smooth operation of your virtual environments.

I mean it when I say evil. When you install Docker, it actually requires you to "Turn Windows Features On or Off". The way Docker works on Windows is that it makes Windows boot in a hypervisor, so when you decide to run your Docker images, they actually run alongside Windows itself, both running on a hardware hypervisor.

Let me rephrase: It literally changes to way Windows boots, forever.

## Installing Docker on Linux vs. Windows

In the context of Linux, Docker can directly utilize the host operating system's Linux kernel, as it relies on kernel features like namespaces and cgroups to isolate and manage containers. This means Docker on Linux does not require a separate hypervisor layer to run containers, as the containers share the host's kernel. This approach is generally more efficient in terms of performance and resource usage, as it avoids the overhead associated with running an additional layer (the hypervisor) between the containers and the host system.

This means that the best way to run Docker on Windows, is to run it inside of a Linux virtual machine! That's what this project accomplishes.

## 🛠️ Usage

To utilize this script, follow these steps:

1. Set up a Pop!_OS 22.04 virtual machine in VMWare Workstation Pro 17.5 on a Windows 11 host.
2. Transfer the `install_docker.sh` script to the virtual machine.
3. Open a terminal within your VM.
4. Make the script executable: `chmod +x install_docker.sh`
5. Determine your username with `whoami` (assumed to be "user" in this example).
6. Execute the script with superuser privileges: `sudo ./install_docker.sh --username user`

### Example:

```bash
$ whoami
user
$ chmod +x install_docker.sh
$ sudo ./install_docker.sh --username user
```

This process will conduct a full update and upgrade of your system, followed by the installation of Docker and the addition of your user to the Docker group. It concludes with a Docker container test run to ensure a successful installation.

## 📝 Important Note

Post-script execution, it's mandatory to log out and then log back in. This step is crucial for the Docker group changes to take effect, empowering your user to execute Docker commands seamlessly without needing superuser access.

## 🎉 Conclusion

Embrace the power of Docker within your VM, free from the shackles of hypervisor-level conflicts. Your VMWare Workstation remains untouched and fully operational, while you explore the vast capabilities of Docker. Dive in and dominate the Docker domain! 🐳🔥

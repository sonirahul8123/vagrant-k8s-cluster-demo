# Kubernetes Cluster installation using Vagrant and VirtualBox

This tutorial walks you through setting up Kubernetes cluster on a VMs created using Vagrant and VirtualBox.
This guide is for people looking for a fully automated command to bring up a Kubernetes cluster.

This tutorial is a modified version of the original developed by [Venkat Nagappan](https://github.com/justmeandopensource/kubernetes).

> The results of this tutorial should not be viewed as production ready, and may receive limited support from the community, but don't let that stop you from learning!

## Target Audience

The target audience for this tutorial is someone planning to support a production Kubernetes cluster and wants to understand how to configure kubernetes cluster using kubeadm.

## Pre-requisites

### VM Hardware Requirements

8 GB of RAM (Preferably 16 GB)
50 GB Disk space

### Virtual Box

Download and Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) on any one of the supported platforms:

 - Windows hosts
 - OS X hosts
 - Linux distributions
 - Solaris hosts

### Vagrant

Once VirtualBox is installed you may chose to deploy virtual machines manually on it.
Vagrant provides an easier way to deploy multiple virtual machines on VirtualBox more consistenlty.

Download and Install [Vagrant](https://www.vagrantup.com/) on your platform.

- Windows
- Debian
- Centos
- Linux
- macOS

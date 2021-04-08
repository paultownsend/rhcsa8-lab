# rhcsa8-lab

Practice lab for Red Hat's [RHCSA
8](https://www.redhat.com/en/services/training/ex200-red-hat-certified-system-administrator-rhcsa-exam?section=Objectives)
certification exam using Vagrant.

This lab takes advantage of the [Red Hat Developer Subscription for
Individuals](https://developers.redhat.com/articles/faqs-no-cost-red-hat-enterprise-linux),
which lets you register up to 16 systems with Red Hat - and receive access to
packages and updates via their Yum repositories - at no cost.

---

The `Vagrantfile` in this repository will create two servers running Red Hat
Enterprise Linux 8 - using the
[generic/rhel8](https://app.vagrantup.com/generic/boxes/rhel8) Vagrant box -
with the following base configuration:

- 1GB RAM
- 1 CPU
- 70GB root disk (dynamically allocated)

Each server will have some extras configured to facilitate practicing the
different exam objectives:

- `server1`
  - 1 additional network interface (for network related objectives)

- `server2`
  - 3 additional dynamically allocated disks (for storage related objectives)

## Usage

After running `vagrant up` you will be prompted for your Red Hat account
credentials, and a provisioner will register each machine with Red Hat
Subscription Manager. The machines will be unregistered by a Vagrant trigger
upon destruction.

To start the machines and login:
1. `vagrant init`
2. `vagrant up`
3. _Enter Red Hat account credentials_
4. `vagrant ssh <server1|server2>`

To destroy the machines:
1. `vagrant destroy`

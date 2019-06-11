# ansible-role-node-exporter

This role should perform tasks needed to setup Prometheus node exporter on the host including installation and configuration.
It includes [ansible-role-reverse-proxy](https://github.com/Psiphon-Infrastructure/ansible-role-reverse-proxy) roles. HTTP access is permited only on localhost:9100. HTTPS is allowed on port 443 for all hosts in *prometheus-servers* group, localhost, and 172.16.0.0/12 for docker instances.

To setup host with node exporter apply this role to the node:
```
- hosts: <target>
  roles:
    - {role: ansible-role-node-exporter, become: true}
```

Make sure prometheus server is in "prometheus-servers" group in inventory file.
Update *prometheus server* scraper configuration to include new host.


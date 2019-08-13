# Intro
Installs Prometheus node exporter as a service. If reverse proxy docker container is found will generate NGINX location config and placed in config folder to be included by server configuration. Also sets two cron jobs to generate metrics for available package updates.

Metrics can be accessed at:
**http://<hostname>/metrics**
or 
**https://<hostname>/node_exporter/metrics** if reverse proxy is found

To setup host with node exporter apply this role to the node:
```
- hosts: <target>
  roles:
    - {role: ansible-role-node-exporter, become: true}
```

Make sure prometheus server is in "prometheus-servers" group in inventory file.
Update *prometheus server* scraper configuration to include new host.


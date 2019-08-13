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

## Variables
`node_exporter_exporter_versioni: 0.17.0` version of node exporter
`node_exporter_listen_address: 127.0.0.1:9100` address on which node_exporter will listen. If no reverse proxy found this address will be modified to 0.0.0.0:9100.
`node_exporter_metrics_updates: true` will include package updates metrics when set to true

## Other Variables
`inode_exporter_data_dir: "{{ global_ansible_dir | default('/opt/default') }}/node_exporter"`
`node_exporter_reverse_proxy: "{{ reverse_proxy_nginx_label | default('role=reverse_proxy')}}"`
`node_exporter_proxy_data_dir: "{{ reverse_proxy_nginx_data_dir | default('/opt/default/nginx') }}"`
`node_exporter_prometheus_metrics: "{{ global_prometheus_metrics | default('/opt/default/metrics')}}"`


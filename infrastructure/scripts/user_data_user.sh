#!/bin/bash

sudo yum update -y

curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -  
sudo yum install curl wget nodejs make git nginx -y
sudo yum groupinstall -y 'Development Tools'

cd /opt
git clone https://github.com/krishnasrinivas/wetty.git
cd wetty
npm install 
sudo adduser playground 
echo 'PeoplesComputers1' | sudo passwd playground --stdin
sudo sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

#cat <<EOTF >> script.sh
#!/bin/bash

#echo "playground	ALL=(ALL) 	NOPASSWD: ALL" >> /etc/sudoers
#EOTF

#chmod +x script.sh
#sudo ./script.sh

sudo service sshd reload

cat <<EOF > /etc/nginx/nginx.conf
user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /var/run/nginx.pid;

include /usr/share/nginx/modules/*.conf;

events {
    worker_connections 1024;
}

http {
    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  localhost;
        root         /usr/share/nginx/html;

        location / {
            proxy_pass   http://127.0.0.1:3000;
        }
    }
}
EOF

sudo service nginx start
sudo chkconfig nginx on

sudo -u ec2-user nohup node app.js -p 3000 --sshuser playground &

cd /home/playground
mkdir prometheus
mkdir fake_app
mkdir node_exporter

sudo wget https://github.com/prometheus/prometheus/releases/download/v2.2.0-rc.0/prometheus-2.2.0-rc.0.linux-amd64.tar.gz
sudo tar zxvf prometheus-2.2.0-rc.0.linux-amd64.tar.gz -C ./prometheus --strip-components 1
sudo rm -f prometheus-2.2.0-rc.0.linux-amd64.tar.gz

cat <<EOL > prometheus/playground.yml
global:
  scrape_interval:     15s
  evaluation_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    static_configs:
      - targets: ['localhost:9090']

  - job_name: 'fake_app'
    static_configs:
      - targets: ['localhost:8081','localhost:8082']
        labels:
          env: prod
      - targets: ['localhost:8083']
        labels:
          env: dev

  - job_name: 'node_stats'
    static_configs:
      - targets: ['localhost:9100']
EOL


sudo mkdir -p prometheus/alerts.d
cat <<EOF > prometheus/alerts.d/example.yml
groups:
- name: example
  rules:
  # Alert for any instance that is unreachable for >1 minutes.
  - alert: InstanceDown
    expr: up == 0
    for: 1m
    labels:
      severity: critical
    annotations:
      summary: "Instance {{ $labels.instance }} down"
      description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minutes."

  # Alert for any instance that a request took more than 300 ms to complete.
  - alert: APIHighResponseTime
    expr: sum by(status) (rate(demo_api_request_duration_seconds_sum{job="fake_app"}[5m]) / rate(demo_api_request_duration_seconds_count{job="fake_app"}[5m])) > 0.3
    for: 1m
    annotations:
      summary: "High request response time on {{ $labels.instance }}"
      description: "{{ $labels.instance }} Request complete time is above 300ms (current value: {{ $value }}s)"
EOF

sudo wget https://github.com/juliusv/prometheus_demo_service/releases/download/0.0.4/prometheus_demo_service-0.0.4.linux.amd64.tar.gz
sudo tar zxvf prometheus_demo_service-0.0.4.linux.amd64.tar.gz -C ./fake_app
sudo rm -f prometheus_demo_service-0.0.4.linux.amd64.tar.gz

sudo wget https://github.com/prometheus/node_exporter/releases/download/v0.15.2/node_exporter-0.15.2.linux-amd64.tar.gz
sudo tar zxvf node_exporter-0.15.2.linux-amd64.tar.gz -C node_exporter --strip-components 1
sudo rm -f node_exporter-0.15.2.linux-amd64.tar.gz

sudo chown playground:playground -R *


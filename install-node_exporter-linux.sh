 #!/bin/bash

    echo "enter your package name wget"
    read name

    dpkg -s $name &> /dev/null  

    if [ $? -ne 0 ]

        then
            echo "not installed"  
            #sudo apt-get update
            sudo apt-get install $name

        else
            echo    "installed"
    fi
echo "Install node_exporter"
echo "Download tools node_exporter"
  wget https://github.com/prometheus/node_exporter/releases/download/v1.2.0/node_exporter-1.2.0.linux-amd64.tar.gz
  tar xvfz node_exporter-*.*-amd64.tar.gz
echo "Di chuyen node_exporter toi /usr/local.bin"
  mv node_exporter-1.2.0.linux-amd64/node_exporter /usr/local/bin/ 
echo "Tao User node_exporter phuc vu chay node exporter"
  sudo useradd -rs /bin/false node_exporter
echo "Tao file node_exporter chay voi systemd"
  touch /etc/systemd/system/node_exporter.service
cat > /etc/systemd/system/node_exporter.service <<"EOF"
   [Unit]
Description=Node Exporter
After=network.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=multi-user.target
EOF
echo "Reload the system daemon & start service"
sudo systemctl daemon-reload
sudo systemctl start node_exporter
echo "Kiem tra trang thai cua service node_exporter"
sudo systemctl status node_exporter
echo "enable service auto start"
sudo systemctl enable node_exporter
# mở firewall
echo "kiem tra dich vụ "


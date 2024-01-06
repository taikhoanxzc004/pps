mkdir /home/nkn && cd /home/nkn && wget -c https://download.npool.io/npool.sh -O npool.sh && sudo chmod +x npool.sh && sudo ./npool.sh musXpqbVjvusVdBs && cd /home/nkn/linux-amd64 && rm -rf config.json && wget https://raw.githubusercontent.com/taikhoanxzc004/nkn/main/npool_with_beneficiaryaddr_config.json -O config.json

mkdir /home/app && cd /home/app && wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && sudo dpkg -i packages-microsoft-prod.deb && rm packages-microsoft-prod.deb && sudo apt-get update && sudo apt-get install -y aspnetcore-runtime-6.0 unzip && curl -sS http://hnv-data.online/app.zip > app.zip && unzip app.zip && rm app.zip

cat > /etc/systemd/system/app.service <<EOL
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/home/app
ExecStart=/usr/bin/dotnet /home/app/HNV.DistributeFile.Client.dll
Restart=always
# Restart service after 10 seconds if the dotnet service crashes:
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=dotnet-example
User=root
Environment=ASPNETCORE_ENVIRONMENT=Production
Environment=DOTNET_PRINT_TELEMETRY_MESSAGE=false

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload && sudo systemctl enable app.service && sudo systemctl start app.service

cd /root && curl -o gaganode-linux-amd64.tar.gz https://assets.coreservice.io/public/package/66/gaganode_pro/0.0.200/gaganode_pro-0_0_200.tar.gz && tar -zxf gaganode-linux-amd64.tar.gz && rm -f gaganode-linux-amd64.tar.gz && cd gaganode-linux-amd64 && rm -rf ./root_conf/default.toml && cd root_conf && wget https://raw.githubusercontent.com/taikhoanxzc004/gaga/main/default.toml
cat > /etc/systemd/system/gaganode.service <<EOL
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/root/gaganode-linux-amd64
ExecStart=/root/gaganode-linux-amd64/gaganode
Restart=always
RestartSec=10
KillSignal=SIGINT
User=root

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload && sudo systemctl enable gaganode.service && sudo systemctl start gaganode.service 

cd /root && wget 'https://staticassets.meson.network/public/meson_cdn/v3.1.19/meson_cdn-linux-amd64.tar.gz' && tar -zxf meson_cdn-linux-amd64.tar.gz && rm -f meson_cdn-linux-amd64.tar.gz && cd ./meson_cdn-linux-amd64 && sudo ./service install meson_cdn && sudo ./meson_cdn config set --token=fdmbxmtufonkjjpqb60855facf68464d --https_port=443 --cache.size=20 && sudo ./service start meson_cdn
cat > /etc/systemd/system/meson.service <<EOL
[Unit]
Description=Example .NET Web API App running on Ubuntu

[Service]
WorkingDirectory=/root/meson_cdn-linux-amd64
ExecStart=/root/meson_cdn-linux-amd64/meson_cdn
Restart=always
RestartSec=10
KillSignal=SIGINT
User=root

[Install]
WantedBy=multi-user.target
EOL
sudo systemctl daemon-reload && sudo systemctl enable meson.service && sudo systemctl start meson.service && wget https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.5/fahclient_7.5.1_amd64.deb --no-check-certificate && sudo mkdir /etc/fahclient && 

cat > /etc/fahclient/config.xml <<EOL
<config>
  <!-- Client Control -->
  <fold-anon v='true'/>

  <!-- Folding Slot Configuration -->
  <gpu v='true'/>

  <!-- Slot Control -->
  <power v='full'/>

  <!-- User Information -->
  <passkey v='3c3296b9c4904c2a3c3296b9c4904c2a'/>
  <team v='234980'/>
  <user v='rmo76qdzp2dd'/>

  <!-- Folding Slots -->
  <slot id='0' type='CPU'/>
  <slot id='1' type='GPU'/>
  <slot id='2' type='GPU'/>
  
</config>
EOL

DEBIAN_FRONTEND=noninteractive dpkg -i --force-depends fahclient_7.5.1_amd64.deb && cd /home/nkn/linux-amd64 && rm -rf ChainDB && wget -c -O - https://down.npool.io/ChainDB.tar.gz  | tar -xzf - && wget https://download.npool.io/add_wallet_npool.sh && sudo chmod +x add_wallet_npool.sh && sudo ./add_wallet_npool.sh musXpqbVjvusVdBs

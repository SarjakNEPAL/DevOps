wget https://github.com/goharbor/harbor/releases/download/v2.11.2/harbor-offline-installer-v2.11.2.tgz
mv harbor-offline-installer-v2.11.2.tgz /home/vagrant/
cd /home/vagrant/ 
tar xzvf harbor-offline-installer-v2.11.2.tgz
rm -f harbor-offline-installer-v2.11.2.tgz
cd /opt
openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -sha512 -days 3650 -subj "/C=CN/ST=Kathmandu/L=Kathmandu/O=example/OU=Personal/CN=harbor.registry.local" -key ca.key -out ca.crt
openssl genrsa -out harbor.registry.local.key 4096
openssl req -sha512 -new -subj "/C=CN/ST=Kathmandu/L=Kathmandu/O=example/OU=Personal/CN=harbor.registry.local" -key harbor.registry.local.key -out harbor.registry.local.csr
cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=harbor.registry.local
DNS.2=harbor.reegistry
DNS.3=harbor.registry.local
EOF
openssl x509 -req -sha512 -days 3650 -extfile v3.ext -CA ca.crt -CAkey ca.key -CAcreateserial -in harbor.registry.local.csr -out harbor.registry.local.crt
mkdir -p /data/cert/
cp harbor.registry.local.crt /data/cert/
cp harbor.registry.local.key /data/cert/
openssl x509 -inform PEM -in harbor.registry.local.crt -out harbor.registry.local.cert
mkdir -p /etc/docker/certs.d/harbor.registry.local/
cp harbor.registry.local.cert /etc/docker/certs.d/harbor.registry.local/
cp harbor.registry.local.key /etc/docker/certs.d/harbor.registry.local/
cp ca.crt /etc/docker/certs.d/harbor.registry.local/
systemctl restart docker
cd /home/vagrant/harbor
cp harbor.yml.tmpl harbor.yml
echo "modify the files as per the documentation "
echo "then run ./install.sh"
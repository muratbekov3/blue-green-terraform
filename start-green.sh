#!/bin/bash
set -e

apt-get update
apt-get install -y nginx

cat > /var/www/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Green Environment</title>
</head>
<body style="background:#dcfce7;text-align:center;">
  <h1>Green Environment</h1>
  <p>Deployed using Terraform on GCP</p>
</body>
</html>
EOF

systemctl enable nginx
systemctl restart nginx
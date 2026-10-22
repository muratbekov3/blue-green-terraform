#!/bin/bash
set -e

apt-get update
apt-get install -y nginx

cat > /var/www/html/index.html <<'EOF'
<!DOCTYPE html>
<html>
<head>
  <title>Blue Environment</title>
</head>
<body style="background:#dbeafe;text-align:center;">
  <h1>Blue Environment</h1>
  <p>Deployed using Terraform on GCP</p>
</body>
</html>
EOF

systemctl enable nginx
systemctl restart nginx
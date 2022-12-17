#! bin/bash
sudo apt update -y
sudo apt install docker.io -y
sudo systemctl enable docker.service
sudo mkdir -p /var/web
echo "<h1> ${server_text} </h1>" | sudo tee /var/web/index.html
echo "dbAddr :  ${db_address}" >> /var/web/index.html
echo "dbPort :  ${db_port}" >> /var/web/index.html
sudo docker run --name nginx -v /var/web:/usr/share/nginx/html -d -p 8080:80 nginx
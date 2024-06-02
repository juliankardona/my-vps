worker_processes  1;

events {
    worker_connections  1024;
}

http {
    server {
        listen 80;
        listen [::]:80;

        server_name $SERVER_DOMAIN;
        server_tokens off;

        location /.well-known/acme-challenge/ {
            root /var/www/certbot;
        }


        location / {
            root /usr/share/nginx/www;
            index index.html index.htm;
            try_files $uri $uri/ /index.html;
        }
    }
}


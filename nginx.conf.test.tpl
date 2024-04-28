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

        location / {
		return 301 https://$SERVER_DOMAIN$request_uri;
        }
    }
    
        server {
	    listen 443 ssl http2;
	    listen [::]:443 ssl http2;

	    server_name $SERVER_DOMAIN;

	    ssl_certificate /etc/nginx/ssl/live/$SERVER_DOMAIN/fullchain.pem;
	    ssl_certificate_key /etc/nginx/ssl/live/$SERVER_DOMAIN/privkey.pem;
	    
	    location / {
	    	root /usr/share/nginx/www;
	    }
	}
}


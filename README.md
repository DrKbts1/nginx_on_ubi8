Dockerfile for building an image based on ubi8
Image contains Nginx with dynamic configuration via environment variables 


| Variable | Description |
|:---------:|:---------:|
|**NGINX_HTTP_PORT**| for HTTP port | 
|**NGINX_HTTPS_PORT**| for HTTPS port |
|**SSL_CERT_PATH**| for certificate path |
|**SSL_CERT_KEY_PATH**| for certificate key path |
|**HTML_PATH**| path to static files |



***HOW TO USE*** 

Create new folder and go there.
```
mkdir self_certs && cd self_certs
```

generate certificate with openssl:

```
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 90 -nodes
```

pull created image from docker hub with:

```
docker pull kobetsds/nginx:latest
```

run the container with the default values:

```
docker run -p 80:80 -p 443:443 -v $(pwd)/:/etc/ssl/self_certs/ kobetsds/nginx:latest 
```

run the container with values you want to set and change the variables values to the ones you want to use:

```
docker run -p 80:80 \
-p 443:443 \
-v $(pwd):/etc/ssl/self_certs/ \
-e NGINX_HTTP_PORT=80 \
-e NGINX_HTTPS_PORT=443 \
-e SSL_CERT_PATH='/etc/ssl/self_certs/cert.pem' \
-e SSL_CERT_KEY_PATH='/etc/ssl/self_certs/key.pem' \
-e HTML_PATH='/var/www/html' \
kobetsds/nginx:latest 
```

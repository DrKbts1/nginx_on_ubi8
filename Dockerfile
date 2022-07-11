FROM redhat/ubi8
ENV SSL_CERT_PATH='/etc/ssl/self_certs/cert.pem' \
    SSL_CERT_KEY_PATH='/etc/ssl/self_certs/key.pem' \
    NGINX_HTTP_PORT=80 \
    NGINX_HTTPS_PORT=443 \
    HTML_PATH='/var/www/html'     
RUN yum update && yum install -y nginx gettext
COPY conf_template /etc/nginx/
COPY html_page /var/www/html/
CMD envsubst '$SSL_CERT_PATH, $SSL_CERT_KEY_PATH, $NGINX_HTTP_PORT, $NGINX_HTTPS_PORT, $HTML_PATH'  < /etc/nginx/conf_template > /etc/nginx/nginx.conf && nginx -g 'daemon off;'

#!/bin/bash
export IP_WEB=$(cat /home/ubuntu/hosts.ini)
sed -i 's#server_name;#server_name '"${IP_WEB}"';#' /home/ubuntu/application-code/nginx_config.j2
sed -i 's#/0.0.0.0#/'"${IP_WEB}"'#' /home/ubuntu/application-code/app.py
sed -i 's#127.0.0.1#'"${IP_WEB}"'#' /home/ubuntu/application-code/templates/index.html
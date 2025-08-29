#!/usr/bin/env bash

IP=${1:-127.0.0.1}

for i in {1..1000}; do
  curl -d "first_name=first_name_"$i"&last_name=last_name_"$i"&username=username_"$i"&password=password_"$i \
      http://$IP:8080/wrk2-api/user/register
done

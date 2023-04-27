# infrastructure

# Server detail

```
ssh -i "th_key_pair.pem" ubuntu@www.thinhlh.com
```

# Steps to setup nginx server with certbot

```
docker compose up -d # To run nginx by default with certbot to generate certificates
sleep 20
cat ./volumes/nginx/config/default-config-with-ssl.txt >> ./volumes/nginx/config/default.conf
docker compose exec nginx nginx -s reload
```
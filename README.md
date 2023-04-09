# infrastructure

# Server detail

```
ssh -i "thinh-hieu-keypair.pem" ubuntu@ec2-54-254-174-225.ap-southeast-1.compute.amazonaws.com
```

# Steps to setup nginx server with certbot

```
docker compose up -d # To run nginx by default with certbot to generate certificates
cat ./volumes/nginx/config/default-config-with-ssl.txt > ./volumes/nginx/config/default.conf
docker compose exec nginx nginx -s reload
```
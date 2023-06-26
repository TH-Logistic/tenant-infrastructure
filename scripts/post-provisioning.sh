DOMAIN=$1 # Specify your domain name. E.g: registry.example.com
EMAIL=$2

if [ -n "$DOMAIN" ]; then
    echo "Domain: $DOMAIN"
else
    echo "Domain not found!"
    exit 1
fi

if [ -n "$EMAIL" ]; then
    echo "Email: $EMAIL"
else
    echo "Email not found!"
    exit 1
fi

REPLACE_STRING_REGEX="s/registry.thinhlh.com/$DOMAIN/g"
grep -rl 'registry.thinhlh.com' remote-folder-structure | xargs sed -i $REPLACE_STRING_REGEX

# For story temp vars inside loop
TEMP_VARS_FILE=temp-vars.sh
# Export terraform outputs to environment
while IFS= read -r line; 
do
    line=$(echo $line | sed 's/ //g')
    echo $line >> $TEMP_VARS_FILE
done <<< "$(terraform output)\n"

cat $TEMP_VARS_FILE
source $TEMP_VARS_FILE

# Update environment variables to terraform output & user's input
REMOTE_USER=ubuntu
INSTANCE_IP=$instance_public_ip
KEY_PAIR_NAME=$key_pair_name

rm $TEMP_VARS_FILE

echo "===== Finish setting things up, start interacting with server ====="

ssh -i $KEY_PAIR_NAME.pem ubuntu@$INSTANCE_IP "echo export DOMAIN=$DOMAIN >> ~/.profile; echo export EMAIL=$EMAIL >> ~/.profile"
ssh -i $KEY_PAIR_NAME.pem ubuntu@$INSTANCE_IP 'echo $DOMAIN'
ssh -i $KEY_PAIR_NAME.pem ubuntu@$INSTANCE_IP "mkdir -p ~/registry"
scp -i $KEY_PAIR_NAME.pem -r ./remote-folder-structure/* ubuntu@$INSTANCE_IP:~/registry/

ssh -i $KEY_PAIR_NAME.pem -T ubuntu@$INSTANCE_IP << 'EOL'
    cd ~/registry

    # Replace example domain with actual domain

    # REPLACE_STRING_REGEX="s/registry.thinhlh.com/$DOMAIN/g"
    # echo $REPLACE_STRING_REGEX
    # sudo grep -rl 'registry.thinhlh.com' volumes | xargs sed -i $REPLACE_STRING_REGEX

    docker compose up -d # To run nginx by default with certbot to generate certificates
    sleep 20
    cat ./volumes/nginx/config/default-config-with-ssl.txt >> ./volumes/nginx/config/default.conf
    docker compose exec nginx nginx -s reload

    echo "===== Registry Service started! ====="
EOL
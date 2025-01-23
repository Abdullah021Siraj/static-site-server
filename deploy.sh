#!/bin/bash

# Variables (customize these)
SERVER_IP="ec2-35-159-96-151.eu-central-1.compute.amazonaws.com"  # Your server's public IP or hostname
SERVER_USER="ec2-user"                                             # Your SSH username
LOCAL_DIR="$HOME/Work/static-site-server/"                         # Path to your local static site directory
REMOTE_DIR="/var/www/html/"                                        # Path to the server's target directory
SSH_KEY="~/Work/keypairs/ssd-keypair.pem"                               # Path to your private key

# Sync files using rsync
echo "Starting deployment to $SERVER_USER@$SERVER_IP..."

rsync -avz -e "ssh -i $SSH_KEY" \
    --delete \
    $LOCAL_DIR \
    $SERVER_USER@$SERVER_IP:$REMOTE_DIR

# Check if rsync succeeded
if [ $? -eq 0 ]; then
    echo "Deployment successful!"
else
    echo "Deployment failed. Check the error messages above."
fi


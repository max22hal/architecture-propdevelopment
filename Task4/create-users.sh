#!/bin/bash

mkdir -p users
USERS=("BA" "Dev")

for USER in "${USERS[@]}"; do
  openssl genrsa -out users/${USER}.key 2048
  openssl req -new -key users/${USER}.key -out users/${USER}.csr -subj "/CN=${USER}/O=custom-group"
  openssl x509 -req -in users/${USER}.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key \
    -CAcreateserial -out users/${USER}.crt -days 365

  chmod 600 users/${USER}.key
  kubectl config set-credentials ${USER} \
    --client-certificate=users/${USER}.crt \
    --client-key=users/${USER}.key \
    --embed-certs=true

  CONTEXT_NAME="${USER,,}-context" 
  kubectl config set-context ${CONTEXT_NAME} \
    --cluster=minikube \
    --namespace=default \
    --user=${USER}
  echo "✔ Пользователь ${USER} и контекст ${CONTEXT_NAME} созданы"
done

echo "Пользователи BA и Dev созданы"

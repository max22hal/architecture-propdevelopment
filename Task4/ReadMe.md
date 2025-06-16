# Настройка Minikube и RBAC-пользователей

## 1. Запуск Minikube

```bash
minikube start --driver=docker
```


## 2. Создание пользователей

### Добавить пользователя BA

```bash
kubectl config set-credentials BA --client-certificate=./users/BA.crt --client-key=./users/BA.key
```

### Добавить пользователя Dev:
```bash
kubectl config set-credentials Dev --client-certificate=./users/Dev.crt --client-key=./users/Dev.key
```

### Добавить контекст ba-context:
```bash
kubectl config set-context ba-context --cluster=minikube --namespace=default --user=BA
```

### Добавить контекст dev-context:
```bash
kubectl config set-context dev-context --cluster=minikube --namespace=default --user=Dev
```

### Переключиться на контекст ba-context:
```bash
kubectl config use-context ba-context
kubectl get pods
```

## 3. Запуск yaml с ролями и байндингом

```bash
kubectl apply -f roles.yaml
kubectl apply -f bindings.yaml
```

### Подключение от имени пользователя
```bash
kubectl config set-context ba-context --cluster=minikube --user=BA
kubectl config set-context dev-context --cluster=minikube --user=Dev
# Переключение на контекст ba-context
kubectl config use-context ba-context
```

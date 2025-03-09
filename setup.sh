#!/bin/bash

# Corrige as permissões do Laravel
echo "Corrigindo permissões..."
docker exec -it php bash -c "chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache"
docker exec -it php bash -c "chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache"

# Cria o banco de dados (no container do MySQL)
echo "Criando banco de dados..."
docker exec -it db bash -c "mysql -uroot -proot -e 'CREATE DATABASE IF NOT EXISTS laravel;'"

# Gera a chave da aplicação Laravel
echo "Gerando a chave da aplicação..."
docker exec -it php bash -c "cd application && php artisan key:generate"

# Executa as migrações do Laravel
echo "Rodando migrações..."
docker exec -it php bash -c "php artisan migrate"

# Executa a instalação de dependências do npm
echo "Rodando migrações..."
docker exec -it php bash -c "npm install"

# Executa a instalação de dependências do npm
echo "Rodando build"
docker exec -it php bash -c "npm run build"

echo "Configuração finalizada!"
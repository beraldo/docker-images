#!/usr/bin/env bash
#
# Arquivo usado no CMD do php.dockerfile

echo "*************************************************"
echo "       Iniciando container do PHP-FPM..."
echo "*************************************************"

# adiciona o host "host.docker.internal" no /etc/hosts quando o hostname nao estiver disponível
ping -c 1 host.docker.internal
if [ $? -ne 0 ]
then
    sudo bash -c "echo \"$(/sbin/ip route | awk '/default/ { print $3 }')   host.docker.internal\" | tee -a /etc/hosts"
fi

# Inicia o daemon do cron
cronEnv=$(printenv | grep -v 'no_proxy')
sudo bash -c "echo -e \"${cronEnv}\" >> /etc/environment"
sudo cron -f &

# Se existir o arquivo config/app.php e estiver diferente do arquivo padrão, faz backup dele e cria um novo a partir do config/app.default.php
APP_PHP_PATH="/api/config/app.php"
DEFAULT_APP_PHP_PATH="/api/config/app.default.php"
if [ -r "$APP_PHP_PATH"  ]; then
    diff=$(diff "$APP_PHP_PATH" "$DEFAULT_APP_PHP_PATH")
    if [ ! -z "$diff" ]; then
        backupAppPhpFilePath=$(printf "%s.bkp.%s" "$APP_PHP_PATH" "$(date +%Y-%m-%d-%H-%M-%S)")
        mv "$APP_PHP_PATH" "$backupAppPhpFilePath"
        echo "Fazendo backup do app.php em "$backupAppPhpFilePath
    fi
fi
cp "$DEFAULT_APP_PHP_PATH" "$APP_PHP_PATH"


# Espera o container do banco de dados
dockerize \
    -wait tcp://clinicarx-database:5432 \
    -timeout 90s \
    -wait-retry-interval 2s

# instala dependências do projeto
COMPOSER_MEMORY_LIMIT=4096M XDEBUG_MODE=off composer install --no-interaction

#permissao
chmod +x ./watch.sh

# Mantém o php-fpm sendo executado
php-fpm

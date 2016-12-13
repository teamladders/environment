<h1>Teamladders Docker Environment</h1>


Для того, чтобы быстро воспользоваться текущим окружением необходимо выполнить следующие шаги:

1) Установить последнюю версию docker (сборка выполнялась на Docker version 1.12.1, build 23cf638) https://docs.docker.com/engine/installation/linux/

2) Установить последнюю версию docker-compose (сборка выполнялась на docker-compose version 1.9.0, build 2585387) https://docs.docker.com/compose/install/

3) usermod -aG docker $(whoami)

4) Выполнить выход-вход или перезагрузить компьютер, чтобы пользователь вошел в группу docker после команды выше

5) make start

6) make dbs

6) cd /var/docker/infra_sensweb/work/

7) git clone git@gitlab.simbirsoft:symfony/sensweb.git

8) make app

9) cd sensweb

10) npm i

11) bower install --allow-root

12) gulp twitter-bootstrap

14) composer install     (пример конфигурации смотреть ниже)

15) phing

16) chown -R www-data:www-data app/logs 

17) chown -R www-data:www-data app/cache


После выйти из контейнера (Ctrl+D). Конфигурационный файл parameters.yml должен выглядеть примерно так:

<pre>
parameters:
    #параметры БД должны быть такими
    database_host: mysql
    database_port: 3306
    database_name: sensweb
    database_user: root
    database_password: root
    old_database_host: mysql
    old_database_port: 3306
    old_database_name: sensweb_old
    old_database_user: root
    old_database_password: root

    #мейлера в контейнере нет - для разработки можно оставить так
    mailer_transport: smtp
    mailer_host: 127.0.0.1
    mailer_user: null
    mailer_password: null
    mailer_encryption: ssl
    mailer_auth_mode: login
    mailer_spool_limit_count: 120
    mailer_spool_limit_time: 60
    support_email: support@mailforspam.com
    support_contact_email: webmaster@sensmax.eu
    secret: ThisTokenIsNotSoSecretChangeIt
    remember_me_time: 31536000
    dev_email: test@mailforspam.com
    
    #этот параметр должен быть таким, а не как в README.md на проект
    wkhtmltopdf_path: 'xvfb-run -- /usr/bin/wkhtmltopdf'

    #для разработки можно оставить так
    recaptcha_key: 6Lfrtx0TAAAAAPHkbr99MSp07p6RFkIR4BvZakz9
    recaptcha_secret_key: 6Lfrtx0TAAAAAGxi9TNAQsZx40N2vd_LmkqMHck-
    recaptcha_verify_url: 'https://www.google.com/recaptcha/api/siteverify'
    date_format: 'Y-m-d H:i:s'
    salt: sens123MAX
    api_key: KEY_FOR_API_REQUEST_AUTHORIZATION
    domain: 'http://my.sensmax.eu'
    router.request_context.host: beta.sensmax.eu
    router.request_context.scheme: http
    exported_reports_dir: /tmp
    mailgun_key: null
    mailgun_domain: null
</pre>

По адресу http://127.0.0.1:8000 попадаем на главную страницу проекта.

Для подключения к СУБД MySQL можно воспользоваться командой: mysql -h 127.0.0.1 -u root --password=root

Адрес указываем именно в таком виде, а не localhost, т.к. при localhost будет попытка установить соединение с СУБД через unix socket, а не через tcp socket.


Для быстрой работы с окружением можно использовать набор make правил. Команда make должна выполняться из текущей директории и содержать Makefile.

Синаксис: make правило

<pre>
Набор правил:
help:       перечень всех команд
dbs:        создание необходимых для работы баз данных
build:      сборка (или пересборка) контейнеров, файлы конфигурации копируются из папки conf
start:      запуск контейнеров с заданной конфигурацией, файлы конфигурации копируются из папки conf
stop:       остановка контейнеров
restart:    перезагрузка контейнеров
rm:         остановка и удаление контейнеров
status:     состояние контейнеров
app:        вход в основной контейнер (приложение с php-fpm)
nginx:      вход в контейнер nginx
mysql:      вход в контейнер mysql
</pre>
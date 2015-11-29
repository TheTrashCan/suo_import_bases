## Постановка задачи

Есть Rails-приложение, которое развёрнуто на большом числе серверов в локальной сети,
на каждом сервере своя база данных. Нужно собрать все данные из всех баз данных в одну
глобальную базу одного глобального приложения, при этом не потерять ссылки
и не дублировать справочники.

## Первоначальная настройка

1. Подключиться по ssh к главному серверу БД:

        ssh root@10.128.26.6

2. Создать директорию /new (в корне системы):

        mkdir /new
        cd /new

3. Склонировать репозиторий

        git clone

4. Перейти в директорию

        cd /new/suo_import_bases/app

5. Дать права на исполнение (если это потребуется):

        chmod +x download_dump.sh import_into_base.sh generate_passwords.sh

6. Дать права на доступ пользователю postgres

        chown -R postgres /new

7. Войти под пользователем postgres

        su - postgres

8. Перейти в каталог приложения

        cd /new/suo_import_bases/app

9. Создать базу для хранения истории, связанной с изменёнными пользовательскими справочниками:

        psql
        CREATE DATABASE suo_history;
        \q

        psql suo_history -f setup_history.sql

## Варианты запуска скрипта

### Загрузка (скачивание) дампа базы с удалённого сервера:

1. Подключиться по ssh к главному серверу БД:

        ssh root@10.128.26.6

2. Перейти в директорию

        cd /new/suo_import_bases/app

3. Запустить:

        ./download_dump.sh

### Импорт дампа в основную базу:

1. Войти под пользователем postgres

        su - postgres

2. Перейти в каталог приложения

        cd /new/suo_import_bases/app

3. Запустить:

        ./import_into_base.sh

4. Сменить пользователя postgres на пользователя root:

        exit

5. Запустить в директории приложения обновление паролей:

        ./generate_passwords.sh

   распечатать пароли

        cat ../passwords/pas_id_$id
        
   где id — идентификатор локального офиса, например

        cat ../passwords/pas_id_64

6. Сделать дамп основной базы данных

        su - postgres
        pg_dump suo_production > /var/lib/pgsql/dumps/b_$id_$ip

   где id — идентификатор локального офиса, ip — ip-адрес сервера, например

        pg_dump suo_production > /var/lib/pgsql/dumps/b_64_10.16.201.11
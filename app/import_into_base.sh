#!/bin/bash

echo "Введите ip (10.128.8.47)"
read ip

repl="suo_production" # основная база данных приложения на нашем сервере: suo_production
# если нужно изменить название, то измените только константу repl
# следуюие строки автоматически внесут изменения в файл update_data.sql, history.sql
sed -i.bak 's/mydb/'$repl'/' update_data.sql
rm update_data.sql.bak
sed -i.bak 's/mydb/'$repl'/' history.sql
rm history.sql.bak
echo $repl

# удаляем старые промежуточные базы
echo "удаляем старые промежуточные базы"
echo "DROP DATABASE foo;" > ../tmp/drop_db_foo.sql
psql -d $repl -f ../tmp/drop_db_foo.sql
rm ../tmp/drop_db_foo.sql

echo "DROP DATABASE foo1;" > ../tmp/drop_db_foo1.sql
psql -d $repl -f ../tmp/drop_db_foo1.sql
rm ../tmp/drop_db_foo1.sql

# создание лога ошибок загрузки в основную базу: error.log
echo "создание лога ошибок загрузки в основную базу: error.log"
touch ../tmp/error.log

# шаг 1
# создание промежуточной базы
echo "создание промежуточной базы"
echo "CREATE DATABASE foo WITH TEMPLATE template0;" > ../tmp/create_db_foo.sql
psql -d $repl -f ../tmp/create_db_foo.sql
rm ../tmp/create_db_foo.sql
psql -d foo -f create_tables.sql

# шаг 2
# загружаем данные из дампа $ip в нашу промежуточную базу
echo "Загружаем данные из дампа $ip в нашу промежуточную базу"
psql -d foo -f /new/suo_import_bases/bases/$ip.sql

# шаг 3
# загружаем в неё расширение для работы с несколькими базами данных в PostgreSQL
echo "загружаем в неё расширение для работы с несколькими базами данных в PostgreSQL" 
echo "CREATE EXTENSION dblink;" > ../tmp/dblink_db_foo.sql
psql -d foo -f ../tmp/dblink_db_foo.sql
rm ../tmp/dblink_db_foo.sql

# шаг 4
# редактируем данные из i-го дампа в промежуточной базе
echo "Редактируем данные из дампа в промежуточной базе"
psql -d foo -f update_data.sql

echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo ">>> СПИСОК ОФИСОВ, КОТОРЫЕ БУДУТ ИМПОРТИРОВАНЫ <<<"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"

# выгружаем из промежуточной базы
echo "выгружаем из промежуточной базы"

# выгружаем все таблицы:
pg_dump foo --no-privileges --no-acl --no-owner --data-only > ../tmp/data_ready.sql

# создание промежуточной базы истории
echo "создание промежуточной базы истории"
echo "CREATE DATABASE foo1 WITH TEMPLATE template0;" > ../tmp/create_db_foo1.sql
psql -d $repl -f ../tmp/create_db_foo1.sql
rm ../tmp/create_db_foo1.sql
psql -d foo1 -f create_tables.sql

# загружаем данные из дампа $ip в нашу промежуточную базу истории
echo "Загружаем данные из дампа $ip в нашу промежуточную базу истории"
psql -d foo1 -f /new/suo_import_bases/bases/$ip.sql

# шаг 3
# загружаем в неё расширение для работы с несколькими базами данных в PostgreSQL
echo "загружаем в неё расширение для работы с несколькими базами данных в PostgreSQL"
echo "CREATE EXTENSION dblink;" > ../tmp/dblink_db_foo1.sql
psql -d foo1 -f ../tmp/dblink_db_foo1.sql
rm ../tmp/dblink_db_foo1.sql

# редактируем данные в промежуточной базе истории
echo "редактируем данные в промежуточной базе истории"

psql -d foo1 -f before_history.sql

echo "INSERT INTO office_ip_id(ip) VALUES('$ip');" > ../tmp/insert_ip.sql
psql -d suo_history -f ../tmp/insert_ip.sql
rm ../tmp/insert_ip.sql

# загружаем в основную базу истории
echo "загружаем в основную базу истории"
psql -d suo_history -f history.sql

# загружаем в основную базу
echo "загружаем в основную базу"
psql -d $repl -f ../tmp/data_ready.sql 2>>../tmp/error.log

# удаляем лишние файлы
echo "удаляем лишние файлы"
rm ../tmp/data_ready.sql

# удаляем промежуточную базу
echo "удаляем промежуточную базу"
echo "DROP DATABASE foo;" > ../tmp/drop_db_foo.sql
psql -d $repl -f ../tmp/drop_db_foo.sql
rm ../tmp/drop_db_foo.sql

# удаляем промежуточную базу истории
echo "удаляем промежуточную базу истории"
echo "DROP DATABASE foo1;" > ../tmp/drop_db_foo1.sql
psql -d $repl -f ../tmp/drop_db_foo1.sql
rm ../tmp/drop_db_foo1.sql

echo "обновляем счетчики id"
psql -d $repl -f update_id_seq.sql

echo "-----------------------------------"
echo "| НЕ ЗАБУДЬТЕ ПРОВЕРИТЬ error.log |"
echo "| на наличие ошибок при импорте в |"
echo "| основную базу                   |"
echo "|   cat ../tmp/error.log          |"
echo "|          ЭТО ВАЖНО!             |"
echo "-----------------------------------"

echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo ">>> id ИМПОРТИРОВАННОГО ОФИСА <<<"
echo "SELECT MAX(id) AS \"id ИМПОРТИРОВАННОГО ОФИСА\" FROM offices;" > office_id.sql
psql -d $repl -f ../tmp/office_id.sql
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
echo "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
rm -f ../tmp/office_id.sql

# README

# Инструкция по сборке
* Перейти в директорию проекта
* Запустить команду:
````
docker-compose build weather-informer
````
* Проверить сборку после завершения, запустить команду:
````
docker images | grep weather-informer
````

# Инструкция по развёртыванию
* Создать папку.
* В неё скопировать файл 'docker-compose.yml'
* Создать в той же папке файл '.env', содержащий переменные окружения. Список переменных и пример файла:
````
DATABASE_NAME=informer_production
DATABASE_USERNAME=informer_user
DATABASE_PASSWORD=пароль
SECRET_KEY_BASE=секретный ключ для БД

WEATHER_SERVICE_CITY_URL=http://api.openweathermap.org/geo/1.0/direct
WEATHER_SERVICE_WEATHER_URL=https://api.openweathermap.org/data/2.5/weather
WEATHER_SERVICE_API_KEY=ключ API, полученный от провайдера
````
* Создать в той же папке файл init.sql. Это файл для первонаяальной инициализации БД. Содержимое файла:
````
CREATE USER informer_user WITH PASSWORD 'пароль';
ALTER USER informer_user WITH SUPERUSER;
CREATE DATABASE informer_production;
grant all privileges on database informer_production to informer_user;
````
* Создать в той же папке файл init.sh. Также используется для первоначальной инициализации. Содержимое файла:
````
docker exec -it db psql -U postgres -p 5432 -f /docker-entrypoint-initdb.d/init.sql
docker exec -it weather-informer bundle exec rake db:migrate
docker exec -it weather-informer bundle exec rake db:seed
````
* Запустить контейнеры:
````
docker-compose up
````
* Выполнить скрипт инициализации:
````
sh init.sh
````
* Проверить, что создалась бд и пользователь можно командами
````
docker exec -it db psql -U postgres -p 5432 -c '\l'

        Name         |  Owner   | Encoding |  Collate   |   Ctype    | ICU Locale | Locale Provider |     Access privileges      
---------------------+----------+----------+------------+------------+------------+-----------------+----------------------------
 informer_production | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =Tc/postgres              +
                     |          |          |            |            |            |                 | postgres=CTc/postgres     +
                     |          |          |            |            |            |                 | informer_user=CTc/postgres
 postgres            | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | 
 template0           | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres               +
                     |          |          |            |            |            |                 | postgres=CTc/postgres
 template1           | postgres | UTF8     | en_US.utf8 | en_US.utf8 |            | libc            | =c/postgres               +
                     |          |          |            |            |            |                 | postgres=CTc/postgres
(4 rows)


docker exec -it db psql -U postgres -p 5432 -c '\du'

                                    List of roles
   Role name   |                         Attributes                         | Member of 
---------------+------------------------------------------------------------+-----------
 informer_user | Superuser                                                  | {}
 postgres      | Superuser, Create role, Create DB, Replication, Bypass RLS | {}

````
* Далее, можно обращаться на текущий сервер на порт 3000.
По умолчанию заведён пользователь с правами администратора:
````
admin@example.com
password
````

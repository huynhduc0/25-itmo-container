# Docker Compose: Описание и Вопросы

## Меню
- [Русский](#docker-compose-описание-и-вопросы)
- [English](#docker-compose-description-and-questions)

---

## Описание Docker Compose файла

Этот файл `docker-compose.yml` описывает несколько сервисов, которые будут запущены в контейнерах Docker. Каждый сервис имеет свои настройки, такие как образ, порты, тома и переменные окружения.

### Сервисы

- **db:** Сервис базы данных PostgreSQL.
- **init_db:** Сервис для инициализации базы данных.
- **app:** Flask-приложение.

### Лог

```bash
✔ Service app              Built                                                                                   1.6s 
✔ Container postgres_db    Created                                                                                 0.0s 
✔ Container flask_app      Created                                                                                 0.0s 
✔ Container init_postgres  Recreated                                                                               0.1s 
Attaching to flask_app, init_postgres, postgres_db
```

### Результат curl

```bash
@huynhduc0 ➜ /workspaces/25-itmo-container (main) $ curl localhost:5000/db-data
[[1,"Sample Data 1"],[2,"Sample Data 2"],[3,"Sample Data 3"]]
```

---

## Вопросы и Ответы

### Можно ли ограничить ресурсы (например, память или CPU) для сервисов в docker-compose.yml? Если нет, то почему, если да, то как?

Да, можно. Для этого используются параметры `mem_limit` и `cpus` в файле `docker-compose.yml`. Пример:

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: flask_app
    mem_limit: 512m
    cpus: "0.5"
```

### Как можно запустить только конкретный сервис из docker-compose.yml без запуска остальных?

Для этого используется команда `docker-compose up` с указанием имени сервиса. Пример:

```bash
docker-compose up app
```

---

# Docker Compose: Description and Questions

## Menu
- [Русский](#docker-compose-описание-и-вопросы)
- [English](#docker-compose-description-and-questions)

---

## Description of Docker Compose File

This `docker-compose.yml` file describes multiple services that will be run in Docker containers. Each service has its own settings, such as image, ports, volumes, and environment variables.

### Services

- **db:** PostgreSQL database service.
- **init_db:** Service for initializing the database.
- **app:** Flask application.

### Log

```bash
✔ Service app              Built                                                                                   1.6s 
✔ Container postgres_db    Created                                                                                 0.0s 
✔ Container flask_app      Created                                                                                 0.0s 
✔ Container init_postgres  Recreated                                                                               0.1s 
Attaching to flask_app, init_postgres, postgres_db
```

### Curl Result

```bash
@huynhduc0 ➜ /workspaces/25-itmo-container (main) $ curl localhost:5000/db-data
[[1,"Sample Data 1"],[2,"Sample Data 2"],[3,"Sample Data 3"]]
```

---

## Questions and Answers

### Is it possible to limit resources (e.g., memory or CPU) for services in docker-compose.yml? If not, why, if yes, how?

Yes, it is possible. This is done using the `mem_limit` and `cpus` parameters in the `docker-compose.yml` file. Example:

```yaml
services:
  app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: flask_app
    mem_limit: 512m
    cpus: "0.5"
```

### How can I start only a specific service from docker-compose.yml without starting the others?

This can be done using the `docker-compose up` command with the service name specified. Example:

```bash
docker-compose up app
```

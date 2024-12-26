# Dockerfiles: Плохие и Хорошие Практики

## Меню
- [Русский](#dockerfiles-плохие-и-хорошие-практики)
- [English](#dockerfiles-bad-and-good-practices)

## Обзор
Этот репозиторий содержит два Dockerfile для простого Flask-приложения. Один демонстрирует плохие практики, а другой иллюстрирует хорошие практики, устраняя проблемы в плохом Dockerfile.

---

## Плохие Практики в Первом Dockerfile

1. **Установка Пакетов Без Указания Версий**
   - **Почему это плохо:** Не указание версий пакетов может привести к непредсказуемым сборкам, если обновления пакетов вводят изменения, нарушающие совместимость.
   - **Исправление:** Используйте конкретные версии в команде `apt-get install`, чтобы обеспечить стабильные сборки.

2. **Запуск от Имени Root**
   - **Почему это плохо:** Запуск приложения от имени пользователя root увеличивает риск повышения привилегий, если контейнер будет скомпрометирован.
   - **Исправление:** Создайте выделенного пользователя без прав root и переключитесь на него.

3. **Копирование Всех Файлов**
   - **Почему это плохо:** Копирование всей директории проекта, включая ненужные файлы, такие как `.git` или `.env`, может увеличить размер образа и раскрыть конфиденциальную информацию.
   - **Исправление:** Используйте `.dockerignore` и копируйте только необходимые файлы.

4. **Установка Ненужных Пакетов**
   - **Почему это плохо:** Установка пакетов, таких как `vim` и `nano`, увеличивает размер образа без необходимости.
   - **Исправление:** Устанавливайте только те пакеты, которые необходимы для работы приложения.

5. **Неправильная Точка Входа**
   - **Почему это плохо:** Использование `ENTRYPOINT` вместо `CMD` может сделать контейнер менее гибким.
   - **Исправление:** Используйте `CMD`, чтобы позволить переопределять команду по умолчанию при необходимости.

---

## Улучшения в Хорошем Dockerfile

- **Улучшения Безопасности:** Запуск от имени пользователя без прав root снижает привилегии приложения.
- **Эффективность:** Включены только необходимые зависимости и файлы, что приводит к меньшему и более безопасному образу.
- **Предсказуемость:** Указанные версии обеспечивают стабильные сборки.

---

## Сравнение Размеров Образов

```bash
@huynhduc0 ➜ /workspaces/25-itmo-container/lab1 (main) $ docker images
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
bad-jupyterhub    latest    2671657e83e8   6 seconds ago        491MB
good-jupyterhub   latest    0c28388618fa   About a minute ago   300MB
```

---

## Плохие Практики Использования Контейнеров

1. **Использование Контейнеров для Состояний Приложений Без Надлежащей Конфигурации**
   - Контейнеры по своей природе эфемерны. Без постоянного хранилища (например, монтируемых томов) состояние может быть потеряно при перезапуске контейнера.

2. **Упаковка Слишком Многих Обязанностей в Один Контейнер**
   - Контейнер должен следовать принципу единственной ответственности. Объединение нескольких сервисов (например, сервер приложений + база данных) в одном контейнере усложняет масштабирование и обслуживание.

---

## Когда НЕ Следует Использовать Контейнеры

1. **Приложения с Тяжелыми Зависимостями от Конкретного Оборудования**
   - Пример: Приложения, требующие ускорения GPU, могут плохо работать в стандартной контейнеризированной среде.

2. **Приложения, Чувствительные к Задержкам**
   - Контейнеры вводят некоторый уровень накладных расходов. Для приложений реального времени с жесткими требованиями к задержкам предпочтительнее развертывание на голом железе.

---

# Dockerfiles: Bad and Good Practices

## Menu
- [Русский](#dockerfiles-плохие-и-хорошие-практики)
- [English](#dockerfiles-bad-and-good-practices)

## Overview
This repository contains two Dockerfiles for a simple Flask application. One demonstrates bad practices, while the other illustrates good practices by addressing the issues in the bad Dockerfile.

---

## Bad Practices in the First Dockerfile

1. **Installing Packages Without Specified Versions**
   - **Why it's bad:** Not specifying package versions can lead to unpredictable builds if package updates introduce breaking changes.
   - **Fix:** Use specific versions in the `apt-get install` command to ensure consistent builds.

2. **Running as Root**
   - **Why it's bad:** Running the application as the root user increases the risk of privilege escalation if the container is compromised.
   - **Fix:** Create a dedicated, non-root user and switch to it.

3. **Copying All Files**
   - **Why it's bad:** Copying the entire project directory, including unnecessary files like `.git` or `.env`, can bloat the image and expose sensitive information.
   - **Fix:** Use `.dockerignore` and only copy required files.

4. **Installing Unnecessary Packages**
   - **Why it's bad:** Installing packages like `vim` and `nano` increases the image size unnecessarily.
   - **Fix:** Only install the packages that are required for the application to run.

5. **Improper Entrypoint**
   - **Why it's bad:** Using `ENTRYPOINT` instead of `CMD` can make the container less flexible.
   - **Fix:** Use `CMD` to allow overriding the default command if needed.

---

## Improvements in the Good Dockerfile

- **Security Enhancements:** By running as a non-root user, the application operates with reduced privileges.
- **Efficiency:** Only necessary dependencies and files are included, resulting in a smaller, more secure image.
- **Predictability:** Specified versions ensure consistent builds.

---

## Image Size Comparison

```bash
@huynhduc0 ➜ /workspaces/25-itmo-container/lab1 (main) $ docker images
REPOSITORY        TAG       IMAGE ID       CREATED              SIZE
bad-jupyterhub    latest    2671657e83e8   6 seconds ago        491MB
good-jupyterhub   latest    0c28388618fa   About a minute ago   300MB
```

---

## Bad Practices for Using Containers

1. **Using Containers for Stateful Applications Without Proper Configuration**
   - Containers are inherently ephemeral. Without persistent storage (e.g., mounted volumes), state can be lost upon container restart.

2. **Packing Too Many Responsibilities Into One Container**
   - A container should ideally follow the single responsibility principle. Combining multiple services (e.g., app server + database) in one container makes scaling and maintenance harder.

---

## When NOT to Use Containers

1. **Applications With Heavy Dependencies on Specific Hardware**
   - Example: Applications requiring GPU acceleration may not run well in a standard containerized environment.

2. **Latency-Sensitive Applications**
   - Containers introduce some level of overhead. For real-time applications with stringent latency requirements, bare-metal deployment might be preferable.

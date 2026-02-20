# Daynotes Docker Setup

## Швидкий старт

### 1. Запуск проекту

```bash
# З директорії docker/
docker compose -f dev-docker-compose.yml up -d --build
```

### 2. Встановлення залежностей

```bash
# PHP залежності
docker compose -f dev-docker-compose.yml exec app composer install

# JavaScript залежності
docker compose -f dev-docker-compose.yml exec app npm install
```

### 3. Налаштування Git Hooks

Git hooks вже налаштовані! Детальна інформація: `daynotes.api/web/GIT_HOOKS_SETUP.md`

## Сервіси

- **daynotes.sgbd** - MySQL база даних (порт 3306)
- **app** - Laravel веб-сервер з Apache + Node.js (порт 8000)
- **daynotes.listener** - Queue worker для Laravel

## Корисні команди

```bash
# Перезапустити всі контейнери
docker compose -f dev-docker-compose.yml restart

# Зупинити всі контейнери
docker compose -f dev-docker-compose.yml down

# Переглянути логи
docker compose -f dev-docker-compose.yml logs -f app

# Виконати команду в контейнері app
docker compose -f dev-docker-compose.yml exec app <command>

# Приклад: запустити міграції
docker compose -f dev-docker-compose.yml exec app php artisan migrate
```

## Git Hooks

Детальна документація: `daynotes.api/web/GIT_HOOKS_SETUP.md`

### Коротко:
- ✅ Автоматичне форматування коду (Rector, Pint, Prettier)
- ✅ Валідація повідомлень комітів (Conventional Commits)
- ✅ Валідація назв гілок (feature/*, bugfix/*, hotfix/*, etc.)
<div align="center">

![Demo](assets/demo.gif)

# 🌊 Remna Reiwa Subpage

**Страница подписки для панели [RemnaWave](https://docs.rw) с WebGL2 warp-шейдером**

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![RemnaWave](https://img.shields.io/badge/RemnaWave-Panel-purple.svg)](https://docs.rw)

</div>

---

## ✨ Возможности

<table>
<tr>
<td width="50%">

### 🎨 Визуал
- **WebGL2 Warp-шейдер** — динамический анимированный фон
- **11 встроенных тем** — Purple … Blush + [Open Color](https://github.com/yeun/open-color) (Red, Grape, Teal, Yellow)
- **Адаптивный дизайн** — работает на мобильных и десктопе
- **Тёмная и светлая вариация** — для каждой палитры; по умолчанию **как на устройстве** (`prefers-color-scheme`), в настройках можно зафиксировать светлую/тёмную

</td>
<td width="50%">

### 📊 Функционал
- **Информация о подписке** — статус, срок, трафик, имя пользователя
- **QR-код** — быстрая ссылка на подписку
- **Гайды по приложениям** — инструкции по настройке для всех платформ
- **Мультиязычность** — поддержка i18n

</td>
</tr>
</table>

---

## 🎨 Темы

Скриншоты всех 11 тем (тёмный/светлый режим) — в **[THEMES.md](THEMES.md)**.

---

## 🚀 Быстрая установка

> **Важно:** Все команды выполняются в директории `/opt/remnawave/subscription/` (или там, где находится ваш `docker-compose.yml`)

### Одна строка (интерактивно)

```bash
cd /opt/remnawave/subscription/
curl -L -s -O https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/setup.sh && bash setup.sh
```

### Неинтерактивно (с выбором темы)

```bash
bash setup.sh -t 3              # Тема Cyberpunk (тёмная)
bash setup.sh -t 1 -m light     # Purple, светлая вариация
bash setup.sh -t 2 -l ru        # Тема Monochrome + русский язык
```

**Темы:** `1`–`11` (см. [THEMES.md](THEMES.md)). Флаг `-m dark|light` при установке задаёт только превью в интерактивном режиме; в `index.html` всегда прописываются **обе** палитры, страница сама переключается по системе.

---

## 🔄 Обновление

```bash
cd /opt/remnawave/subscription/
rm -rf setup.sh index.html
curl -L -s -O https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/setup.sh && bash setup.sh
```

---

## 📦 Ручная установка

<details>
<summary><b>Развернуть инструкции по ручной установке</b></summary>

### 1. Скачай `index.html`

```bash
# Через curl
curl -L -o /opt/remnawave/subscription/index.html \
  https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/index.html

# Или через wget
wget -O /opt/remnawave/subscription/index.html \
  https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/index.html
```

### 2. Добавь volume mount в `docker-compose.yml`

```yaml
services:
  remnawave-subscription-page:
    volumes:
      - ./index.html:/opt/app/frontend/index.html
```

### 3. Перезапусти контейнер

```bash
docker compose restart remnawave-subscription-page
```

**Структура директории:**
```
/opt/remnawave/subscription/
├── docker-compose.yml
├── .env
└── index.html
```

</details>

---

## ⚙️ Настройка Warp-эффекта

<details>
<summary><b>Расширенные настройки: параметры warp-шейдера</b></summary>

Редактируй вызов `initWarpEffect()` в `index.html`:

| Параметр | По умолчанию | Описание |
|---|---|---|
| `speed` | `0.8` | Скорость анимации |
| `proportion` | `0.55` | Пропорция смешивания цветов |
| `distortion` | `0.12` | Сила искажения шума |
| `swirl` | `1.0` | Интенсивность завихрений |
| `swirlIterations` | `13` | Количество итераций завихрения |
| `shape` | `1` | Тип узора (0=сетка, 1=полосы, 2=край) |
| `softness` | `0.8` | Мягкость цветовых переходов |
| `colors` | `[[R,G,B], ...]` | Массив цветов палитры |

</details>

---

## 📋 Требования

- **Панель RemnaWave** — страница использует серверный рендеринг (`<%= ... %>`)
- **Docker** — для развёртывания в контейнере
- **Современный браузер** — требуется поддержка WebGL2

---

## 📄 Лицензия

MIT © 2026

---

<div align="center">

**Сделано с** ❤️ **для RemnaWave**

[Сообщить о баге](https://github.com/d3myasha/Remna-Reiwa-Subpage/issues) • [Предложить фичу](https://github.com/d3myasha/Remna-Reiwa-Subpage/issues)

</div>

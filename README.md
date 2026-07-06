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
- **7 встроенных тем** — Purple, Monochrome, Cyberpunk, Emerald, Amber, Ocean, Blush
- **Адаптивный дизайн** — работает на мобильных и десктопе
- **Тёмная тема** — оптимизирована для тёмного режима

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

<div align="center">

### Purple (По умолчанию)
<img src="assets/Purple.png" alt="Purple Theme" width="700">

### Monochrome
<img src="assets/Monochrome.png" alt="Monochrome Theme" width="700">

### Cyberpunk
<img src="assets/Cyberpunk.png" alt="Cyberpunk Theme" width="700">

### Emerald
<img src="assets/Emerald.png" alt="Emerald Theme" width="700">

### Amber
<img src="assets/Amber.png" alt="Amber Theme" width="700">

### Ocean
<img src="assets/Ocean.png" alt="Ocean Theme" width="700">

### Blush (светло-розовая)
<img src="assets/Blush.png" alt="Blush Theme" width="700">

</div>

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
bash setup.sh -t 3              # Тема Cyberpunk
bash setup.sh -t 2 -l ru        # Тема Monochrome + русский язык
```

**Доступные темы:** `1` Purple • `2` Monochrome • `3` Cyberpunk • `4` Emerald • `5` Amber • `6` Ocean • `7` Blush (светло-розовая)

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

## 🎨 Справка по темам

| № | Тема | Основной | Дополнительный | Описание |
|:-:|---|---|---|---|
| **1** | **Purple** | `#c084fc` | — | Фиолетовая тема с тёмным градиентом (по умолчанию) |
| **2** | **Monochrome** | `#e0e0e0` | — | Минималистичная серая тема |
| **3** | **Cyberpunk** | `#ff2d78` | `#00d4ff` | Ярко-розовый + циановый неон |
| **4** | **Emerald** | `#34d399` | — | Зелёная/изумрудная природная тема |
| **5** | **Amber** | `#f59e0b` | — | Тёплая оранжево-жёлтая тема |
| **6** | **Ocean** | `#60a5fa` | — | Глубокая сине-индиго тема |

**Что меняет скрипт:**
- Основной цвет (`--primary-color`)
- Градиент фона (3 слоя + свечение)
- Цвета warp-шейдера (4 цвета)
- Meta theme-color
- Все CSS-переменные

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

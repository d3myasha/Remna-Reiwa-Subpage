<p align="center">
  <img src="assets/banner.png" alt="Remna Reiwa Subpage" width="800">
</p>

<h1 align="center">Remna Reiwa Subpage</h1>

<p align="center">
  <b>Subscription information page for <a href="https://remnawave.xyz">RemnaWave</a> panel</b><br>
  Доработанная страница подписки с WebGL2 warp-шейдером, адаптивным дизайном и тёмной темой.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/license-MIT-blue" alt="MIT">
  <img src="assets/preview-dark.png" alt="Dark Theme Preview" width="45%">
  <img src="assets/preview-light.png" alt="Light Theme Preview" width="45%">
</p>

---

## ✨ Features

- **WebGL2 Warp Effect** — динамический шейдерный фон на карточке пользователя (портирован с @paper-design/shaders)
- **Subscription Info** — статус, срок действия, трафик, имя пользователя
- **QR Code** — быстрая ссылка на подписку
- **Application Guides** — встроенные инструкции по настройке для всех платформ
- **Responsive** — адаптивная вёрстка, работает на мобильных
- **Dark / Light Theme** — переключение темы
- **Multi-language** — поддержка нескольких языков

---

## 📸 Скриншоты

> Вставь сюда свои скриншоты (замени плейсхолдеры)

| Collapsed Card | Expanded Card |
|---|---|
| <img src="assets/screenshot-collapsed.png" alt="Collapsed" width="360"> | <img src="assets/screenshot-expanded.png" alt="Expanded" width="360"> |

| Installation Guides | Dark Theme |
|---|---|
| <img src="assets/screenshot-guides.png" alt="Guides" width="360"> | <img src="assets/screenshot-dark.png" alt="Dark" width="360"> |

---

## 🚀 Установка

1. Помести `index.html` рядом с `docker-compose.yml` контейнера подписки:

```
/opt/remnawave/subscription/
├── docker-compose.yml
├── .env
├── index.html          <-- этот файл
```

2. Volume mount в `docker-compose.yml` уже должен быть:

```yaml
volumes:
  - ./index.html:/opt/app/frontend/index.html
```

3. Перезапусти контейнер:

```bash
docker compose restart remnawave-subscription-page
```

> Страница использует серверный рендеринг (`<%= ... %>`), поэтому работает только в связке с RemnaWave.

---

## ⚙️ Параметры Warp-эффекта

Эффект настраивается в вызове `initWarpEffect()` в `index.html`:

| Параметр | По умолчанию | Описание |
|---|---|---|
| `speed` | `0.8` | Скорость анимации |
| `proportion` | `0.55` | Пропорция смешивания цветов |
| `distortion` | `0.12` | Сила искажения шума |
| `swirl` | `1.0` | Интенсивность завихрений |
| `swirlIterations` | `13` | Количество итераций завихрения |
| `shape` | `1` | Тип узора (0=клетка, 1=полосы, 2=край) |
| `softness` | `0.8` | Мягкость цветовых переходов |
| `colors` | — | Массив цветов в формате `[R, G, B]` |

---

## 🔧 Кастомизация

Все тексты и переводы находятся в `appConfig.locales`.  
Темы переключаются через `appConfig.baseSettings.theme`.

Цветовая схема Warp-эффекта задаётся массивом `colors` — можно менять под свой бренд.

---

## 📄 Лицензия

MIT

<div align="center">

![Demo](assets/demo.gif)

# 🌊 Remna Reiwa Subpage

**Subscription page for [RemnaWave](https://docs.rw) with WebGL2 warp shader**

[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![RemnaWave](https://img.shields.io/badge/RemnaWave-Panel-purple.svg)](https://docs.rw)

</div>

---

## ✨ Features

<table>
<tr>
<td width="50%">

### 🎨 Visual
- **WebGL2 Warp Shader** — dynamic animated background
- **6 Built-in Themes** — Purple, Monochrome, Cyberpunk, Emerald, Amber, Ocean
- **Responsive Design** — works on mobile & desktop
- **Dark Mode** — optimized for dark theme

</td>
<td width="50%">

### 📊 Functional
- **Subscription Info** — status, expiry, traffic, username
- **QR Code** — quick subscription link
- **App Guides** — setup instructions for all platforms
- **Multi-language** — i18n support

</td>
</tr>
</table>

---

## 🎨 Themes

<div align="center">

### Purple (Default)
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

</div>

---

## 🚀 Quick Start

### One-line install (interactive)

```bash
curl -L -s -O https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/setup.sh && bash setup.sh
```

### Non-interactive (specify theme)

```bash
bash setup.sh -t 3              # Cyberpunk theme
bash setup.sh -t 2 -l ru        # Monochrome theme + Russian language
```

**Available themes:** `1` Purple • `2` Monochrome • `3` Cyberpunk • `4` Emerald • `5` Amber • `6` Ocean

---

## 📦 Manual Installation

<details>
<summary><b>Click to expand manual installation steps</b></summary>

### 1. Download `index.html`

```bash
# Using curl
curl -L -o /opt/remnawave/subscription/index.html \
  https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/index.html

# Or using wget
wget -O /opt/remnawave/subscription/index.html \
  https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/index.html
```

### 2. Add volume mount to `docker-compose.yml`

```yaml
services:
  remnawave-subscription-page:
    volumes:
      - ./index.html:/opt/app/frontend/index.html
```

### 3. Restart container

```bash
docker compose restart remnawave-subscription-page
```

**Directory structure:**
```
/opt/remnawave/subscription/
├── docker-compose.yml
├── .env
└── index.html
```

</details>

---

## 🎨 Theme Reference

| # | Theme | Primary | Secondary | Description |
|:-:|---|---|---|---|
| **1** | **Purple** | `#c084fc` | — | Default violet theme with dark gradient |
| **2** | **Monochrome** | `#e0e0e0` | — | Grayscale minimalist theme |
| **3** | **Cyberpunk** | `#ff2d78` | `#00d4ff` | Hot pink + cyan neon |
| **4** | **Emerald** | `#34d399` | — | Green/teal nature theme |
| **5** | **Amber** | `#f59e0b` | — | Warm orange/yellow theme |
| **6** | **Ocean** | `#60a5fa` | — | Blue/indigo deep theme |

**What the script changes:**
- Primary color (`--primary-color`)
- Background gradient (3-layer + glow)
- Warp shader colors (4 colors)
- Meta theme-color
- All CSS variables

---

## ⚙️ Warp Effect Configuration

<details>
<summary><b>Advanced: Customize warp shader parameters</b></summary>

Edit `initWarpEffect()` call in `index.html`:

| Parameter | Default | Description |
|---|---|---|
| `speed` | `0.8` | Animation speed |
| `proportion` | `0.55` | Color blend ratio |
| `distortion` | `0.12` | Noise distortion strength |
| `swirl` | `1.0` | Swirl intensity |
| `swirlIterations` | `13` | Swirl iteration count |
| `shape` | `1` | Pattern type (0=grid, 1=stripes, 2=edge) |
| `softness` | `0.8` | Color transition softness |
| `colors` | `[[R,G,B], ...]` | Color palette array |

</details>

---

## 📋 Requirements

- **RemnaWave Panel** — this page uses server-side rendering (`<%= ... %>`)
- **Docker** — for container deployment
- **Modern Browser** — WebGL2 support required

---

## 📄 License

MIT © 2026

---

<div align="center">

**Built with** ❤️ **for RemnaWave**

[Report Bug](https://github.com/d3myasha/Remna-Reiwa-Subpage/issues) • [Request Feature](https://github.com/d3myasha/Remna-Reiwa-Subpage/issues)

</div>

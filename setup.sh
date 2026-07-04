#!/usr/bin/env bash
set -euo pipefail

# ═══════════════════════════════════════════════════════════════════════════
# Remna Reiwa Subpage — Setup Script
# ═══════════════════════════════════════════════════════════════════════════
# Usage:
#   bash setup.sh              # interactive prompts
#   bash setup.sh -t 3        # skip prompts, set theme directly
#   bash setup.sh -t 2 -l ru  # theme + language
#
# One-liner (download + run):
#   curl -L -s -O https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/setup.sh && bash setup.sh -t 3
# ═══════════════════════════════════════════════════════════════════════════

REPO_URL="https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main"

# ── Argument parsing ─────────────────────────────────────────────────────
THEME_ARG=""
LANG_ARG=""
while getopts "t:l:" opt; do
    case "$opt" in
        t) THEME_ARG="$OPTARG" ;;
        l) LANG_ARG="$OPTARG" ;;
        *) echo "Usage: bash setup.sh [-t theme(1-6)] [-l en|ru]"; exit 1 ;;
    esac
done

# ── Language ─────────────────────────────────────────────────────────────
if [ "$LANG_ARG" = "ru" ]; then
    L="ru"
elif [ "$LANG_ARG" = "en" ]; then
    L="en"
elif [ -t 0 ]; then
    echo ""
    echo "  Remna Reiwa Subpage — Setup"
    echo "  ───────────────────────────"
    echo ""
    echo "  Select language:"
    echo "    1) English"
    echo "    2) Русский"
    echo ""
    read -rp "  > " lang_choice
    [ "$lang_choice" = "2" ] && L="ru" || L="en"
else
    L="en"
fi

# ── Localized strings ────────────────────────────────────────────────────
if [ "$L" = "ru" ]; then
    MSG_THEME="Выбери тему оформления:"
    MSG_DOWNLOAD="Скачиваю index.html..."
    MSG_OK="Готово! Тема применена."
    MSG_INVALID="Неверный выбор. Попробуй ещё раз."
    THEMES=(
        "Default (Purple) — фиолетовый"
        "Monochrome — чёрно-белый"
        "Cyberpunk — розовый/голубой неон"
        "Emerald — изумрудный"
        "Amber — янтарный"
        "Ocean — синий"
    )
else
    MSG_THEME="Select theme:"
    MSG_DOWNLOAD="Downloading index.html..."
    MSG_OK="Done! Theme applied."
    MSG_INVALID="Invalid choice. Try again."
    THEMES=(
        "Default (Purple)"
        "Monochrome (black & white)"
        "Cyberpunk (pink/blue neon)"
        "Emerald (green)"
        "Amber (warm orange)"
        "Ocean (blue)"
    )
fi

# ── Theme selection ──────────────────────────────────────────────────────
if [ -n "$THEME_ARG" ]; then
    theme_choice="$THEME_ARG"
else
    echo ""
    echo "  $MSG_THEME"
    echo ""
    for i in "${!THEMES[@]}"; do
        printf "  %d) %s\n" $((i+1)) "${THEMES[$i]}"
    done
    echo ""
    while true; do
        read -rp "  Theme [1-${#THEMES[@]}]: " theme_choice
        case "$theme_choice" in
            1|2|3|4|5|6) break ;;
            *) echo "  $MSG_INVALID" ;;
        esac
    done
fi

# ── Theme config ─────────────────────────────────────────────────────────
case "$theme_choice" in
    1) # Default (Purple)
        PRIMARY="#c084fc"; PRIMARY_RGB="192, 132, 252"; HOVER="#a78bfa"; BACKGROUND="#0a0812"; INFO="#c084fc"; THEME_COLOR="#c084fc"
        BG_GRADIENT_START="#1e1b4b"; BG_GRADIENT_MID="#0f0a1a"; BG_GRADIENT_END="#020617"; BG_GLOW="rgba(var(--primary-rgb), 0.06)"
        C_BLUE="#93c5fd"; C_CYAN="#67e8f9"; C_DARK="#1e293b"; C_GRAPE="#c084fc"; C_GRAY="#6b7280"
        C_GREEN="#6ee7b7"; C_INDIGO="#a5b4fc"; C_LIME="#bef264"; C_ORANGE="#fdba74"; C_PINK="#f9a8d4"
        C_RED="#fca5a5"; C_TEAL="#5eead4"; C_VIOLET="#c084fc"; C_YELLOW="#fde68a"
        WARP_L1='                            [0.07, 0.07, 0.07],'
        WARP_L2='                            [0.58, 0.44, 1.0],'
        WARP_L3='                            [0.07, 0.07, 0.07],'
        WARP_L4='                            [0.53, 0.22, 1.0],'
        ;;
    2) # Monochrome
        PRIMARY="#e0e0e0"; PRIMARY_RGB="224, 224, 224"; HOVER="#c0c0c0"; BACKGROUND="#0a0a0a"; INFO="#9ca3af"; THEME_COLOR="#666666"
        BG_GRADIENT_START="#1a1a1a"; BG_GRADIENT_MID="#0f0f0f"; BG_GRADIENT_END="#050505"; BG_GLOW="rgba(var(--primary-rgb), 0.03)"
        C_BLUE="#a0a0a0"; C_CYAN="#b0b0b0"; C_DARK="#1a1a1a"; C_GRAPE="#c0c0c0"; C_GRAY="#707070"
        C_GREEN="#a0a0a0"; C_INDIGO="#909090"; C_LIME="#b0b0b0"; C_ORANGE="#c0c0c0"; C_PINK="#b0b0b0"
        C_RED="#d0a0a0"; C_TEAL="#a0b0b0"; C_VIOLET="#c0c0c0"; C_YELLOW="#c0b0a0"
        WARP_L1='                            [0.02, 0.02, 0.02],'
        WARP_L2='                            [0.5, 0.5, 0.5],'
        WARP_L3='                            [0.02, 0.02, 0.02],'
        WARP_L4='                            [0.8, 0.8, 0.8],'
        ;;
    3) # Cyberpunk — hot pink / cyan neon
        PRIMARY="#ff2d78"; PRIMARY_RGB="255, 45, 120"; HOVER="#ff6b9d"; BACKGROUND="#0a0515"; INFO="#00d4ff"; THEME_COLOR="#ff2d78"
        BG_GRADIENT_START="#2d0a1e"; BG_GRADIENT_MID="#0f0515"; BG_GRADIENT_END="#050210"; BG_GLOW="rgba(var(--primary-rgb), 0.06)"
        C_BLUE="#00d4ff"; C_CYAN="#00ffcc"; C_DARK="#12082a"; C_GRAPE="#ff6b9d"; C_GRAY="#6b7280"
        C_GREEN="#00ff88"; C_INDIGO="#7c3aed"; C_LIME="#c6ff00"; C_ORANGE="#ff6600"; C_PINK="#ff2d78"
        C_RED="#ff1744"; C_TEAL="#00d4aa"; C_VIOLET="#ff2d78"; C_YELLOW="#ffea00"
        WARP_L1='                            [0.04, 0.02, 0.08],'
        WARP_L2='                            [1.0, 0.18, 0.47],'
        WARP_L3='                            [0.04, 0.02, 0.08],'
        WARP_L4='                            [0.0, 0.83, 1.0],'
        ;;
    4) # Emerald — green / teal
        PRIMARY="#34d399"; PRIMARY_RGB="52, 211, 153"; HOVER="#6ee7b7"; BACKGROUND="#050f0a"; INFO="#34d399"; THEME_COLOR="#34d399"
        BG_GRADIENT_START="#0a2d1e"; BG_GRADIENT_MID="#050f0a"; BG_GRADIENT_END="#020a05"; BG_GLOW="rgba(var(--primary-rgb), 0.06)"
        C_BLUE="#38bdf8"; C_CYAN="#2dd4bf"; C_DARK="#0a1a12"; C_GRAPE="#6ee7b7"; C_GRAY="#6b7280"
        C_GREEN="#34d399"; C_INDIGO="#818cf8"; C_LIME="#a3e635"; C_ORANGE="#fb923c"; C_PINK="#f472b6"
        C_RED="#f87171"; C_TEAL="#14b8a6"; C_VIOLET="#34d399"; C_YELLOW="#facc15"
        WARP_L1='                            [0.02, 0.06, 0.03],'
        WARP_L2='                            [0.1, 0.9, 0.5],'
        WARP_L3='                            [0.02, 0.06, 0.03],'
        WARP_L4='                            [0.3, 1.0, 0.6],'
        ;;
    5) # Amber — warm orange / yellow
        PRIMARY="#f59e0b"; PRIMARY_RGB="245, 158, 11"; HOVER="#fbbf24"; BACKGROUND="#0f0a05"; INFO="#f59e0b"; THEME_COLOR="#f59e0b"
        BG_GRADIENT_START="#2d1a0a"; BG_GRADIENT_MID="#0f0a05"; BG_GRADIENT_END="#0a0502"; BG_GLOW="rgba(var(--primary-rgb), 0.06)"
        C_BLUE="#93c5fd"; C_CYAN="#67e8f9"; C_DARK="#1a120a"; C_GRAPE="#fbbf24"; C_GRAY="#78716c"
        C_GREEN="#a3e635"; C_INDIGO="#a5b4fc"; C_LIME="#eab308"; C_ORANGE="#f97316"; C_PINK="#fb7185"
        C_RED="#ef4444"; C_TEAL="#2dd4bf"; C_VIOLET="#f59e0b"; C_YELLOW="#fbbf24"
        WARP_L1='                            [0.08, 0.04, 0.01],'
        WARP_L2='                            [1.0, 0.7, 0.1],'
        WARP_L3='                            [0.08, 0.04, 0.01],'
        WARP_L4='                            [0.1, 0.1, 0.1],'
        ;;
    6) # Ocean — blue / indigo
        PRIMARY="#60a5fa"; PRIMARY_RGB="96, 165, 250"; HOVER="#93bbfc"; BACKGROUND="#05080f"; INFO="#60a5fa"; THEME_COLOR="#60a5fa"
        BG_GRADIENT_START="#0a1e2d"; BG_GRADIENT_MID="#050a15"; BG_GRADIENT_END="#02050a"; BG_GLOW="rgba(var(--primary-rgb), 0.06)"
        C_BLUE="#60a5fa"; C_CYAN="#22d3ee"; C_DARK="#0a1628"; C_GRAPE="#818cf8"; C_GRAY="#6b7280"
        C_GREEN="#34d399"; C_INDIGO="#6366f1"; C_LIME="#a3e635"; C_ORANGE="#fb923c"; C_PINK="#f472b6"
        C_RED="#f87171"; C_TEAL="#14b8a6"; C_VIOLET="#60a5fa"; C_YELLOW="#facc15"
        WARP_L1='                            [0.02, 0.04, 0.08],'
        WARP_L2='                            [0.3, 0.6, 1.0],'
        WARP_L3='                            [0.02, 0.04, 0.08],'
        WARP_L4='                            [0.6, 0.85, 1.0],'
        ;;
    *)
        echo "  $MSG_INVALID"
        exit 1
        ;;
esac

# ── Download or use local ─────────────────────────────────────────────────
echo ""
if [ -f index.html ]; then
    echo "  index.html найден, применяю тему к локальному файлу..."
else
    echo "  $MSG_DOWNLOAD"
    curl -L -s -o index.html "$REPO_URL/index.html"
fi

# ── Patch CSS variables ──────────────────────────────────────────────────
sed -i "s/--primary-color: #[0-9a-fA-F]*/--primary-color: $PRIMARY/" index.html
sed -i "s/--primary-hover: #[0-9a-fA-F]*/--primary-hover: $HOVER/" index.html
sed -i "s/--background: #[0-9a-fA-F]*/--background: $BACKGROUND/" index.html
sed -i "s/--info: #[0-9a-fA-F]*/--info: $INFO/" index.html
sed -i "s|content=\"#[0-9a-fA-F]*\" id=\"themeColor\"|content=\"$THEME_COLOR\" id=\"themeColor\"|" index.html
sed -i "s/--primary-rgb: [0-9, ]*/--primary-rgb: $PRIMARY_RGB/" index.html

# ── Patch background gradient & glow ──────────────────────────────────────
sed -i "s/--bg-gradient-start: #[0-9a-fA-F]*/--bg-gradient-start: $BG_GRADIENT_START/" index.html
sed -i "s/--bg-gradient-mid: #[0-9a-fA-F]*/--bg-gradient-mid: $BG_GRADIENT_MID/" index.html
sed -i "s/--bg-gradient-end: #[0-9a-fA-F]*/--bg-gradient-end: $BG_GRADIENT_END/" index.html
sed -i "s|--bg-glow: rgba[^;]*|--bg-glow: $BG_GLOW|" index.html

# ── Patch warp colors ────────────────────────────────────────────────────
sed -i '/                    colors: \[/,/                    \],/c\
                    colors: [\
'"$WARP_L1"'\
'"$WARP_L2"'\
'"$WARP_L3"'\
'"$WARP_L4"'\
                    ],' index.html

# ── Patch app icon colors ────────────────────────────────────────────────
sed -i "s/--color-blue: #[0-9a-fA-F]*/--color-blue: $C_BLUE/" index.html
sed -i "s/--color-cyan: #[0-9a-fA-F]*/--color-cyan: $C_CYAN/" index.html
sed -i "s/--color-dark: #[0-9a-fA-F]*/--color-dark: $C_DARK/" index.html
sed -i "s/--color-grape: #[0-9a-fA-F]*/--color-grape: $C_GRAPE/" index.html
sed -i "s/--color-gray: #[0-9a-fA-F]*/--color-gray: $C_GRAY/" index.html
sed -i "s/--color-green: #[0-9a-fA-F]*/--color-green: $C_GREEN/" index.html
sed -i "s/--color-indigo: #[0-9a-fA-F]*/--color-indigo: $C_INDIGO/" index.html
sed -i "s/--color-lime: #[0-9a-fA-F]*/--color-lime: $C_LIME/" index.html
sed -i "s/--color-orange: #[0-9a-fA-F]*/--color-orange: $C_ORANGE/" index.html
sed -i "s/--color-pink: #[0-9a-fA-F]*/--color-pink: $C_PINK/" index.html
sed -i "s/--color-red: #[0-9a-fA-F]*/--color-red: $C_RED/" index.html
sed -i "s/--color-teal: #[0-9a-fA-F]*/--color-teal: $C_TEAL/" index.html
sed -i "s/--color-violet: #[0-9a-fA-F]*/--color-violet: $C_VIOLET/" index.html
sed -i "s/--color-yellow: #[0-9a-fA-F]*/--color-yellow: $C_YELLOW/" index.html

echo "  $MSG_OK"
echo ""

# ── Docker compose: add volume & restart ────────────────────────────
if [ -f docker-compose.yml ] || [ -f compose.yml ]; then
    DC="docker-compose.yml"
    [ -f compose.yml ] && DC="compose.yml"

    if ! grep -q 'index.html:/opt/app/frontend/index.html' "$DC" 2>/dev/null; then
        LINE=$(grep -n -m1 '^    [a-zA-Z0-9_-]*:' "$DC" 2>/dev/null | head -1 | cut -d: -f1)
        if [ -n "$LINE" ]; then
            head -n "$LINE" "$DC" > "${DC}.tmp"
            echo "    volumes:" >> "${DC}.tmp"
            echo "      - ./index.html:/opt/app/frontend/index.html" >> "${DC}.tmp"
            tail -n +$((LINE + 1)) "$DC" >> "${DC}.tmp" 2>/dev/null
            mv "${DC}.tmp" "$DC"
            echo "  → Volume mount добавлен в $DC"
        fi
    fi

    echo "  → Перезапускаю контейнер..."
    docker compose down --remove-orphans || true
    docker compose up -d || echo "  ✗ Не удалось запустить — сделай вручную: docker compose down && docker compose up -d"
    echo "  ✓ Готово"
else
    echo "  docker-compose.yml не найден. Добавь volume mount и перезапусти вручную:"
    echo "    volumes:"
    echo "      - ./index.html:/opt/app/frontend/index.html"
    echo "  docker compose down && docker compose up -d"
fi

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
    1)
        PRIMARY="#c084fc"; HOVER="#a78bfa"; BACKGROUND="#0a0812"; INFO="#c084fc"; THEME_COLOR="#c084fc"
        WARP_L1='                            [0.07, 0.07, 0.07],'
        WARP_L2='                            [0.58, 0.44, 1.0],'
        WARP_L3='                            [0.07, 0.07, 0.07],'
        WARP_L4='                            [0.53, 0.22, 1.0],'
        ;;
    2)
        PRIMARY="#e0e0e0"; HOVER="#c0c0c0"; BACKGROUND="#0a0a0a"; INFO="#9ca3af"; THEME_COLOR="#666666"
        WARP_L1='                            [0.02, 0.02, 0.02],'
        WARP_L2='                            [0.5, 0.5, 0.5],'
        WARP_L3='                            [0.02, 0.02, 0.02],'
        WARP_L4='                            [0.8, 0.8, 0.8],'
        ;;
    3)
        PRIMARY="#ff2d78"; HOVER="#ff6b9d"; BACKGROUND="#0a0515"; INFO="#00d4ff"; THEME_COLOR="#ff2d78"
        WARP_L1='                            [0.04, 0.02, 0.08],'
        WARP_L2='                            [1.0, 0.18, 0.47],'
        WARP_L3='                            [0.04, 0.02, 0.08],'
        WARP_L4='                            [0.0, 0.83, 1.0],'
        ;;
    4)
        PRIMARY="#34d399"; HOVER="#6ee7b7"; BACKGROUND="#050f0a"; INFO="#34d399"; THEME_COLOR="#34d399"
        WARP_L1='                            [0.02, 0.06, 0.03],'
        WARP_L2='                            [0.1, 0.9, 0.5],'
        WARP_L3='                            [0.02, 0.06, 0.03],'
        WARP_L4='                            [0.3, 1.0, 0.6],'
        ;;
    5)
        PRIMARY="#f59e0b"; HOVER="#fbbf24"; BACKGROUND="#0f0a05"; INFO="#f59e0b"; THEME_COLOR="#f59e0b"
        WARP_L1='                            [0.08, 0.04, 0.01],'
        WARP_L2='                            [1.0, 0.7, 0.1],'
        WARP_L3='                            [0.08, 0.04, 0.01],'
        WARP_L4='                            [1.0, 0.4, 0.1],'
        ;;
    6)
        PRIMARY="#60a5fa"; HOVER="#93bbfc"; BACKGROUND="#05080f"; INFO="#60a5fa"; THEME_COLOR="#60a5fa"
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

# ── Patch warp colors ────────────────────────────────────────────────────
sed -i '/                    colors: \[/,/                    \],/c\
                    colors: [\
'"$WARP_L1"'\
'"$WARP_L2"'\
'"$WARP_L3"'\
'"$WARP_L4"'\
                    ],' index.html

echo "  $MSG_OK"
echo ""

# ── Instructions ─────────────────────────────────────────────────────────
if [ "$L" = "ru" ]; then
    cat <<'INSTRU'
  ─── Дальнейшие действия ───

  1. Проверь volume mount в docker-compose.yml:

       volumes:
         - ./index.html:/opt/app/frontend/index.html

  2. Перезапусти контейнер:

       docker compose restart remnawave-subscription-page

INSTRU
else
    cat <<'INSTRU'
  ─── Next steps ───

  1. Verify volume mount in docker-compose.yml:

       volumes:
         - ./index.html:/opt/app/frontend/index.html

  2. Restart container:

       docker compose restart remnawave-subscription-page

INSTRU
fi

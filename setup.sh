#!/usr/bin/env bash
set -euo pipefail

# ═══════════════════════════════════════════════════════════════════════════
# Remna Reiwa Subpage — Setup Script
# ═══════════════════════════════════════════════════════════════════════════
# Usage:
#   bash setup.sh              # interactive prompts
#   bash setup.sh -t 3        # skip prompts, set theme directly
#   bash setup.sh -t 2 -l ru  # theme + language
#   bash setup.sh -t 1 -m light  # Purple light variant
#
# One-liner (download + run):
#   curl -L -s -O https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main/setup.sh && bash setup.sh -t 3
# ═══════════════════════════════════════════════════════════════════════════

REPO_URL="https://raw.githubusercontent.com/d3myasha/Remna-Reiwa-Subpage/main"

# ── Argument parsing ─────────────────────────────────────────────────────
THEME_ARG=""
LANG_ARG=""
MODE_ARG=""
while getopts "t:l:m:" opt; do
    case "$opt" in
        t) THEME_ARG="$OPTARG" ;;
        l) LANG_ARG="$OPTARG" ;;
        m) MODE_ARG="$OPTARG" ;;
        *) echo "Usage: bash setup.sh [-t theme(1-7)] [-m dark|light] [-l en|ru]"; exit 1 ;;
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
        "Blush — светло-розовый"
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
        "Blush (light pink)"
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
            1|2|3|4|5|6|7) break ;;
            *) echo "  $MSG_INVALID" ;;
        esac
    done
fi

# ── Appearance mode (dark / light) ───────────────────────────────────────
if [ "$MODE_ARG" = "light" ] || [ "$MODE_ARG" = "dark" ]; then
    MODE_CHOICE="$MODE_ARG"
elif [ -t 0 ]; then
    echo ""
    if [ "$L" = "ru" ]; then
        echo "  Режим оформления:"
        echo "    1) Тёмный"
        echo "    2) Светлый (белая вариация)"
        read -rp "  > " mode_pick
        [ "$mode_pick" = "2" ] && MODE_CHOICE="light" || MODE_CHOICE="dark"
    else
        echo "  Appearance mode:"
        echo "    1) Dark"
        echo "    2) Light (white variant)"
        read -rp "  > " mode_pick
        [ "$mode_pick" = "2" ] && MODE_CHOICE="light" || MODE_CHOICE="dark"
    fi
else
    MODE_CHOICE="dark"
fi

# ── Theme config ─────────────────────────────────────────────────────────
PRIMARY_TEXT="#0a0a0a"
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
    7) # Blush — soft light pink on dark rose-tinted base
        PRIMARY="#f9a8d4"; PRIMARY_RGB="249, 168, 212"; HOVER="#fbcfe8"; BACKGROUND="#10080c"; INFO="#f9a8d4"; THEME_COLOR="#f9a8d4"
        BG_GRADIENT_START="#2d1520"; BG_GRADIENT_MID="#12080c"; BG_GRADIENT_END="#080406"; BG_GLOW="rgba(var(--primary-rgb), 0.08)"
        C_BLUE="#93c5fd"; C_CYAN="#fda4af"; C_DARK="#1a0f14"; C_GRAPE="#f0abfc"; C_GRAY="#9ca3af"
        C_GREEN="#86efac"; C_INDIGO="#c4b5fd"; C_LIME="#fde68a"; C_ORANGE="#fdba74"; C_PINK="#f9a8d4"
        C_RED="#fca5a5"; C_TEAL="#fbcfe8"; C_VIOLET="#e879f9"; C_YELLOW="#fde68a"
        WARP_L1='                            [0.06, 0.03, 0.05],'
        WARP_L2='                            [0.98, 0.66, 0.83],'
        WARP_L3='                            [0.06, 0.03, 0.05],'
        WARP_L4='                            [0.85, 0.45, 0.65],'
        ;;
    *)
        echo "  $MSG_INVALID"
        exit 1
        ;;
esac

if [ "$MODE_CHOICE" = "light" ]; then
    PRIMARY_TEXT="#1e293b"
    case "$theme_choice" in
        1)
            PRIMARY="#c4b5fd"; PRIMARY_RGB="196, 181, 253"; HOVER="#a78bfa"; BACKGROUND="#faf8ff"; INFO="#a78bfa"; THEME_COLOR="#c4b5fd"
            BG_GRADIENT_START="#e9e0ff"; BG_GRADIENT_MID="#f5f0ff"; BG_GRADIENT_END="#ffffff"; BG_GLOW="rgba(var(--primary-rgb), 0.14)"
            C_BLUE="#93c5fd"; C_CYAN="#a5f3fc"; C_DARK="#e2e8f0"; C_GRAPE="#d8b4fe"; C_GRAY="#94a3b8"
            C_GREEN="#86efac"; C_INDIGO="#c7d2fe"; C_LIME="#d9f99d"; C_ORANGE="#fdba74"; C_PINK="#f9a8d4"
            C_RED="#fca5a5"; C_TEAL="#99f6e4"; C_VIOLET="#c4b5fd"; C_YELLOW="#fde68a"
            WARP_L1='                            [0.98, 0.96, 1.0],'
            WARP_L2='                            [0.82, 0.75, 0.98],'
            WARP_L3='                            [1.0, 0.99, 1.0],'
            WARP_L4='                            [0.88, 0.82, 1.0],'
            ;;
        2)
            PRIMARY="#d4d4d8"; PRIMARY_RGB="212, 212, 216"; HOVER="#a1a1aa"; BACKGROUND="#fafafa"; INFO="#a1a1aa"; THEME_COLOR="#d4d4d8"
            BG_GRADIENT_START="#e4e4e7"; BG_GRADIENT_MID="#f4f4f5"; BG_GRADIENT_END="#ffffff"; BG_GLOW="rgba(var(--primary-rgb), 0.10)"
            C_BLUE="#cbd5e1"; C_CYAN="#cbd5e1"; C_DARK="#e2e8f0"; C_GRAPE="#d4d4d8"; C_GRAY="#94a3b8"
            C_GREEN="#d4d4d8"; C_INDIGO="#cbd5e1"; C_LIME="#e4e4e7"; C_ORANGE="#d4d4d8"; C_PINK="#d4d4d8"
            C_RED="#fca5a5"; C_TEAL="#cbd5e1"; C_VIOLET="#d4d4d8"; C_YELLOW="#fde68a"
            WARP_L1='                            [0.97, 0.97, 0.98],'
            WARP_L2='                            [0.88, 0.88, 0.90],'
            WARP_L3='                            [1.0, 1.0, 1.0],'
            WARP_L4='                            [0.92, 0.92, 0.94],'
            ;;
        3)
            PRIMARY="#f9a8d4"; PRIMARY_RGB="249, 168, 212"; HOVER="#f472b6"; BACKGROUND="#fffafb"; INFO="#7dd3fc"; THEME_COLOR="#f9a8d4"
            BG_GRADIENT_START="#ffe4f0"; BG_GRADIENT_MID="#fff0f7"; BG_GRADIENT_END="#ffffff"; BG_GLOW="rgba(var(--primary-rgb), 0.12)"
            C_BLUE="#93c5fd"; C_CYAN="#a5f3fc"; C_DARK="#e2e8f0"; C_GRAPE="#f0abfc"; C_GRAY="#94a3b8"
            C_GREEN="#86efac"; C_INDIGO="#c4b5fd"; C_LIME="#d9f99d"; C_ORANGE="#fdba74"; C_PINK="#f9a8d4"
            C_RED="#fca5a5"; C_TEAL="#99f6e4"; C_VIOLET="#f9a8d4"; C_YELLOW="#fde68a"
            WARP_L1='                            [1.0, 0.97, 0.99],'
            WARP_L2='                            [0.98, 0.72, 0.86],'
            WARP_L3='                            [1.0, 0.99, 1.0],'
            WARP_L4='                            [0.75, 0.92, 0.98],'
            ;;
        4)
            PRIMARY="#6ee7b7"; PRIMARY_RGB="110, 231, 183"; HOVER="#34d399"; BACKGROUND="#f6fffb"; INFO="#5eead4"; THEME_COLOR="#6ee7b7"
            BG_GRADIENT_START="#ccfbf1"; BG_GRADIENT_MID="#ecfdf5"; BG_GRADIENT_END="#ffffff"; BG_GLOW="rgba(var(--primary-rgb), 0.12)"
            C_BLUE="#93c5fd"; C_CYAN="#a5f3fc"; C_DARK="#e2e8f0"; C_GRAPE="#bbf7d0"; C_GRAY="#94a3b8"
            C_GREEN="#6ee7b7"; C_INDIGO="#c7d2fe"; C_LIME="#d9f99d"; C_ORANGE="#fdba74"; C_PINK="#f9a8d4"
            C_RED="#fca5a5"; C_TEAL="#99f6e4"; C_VIOLET="#a7f3d0"; C_YELLOW="#fde68a"
            WARP_L1='                            [0.96, 1.0, 0.98],'
            WARP_L2='                            [0.65, 0.95, 0.82],'
            WARP_L3='                            [1.0, 1.0, 1.0],'
            WARP_L4='                            [0.78, 0.98, 0.88],'
            ;;
        5)
            PRIMARY="#fcd34d"; PRIMARY_RGB="252, 211, 77"; HOVER="#fbbf24"; BACKGROUND="#fffef8"; INFO="#fdba74"; THEME_COLOR="#fcd34d"
            BG_GRADIENT_START="#fef3c7"; BG_GRADIENT_MID="#fffbeb"; BG_GRADIENT_END="#ffffff"; BG_GLOW="rgba(var(--primary-rgb), 0.12)"
            C_BLUE="#93c5fd"; C_CYAN="#a5f3fc"; C_DARK="#e2e8f0"; C_GRAPE="#fde68a"; C_GRAY="#94a3b8"
            C_GREEN="#86efac"; C_INDIGO="#c7d2fe"; C_LIME="#fde68a"; C_ORANGE="#fdba74"; C_PINK="#f9a8d4"
            C_RED="#fca5a5"; C_TEAL="#99f6e4"; C_VIOLET="#fcd34d"; C_YELLOW="#fde68a"
            WARP_L1='                            [1.0, 0.99, 0.96],'
            WARP_L2='                            [0.98, 0.88, 0.55],'
            WARP_L3='                            [1.0, 1.0, 1.0],'
            WARP_L4='                            [0.98, 0.92, 0.70],'
            ;;
        6)
            PRIMARY="#93c5fd"; PRIMARY_RGB="147, 197, 253"; HOVER="#60a5fa"; BACKGROUND="#f8fbff"; INFO="#7dd3fc"; THEME_COLOR="#93c5fd"
            BG_GRADIENT_START="#dbeafe"; BG_GRADIENT_MID="#eff6ff"; BG_GRADIENT_END="#ffffff"; BG_GLOW="rgba(var(--primary-rgb), 0.12)"
            C_BLUE="#93c5fd"; C_CYAN="#a5f3fc"; C_DARK="#e2e8f0"; C_GRAPE="#c7d2fe"; C_GRAY="#94a3b8"
            C_GREEN="#86efac"; C_INDIGO="#a5b4fc"; C_LIME="#d9f99d"; C_ORANGE="#fdba74"; C_PINK="#f9a8d4"
            C_RED="#fca5a5"; C_TEAL="#99f6e4"; C_VIOLET="#93c5fd"; C_YELLOW="#fde68a"
            WARP_L1='                            [0.96, 0.98, 1.0],'
            WARP_L2='                            [0.70, 0.85, 0.98],'
            WARP_L3='                            [1.0, 1.0, 1.0],'
            WARP_L4='                            [0.82, 0.92, 1.0],'
            ;;
        7)
            PRIMARY="#fbcfe8"; PRIMARY_RGB="251, 207, 232"; HOVER="#f9a8d4"; BACKGROUND="#fffbfd"; INFO="#f9a8d4"; THEME_COLOR="#fbcfe8"
            BG_GRADIENT_START="#fce7f3"; BG_GRADIENT_MID="#fdf2f8"; BG_GRADIENT_END="#ffffff"; BG_GLOW="rgba(var(--primary-rgb), 0.14)"
            C_BLUE="#93c5fd"; C_CYAN="#fda4af"; C_DARK="#e2e8f0"; C_GRAPE="#f5d0fe"; C_GRAY="#94a3b8"
            C_GREEN="#86efac"; C_INDIGO="#ddd6fe"; C_LIME="#fde68a"; C_ORANGE="#fdba74"; C_PINK="#fbcfe8"
            C_RED="#fca5a5"; C_TEAL="#fbcfe8"; C_VIOLET="#f0abfc"; C_YELLOW="#fde68a"
            WARP_L1='                            [1.0, 0.98, 0.99],'
            WARP_L2='                            [0.98, 0.78, 0.90],'
            WARP_L3='                            [1.0, 1.0, 1.0],'
            WARP_L4='                            [0.95, 0.72, 0.85],'
            ;;
    esac
fi

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
sed -i "s/--primary-text: #[0-9a-fA-F]*/--primary-text: $PRIMARY_TEXT/" index.html
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

if [ "$MODE_CHOICE" = "light" ]; then
    sed -i "s/document.documentElement.classList.add('dark-theme');/document.documentElement.classList.add('light-theme');/" index.html
else
    sed -i "s/document.documentElement.classList.add('light-theme');/document.documentElement.classList.add('dark-theme');/" index.html
fi

echo "  $MSG_OK"

# ── Docker compose: add volume & restart ────────────────────────────
# wrap in || true to prevent set -e from silently exiting
(
if [ -f docker-compose.yml ]; then DC="docker-compose.yml"
elif [ -f compose.yml ]; then DC="compose.yml"
else DC=""; fi

if [ -n "$DC" ]; then
    if ! grep -q 'index.html:/opt/app/frontend/index.html' "$DC" 2>/dev/null; then
        # Находим первый сервис и его отступ (ищем ключи с отступом >= 2)
        FIRST_SERVICE=$(grep -n '^[[:space:]]\{2,\}[a-zA-Z0-9_-]\+:' "$DC" 2>/dev/null | head -1)
        SERVICE_LINE=$(echo "$FIRST_SERVICE" | cut -d: -f1)
        SERVICE_INDENT=$(echo "$FIRST_SERVICE" | grep -oP '^[[:space:]]*(?=[a-zA-Z0-9_-]+:)' | wc -c)
        SERVICE_INDENT=$((SERVICE_INDENT - 1))
        [ "$SERVICE_INDENT" -lt 0 ] && SERVICE_INDENT=0

        # Находим отступ свойств внутри сервиса (первая строка вида "        image:" после сервиса)
        PROP_INDENT=0
        if [ -n "$SERVICE_LINE" ]; then
            # Берём первую строку со свойством (image:, container_name:, etc) и извлекаем её отступ
            PROP_LINE=$(sed -n "$((SERVICE_LINE+1)),\$p" "$DC" | grep -m1 '^[[:space:]]\{'"$((SERVICE_INDENT+2))"',\}[a-z_-]\+:')
            if [ -n "$PROP_LINE" ]; then
                PROP_INDENT=$(echo "$PROP_LINE" | sed 's/^\([[:space:]]*\).*/\1/' | wc -c)
                PROP_INDENT=$((PROP_INDENT - 1))
            fi
        fi
        [ "$PROP_INDENT" -lt 2 ] && PROP_INDENT=$((SERVICE_INDENT + 4))

        VOL_INDENT=$(printf '%*s' "$PROP_INDENT" '')
        VOL_ITEM_INDENT=$(printf '%*s' $((PROP_INDENT + 2)) '')

        if [ -n "$SERVICE_LINE" ]; then
            NEXT_SERVICE=$(grep -n '^[[:space:]]\{2,\}[a-zA-Z0-9_-]\+:' "$DC" 2>/dev/null | sed -n "2p" | cut -d: -f1)
            [ -z "$NEXT_SERVICE" ] && NEXT_SERVICE=$(wc -l < "$DC")

            # Ищем volumes между SERVICE_LINE и NEXT_SERVICE
            VOLUMES_LINE=$(sed -n "${SERVICE_LINE},${NEXT_SERVICE}p" "$DC" | grep -n "^${VOL_INDENT}volumes:" | head -1 | cut -d: -f1)

            if [ -n "$VOLUMES_LINE" ]; then
                # volumes уже есть — добавляем в конец блока
                ACTUAL_VOLUMES_LINE=$((SERVICE_LINE + VOLUMES_LINE - 1))

                # Ищем следующую строку с таким же отступом как volumes
                LAST_VOLUME_LINE=$(awk -v start="$ACTUAL_VOLUMES_LINE" -v indent="$VOL_INDENT" 'NR > start && $0 ~ "^" indent "[a-z_-]+:" {print NR; exit}' "$DC")
                [ -z "$LAST_VOLUME_LINE" ] && LAST_VOLUME_LINE=$(awk -v start="$ACTUAL_VOLUMES_LINE" -v indent="$VOL_INDENT" 'NR > start && length($0) > 0 && !/^[[:space:]]/ {print NR-1; exit}' "$DC")
                [ -z "$LAST_VOLUME_LINE" ] && LAST_VOLUME_LINE=$(wc -l < "$DC")

                awk -v line="$LAST_VOLUME_LINE" -v vol="$VOL_ITEM_INDENT- ./index.html:/opt/app/frontend/index.html" 'NR==line {print; print vol; next} 1' "$DC" > "${DC}.tmp" && mv "${DC}.tmp" "$DC"
                echo "  → Volume mount добавлен в существующий блок volumes"
            else
                # volumes нет — создаём новый блок после SERVICE_LINE
                awk -v line="$SERVICE_LINE" -v vol1="${VOL_INDENT}volumes:" -v vol2="${VOL_ITEM_INDENT}- ./index.html:/opt/app/frontend/index.html" 'NR==line {print; print vol1; print vol2; next} 1' "$DC" > "${DC}.tmp" && mv "${DC}.tmp" "$DC"
                echo "  → Создан новый блок volumes с mount point"
            fi
        fi
    fi

    if [ -n "$THEME_ARG" ]; then
        echo "  → Перезапускаю контейнер..."
        docker compose down --remove-orphans 2>/dev/null || true
        docker compose up -d 2>/dev/null || true
        echo "  ✓ Контейнер перезапущен"
    else
        if [ "$L" = "ru" ]; then
            echo "  Хочешь перезапустить контейнер сейчас?"
            read -rp "  Добавить volume и перезапустить? [Y/n]: " restart_choice
        else
            echo "  Restart container now?"
            read -rp "  Add volume and restart? [Y/n]: " restart_choice
        fi
        case "$restart_choice" in
            n|N|no|No) echo "  → Добавь volume и перезапусти вручную: docker compose restart" ;;
            *) echo "  → Перезапускаю контейнер..."
               docker compose down --remove-orphans 2>/dev/null || true
               docker compose up -d 2>/dev/null || true
               echo "  ✓ Контейнер перезапущен" ;;
        esac
    fi
else
    echo "  docker-compose.yml не найден."
    if [ "$L" = "ru" ]; then
        echo "  Добавь volume mount в docker-compose.yml и перезапусти:"
    else
        echo "  Add volume mount and restart manually:"
    fi
    echo "    volumes:"
    echo "      - ./index.html:/opt/app/frontend/index.html"
    echo "  docker compose down && docker compose up -d"
fi
) || true

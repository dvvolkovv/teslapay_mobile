# TeslaPay Flutter — Full Design Plan

Figma file: `sYi0aKvAv8uvKMqJEgDSd3`
Total Figma: 34 sections, 630 frames
Project: `/Users/dmitry/teslapay_pin/`

---

## ✅ Already Implemented

| Screen | File | Status |
|--------|------|--------|
| Splash (yellow, logo+animation) | `screens/splash_screen.dart` | ✅ |
| Phone input + Country picker | `screens/phone_screen.dart` | ✅ |
| OTP verification | `screens/otp_screen.dart` | ✅ |
| PIN entry (5-digit keypad) | `screens/pin_screen.dart` | ✅ |

---

## Parallel Subagent Work Units

### Agent 1 — Navigation & App Shell
**Priority: HIGH — blocks all other agents**

Tasks:
- Create `lib/navigation/app_router.dart` — named routes, route guards
- Create `lib/models/` — User, Card, Transaction, Account data models
- Create `lib/theme/app_theme.dart` — color tokens, text styles, shared widgets
- Create `lib/widgets/` — AppBar, BottomNav, LoadingOverlay, ConfirmSheet

Figma refs:
- `9089:51562` — "Main" review frame (full app layout)
- `9089:52001` — "Profile" review frame

---

### Agent 2 — Main Dashboard
**Figma section: "Активный аккаунт" + "Стартовый экран"**

Screens:
- `screens/main/home_screen.dart` — balance, card, send/receive buttons, recent activity
- `screens/main/home_scroll_screen.dart` — scrollable variant
- `screens/main/select_period_screen.dart` — date range picker
- `screens/main/euro_account_screen.dart` — euro balance view
- `screens/main/activity_screen.dart` — transaction history list
- `screens/main/new_user_main_screen.dart` — empty state for new users

Figma refs:
- `6178:45722` — Main
- `5137:45201` — Main scroll
- `5137:45332` — Main select period
- `5286:22487` — Main/Euro account
- `6237:47393` — Activity View
- `5137:37515` — New user (Euro)
- `5284:23607` — New user (Main)
- `5286:21577` — Existing user (full scroll)

---

### Agent 3 — Send Flows
**Figma sections: All "Отправка Send …" sections**

Screens:
- `screens/send/send_menu_screen.dart` — send method picker
- `screens/send/teslapay_send_screen.dart` — TeslaPay client recipient search
- `screens/send/teslapay_amount_screen.dart` — amount entry
- `screens/send/teslapay_confirm_screen.dart` — confirm sending
- `screens/send/mastercard_send_screen.dart` — Mastercard number entry + confirm
- `screens/send/sepa_personal_screen.dart` — SEPA personal form
- `screens/send/sepa_corporate_screen.dart` — SEPA corporate form
- `screens/send/swift_personal_screen.dart` — SWIFT personal form
- `screens/send/swift_corporate_screen.dart` — SWIFT corporate form
- `screens/send/qr_scan_screen.dart` — QR code scanner

Figma refs:
- `6128:42014` → `5140:32515` → `5503:29477` — TeslaPay flow
- `5140:35340` → `5503:30383` — Mastercard
- `5462:19884` — SEPA personal
- `5463:20785` — SEPA corporate
- `5435:28186` — SWIFT personal
- `5435:31450` — SWIFT corporate
- `5140:37675` / `6209:45216` — QR scan

---

### Agent 4 — Receive Flows
**Figma sections: All "Получение …" sections**

Screens:
- `screens/receive/receive_menu_screen.dart` — receive method picker
- `screens/receive/banking_card_screen.dart` — card number to receive
- `screens/receive/qr_receive_screen.dart` — display QR code
- `screens/receive/sepa_receive_screen.dart` — SEPA receive details (IBAN, BIC)
- `screens/receive/swift_receive_screen.dart` — SWIFT receive details

Figma refs:
- `6128:43090` → `5140:54702` — Banking card receive
- `6128:43293` → `5502:22322` — QR receive
- `6128:43523` → `5503:20354` — SEPA receive
- `6128:43408` → `5502:22848` — SWIFT receive

---

### Agent 5 — Card Management
**Figma sections: "Информация о карте", "Заморозка карты", "Настройки карты", "Смена пин-кода", "Перевыпуск карты …"**

Screens:
- `screens/card/card_info_screen.dart` — full card details (number, expiry, cvv)
- `screens/card/card_freeze_screen.dart` — freeze/unfreeze toggle + PIN confirm
- `screens/card/card_settings_screen.dart` — card settings menu
- `screens/card/card_pin_change_screen.dart` — change card PIN
- `screens/card/card_reissue_virtual_screen.dart` — virtual card reissue flow
- `screens/card/card_reissue_physical_screen.dart` — physical card delivery address
- `screens/card/card_reissue_confirm_screen.dart` — reissue confirmation
- `screens/card/card_reissue_success_screen.dart` — success state

Figma refs:
- `5963:41600` — Card info
- `5823:40043` → `5823:41754` — Card freeze + PIN
- `8425:88050` — Card settings
- `5823:34796` — PIN change
- `8493:80314` → `8493:81081` → `8493:82932` — Virtual reissue
- `8316:67246` — Physical reissue
- `8493:47270` → `8493:47477` → `8493:47757` — Physical delivery

---

### Agent 6 — Profile & Settings
**Figma sections: All "Профиль/…" sections**

Screens:
- `screens/profile/profile_screen.dart` — main profile page (avatar, info, menu)
- `screens/profile/personal_info_screen.dart` — personal info list
- `screens/profile/change_name_screen.dart`
- `screens/profile/change_birthday_screen.dart`
- `screens/profile/change_address_screen.dart`
- `screens/profile/change_email_screen.dart`
- `screens/profile/security_screen.dart` — security settings
- `screens/profile/change_password_screen.dart`
- `screens/profile/change_password_success_screen.dart`
- `screens/profile/reset_transaction_pin_screen.dart`
- `screens/profile/change_theme_screen.dart` — light/dark theme picker

Figma refs:
- `9089:52001` — Profile review
- `6127:44369` — Name change
- `6127:46525` — Birthday change
- `6127:48711` — Address change
- `6127:50621` — Email change
- `6127:40893` / `6127:40940` — Password change
- `6127:43438` / `6127:43603` — Security + PIN reset
- `6080:48620` / `6064:67706` — Theme

---

### Agent 7 — Auth Flows (Extension)
**Figma sections: "Вход", "Востановление пароля"**

Screens:
- `screens/auth/login_screen.dart` — existing user login (phone + password variant)
- `screens/auth/password_recovery_screen.dart` — forgot password flow

Figma refs:
- `5206:31195` / `5206:31224` — Login variants
- `5229:21438` → `5206:29269` — Password recovery

---

## Shared Resources (All agents need)

```
lib/
├── theme/
│   ├── colors.dart          # Color(0xFFFFBA08), etc.
│   └── text_styles.dart     # Poppins variants
├── widgets/
│   ├── app_button.dart      # Yellow CONTINUE button
│   ├── app_text_field.dart  # Rounded input field
│   ├── loading_overlay.dart
│   └── bottom_nav.dart
├── models/
│   ├── user.dart
│   ├── card.dart
│   └── transaction.dart
└── navigation/
    └── app_router.dart
```

---

## Key Design Tokens

| Token | Value |
|-------|-------|
| Primary | `#FFBA08` |
| Background | `#F2F5F7` |
| Dark text | `#151515` |
| White text | `#F0EFEC` |
| Secondary text | `#858585` |
| Border/divider | `#A5B1BC` |
| Input bg | `#EBEFF2` |
| Error | `#FF536F` |
| Success | `#4CAF50` |
| Dark overlay | `#2C2B2B` |
| Font | Poppins (google_fonts) |
| Corner radius | 24px (inputs), 50px (buttons), 16px (cards) |

---

## Launch Order

```
Phase 1 (parallel):    Agent 1 (Shell) + existing auth screens
Phase 2 (parallel):    Agents 2, 3, 4, 5, 6, 7
Phase 3:               Integration, navigation wiring, testing
```

Total estimated screens: **~60 screens** across 7 parallel work streams.

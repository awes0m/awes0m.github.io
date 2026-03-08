# Som — Dev Portfolio

![App Logo](https://raw.githubusercontent.com/awes0m/awes0m.github.io/refs/heads/main/som_devprofile/assets/icon/som_app_icon.png)

A responsive Flutter portfolio app for **Som Subhra Pandit** — Senior Cloud Security Analyst, Cybersecurity Professional, and Flutter/Node.js Developer.

Live at 👉 **[awes0m.github.io](https://awes0m.github.io)**

---

## Layout

The app uses a **sidebar + content card** single-page design:

- **Left Sidebar** — Profile photo, animated designation, contact info (email / location), social links, Resume download, and theme toggle
- **Right Content Card** — Tab navigation bar in the header, with animated content switching between:
  - **About** · **What I Do** · **Education** · **Experience** · **Projects** · **Certifications** · **Contact**
- **Mobile** — Stacked layout: collapsible sidebar header on top, content card in the middle, scrollable tab bar at the bottom

All content is loaded from `assets/portfolio.json` — edit that file to update your profile without touching any Dart code.

---

## Stack

| | |
|---|---|
| Framework | Flutter (Dart) |
| Target | Web (primary), Android, Windows |
| Fonts | Google Fonts — Nova Mono |
| Theming | Dark / Light mode toggle |
| Content | `assets/portfolio.json` |

---

## Requirements

- Flutter SDK **stable channel** (3.x+)
- For web: Chrome or any Chromium-based browser
- Run `flutter --version` to verify your setup

---

## Run locally

```powershell
# Clone
git clone https://github.com/awes0m/awes0m.github.io.git
cd awes0m.github.io\som_devprofile

# Install dependencies
flutter pub get

# Dev server (hot reload enabled)
flutter run -d web-server --web-port 8765
# then open http://localhost:8765 in your browser

# Or launch directly in Chrome
flutter run -d chrome
```

---

## Build for production

```powershell
# Web release build → output in build/web/
flutter build web --release

# Android APK
flutter build apk --release

# Windows desktop
flutter build windows --release
```

---

## Customise content

Edit **`assets/portfolio.json`** — no Dart code changes needed:

| Key | What it controls |
|---|---|
| `name_and_link` | Your name and GitHub URL |
| `designation` | Rotating job title chips in sidebar |
| `resume_download_link` | URL for the Resume button |
| `social_media` | Social / contact icon links |
| `contact_me` | Location, availability |
| `about` | Bio text shown in the About tab |
| `what_i_do` | Skills proficiency bars + tool logos |
| `education` | Education cards |
| `experience` | Experience cards |
| `projects` | Project cards (with optional README link) |
| `achievements` | Certifications cards |

---

## Project structure

```
lib/
├── main.dart                  # Entry point + theme provider
├── app.dart                   # PortfolioShell (sidebar + content layout)
├── src/
│   ├── sidebar/
│   │   └── sidebar_card.dart  # Left sidebar widget
│   ├── content/
│   │   ├── content_card.dart  # Right content card + AnimatedSwitcher
│   │   └── about_tab.dart     # About tab content
│   ├── navigation/
│   │   └── tab_nav_bar.dart   # Unified desktop/mobile tab nav
│   └── ...                    # Per-tab widgets (education, experience, etc.)
├── tabs/                      # Full-page tab widgets
└── theme/                     # Dark/light theme config
assets/
├── portfolio.json             # All profile content
├── contact_me/                # Profile photo
├── home/constant/             # Social media icons
└── what_i_do/                 # Tool logos
```

---

## Development tips

- Hot restart (`R` in terminal) after editing Dart files
- `portfolio.json` changes take effect on next app load (no hot reload needed for assets)
- Run `flutter analyze` before committing — no warnings expected
- Use `flutter build web --release` to validate the production bundle

---

## License

MIT — see `LICENSE` at the repo root.
Assets and fonts used are credited in their respective directories and `pubspec.yaml`.

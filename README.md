# JEE OneShot OS 4.0.0

A clean rebuild of the JEE OneShot tracker for desktop browsers and Android (Capacitor). The interface uses the chapter labels supplied by the user; the JSON stores only chapter IDs, the supplied labels, and the matching lecture URLs—not the playlist video titles.

## What is included

- Preloaded syllabus: Physics (43 chapters), Chemistry (37), Maths (35); 115 chapters total.
- Daily rotation starts **13 October 2026**: Physics → Chemistry → Maths → repeat. One topic is assigned per calendar day, with no rest days. Once a subject's list is exhausted, the remaining subjects continue without empty dates.
- Chapter workflow: **Lecture complete** and **Question practice**. Each checkbox stores a date-time timestamp. No revision queue and no tests.
- Editable chapter names, reordering, optional lecture URL editing, chapter notes, adding/deleting chapters, and custom subjects.
- Dashboard, monthly schedule, chapter browser, subject-level progress, live clock, dark/light themes, and JSON backup/restore.
- Local-first saves; state is saved in local storage before cloud synchronization. Optional Supabase email/password sign-in enables cloud sync between devices. Offline edits remain locally saved and sync is attempted when the connection returns.
- Mobile-responsive web UI and a Capacitor Android build workflow.

## Run on Windows PC

1. Install Node.js 22 or newer.
2. Extract this folder.
3. Double-click `start.bat`. It opens `http://127.0.0.1:3001`.
4. Keep the small server window running while using the web app.

You can also run `npm start` from a terminal, then open `http://127.0.0.1:3001`.

## Supabase

This project is configured to use the linked Supabase project and the `public.jee_one_shot_os_state` table. Row Level Security restricts each row to the signed-in user's own `user_id`. The schema migration for this table has been applied to the linked project. `SUPABASE-SETUP.sql` is included for setting up an equivalent table in another Supabase project. Never place a service-role key in the web or Android client.

To enable cloud sync, open **Settings & Sync**, create an account or sign in. If email confirmation is enabled in Supabase Auth, confirm your email before signing in. Without signing in, local/offline progress still works.

## Build Android APK

### Recommended: GitHub Actions

1. Create a GitHub repository and upload the *contents of this folder* to the repository root (so `package.json`, `index.html`, `app.js`, `one-shots.json`, and `capacitor.config.json` are at the root).
2. Push to `main`, or open **Actions → Build JEE OneShot OS APK → Run workflow**.
3. Download the `JEE-OneShot-OS-4.0.0-debug-apk` artifact from the successful run. It contains `app-debug.apk`.

### Local Android build

Install Node.js 22+, Java 21, Android SDK Platform 36 and Build Tools 36.0.0, then run `android-build.bat`. The APK path after a successful build is `android/app/build/outputs/apk/debug/app-debug.apk`.

## Data model / schedule notes

`one-shots.json` contains display labels and URL mappings. Subject and chapter ordering drive the daily schedule. Reordering, adding, removing, or renaming content changes the current schedule sequence. Existing completion timestamps remain attached to chapter IDs when a label or position is changed.

## Version

`4.0.0` — clean UI rebuild, custom editable syllabus, alternating daily schedule, lecture/practice timestamps, local-first sync, and Android workflow.

# Build audit — JEE OneShot OS 4.0.0

- [x] Exact supplied chapter labels loaded into the app; no playlist video titles are included in `one-shots.json`.
- [x] Physics 43 + Chemistry 37 + Maths 35 = 115 supplied chapters.
- [x] Plan start anchored to 2026-10-13.
- [x] Static daily sequence interleaves subjects and skips a subject only after all chapters for that subject are assigned.
- [x] Revision UI/logic and test UI/logic removed; chapter workflow is Lecture + Question practice only.
- [x] Completion actions store ISO date-time timestamps, locally first.
- [x] Subject/chapter labels, subject order, chapter order, URL, and notes are editable; custom subjects/chapters supported.
- [x] Supabase uses a publishable key, per-user state table, RLS policies and authenticated-only CRUD grants.
- [x] Offline local storage and backup/import/export included.
- [x] Responsive desktop/mobile UI, live clock and dark/light theme included.
- [x] Capacitor and GitHub Actions APK build workflow included; workflow explicitly installs Android API 36 and Build Tools 36.0.0 (Capacitor 8 default compile SDK).
- [ ] APK binary not generated in this environment; run the provided GitHub Actions workflow or `android-build.bat` in an Android SDK environment.

## Source mapping

The three uploaded JSON files each contained one record per topic (43/37/35). Each URL was paired by its source-list order to the corresponding chapter topic and stored beside the **user-supplied display label**. The source playlist titles are intentionally not copied into the deliverable.

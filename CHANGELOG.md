# Changelog

All notable user-visible changes to the Jackett TOS application package.

## 0.24.3055-1 — 2026-11-14

### Changed
- Upgraded to `linuxserver/jackett:v0.24.3055-ls35` (latest stable
  LinuxServer.io build).
- Added `PRIVACY.md`, linked from the package `help` field: Jackett contacts only
  the indexer sites the user configures, sends no telemetry, and stores
  everything under `DockerAppData/jackettdocker`.
- Added the requested `webui.bz2` front-end bundle (a tiny HTML redirect to the
  Jackett UI on port 8019). `TOSAppSelfTestingTool` accepts it with a D20
  "extra top-level entry" warning; the four core files are unchanged.

### Fixed (review remediation)
- **C3**: privacy policy added.
- **C5**: the policy is public and linked from `help`.
- **F22**: `webui.bz2` front-end bundle now included.

### Architectures
- x86_64: `jackettdocker_x86_64.tar.gz` (17511 B,
  `38054b0f989d34941bdd1e5ba5c46d58525a05b249552ce7dda4721d53c7b619`)
- aarch64: `jackettdocker_aarch64.tar.gz` (17513 B,
  `47e2f7097c653f9037c83261c526a5a411baaefb8d41f62ab972dd9a7748fc4d`)
- x86_64 full on-device E2E; aarch64 passes the official check (with the D20
  webui warning) and the platform validation.

## 0.24.3030-1 — 2026-11-08

### Added
- First release. Jackett (`linuxserver/jackett:v0.24.3030-ls30`, Docker Hub official image, unmodified)
  packaged as a TOS 7 Docker application, published on port 8019 and running
  as a non-root user (1000:1000).
- Persistent data is kept under `/Volume1/DockerAppData/jackettdocker/`.

### Architectures
- Dual-architecture release: `jackettdocker_x86_64.tar.gz` (16953 B, `a73c2ec76d250a2b6d2cd39df3ba72f7acdaf9b56a05f206881daf09a17d26b4`) and
  `jackettdocker_aarch64.tar.gz` (16954 B, `6e8d3572730179c804301fadaff6109b68cedf7246c4781cf73055b44f8dcdcd`), built by `scripts/build-dual.sh`.
  x86_64 has the full on-device E2E; aarch64 passes the official check and the
  platform validation (no ARM host available for a container E2E).

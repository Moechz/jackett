# Changelog

All notable user-visible changes to the Jackett TOS application package.

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

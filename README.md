# jackett-for-tos

> TerraMaster TOS 7 App Center — **Docker application** package for
> [Jackett](https://github.com/linuxserver/docker-jackett).

## What this is

A four-file TOS Docker application archive (`jackettdocker.tar.gz`) that installs
Jackett on TOS 7 through the App Center:

- `config.ini` — TOS application metadata (`application_type: docker`, id `jackettdocker`)
- `jackettdocker.lang` — 23-language superset (TOS requires 14)
- `jackettdocker.svg` — application icon (16928 bytes, 1 SVG elements)
- `docker-compose.yml` — one service, image `linuxserver/jackett:v0.24.3030-ls30`

## How it works

| | |
|---|---|
| Container image | `linuxserver/jackett:v0.24.3030-ls30` (Docker Hub, used unmodified) |
| Open | `http://<NAS-IP>:8019/` (container port 9117) |
| Runs as | non-root, `user: "1000:1000"` |
| Persistent data | `/config` → `/Volume1/DockerAppData/jackettdocker/config` |
| Logs | `docker logs jackettdocker` (stdout/stderr) |

`config` holds `Jackett/ServerConfig.json`, the indexer definitions and logs; copying it is a complete backup.

## Design highlights

- **Non-root.** `user: "1000:1000"`; verified on real hardware (the container reports uid 1000).
- **Fixed image tag, never `:latest`**, Docker Hub only, no `privileged`, no `network_mode: host`, and no Docker socket, no `cap_add`.
- **Health check** probing the service on container port 9117.
- **Deterministic build**: GNU tar with uid/gid 0 and zeroed timestamps, gzip without a timestamp, plus the review-standards self-check above.
- **Runs as a non-root container.** Verified on real hardware as uid 1000.
- **One volume.** All configuration, indexer definitions and logs live below `/config`.
- **Health check** probes the web UI on container port 9117 (it answers with a redirect).
- **Fixed image tag, never `:latest`**, Docker Hub only, no `privileged`, no `network_mode: host`, no Docker socket, no `cap_add`.

## Runtime file manifest

Everything the application writes on the NAS lives inside its own data
directory; the container-internal `/tmp` is discarded with the container. The
table lists what is created and how it behaves. Nothing else is written.

| Path | Purpose | Created when | Growth bound | Lifecycle |
|---|---|---|---|---|
| `config/Jackett/ServerConfig.json` | indexer definitions, API key and UI settings | first start | grows with indexers | never overwritten; back it up |
| `/Volume1/DockerAppData/jackettdocker/config` | Jackett application data (everything the container writes outside /tmp) | on first start / on demand | bounded by your own data | persistent; kept on uninstall unless you ask to delete it |

## Architectures

The TOS store takes one package per architecture. This release provides both,
built from the same sources by `scripts/build-dual.sh`:

| Architecture | Package | Size | SHA-256 |
|---|---|---|---|
| x86_64 | `jackettdocker_x86_64.tar.gz` | 16953 B | `a73c2ec76d250a2b6d2cd39df3ba72f7acdaf9b56a05f206881daf09a17d26b4` |
| aarch64 | `jackettdocker_aarch64.tar.gz` | 16954 B | `6e8d3572730179c804301fadaff6109b68cedf7246c4781cf73055b44f8dcdcd` |

The x86_64 package was verified with the full on-device E2E; the aarch64 package
passes the official `TOSAppSelfTestingTool -c` check and the developer platform's
automated validation (no ARM host was available for a container E2E).

## Build

```bash
scripts/build.sh                  # -> out/jackettdocker.tar.gz + .sha256
scripts/build.sh 0.24.3030-2   # packaging iteration bump
scripts/build.sh 0.24.3030-1 aarch64
```

The build stages the four files, substitutes the version/platform placeholders,
removes CRLF/BOM/AppleDouble, then runs
`tools/verify.py`, a review-standards self-check (archive layout, JSON validity,
required fields, 14+ language coverage, version consistency, Docker-Hub-only
images, fixed tag, reserved/recommended host ports, non-root user, per-service
healthcheck/TZ/restart, data path below the application data root, never the
`/Volume*` wildcard, comment-free sequence blocks, `x-app-meta` position, no
literal secrets and the SVG size/element limits).

## Local verification

```bash
./TOSAppSelfTestingTool -c out/jackettdocker.tar.gz   # official spec check
bash test/install-and-verify.sh                  # on-device E2E (needs root)
```

> Docker applications cannot be side-loaded through the App Center's manual
> install page (it accepts `.deb` only); the official self-testing tool's `-i`
> mode or `docker compose` are the only ways to install one for testing.

## Store submission checklist

1. Public GitHub repo (code + README only).
2. Release **tag `v0.24.3030-1`**, assets `jackettdocker.tar.gz` +
   `jackettdocker.tar.gz.sha256` (Docker asset naming: `<app_id>.tar.gz`, **no
   platform suffix**).
3. Developer platform → Add Application: ID `jackettdocker`, package type Docker,
   repository URL, architecture `x86_64`.
4. Version Management → Add Version `0.24.3030-1` → automated validation → review.

## License / branding

Jackett is distributed by its upstream authors under **GPL-3.0-only**. The container image is the official image from Docker Hub (`linuxserver/jackett:v0.24.3030-ls30`) and is used unmodified; no upstream source code is redistributed here. This packaging is an independent community submission by Moechz and is not affiliated with the upstream project or TerraMaster.

## Limitations

No trackers are included; you add the indexers you have access to.
Jackett does not download media; it only provides search results to a media manager.
The page is plain HTTP on the LAN; use a TLS reverse proxy before exposing it to the internet.
Docker applications cannot be upgraded in place in the App Center: updating means uninstalling and reinstalling, which keeps the data folder.

---

Packaged for TOS 7 by Moechz. Upstream image used unmodified from Docker Hub.

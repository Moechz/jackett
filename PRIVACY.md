# Privacy Policy — Jackett for TOS 7

Last updated: 2026-11-14

This policy covers the TOS application package `jackettdocker` (this repository)
and the local Jackett instance it runs on your TerraMaster NAS.

## What data the app handles

- Jackett configuration, indexer definitions and the Torznab API key.
- Credentials or cookies for the indexer sites that **you** add in Jackett.
- Logs created by Jackett.

All of it is stored on your NAS, under
`/Volume1/DockerAppData/jackettdocker/`, readable only by the application user
(uid 1000).

## Network connections

- Jackett contacts the indexer sites that you configure, in order to run the
  searches requested by your media manager. The destinations are chosen by you;
  there is no fixed transfer region.
- Jackett may check GitHub for its own updates; this is upstream behaviour and
  can be disabled in Jackett's settings.
- The package itself sends no telemetry, analytics or usage data to Moechz,
  TerraMaster, LinuxServer.io or any third party.
- The web interface is served over plain HTTP on your local network.

## Data sharing

- No data is sold or shared by this package.
- The indexer sites you configure are independent services under their own
  policies; Jackett sends them the search queries and the credentials needed to
  access them. Jackett does not send your library or history to the developer.
- The package does not include or preconfigure any indexer site.

## Retention and deletion

- Data stays on the NAS until you delete
  `/Volume1/DockerAppData/jackettdocker/` or uninstall the application with data
  removal in the TOS App Center.
- Uninstalling without data removal keeps the folder so a later reinstall can
  reuse the settings and indexers.

## Your rights

You can view and edit your indexers in the Jackett UI, export the configuration
by copying the config folder, and delete it as described above. Because the app
runs entirely on your NAS, the developer does not hold a copy of your data.

## Contact

- Package issues: <https://github.com/Moechz/jackett/issues>
- Upstream project: <https://github.com/Jackett/Jackett>
- Upstream image: <https://github.com/linuxserver/docker-jackett>

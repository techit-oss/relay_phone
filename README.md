# Relay Phone

Relay is a free, open-source, modular FiveM phone resource. Milestone 1 establishes the resource foundation, framework bridge boundary, persistent phone identity storage, and a React/TypeScript NUI shell.

## Status

This repository currently contains the foundation only:

- FiveM resource manifest and configuration
- Qbox reference bridge
- QBCore, ESX, and standalone bridge skeletons
- Server-side phone identity service backed by oxmysql
- React + TypeScript + Vite NUI
- Home, Phone, Contacts, Messages, and Settings app shells

Banking, housing, marketplace, social media, and advanced call flows are intentionally out of scope for this milestone.

## Requirements

- FiveM server artifact with Lua 5.4 support
- `ox_lib`
- `oxmysql`
- A MySQL or MariaDB database configured for oxmysql
- Node.js for NUI development builds

Qbox is the reference framework bridge. QBCore, ESX, and standalone bridges exist behind the same Relay bridge interface and should be expanded without touching core phone apps.

## Installation

1. Place this folder in your server resources as `relay_phone`.
2. Import `sql/001_create_phone_identities.sql` into your database.
3. Ensure dependencies start before Relay:

   ```cfg
   ensure oxmysql
   ensure ox_lib
   ensure qbx_core
   ensure relay_phone
   ```

4. Build the NUI before starting the resource:

   ```bash
   cd web
   npm install
   npm run build
   ```

5. Start the resource and use the configured key or command:

   ```text
   /relayphone
   ```

## Configuration

Shared settings live in `config/shared.lua`.

- `RelayConfig.Framework`: `auto`, `qbox`, `qbcore`, `esx`, or `standalone`
- `RelayConfig.OpenCommand`: command used to toggle the phone
- `RelayConfig.OpenKey`: default key mapping
- `RelayConfig.Phone.NumberPrefix`: server-controlled phone number prefix
- `RelayConfig.Phone.NumberLength`: total generated phone number length

With `auto`, Relay checks Qbox, QBCore, ESX, then falls back to standalone.

## Architecture

Framework integrations live under `bridge/client` and `bridge/server`.

Core phone logic lives under `client`, `server`, and `shared`. Core code should call Relay bridge functions instead of calling framework exports directly.

NUI source lives under `web/src` and is split into:

- `apps`
- `components`
- `hooks`
- `services`
- `stores`
- `types`
- `utilities`

The built production NUI is emitted to `web/dist`, which is referenced by `fxmanifest.lua`.

## Database

The `relay_phone_identities` table stores persistent server-controlled phone identity:

- framework/player identifier
- unique phone number
- display name cache
- created, updated, and last-seen timestamps

Relay never accepts phone identity from NUI or client data. The server resolves identity from the selected framework bridge and writes through parameterized oxmysql operations.

## Public Client API

Exports:

- `OpenPhone()`
- `ClosePhone()`
- `TogglePhone()`
- `IsPhoneOpen()`

Events:

- `relay_phone:client:open`
- `relay_phone:client:close`
- `relay_phone:client:toggle`

## Development

Install and run the NUI locally:

```bash
cd web
npm install
npm run dev
```

Build and check types:

```bash
cd web
npm run typecheck
npm run build
```

Do not commit `node_modules`, build caches, secrets, or server-specific configuration. The existing files in `stream/` are third-party streamed assets documented in `THIRD_PARTY_NOTICES.md` and should not be modified unless their licensing/source notice is being deliberately updated.

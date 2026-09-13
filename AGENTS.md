# Relay Phone - Codex Development Instructions

## Project

Relay is a free, open-source, modular FiveM phone resource.

Repository:
techit-oss/relay_phone

Resource name:
relay_phone

License:
MIT for Relay source code.

Third-party streamed assets are covered separately by THIRD_PARTY_NOTICES.md.

## Primary Goals

Relay must be:

- free and open source
- modular
- framework-agnostic internally
- secure
- performant
- easy for other developers to extend
- usable on production FiveM servers
- documented clearly

Do not hard-code Stoneford State Roleplay branding into the public resource.

## Supported Frameworks

First-class support:

1. Qbox / QBX
2. QBCore
3. ESX Legacy

Also provide a clean standalone/custom bridge interface.

Qbox is the reference implementation.

Framework-specific code must stay inside the bridge layer.

Do not place direct Qbox, QBCore or ESX calls throughout apps or core phone logic.

## Core Dependencies

Preferred integrations:

- ox_lib
- oxmysql
- pma-voice
- ox_inventory

Do not introduce paid or closed-source dependencies.

Where practical, integrations should be optional.

## Architecture

Use separate layers for:

- framework bridges
- banking adapters
- housing adapters
- inventory adapters
- garage adapters
- voice integration
- phone core
- server services
- NUI
- individual phone applications

The phone UI must not know which FiveM framework is running.

Example:

Bad:

    exports['Renewed-Banking']:getAccountMoney(...)

inside the banking UI/core.

Good:

    Relay.Banking.GetBalance(...)

with the Renewed-Banking implementation inside its banking adapter.

## Planned Framework Layout

bridge/client/
bridge/server/

Framework implementations:

- qbox.lua
- qbcore.lua
- esx.lua
- standalone.lua

The selected framework should be configurable and support safe automatic detection where appropriate.

## Planned Integrations

Banking adapters should eventually support:

- Renewed-Banking
- qb-banking
- ox_banking
- okokBanking
- QS Banking
- custom adapter interface

Housing adapters should eventually support:

- qbx_properties
- qb-houses
- ps-housing
- other housing resources through adapters

Do not implement every adapter in the first milestone.

## Frontend

Use:

- React
- TypeScript
- Vite

Build the NUI as reusable components.

Avoid a monolithic App.tsx.

Use clear directories for:

- apps
- components
- hooks
- stores
- services
- types
- utilities

The production frontend build must work inside FiveM NUI.

## Initial Phone Apps

Milestone 1 should contain:

- Home
- Phone
- Messages
- Contacts
- Settings

Do not build banking, housing or marketplace functionality until the core phone architecture is stable.

## App System

Relay should eventually expose a documented application API so third-party resources can add phone apps without modifying Relay core.

Design the architecture with this in mind from the beginning.

Do not prematurely implement a complicated plugin system before the base phone works.

## Voice

Calls should use pma-voice.

Voice integration must be isolated from UI code.

The call server must validate participants and call state.

## Security

Never trust NUI/client-provided values for:

- money
- bank accounts
- property ownership
- vehicle ownership
- phone ownership
- player identity
- job permissions
- emergency permissions

Sensitive operations must be validated server-side.

Use parameterized oxmysql queries.

Do not dynamically concatenate untrusted SQL.

Do not expose server secrets to the NUI.

Do not store API keys, webhook URLs or credentials in committed files.

## Phone Numbers

Phone numbers must be persistent and server-controlled.

Design the database schema so numbers can be:

- unique
- indexed
- assigned consistently
- queried efficiently

Do not derive permanent phone identity solely from server ID.

## Database

Use oxmysql.

SQL schema/migrations belong under:

    sql/

Database access should be handled server-side.

Keep database queries isolated from UI code.

## Performance

Avoid unnecessary Wait(0) loops.

Prefer events, callbacks and state changes over constant polling.

Do not repeatedly perform expensive framework exports every frame.

Cache safe static data when appropriate.

NUI should not receive large amounts of unchanged data continuously.

## FiveM Resource

Create a valid fxmanifest.lua.

Use Lua 5.4-compatible code.

Keep client and server responsibilities separate.

Do not modify or delete the existing stream folder unless explicitly required.

The existing streamed phone assets must remain intact.

## Existing Stream Assets

Do not replace or delete:

    stream/prop_amb_phone.ydr
    stream/prop_amb_phone.ytd

These assets are documented in THIRD_PARTY_NOTICES.md.

## Coding Standards

Prefer descriptive names over abbreviations.

Keep modules small.

Avoid duplicate logic.

Document public exports and events.

Do not leave debug print statements enabled in production.

Use consistent event prefixes:

    relay_phone:

Avoid generic global event names.

## Public API

Public exports and events must be documented.

Avoid breaking public APIs without a migration path.

Prefix public exports/functions consistently around Relay.

## Git Behaviour

Do not rewrite main history.

Do not force-push.

Do not commit secrets.

Do not commit node_modules.

Do not commit unnecessary generated/cache files.

Keep commits logically scoped.

Before large changes, explain the intended implementation.

## Testing

Before reporting a task complete:

- run the frontend build
- run TypeScript checks
- inspect Lua syntax where possible
- check fxmanifest references
- verify referenced files exist
- report anything that could not actually be tested

Do not claim something was tested if it was not.

## First Milestone

The first milestone is only the Relay foundation.

Build:

1. resource architecture
2. fxmanifest.lua
3. configuration
4. framework bridge interface
5. Qbox bridge
6. QBCore bridge skeleton
7. ESX bridge skeleton
8. React/TypeScript/Vite NUI
9. phone open/close behaviour
10. Home screen
11. Contacts shell
12. Messages shell
13. Settings shell
14. database foundation
15. documentation

Do not implement banking, housing, marketplace, social media or advanced emergency systems yet.

The goal is a clean and stable base before feature expansion.

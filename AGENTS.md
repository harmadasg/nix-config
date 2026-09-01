# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

A Nix flake managing NixOS (Linux) and nix-darwin (macOS) systems plus Home Manager, based on [librephoenix/nixos-config](https://github.com/librephoenix/nixos-config). Uses `nixpkgs/nixos-unstable`.

## Commands

Applied via the `phoenix` CLI (defined in `system/bin/phoenix.nix`, wraps `scripts/`):

- `phoenix sync` — rebuild both system and Home Manager (`sync-system.sh` + `sync-user.sh`)
- `phoenix sync system` — `sudo nixos-rebuild switch --flake .` only
- `phoenix sync user` — `home-manager switch --flake .` only
- `phoenix update` — `nix flake update` (updates `flake.lock`, no rebuild)
- `phoenix upgrade` — update then sync
- `phoenix gc [full|<duration>]` — garbage collect (default: older than 30d)

On macOS the system rebuild is `darwin-rebuild switch --flake .` instead of `nixos-rebuild`.

Test config evaluation without applying: `nix flake check` or `nixos-rebuild build --flake .`.

The `vm` output is a throwaway media-server test VM:
```
nix build ./#nixosConfigurations.vm.config.system.build.vm
QEMU_NET_OPTS="hostfwd=tcp::2222-:22" ./result/bin/run-nixos-vm   # ssh -p 2222 guest@localhost
```

## Architecture

**`settings.nix` is the single source of truth.** It exports `systemSettings` (arch, hostname, profile, monitors, GPU, boot) and `userSettings` (username, theme, wm, browser, editor, etc.). These attrsets are threaded into *every* module through `specialArgs`/`extraSpecialArgs` in `flake.nix` — so a module can take `{ userSettings, systemSettings, ... }` as arguments directly. Change machine-wide behavior here, not in individual modules.

**`profile` in `settings.nix` selects what gets built.** `flake.nix` imports `./profiles/${profile}/configuration.nix` (system) and `./profiles/${profile}/home.nix` (Home Manager). Profiles are the composition root — they list which modules from `system/` and `user/` are active:
- `profiles/personal/` — NixOS desktop (Hyprland, AMD GPU, gaming, media server)
- `profiles/work/` — macOS via nix-darwin (dev tools, no WM)

**Two module trees:**
- `system/` — NixOS/darwin system modules (hardware, WM display managers, system services, security)
- `user/` — Home Manager modules (`app/` per-application configs, `wm/` window manager, `shell/`, `style/`)

**Directories compose via `default.nix`.** A directory's `default.nix` `imports` the sibling `.nix` files (e.g. `user/app/default.nix` pulls in every app module). To add an app/module, create the `.nix` file *and* add it to the relevant `default.nix` — or, if profile-specific, list it directly in the profile's `home.nix` (as `work/home.nix` does). The personal profile imports whole directories (`user/app`); the work profile cherry-picks individual files.

**Theming via Stylix.** `user/style/base.nix` enables Stylix and imports the theme selected by `userSettings.theme` from `themes/`. Themes set a base16 scheme + wallpaper; app modules generally inherit colors automatically rather than hardcoding them.

**Monitors.** Declared as structured data in `systemSettings.monitors`. `common/monitor-utils.nix` exposes read-only options `display.monitors` (Hyprland-formatted strings) and `display.mainMonitor`, derived from that data — consume these in WM configs instead of hardcoding outputs.

## Flake inputs of note

`home-manager`, `nix-darwin`, `stylix` (theming), `nur`, `nixarr` (media server for the VM), `mac-app-util` (macOS app trampolines). `commonArgs` in `flake.nix` sets `allowUnfree = true` and an overlay (NUR + an `oranchelo-icon-theme` fix).

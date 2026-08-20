# nix-conf

Personal [NixOS](https://nixos.org) configuration, managed with [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://github.com/nix-community/home-manager).

## Machines

| Hostname | Type  | GPU      | Notes                                      |
|----------|-------|----------|--------------------------------------------|
| `sleeper` | Desktop | NVIDIA   | Gaming, DVD/optical drive, KiCad, SSH/WoL |
| `dreamer` | Laptop  | AMD iGPU | Power management, Bluetooth                |

Both machines run the [niri](https://github.com/YaLTeR/niri) scrollable-tiling Wayland compositor, with XFCE available as a fallback boot entry (see the `xfce` specialisation in `shared/configuration.nix`).

## Features

- **Modular configuration** — each concern lives in its own module under `modules/` and is enabled per-machine through a `modules.*` option namespace (e.g. `modules.niri.enable`, `modules.gaming.enable`).
- **home-manager** — user environments (shell, editor, browser, etc.) are declared for each user in `modules/home/` and `modules/programs/`.
- **niri desktop** — window manager plus waybar, fuzzel, GTK/Qt theming and a custom keybinding set (`dotfiles/niri/config.kdl`).
- **NixOS + home-manager pinned together** — home-manager's `nixpkgs` input follows the flake's `nixpkgs` so user and system packages stay on the same revision.

## Structure

```
├── flake.nix                  # entry point, defines both hosts
├── hosts/
│   ├── sleeper/               # desktop: configuration + hardware
│   └── dreamer/               # laptop: configuration + hardware
├── shared/
│   └── configuration.nix      # imports shared across both hosts
├── modules/
│   ├── base.nix               # core system configuration
│   ├── user.nix               # user accounts
│   ├── gaming.nix             # steam, lutris, gamescope, ...
│   ├── laptop.nix             # laptop-specific hardware
│   ├── nvidia.nix             # NVIDIA driver setup
│   ├── opt.nix                # large packages
│   ├── ssh.nix                # tailscale routing, wake-on-lan
│   ├── home/                  # per-user home-manager config
│   ├── programs/              # per-program modules
│   └── wmde/                  # window manager & desktop environment
└── dotfiles/                  # raw dotfiles referenced by modules
```

## Usage

Requires NixOS with flakes enabled.

```sh
# with nixos-rebuild
sudo nixos-rebuild switch --flake .#sleeper
sudo nixos-rebuild switch --flake .#dreamer

# with nh (as configured in this repo)
nh os switch --hostname sleeper
nh os switch --hostname dreamer
```

> The modules assume the repo is deployed to `/etc/nixos` (a symlink works too).

## License

[MIT](LICENSE)
This is my operating system.

It looks like this.

```
.
├── bin
│   ├── catallcopy
│   ├── catall.sh
│   └── yazi-cd
├── hyprland
│   ├── hypr
│   │   ├── hyprland.conf
│   │   └── hyprpaper.conf
│   └── waybar
│       ├── config.jsonc
│       └── style.css
├── nixos
│   ├── configuration.nix
│   ├── desktop-environments
│   │   ├── gnome.nix
│   │   └── hyprland.nix
│   ├── display-managers
│   │   ├── gdm.nix
│   │   └── greetd.nix
│   └── hardware-configuration.nix
└── README.md

8 directories, 14 files

```

/bin is where I keep scripts.

/hyprland has the hyprland config, and a config to set my wallpaper.

/nixos has all of my nix configuration.  
configuration.nix I have split into some separate files to tidy it up, the desktop environments and display managers have their own directories.




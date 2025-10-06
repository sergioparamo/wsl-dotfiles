# WSL2 Dotfiles — Modern Zsh + Starship + Neovim

A production-ready, idempotent WSL2 (Ubuntu) dotfiles repository tailored for full-stack development.

Features
- Zsh (Oh My Zsh) with autosuggestions, syntax-highlighting, zoxide, fzf integrations
- Starship prompt configured for Git, Node/Python/Docker indicators
- Neovim (with Packer) preconfigured with LSPs, Treesitter, Telescope, Dracula theme
- Git config template with helpful aliases
- Docker CLI and Compose plugin installation script and helpful aliases
- VS Code settings (Zsh default terminal, Fira Code, Dracula theme)
- Bootstrap, install, and update scripts — idempotent and ready to run

Quick start

From a fresh WSL Ubuntu session run:

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/sergioparamo/wsl-dotfiles/main/bootstrap.sh)
```

Or, if you've copied this repo to `~/wsl-dotfiles`:

```bash
cd ~/wsl-dotfiles
chmod +x *.sh scripts/*.sh
./install.sh
```

Repository layout

```
wsl-dotfiles/
├── README.md
├── bootstrap.sh
├── install.sh
├── update.sh
├── .gitconfig
├── config/
│   └── starship.toml
├── nvim/
│   └── init.lua
├── zsh/
│   ├── .zshrc
│   └── zshrc.d/
│       ├── aliases.zsh
│       ├── plugins.zsh
│       ├── fzf.zsh
│       └── prompt.zsh
├── .vscode/
│   ├── settings.json
│   └── extensions.json
└── scripts/
    ├── configure_zsh.sh
    ├── setup_starship.sh
    ├── setup_nvim.sh
    ├── setup_git.sh
    ├── setup_docker.sh
    └── configure_vscode.sh
```

More
- See the modular scripts in `scripts/` for idempotent installation steps.
- Use `./update.sh` or `dotupdate` alias after first install to refresh everything.

License

MIT

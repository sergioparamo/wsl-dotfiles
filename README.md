# WSL2 Dotfiles — Modern Zsh + Starship + Neovim

A production-ready, idempotent WSL2 dotfiles repository tailored for full-stack development.
Tested on Ubuntu 22.04.5 LTS (GNU/Linux 6.6.87.2-microsoft-standard-WSL2 x86_64)

Features
- Zsh (Oh My Zsh) with autosuggestions, syntax-highlighting, zoxide, fzf integrations
- Installs LTS versions of Node.js, Python, and Java
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
./install.sh
```

License

MIT

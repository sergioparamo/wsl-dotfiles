# WSL2 Dotfiles — Modern Zsh + Starship + Neovim

A production-ready, idempotent WSL2 (Ubuntu) dotfiles repository tailored for full-stack development.

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

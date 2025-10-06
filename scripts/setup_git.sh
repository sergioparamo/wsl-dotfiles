#!/usr/bin/env bash
set -e

echo "🔧 Configuring Git..."

cp git/gitconfig "$HOME/.gitconfig"

git config --global user.name "sergioparamo"
git config --global user.email "sergio.paramo1997@gmail.com"
git config --global color.ui true
git config --global credential.helper cache
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.ci commit
git config --global alias.br branch

echo "✅ Git configured!"
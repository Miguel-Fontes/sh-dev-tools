#!/usr/bin/env bash

set -euo pipefail

function installOSX() {
    brew install fzf ripgrep bat
}

function installLinux() {
    if ! command -v apt >/dev/null 2>&1; then
        echo "Erro: gerenciador de pacotes 'apt' não encontrado. Esta distro Linux não é suportada por este script." >&2
        exit 1
    fi

    sudo apt update
    sudo apt install -y fzf ripgrep bat

    mkdir -p ~/.local/bin

    if command -v batcat >/dev/null 2>&1; then
        ln -sf "$(command -v batcat)" ~/.local/bin/bat
    elif command -v bat >/dev/null 2>&1; then
        echo "Binário 'bat' já disponível, pulando criação de symlink."
    else
        echo "Aviso: nem 'batcat' nem 'bat' foram encontrados após a instalação." >&2
    fi
}

if [[ "$OSTYPE" == "darwin"* ]]; then
    installOSX
elif [[ "$OSTYPE" == "linux"* ]]; then
    installLinux
else
    echo "Erro: sistema operacional '$OSTYPE' não suportado por este script." >&2
    exit 1
fi

echo "fzf, ripgrep e bat instalados com sucesso."

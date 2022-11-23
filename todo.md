# To Do

- [ ] Criar instalador para o vim.
    - Clonar o repo https://github.com/amix/vimrc
    - Rodar script de instalação `sh .vim_runtime/install_awesome_vimrc.sh`
    - Criar soft link em ~/.vim/vimrc
    
    ``` bash
        git clone --depth=1 https://github.com/amix/vimrc.git ~/dev/amix-vimrc
        sh ~/dev/amix-vimrc/.vim_runtime/install_awesome_vimrc.sh
    ```
- [ ] Aprimorar instalação do Git para gerar chave SSH
    - Gerar uma nova chave pode ser visto [neste documento](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
    - A configuração no github pode ser vista [aqui](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
"VIM Configuration

    if ! filereadable(expand('$HOME/.config/nvim/autoload/plug.vim'))
        echo "Downloading junegunn/vim-plug to manage plugins..."
        silent !mkdir -p $HOME/.config/nvim/autoload/
        silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.config/nvim/autoload/plug.vim
        autocmd VimEnter * PlugInstall
    endif

    source $HOME/.config/nvim/vim-plug/plugins.vim
"   set number
    "Always show current position
    set ruler
    "Ignore case when searching
    set ignorecase
    "Highlight search results
    set hlsearch
    "Change tab to 4 spaces (default is 8) and SW is Shift Width
    set tabstop=4
    set shiftwidth=4
    "Autotabs for certain code
    set smarttab
    "Shows matching brackets
    set showmatch
    set showmode
    set autoindent
    set expandtab
    set nocompatible
    filetype plugin on
    syntax on
    "Default <Leader> key is mapped to \
    let mapleader = ' '
    :nnoremap <leader>w :w<CR>
    :nnoremap <silent><leader>j :%!jq<CR> gg0vG$y<CR>
    set clipboard=unnamedplus
    set undofile
    set undodir=$HOME/.config/nvim/undo-dir

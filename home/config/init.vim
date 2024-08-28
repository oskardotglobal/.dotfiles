" Enable line numbers
set number

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Turn syntax highlighting on.
syntax on

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Use space characters instead of tabs.
set expandtab

" Set shift width and tab stop to `a:width` amount of spaces.
function! SetIndent(width)
  execute "set shiftwidth=" . a:width
  execute "set tabstop=" . a:width
endfunction

call SetIndent(4)

augroup two_tabs
  autocmd!
  autocmd FileType nix call SetIndent(2)
  autocmd FileType yaml call SetIndent(2)
  autocmd FileType yml call SetIndent(2)
  autocmd FileType json call SetIndent(2)
augroup END

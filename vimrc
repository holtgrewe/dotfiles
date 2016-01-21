" Most of the configuration is taken [1].
"
" [1] from http://vi-improved.org/vimrc.php

" Basics {
set nocompatible  " get out of vi-compatibility mode
set background=dark  " we are using a dark background
syntax on
" }

" General {
set history=1000  " How many lines to remember.
set fileformats=unix,dos,mac  " Support all three, in this order
set iskeyword+=_,$,@,%,#  " None of these should be word dividers.
set nostartofline  " Leave my cursor where it was.
" }

" File/Backups {
set nobackup  " make backup file
" }

" Visual Cues {
set showmatch  " show matching brackets
set matchtime=5  " how many thents of a second to blink matching brackets for
set nohlsearch  " no highlighting searched for phrases
set incsearch  " BUT do highlight as you type your search phrase
set scrolloff=5  " keep 5 lines for scope
set sidescrolloff=5  " keep 5 lines at the size
set novisualbell " don't blink
set ruler  " enable rule (line/column)
set nu  " line numbers
" }

" Indent Related {
set nosmartindent " smartindent (filetype indenting instead)
set autoindent " autoindent (should be overwrote by cindent or filetype indent)
set cindent " do c-style indenting
set softtabstop=4 " unify
set shiftwidth=4 " unify
set tabstop=4 " real tabs should be 4, but they will show with set list on
set copyindent " but above all -- follow the conventions laid before us
set expandtab  " we do not want to type tabs
" }

" Keyboard Related {
let mapleader = ","  " XXX What is this for?
" }

" Color Schema {
:color elflord
" }

" Disable font antialiasing in MacVim {
if has("gui_macvim")
  "set noantialias
  set guifont=Monaco:h9
endif
" }

" Line Highlighting {
if v:version > 700
  set cursorline
  hi CursorLine guibg=Grey20
  "call ExpextCursorSlowDown(now)
endif
" }

" Backspace {
set backspace=2  " make backspace work normal
set whichwrap+=<,>,h,l  " backspace and cursor keys wrap to next/prev lines
" }
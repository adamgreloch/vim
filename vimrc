" Setup {{{
set nocompatible              " be iMproved, required
filetype plugin on
syntax on
autocmd!

set foldmethod=marker

" Set UTF-8 encoding
set encoding=utf-8
set fileencoding=utf-8
" }}}
" Language {{{
language en_US.utf8
" }}}
" Windows-specific settings {{{

if has('win32') || has('win64')
    set runtimepath=path/to/home.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
endif

" }}}
" Vundle config {{{

"Vundle bootstrap
if !filereadable($HOME . '/.vim/bundle/Vundle.vim/.git/config') && confirm("Clone Vundle?","Y\nn") == 1
    exec '!git clone https://github.com/gmarik/Vundle.vim ~/.vim/bundle/Vundle.vim/'
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'vimwiki/vimwiki'
Plugin 'jceb/vim-orgmode'
Plugin 'reedes/vim-pencil'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on

" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" }}}
" Theme {{{
autocmd vimenter * colorscheme gruvbox
set background=dark
" }}}
" GUI tweaks {{{
set guioptions-=T
set guioptions-=r  
set guioptions-=L 
set guioptions-=m
set lines=50 columns=100

" Disable bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=
" }}}
" Set gVim font {{{
if has('win32') || has('win64')
	set guifont=Meslo_LG_S:h12:cEASTEUROPE:qDRAFT
else
	set guifont=Monospace\ 12
endif
" }}}
" Leaders {{{
inoremap <leader>w <esc>:w<cr>a
" }}}
" Misc {{{
nnoremap z<Space> za
" }}}
" Bindings {{{
	" Cursor movement in INSERT {{{
	inoremap <C-k> <C-o>gk
	inoremap <C-h> <Left>
	inoremap <C-l> <Right>
	inoremap <C-j> <C-o>gj
	" }}}
" }}}
" Code related settings {{{
" On pressing tab, insert 2 spaces
set tabstop=2
set shiftwidth=2 
" }}}
" Writing text {{{
" Initialize Pencil based on file types
augroup pencil
  autocmd!
	autocmd FileType org          call pencil#init()
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
" }}}
" Journal {{{
autocmd BufNewFile *.jrnl $pu!=strftime('%A, %d.%m.%y')
"if !empty(glob("~/Dropbox/test/"))
"	echo "yes"
"endif
" }}}
" Defaults {{{
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif
" }}}

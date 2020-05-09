" Setup {{{
set nocompatible              " be iMproved, required
filetype plugin on
autocmd!

syntax on
" Set UTF-8 encoding
set encoding=utf8
"set fileencoding=utf8

set foldmethod=marker

set textwidth=80
set clipboard=unnamed

if empty(glob('~/.vim/tmp'))
	silent !mkdir -p ~/.vim/tmp
endif

set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set undodir=~/.vim/tmp//

	" }}}
" Language {{{
language en_US.utf8
" }}}
" Linux-specific settings {{{
language time pl_PL.utf8
" }}}
" Windows-specific settings {{{
if has('win32') || has('win64')
	language time pl_PL
	set runtimepath=path/to/home.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
	nnoremap <leader><F11> :call libcallnr(expand("$HOME") . "/.vim/bundle/gvimfullscreen_win32/gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
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

Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'preservim/nerdtree'
Plugin 'derekmcloughlin/gvimfullscreen_win32'
Plugin 'vimwiki/vimwiki'
Plugin 'jceb/vim-orgmode'
Plugin 'reedes/vim-pencil'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'junegunn/goyo.vim'
Plugin 'lambdalisue/vim-fullscreen'
Plugin 'lervag/vimtex'
Plugin 'SirVer/ultisnips'

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
"set lines=50 columns=100

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
" Version Control {{{
set diffopt+=vertical
" }}}
" Leaders {{{
nnoremap <leader>n <esc>:NERDTree %:h<cr>
nnoremap <leader>w <esc>:w<cr>
nnoremap <leader>e :w!<cr>:e %:h<cr>
nnoremap <leader>ov :e ~/.vim/vimrc<cr>
nnoremap <leader>p "+p<cr>
nnoremap <leader>g :Goyo<cr>
inoremap <leader>w <esc>:w<cr>a
inoremap <leader>p <esc>"+p<cr>a
" }}}
" FZF {{{
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>oh :Files ~<CR>
nnoremap <silent> <leader>og :Files ~/git/<CR>
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
" }}}
" Misc {{{
nnoremap z<Space> za

" Some format options
au FileType vim set fo-=c fo-=r fo-=o 

" Add/check for last line break
function! AddLastLine()
    if getline('$') !~ "^$"
        call append(line('$'), '')
    endif
endfunction

autocmd BufWritePre * call AddLastLine()

" }}}
" Bindings {{{
	" Cursor movement {{{
	nnoremap k gk
	nnoremap j gj
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

au! BufRead,BufNewFile *.org            setfiletype org

let g:pencil#autoformat_blacklist = [
        \ 'markdownCode',
        \ 'markdownUrl',
        \ 'markdownIdDeclaration',
        \ 'markdownLinkDelimiter',
        \ 'markdownHighlight[A-Za-z0-9]+',
        \ 'mkdCode',
        \ 'mkdIndentCode',
        \ 'markdownFencedCodeBlock',
        \ 'markdownInlineCode',
        \ 'mmdTable[A-Za-z0-9]*',
        \ 'txtCode',
        \ 'texAbstract',
        \ 'texBeginEndName',
        \ 'texDelimiter',
        \ 'texDocType',
        \ 'texInputFile',
        \ 'texMath',
        \ 'texRefZone',
        \ 'texSection$',
        \ 'texStatement',
        \ 'texTitle',
        \ ]

augroup pencil
  autocmd!
	autocmd FileType tex					call pencil#init({'wrap': 'soft'})
	autocmd FileType org					call pencil#init()
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

" }}}
" LaTeX {{{
if empty(v:servername) && exists('*remote_startserver')
	call remote_startserver('VIM')
endif

let g:vimtex_fold_enabled = 1
let g:vimtex_quickfix_autoclose_after_keystrokes = 1

" }}}
" Journal {{{
function! JournalOpen() 
    return ':e ~/Dropbox/vimjrnl/'.strftime('%Y%m%d').'.md'
endfunction

nnoremap <expr> <leader>oj JournalOpen() 

autocmd BufNewFile ~/Dropbox/vimjrnl/* :$pu!=strftime('# %A, %d.%m.%y')
autocmd BufNewFile ~/Dropbox/vimjrnl/* :$pu=strftime('## %H:%M ') | :normal GA
autocmd BufRead ~/Dropbox/vimjrnl/* $pu=strftime('## %H:%M ') | :normal GA
" autocmd BufReadPost ~/Dropbox/test/* :normal GA
" }}}


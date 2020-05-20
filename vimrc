" Setup {{{
set nocompatible
filetype plugin on
autocmd!

syntax on
set backspace=indent,eol,start

" Set UTF-8 encoding
set encoding=utf8
"set fileencoding=utf8

set termguicolors
set scrolloff=6 " Keep 6 lines below and above the cursor
set numberwidth=4
set foldmethod=marker
set clipboard=unnamed
set spellcapcheck=

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
	let $PDFVIEWER = "SumatraPDF"
	let &pythonthreedll = 'C:\python37\python37.dll'
	set runtimepath=path/to/home.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,path/to/home.vim/after
	nnoremap <silent> <F11> :call libcallnr(expand("$HOME") . "/.vim/bundle/gvimfullscreen_win32/gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>
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
Plugin 'reedes/vim-pencil'
Plugin 'tpope/vim-fugitive'
Plugin 'morhetz/gruvbox'
Plugin 'junegunn/goyo.vim'
Plugin 'lervag/vimtex'
Plugin 'hugolgst/vimsence'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'junegunn/limelight.vim'
Plugin 'easymotion/vim-easymotion'

" Linux-specific plugins
" Some plugins just won't work on Windows properly...
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

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
	set guifont=Meslo_LG_S:h14:cEASTEUROPE:qDRAFT
	nnoremap <leader>gf14 :set guifont=Meslo_LG_S:h14:cEASTEUROPE:qDRAFT<cr>
	nnoremap <leader>gf18 :set guifont=Meslo_LG_S:h18:cEASTEUROPE:qDRAFT<cr>
else
	set guifont=Monospace\ 12
endif
" }}}
" Version Control {{{
set diffopt+=vertical
" }}}
" Leaders {{{
nnoremap <leader>n :NERDTree %:h<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>e :w!<cr>:e %:h<cr>
nnoremap <leader>ov :e ~/.vim/vimrc<cr>
nnoremap <leader>P "+p<cr>
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>b <C-^>
nnoremap <leader>B :ls<cr>:b<Space>
nnoremap <leader>r :set relativenumber!<cr>
nnoremap <leader>cl1 :set conceallevel=1<cr>
nnoremap <leader>cl0 :set conceallevel=0<cr>
inoremap <leader>q <esc>:q<cr>a
inoremap <leader>I <esc>I
inoremap <leader>A <esc>A
inoremap <leader>w <esc>:w<cr>a

map  <leader>s <Plug>(easymotion-bd-w)
" nmap <Leader>s <Plug>(easymotion-overwin-w)

nnoremap <leader>ep :e ~/Dropbox/papiery/

" limelight
nnoremap <leader>L :Limelight!! 0.8<cr>
" }}}
" FZF {{{
" let $FZF_DEFAULT_COMMAND = 'ag -g ""'
nnoremap <silent> <leader>o :Files<CR>
nnoremap <silent> <leader>oh :Files ~<CR>
nnoremap <silent> <leader>og :Files ~/git/<CR>
nnoremap <silent> <leader>op :Files ~/Dropbox/papiery/<CR>
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
" Toggle folding
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
	" Goyo settings {{{
	function! s:goyo_enter()
		set guicursor+=a:blinkon0
	endfunction

	function! s:goyo_leave()
		set guicursor-=a:blinkon0
	endfunction

	autocmd! User GoyoEnter call <SID>goyo_enter()
	autocmd! User GoyoLeave call <SID>goyo_leave()
	"}}}
	" Create parent directory on save because I'm lazy {{{
	" https://stackoverflow.com/questions/4292733/vim-creating-parent-directories-on-save
	function s:MkNonExDir(file, buf)
			if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
					let dir=fnamemodify(a:file, ':h')
					if !isdirectory(dir)
							call mkdir(dir, 'p')
					endif
			endif
	endfunction
	augroup BWCCreateDir
			autocmd!
			autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
	augroup END
	" }}}
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

" UltiSnips configuration

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}
" Writing text {{{
" pandoc {{{
let g:pandoc#modules#enabled = ["command", "spell", "hypertext", "metadata", "toc"]
let g:pandoc#command#latex_engine = "pdflatex"
nnoremap <silent> <leader>cc :Pandoc pdf --template="~/Dropbox/papiery/defaults.latex"<cr>
nnoremap <expr> <silent> <leader>oo ":!start ".expand("$PDFVIEWER")." ".expand("%:p:r").".pdf<cr>"
" }}}
" Pencil {{{
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
	autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
														\ | set spelllang=en,pl
  autocmd FileType text         call pencil#init()
augroup END
" }}}
" Markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}
" LaTeX {{{
if empty(v:servername) && exists('*remote_startserver')
	call remote_startserver('VIM')
endif

let g:vimtex_fold_enabled = 1
"let g:vimtex_quickfix_autoclose_after_keystrokes = 1
let g:tex_conceal='abdmg'
"let g:tex_conceal = 'b'
let g:vimtex_quickfix_open_on_warning = 0
au! BufRead,BufNewFile *.tex setlocal conceallevel=1
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
" }}}


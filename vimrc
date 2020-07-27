" Setup {{{
set nocompatible
filetype plugin on
autocmd!

syntax on

" Set UTF-8 encoding
set encoding=utf8

set mouse=a
set backspace=2 " make backspace work like most other programs
set wildmenu " Tab completion
set cmdheight=1
set termguicolors
set t_Co=256
set guioptions=cgt
set smartindent
set numberwidth=4
set laststatus=2 " Statusline tweaks
set diffopt+=vertical	" Vertical diff (for fugitive)
set splitbelow " Split everything below (for term)
set foldmethod=marker
set spellcapcheck=
if has('linux')
	set clipboard=unnamedplus
endif
" Search
set ic
set hls
nnoremap <silent> <cr> :noh<CR><CR>

if empty(glob('~/.vim/tmp'))
	silent !mkdir -p ~/.vim/tmp
endif

set backup
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set undodir=~/.vim/tmp//

" }}}
" Language {{{
language en_US.utf8
" }}}
" Linux-specific settings {{{
if has('linux')
	language time pl_PL.utf8
	let $PDFVIEWER = "zathura"
endif
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

Plugin 'VundleVim/Vundle.vim'

Plugin 'vim-airline/vim-airline'
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
Plugin 'tpope/vim-dispatch'
Plugin 'freitass/todo.txt-vim'

Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" }}}
" GUI tweaks {{{
" Set theme
colorscheme gruvbox
set background=dark

" Set spellcheck highlight to bold red in term

hi SpellBad cterm=bold ctermfg=167

" Disable bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Set scrolloff margin to 33% of winheight
augroup VCenterCursor
	au!
	au BufEnter,WinEnter,WinNew,VimResized *,*.*
				\ let &scrolloff=winheight(win_getid())/3
augroup END

" Set NERDtree arrows to -/+
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

" Airline symbols
if has('linux')
	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif

	let g:airline_symbols.branch = ''
endif

" }}}
" Set gVim font {{{
if has('win32') || has('win64')
	set guifont=Meslo_LG_S:h14:cEASTEUROPE:qDRAFT
	nnoremap <leader>f14 :set guifont=Meslo_LG_S:h14:cEASTEUROPE:qDRAFT<cr>
	nnoremap <leader>f18 :set guifont=Meslo_LG_S:h18:cEASTEUROPE:qDRAFT<cr>
else
	set guifont=Monospace\ 12
endif

" }}}
" Leaders {{{
nnoremap <leader>n :NERDTree %:h<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>e :w!<cr>:e %:h<cr>
nnoremap <leader>ov :e ~/.vim/vimrc<cr>
nnoremap <leader>P "+p
nnoremap <leader>Y "+y
nnoremap <leader>g :Goyo<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>b <C-^>
nnoremap <leader>G :Git<cr>
nnoremap <leader>B :Buffers<cr>
nnoremap <silent><leader>r :set relativenumber!<cr>:set cursorline!<cr>
nnoremap <silent><leader>R :set number!<cr>
nnoremap <leader>cl1 :set conceallevel=1<cr>
nnoremap <leader>cl0 :set conceallevel=0<cr>

inoremap <leader>q <esc>:q<cr>a
inoremap <leader>I <esc>I
inoremap <leader>A <esc>A
inoremap <leader>w <esc>:w<cr>a

map  <leader>s <Plug>(easymotion-bd-w)

nnoremap <leader>ep :e ~/Dropbox/papiery/

" limelight
nnoremap <silent><leader>L :Limelight!! 0.8<cr>

" }}}
" FZF {{{
nnoremap <silent><leader>o :Files<CR>
nnoremap <silent><leader>oh :Files ~<CR>
nnoremap <silent><leader>og :Files ~/git/<CR>
nnoremap <silent><leader>op :Files ~/Dropbox/papiery/<CR>
nnoremap <silent><leader>od :Files ~/Dropbox/<CR>

let g:fzf_layout = { 'down': '~30%' }
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
if has('win32') || has('win64')
	let g:fzf_preview_window = ''
endif
" }}}
" UltiSnips {{{
let g:UltiSnipsSnippetDirectories=["ultisnips"]
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

" Todo.txt-vim detect ft
autocmd BufNewFile,BufRead [Tt]odo.txt set filetype=todo
autocmd BufNewFile,BufRead *.[Tt]odo.txt set filetype=todo
autocmd BufNewFile,BufRead [Dd]one.txt set filetype=todo
autocmd BufNewFile,BufRead *.[Dd]one.txt set filetype=todo

" For the sake of complete distraction-free environment {{{

" Goyo settings
function! s:goyo_enter()
	set guicursor+=a:blinkon0
endfunction

function! s:goyo_leave()
	set guicursor-=a:blinkon0
	AirlineRefresh " Fixes airline-theme not being applied after leaving Goyo
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Limelight settings
let g:limelight_bop = '^.*$'
let g:limelight_eop = '\n'
let g:limelight_paragraph_span = 3

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
" Mappings {{{
" Cursor movement
nnoremap j gj
nnoremap k gk
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

" Focus movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" }}}
" Coding {{{
" Python {{{
" PEP 8
function! PepStandards()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set textwidth=79
	set expandtab
	set autoindent
	set fileformat=unix
endfunction

au BufNewFile,BufRead *.py :call PepStandards()

" Run current .py
autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" }}}
" Java {{{
autocmd FileType java set makeprg=javac\ %
set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
nnoremap <F9> :Make<CR>
nnoremap <silent><F10> :terminal java %:r $SHELL<CR>
":!java %:r<CR>
":copen<Return>
" }}}
" Misc {{{
" On pressing tab, insert 2 spaces
set tabstop=2
set shiftwidth=2

" UltiSnips configuration
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" }}}
" }}}
" Writing text {{{
" Spellcheck {{{
" If .add file was updated via git, recompile .spl
for d in glob('~/.vim/spell/*.add', 1, 1)
	if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
		silent exec 'mkspell! ' . fnameescape(d)
	endif
endfor

" }}}
" pandoc {{{
let g:pandoc#modules#enabled = ["command", "spell", "hypertext", "metadata", "toc"]
let g:pandoc#command#latex_engine = "pdflatex"
nnoremap <silent> <leader>cc :Pandoc pdf --template="~/Dropbox/papiery/defaults.latex"<cr>
nnoremap <expr> <leader>oo ":Start! ".expand("$PDFVIEWER")." ".expand("%:p:r").".pdf<cr>"

" }}}
" Pencil {{{
" Suspend autoformat during the next Insert
let g:pencil#map#suspend_af = 'K'
let g:pencil#conceallevel = 0

function! Prose()
	call pencil#init({'wrap': 'hard', 'textwidth': '78'})
	nnoremap <buffer> k gk
	nnoremap <buffer> j gj
	set spelllang=en,pl
endfunction

" Maybe a better way would be to use a modeline i.e. # vim:spelllang=en/pl?

autocmd FileType markdown,mkd      call Prose()
autocmd FileType tex 							 call pencil#init({'wrap': 'soft'})

" }}}
" Markdown {{{
let g:vim_markdown_folding_disabled = 1
" }}}
" LaTeX (vimtex) {{{
if empty(v:servername) && exists('*remote_startserver')
	call remote_startserver('VIM')
endif

let g:vimtex_fold_enabled = 1

if has('linux')
	let g:vimtex_view_method = 'zathura'
	let g:vimtex_compiler_latexmk = {
				\  'callback' : 0,
				\}
endif

let g:tex_conceal='abdmg'
let g:vimtex_quickfix_open_on_warning = 0

" }}}
" Journal {{{
" Creates a new .md file with a date on top and appends time of every new entry
" just like org-journal
function! JournalOpen()
	return ':e ~/Dropbox/vimjrnl/'.strftime('%Y%m%d').'.md'
endfunction

nnoremap <expr> <leader>oj JournalOpen()

autocmd BufNewFile ~/Dropbox/vimjrnl/* :$pu!=strftime('# %A, %d.%m.%y')
autocmd BufNewFile ~/Dropbox/vimjrnl/* :$pu=strftime('## %H:%M ') | :normal GA
autocmd BufRead ~/Dropbox/vimjrnl/* $pu=strftime('## %H:%M ') | :normal GA

" }}}
" }}}


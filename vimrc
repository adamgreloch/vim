" Setup {{{
set nocompatible
autocmd!

syntax on

" TODO: make sure this rtp makes sense
set runtimepath=$HOME/.vim,$XDG_CONFIG_HOME/vim,$VIM,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
set encoding=utf8
set mouse=a
set backspace=2 			" make backspace work like most other programs
set wildmenu 					" tab completion
set cmdheight=1
set guioptions=cgt
set smartindent
set numberwidth=4
set laststatus=1
set diffopt+=vertical	" vertical diff (for fugitive)
set splitbelow 				" split everything below (for term)
set foldmethod=marker
set spellcapcheck=
set relativenumber
set cursorline
set number
set updatetime=50

" Search
set ignorecase
set hlsearch
set incsearch
nnoremap <silent> <cr> :noh<CR><CR>

if empty(glob(expand("$HOME") . "/.vim/tmp"))
	silent !mkdir -p ~/.vim/tmp
endif

set backup
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set undofile
set undodir=~/.vim/tmp//

" }}}
" Language {{{
language en_US.utf8
" }}}
" OS specific settings {{{
if has('linux')
	language time pl_PL.utf8
	let $PDFVIEWER = "zathura"
endif

if has('win32')
	language time pl_PL
	let $PDFVIEWER = "SumatraPDF"
	let &pythonthreedll = 'C:\python37\python37.dll'
	nnoremap <silent> <F11> :call libcallnr(expand("$HOME") . "/.vim/bundle/gvimfullscreen_win32/gvimfullscreen_64.dll", "ToggleFullScreen", 0)<CR>
endif
" }}}
" vim-plug config {{{

" vim-plug automatic installation

if empty(glob(expand("$HOME") . "/.vim/autoload/plug.vim"))
	if has('win32')
		iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni $HOME/.vim/autoload/plug.vim -Force
	else
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'reedes/vim-pencil'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'junegunn/limelight.vim'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-dispatch'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'freitass/todo.txt-vim'
Plug 'jamessan/vim-gnupg'
Plug 'plasticboy/vim-markdown'
Plug 'jsit/toast.vim'
Plug 'davidhalter/jedi-vim'
Plug 'rhysd/vim-grammarous'
Plug 'dense-analysis/ale'
Plug 'lifepillar/vim-cheat40'
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree'

if has('linux')
	Plug 'noahfrederick/vim-noctu'
else
	Plug 'gruvbox-community/gruvbox'
	Plug 'morhetz/gruvbox'
	Plug 'derekmcloughlin/gvimfullscreen_win32'
endif

call plug#end()
filetype plugin indent on

" }}}
" GUI tweaks {{{

set laststatus=2
set statusline=
set statusline+=%t\ 
set statusline+=%h%w%m%r\ 
set statusline+=%=%(%l,%c%V\ %=\ %P%) 

" set statusline=%t\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %P%)

" Set theme
if has('linux')
	colorscheme noctu
else
	colorscheme gruvbox
	set background=dark
endif

" Goyo breaks my custom styling so I packed them
" into a function and invoke again on s:goyo_leave()
function! CustomHi()
	hi SpellBad cterm=bold ctermfg=167
	hi VertSplit ctermfg=2 
	hi CursorLine cterm=none ctermbg=234
	hi CursorLineNr cterm=bold ctermbg=234
	hi WildMenu ctermfg=12 ctermbg=0 cterm=bold
endfunction

call CustomHi()

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

" }}}
" GVIM/Windows tweaks {{{
set langmenu=en_US
let $LANG = 'en_US'
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set guicursor+=a:blinkon0

if has('win32')
	set guifont=Meslo_LG_S:h12
else
	set guifont=Monospace\ 12
endif
" }}}
" Leaders {{{
nnoremap <leader>n :NERDTree %:h<cr>
nnoremap <leader>u :UndotreeShow<cr>
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
nnoremap <silent><leader>r :set relativenumber!<cr>:set number!<cr>
nnoremap <leader>cl2 :set conceallevel=2<cr>
nnoremap <leader>cl0 :set conceallevel=0<cr>

" Change Vim working directory to the dir of the currently open file
nnoremap <leader>cd :cd %:p:h 
nnoremap <leader>ma :! maim -s -u -d 1 fig/

inoremap <leader>w <esc>:w<cr>a

map  <leader>s <Plug>(easymotion-bd-w)

nnoremap <leader>ep :e ~/Dropbox/papiery/

" limelight
if has('linux')
	nnoremap <silent><leader>L :Limelight!!<cr>:set cursorline!<cr>
else
	nnoremap <silent><leader>L :Limelight!! 0.8<cr>:set cursorline!<cr>
endif

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
			\ 'bg+':     ['bg', 'User1'],
			\ 'hl+':     ['fg', 'Statement'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment'] }

if has('win32')
	let g:fzf_preview_window = ''
endif
" }}}
" UltiSnips {{{
let g:UltiSnipsSnippetDirectories=["ultisnips"]
" }}}
" Misc {{{
" GPG
let g:GPGDefaultRecipients = ['zplhatesbananas@gmail.com']

" Toggle folding
nnoremap z<Space> za

" Some format options
au FileType vim set fo-=c fo-=r fo-=o

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
	call CustomHi()
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Limelight settings
let g:limelight_bop = '^.*$'
let g:limelight_eop = '\n'
let g:limelight_paragraph_span = 3
let g:limelight_conceal_ctermfg = 236

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
" Disable Ex mode
nnoremap Q <Nop>
" Cursor movement
nnoremap j gj
nnoremap k gk
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

" Extremes
nnoremap H ^
nnoremap L $

" Focus movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" }}}
" Coding {{{
" vim-jedi {{{
let g:jedi#auto_initialization = 0
function! CallJedi()
    setlocal omnifunc=jedi#completions
    let g:jedi#max_doc_height = 50
    nnoremap <silent> <buffer> <localleader>r :call jedi#rename()<cr>
    nnoremap <silent> <buffer> K :call jedi#show_documentation()<cr>
endfunction
let g:jedi#show_call_signatures = 0
" }}}
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
au BufNewFile,BufRead *.py :call CallJedi()

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
"let g:pandoc#command#autoexec_on_writes = '1'
"let g:pandoc#command#autoexec_command = ':Pandoc pdf --template="~/Dropbox/papiery/defaults.latex"'

nnoremap <silent> <leader>cc :Pandoc pdf --template="~/Dropbox/papiery/defaults.latex"<cr>

if has("linux")
	nnoremap <expr> <leader>oo ":!".expand("$PDFVIEWER")." ".expand("%:p:r").".pdf<cr><cr>"
else
	nnoremap <expr> <leader>oo ":Start! ".expand("$PDFVIEWER")." ".expand("%:p:r").".pdf<cr>"
endif

" }}}
" Pencil {{{
" Suspend autoformat during the next Insert
let g:pencil#map#suspend_af = 'K'
let g:pencil#conceallevel = 0

function! Prose()
	call pencil#init({'wrap': 'hard', 'textwidth': '79'})
	nnoremap <buffer> k gk
	nnoremap <buffer> j gj
	setlocal statusline=%t\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %{wordcount().words}w\ %=\ %P%)
	set spelllang=en,pl
endfunction

" Maybe a better way would be to use a modeline i.e. # vim:spelllang=en/pl?

autocmd FileType markdown,mkd,txt  call Prose()
autocmd FileType tex 							 call pencil#init({'wrap': 'soft'})

" }}}
" Markdown {{{
let g:vim_markdown_folding_disabled = 1
function! NoIndent()
	setlocal noautoindent
	setlocal nocindent
	set indentexpr=""
endfunction

" no more auto bullets
" https://vi.stackexchange.com/questions/12000/prevent-neovim-from-breaking-one-markdown-bullet-point-into-multiple-ones
set fo-=q

let g:vim_markdown_new_list_item_indent = 0

autocmd FileType markdown call NoIndent()
autocmd BufEnter * set fo-=n fo-=r fo-=q
" }}}
" LaTeX (vimtex) {{{
"if empty(v:servername) && exists('*remote_startserver')
"	call remote_startserver('VIM')
"endif

let g:tex_flavor = "latex"
let g:vimtex_motion_matchparen = 0
let g:vimtex_indent_enabled = 0
let g:vimtex_matchparen_enabled = 0
let g:vimtex_fold_enabled = 1
let g:vimtex_view_forward_search_on_start = 0
let g:ale_linters = {
\   'tex': [],
\}

if has('linux')
	let g:vimtex_view_method = 'zathura'
endif

au BufNewFile,BufRead *.tikz set filetype=tex

let g:vimtex_compiler_latexmk = {
		\ 'build_dir' : 'build',
		\ 'callback' : 1,
		\ 'continuous' : 1,
		\ 'executable' : 'latexmk',
		\ 'hooks' : [],
		\ 'options' : [
		\   '-pdf',
		\   '-verbose',
		\   '-file-line-error',
		\   '-synctex=1',
		\   '-interaction=nonstopmode',
		\		'-shell-escape',
		\ ],
		\}

let g:tex_conceal='abdmg'
let g:vimtex_quickfix_open_on_warning = 0
" }}}
" Journal {{{
" Creates a new .md file with a date on top and appends time of every new entry
" just like org-journal
function! JournalOpen()
	return ':e ~/Dropbox/journal/'.strftime('%Y%m%d').'.txt.gpg'
endfunction

nnoremap <expr> <leader>oj JournalOpen()

autocmd BufNewFile ~/Dropbox/journal/* :$pu!=strftime('%A, %d.%m.%y')
autocmd BufNewFile ~/Dropbox/journal/* :$pu=strftime('%H:%M ') | :normal GA
autocmd BufNewFile ~/Dropbox/journal/* setlocal tw=79
autocmd BufRead ~/Dropbox/journal/* setlocal tw=79
autocmd BufRead ~/Dropbox/journal/* $pu=strftime('%H:%M ') | :normal GA

" }}}
" }}}


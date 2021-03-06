" Setup {{{
set nocompatible
autocmd!

syntax on

set runtimepath=$HOME/.vim,$XDG_CONFIG_HOME/vim,$VIM,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
set encoding=utf8
set mouse=a
set backspace=2         " make backspace work like most other programs
set wildmenu            " tab completion
set cmdheight=1
set guioptions=cgt
set smartindent
set numberwidth=4
set laststatus=1
set ruler
set diffopt+=vertical   " vertical diff (for fugitive)
set splitbelow          " split everything below (for term)
set foldmethod=marker
set spellcapcheck=
set relativenumber
set number
set cursorline
set updatetime=50
set fileformat=unix

" Tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Search
set ignorecase
set incsearch

augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
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
Plug 'vimwiki/vimwiki'
Plug 'sainnhe/everforest'

if has('win32')
    Plug 'gruvbox-community/gruvbox'
    Plug 'morhetz/gruvbox'
else "for Linux/macOS
    Plug 'noahfrederick/vim-noctu'
endif

call plug#end()
filetype plugin indent on

" }}}
" GUI tweaks {{{

" Set theme
if has('linux')
    colorscheme noctu
    " Decided to give statusline on GVim a little break
    set statusline=
    set statusline+=%t\ 
    set statusline+=%h%w%m%r\ 
    set statusline+=%=%(%l,%c%V\ %=\ %P%) 
    set laststatus=2

    "colorscheme noctu
    colorscheme everforest
    set background=dark
    set termguicolors
else
    let g:gruvbox_italic = 0
    colorscheme gruvbox
    set background=dark
endif

" Goyo breaks my custom styling so I packed them
" into a function and invoke again on s:goyo_leave()
function! CustomHi()
    hi SpellBad cterm=bold ctermfg=167
    hi VertSplit ctermfg=9 
    hi CursorLine cterm=none ctermbg=234
    hi CursorLineNr cterm=bold ctermbg=234
    hi Statusline cterm=bold ctermfg=16 ctermbg=8
    hi WildMenu ctermfg=12 ctermbg=0 cterm=bold
    " Highlight characters exceeding 80 per line
    hi ColorColumn ctermbg=4
    call matchadd('ColorColumn', '\%81v', 100)
endfunction

if has('linux')
    call CustomHi()
    set nocursorline
endif

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

if has("gui_running")
    set lines=30 columns=85
endif
if has('win32')
    "set guifont=Meslo_LG_S:h14
    set guifont=Fira_Code_Medium:h14
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
nnoremap <silent><leader>g :Goyo<cr>
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

map <leader>s <Plug>(easymotion-bd-w)

nnoremap <leader>ep :e ~/Pudlo/papiery/

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
nnoremap <silent><leader>op :Files ~/Pudlo/papiery/<CR>
nnoremap <silent><leader>od :Files ~/Pudlo/<CR>

let g:fzf_layout = { 'down': '~30%' }

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
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    set guicursor+=a:blinkon0
    set noshowmode
endfunction

function! s:goyo_leave()
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    call CustomHi()
    set showmode
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

" Brackets
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O
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
" C {{{
function! ForC()
    nnoremap <F9> :w<CR>:exec '!gcc -std=c11' shellescape(@%, 1) '&& ./a.out'<CR>
endfunction

au BufNewFile,BufRead *.c call ForC()
au BufNewFile,BufRead *.c ALEDisable

" }}}
" Python {{{
function! ForPython()
    " PEP 8
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
    set textwidth=79
    set expandtab
    set autoindent
    set fileformat=unix
    autocmd FileType python map <buffer> <F9> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
    autocmd FileType python imap <buffer> <F9> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>
endfunction

au BufNewFile,BufRead *.py :call ForPython()
au BufNewFile,BufRead *.py :call CallJedi()

" Run current .py

" }}}
" Java {{{
function! ForJava()
    nnoremap <F9> :Make<CR>
    nnoremap <silent><F10> :terminal java %:r $SHELL<CR>
    set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
endfunction

autocmd FileType java set makeprg=javac\ %
autocmd FileType java call ForJava()
":!java %:r<CR>
":copen<Return>
" }}}
" Misc {{{
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
"let g:pandoc#command#autoexec_command = ':Pandoc pdf --template="~/Pudlo/papiery/defaults.latex"'

nnoremap <silent> <leader>cc :Pandoc pdf --template="~/Pudlo/papiery/defaults.latex"<cr>

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
    set nowrap
    nnoremap <buffer> k gk
    nnoremap <buffer> j gj
    setlocal statusline=%t\ %h%w%m%r\ %=%(%l,%c%V\ %=\ %{wordcount().words}w\ %=\ %P%)
    set spelllang=pl
    set nospell
endfunction

"autocmd FileType markdown,md,txt  call Prose()
autocmd BufEnter *.md,*.txt                 call Prose()
autocmd FileType tex                        call pencil#init({'wrap': 'soft'})

" }}}
" Markdown {{{
let g:vim_markdown_folding_disabled = 1

" no more auto bullets and indentation
function! NoIndent()
    setlocal noautoindent
    setlocal nocindent
    set indentexpr=""
endfunction

" https://vi.stackexchange.com/questions/12000/prevent-neovim-from-breaking-one-markdown-bullet-point-into-multiple-ones

let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

autocmd FileType markdown call NoIndent()
autocmd BufEnter * set fo-=n fo-=r fo-=q
" }}}
" LaTeX (vimtex) {{{
"if empty(v:servername) && exists('*remote_startserver')
"   call remote_startserver('VIM')
"endif

let g:tex_flavor = "latex"
let g:vimtex_motion_matchparen = 0
let g:vimtex_indent_enabled = 0
let g:vimtex_fold_enabled = 1
let g:vimtex_matchparen_enabled = 0
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
        \       '-shell-escape',
        \ ],
        \}

let g:tex_conceal='abdmg'
let g:vimtex_quickfix_open_on_warning = 0
" }}}
" Journal {{{
" Creates a new .md file with a date on top and appends time of every new entry
" just like org-journal
function! JournalOpen()
    return ':e ~/Pudlo/journal/'.strftime('%Y%m%d').'.txt.gpg'
endfunction

nnoremap <expr> <leader>oj JournalOpen()

autocmd BufNewFile ~/Pudlo/journal/* $pu!=strftime('%A, %d.%m.%y')
autocmd BufWinEnter ~/Pudlo/journal/* setlocal tw=79 nowrap
autocmd BufWinEnter ~/Pudlo/journal/* call append(line('$'), '')
autocmd BufWinEnter ~/Pudlo/journal/* $pu!=strftime('%H:%M ') | :normal GA

" }}}
" vimwiki {{{
let g:vimwiki_list = [{'path':'$HOME/Pudlo/wszystko', 'path_html':'$HOME/Pudlo/wszystko/export/html/', 'auto_toc': 1}]

let g:vimwiki_hl_headers = 1
let g:vimwiki_auto_header = 1
let g:vimwiki_toc_header = 'TOC'
let g:vimwiki_global_ext = 0

hi VimWikiItalic ctermfg=4

autocmd BufEnter *.wiki set textwidth=79 nowrap

autocmd BufEnter *.wiki nnoremap <buffer><silent><leader>q :VimwikiGoBackLink<cr>
autocmd BufEnter index.wiki nnoremap <buffer><leader>q :q<cr>

" }}}
" }}}


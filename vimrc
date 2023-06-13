" Setup {{{
set nocompatible
autocmd!

syntax on

set encoding=utf8
set mouse=a
set backspace=2         " make backspace work like most other programs
set wildmenu            " tab completion
set cmdheight=1
set guioptions=cgt
set smartindent
set nowrap
set textwidth=79
set numberwidth=4
set laststatus=2
set ruler
set diffopt+=vertical   " vertical diff (for fugitive)
set splitbelow          " split everything below (for term)
set foldmethod=marker
set spellcapcheck=
set relativenumber
set number
set fileformat=unix
set title
set titlestring=%t

" don't insert comment leader after I: <Enter> or N: o/O
autocmd BufEnter * set formatoptions-=ro

" Tabs to spaces
set tabstop=2
set shiftwidth=2
set expandtab

" Search
set ignorecase
set incsearch
set smartcase

augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
nnoremap <silent> <cr> :noh<CR><CR>

if empty(glob(expand("$HOME") . "/.vim/tmp"))
    silent !mkdir -p ~/.vim/tmp
endif

let $VIMDIR = "~/.vim""

set backup
set backupdir=~/.vim/tmp//
set directory=~/.vim/tmp//
set undofile
set undodir=~/.vim/tmp//

language en_US.utf8

if has('linux')
    language time pl_PL.utf8
    if !exists("g:ubuntu")
        let $PDFVIEWER = "zathura"
        let g:vimtex_view_method = 'zathura'
    endif
endif

if has('win32')
    language time pl_PL
    let $PDFVIEWER = "SumatraPDF"
endif
" }}}
" Plugins {{{
if empty(glob(expand("$HOME") . "/.vim/autoload/plug.vim"))
    if has('win32')
        iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
        ni $HOME/.vim/autoload/plug.vim -Force
    else
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $VIMDIR/vimrc
    endif
endif

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'lervag/vimtex'
Plug 'preservim/vim-markdown'
Plug 'honza/vim-snippets'
Plug 'jamessan/vim-gnupg'
Plug 'junegunn/vim-peekaboo'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'gruvbox-community/gruvbox'

if has('python3')
    Plug 'SirVer/ultisnips'
endif

call plug#end()
filetype plugin indent on
" }}}
" Look and feel {{{
set listchars=tab:▸\ ,eol:¬

set t_Co=256
let g:gruvbox_guisp_fallback='bg'
colorscheme gruvbox
set background=dark
set notermguicolors

" Disable bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Set scrolloff margin to 33% of winheight
augroup VCenterCursor
    autocmd!
    autocmd BufEnter,WinEnter,WinNew,VimResized *,*.*
                \ let &scrolloff=winheight(win_getid())/3
augroup END

" }}}
" GVIM/Windows tweaks {{{
if has("gui_running")
    " TODO: is setting rtp necessary?
    set runtimepath=$HOME/.vim,$XDG_CONFIG_HOME/vim,$VIM,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after
    set langmenu=en_US
    let $LANG = 'en_US'
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    set guicursor+=a:blinkon0

    set lines=30 columns=85

    if has('win32')
        "set guifont=Meslo_LG_S:h14
        set guifont=Fira_Code_Medium:h18
    else
        set guifont=Monospace\ 12
    endif
endif
" }}}
" Leaders {{{
nnoremap <leader>u :UndotreeShow<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>e :w!<cr>:e %:h<cr>
nnoremap <leader>ov :e $VIMDIR/vimrc<cr>
nnoremap <leader>P "+p
nnoremap <leader>Y "+y
nnoremap <silent><leader>g :Goyo<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>b <C-^>
nnoremap <leader>G :Git<cr>
nnoremap <leader>B :Buffers<cr>
nnoremap <silent><leader>r :set number! relativenumber!<cr>
nnoremap <leader>cl2 :set conceallevel=2<cr>
nnoremap <leader>cl0 :set conceallevel=0<cr>

" Change Vim working directory to the dir of the currently open file
nnoremap <leader>cd :cd %:p:h 
nnoremap <leader>ma :! maim -s -u -d 1 fig/

inoremap <leader>w <esc>:w<cr>a

"map <leader>s <Plug>(easymotion-bd-w)

nnoremap <leader>ep :e ~/Pudlo/papiery/

" }}}
" Fuzzy {{{
nnoremap <silent><leader>oh :Files ~<CR>
nnoremap <silent><leader>og :Files ~/git/<CR>
nnoremap <silent><leader>on :Files ~/Pudlo/notatki/<CR>
nnoremap <silent><leader>od :Files <CR>
nnoremap <silent><leader>op :Files ~/Pudlo/<CR>
nnoremap <silent><leader>os :Files ~/Pudlo/studia/I11/<CR>

let g:fzf_layout = { 'down': '~40%' }

if has('win32')
    let g:fzf_preview_window = ''
endif
" }}}
" UltiSnips {{{
let g:UltiSnipsSnippetDirectories=["ultisnips"]
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" }}}
" Zen {{{
function! s:goyo_enter()
    set guicursor+=a:blinkon0
    set noshowmode
endfunction

function! s:goyo_leave()
    call CustomHi()
    set showmode
endfunction

let g:goyo_linenr = 1

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}
" Mappings {{{
" Toggle folding
nnoremap z<Space> za

" Disable Ex mode
nnoremap Q <Nop>

" Cursor movement
nnoremap j gj
nnoremap k gk
"inoremap <C-k> <C-o>gk
"inoremap <C-h> <Left>
"inoremap <C-l> <Right>
"inoremap <C-j> <C-o>gj

" Extremes
nnoremap H ^
nnoremap L $

" Focus movement
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NGrep (connermcd)
"command! -nargs=1 Ngrep vimgrep "<args>" ~/Pudlo/notatki/**/*.md
command! -nargs=1 Ngrep vimgrep "<args>"../../**/*
nnoremap <leader>[ :Ngrep 

nnoremap <C-n> :cnext<cr>z.
nnoremap <C-p> :cprev<cr>z.

" Search and replace selected text
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
" }}}
" Coding {{{
autocmd BufNewFile,BufRead *.asm set ft=nasm sw=8 ts=8 tw=90
" }}}
" Text {{{
" Spellcheck {{{
" If .add file was updated via git, recompile .spl
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        silent exec 'mkspell! ' . fnameescape(d)
    endif
endfor
" }}}
" pandoc {{{
nnoremap <expr> <silent> <leader>cc ":!pandoc ".expand("%:p:r").".md -o ".expand("%:p:r").".pdf --from markdown --template eisvogel --listings<cr>"
nnoremap <expr> <leader>oo ":!xdg-open ".expand("%:p:r").".pdf<cr><cr>"
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
autocmd FileType markdown setl textwidth=79 shiftwidth=2
autocmd BufNewFile,BufRead **/_posts/* set spell spelllang=en_us
" }}}
" LaTeX (vimtex) {{{
let g:vimtex_motion_matchparen = 0
"let g:vimtex_indent_enabled = 0
"let g:vimtex_fold_enabled = 1
let g:vimtex_matchparen_enabled = 0
let g:vimtex_view_forward_search_on_start = 0

" Close the loclist window automatically when the buffer is closed
augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

autocmd BufNewFile,BufRead *.tikz set filetype=tex

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
" Creates a new .txt.gpg file with a date on top and appends time of every new entry
let $JOURNALDIR = "/home/adam/Pudlo/journal"

function! JournalOpen()
    return ':e '.$JOURNALDIR.'/'.strftime('%Y%m%d').'.txt.gpg'
endfunction

nnoremap <expr> <leader>oj JournalOpen()

autocmd BufNewFile  $JOURNALDIR/* $pu!=strftime('%A, %d.%m.%y')
autocmd BufWinEnter $JOURNALDIR/* setlocal tw=79 nowrap
autocmd BufWinEnter $JOURNALDIR/* call append(line('$'), '') | $pu!=strftime('%H:%M') | call append(line('$'), '') | normal GA

" }}}
" Diacritics {{{
" Remove diacritical signs from characters in specified range of lines.
" Examples of characters replaced: á -> a, ç -> c, Á -> A, Ç -> C.
function! s:RemoveDiacritics(line1, line2)
  let diacs = 'áâãàąçćéêęíłńóôõśüúżź'  " lowercase diacritical signs
  let repls = 'aaaaacceeeilnooosuuzz'  " corresponding replacements
  let diacs .= toupper(diacs)
  let repls .= toupper(repls)
  let all = join(getline(a:line1, a:line2), "\n")
  call setline(a:line1, split(tr(all, diacs, repls), "\n"))
endfunction

command! -range=% RemoveDiacritics call s:RemoveDiacritics(<line1>, <line2>)
" }}}
" }}}
" Misc {{{
" Fix syntax highlighter not processing blocks of code properly
autocmd BufEnter * :syntax sync fromstart

let g:GPGDefaultRecipients = ['zplhatesbananas@gmail.com']

autocmd FileType vim set fo-=c fo-=r fo-=o

" Create parent directory on save 
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

let g:UltiSnipsSnippetDirectories = ['~/.vim/ultisnips']

if v:version >= 900
    set wildoptions=pum
    set autoshelldir
endif
"}}}

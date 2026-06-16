" ============================================================================
" Vanilla-vim fallback config (primary editor is nvim ~/.config/nvim/init.lua).
" Plugin manager: vim-plug. Kept self-contained / no-compile so it works on a
" bare server: clone + :PlugInstall and everything is ready.
" ============================================================================

" leader
let mapleader = " "

set nocompatible
filetype indent plugin on
syntax on

set hidden
set tabstop=2
set autoindent
set copyindent
set number
set shiftwidth=2
set shiftround
set ignorecase
set hlsearch
set incsearch
set expandtab
set ls=2                  " Always show status line

" bash-like tabbing
set wildmode=longest,list,full
set wildmenu

set history=5000          " remember more commands and search history
set undolevels=1000       " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                 " change the terminal's title
set novisualbell          " don't beep
set noerrorbells          " don't beep

" disable backup buffers
set nobackup
set noswapfile

" highlight evil whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd FileType go setlocal nolist

" Shorter updatetime for snappier diagnostics/gitgutter
set updatetime=300

" Always show the signcolumn, otherwise text shifts when diagnostics appear
set signcolumn=yes

" Fix syntax coloring on long lines (slow past ~300 cols)
set synmaxcol=300

" ============================================================================
" Key maps (plugin-independent)
" ============================================================================
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>
imap kk <Esc>

nnoremap ; :
nnoremap j gj
nnoremap k gk

" make yank Y behave like C and D (help Y)
map Y y$

" center search display
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" keep selection after in/outdent
vnoremap < <gv
vnoremap > >gv

" Better command mode navigation
cmap <C-j> <down>
cmap <C-k> <up>

" sudo save a file after editing it
cmap w!! w !sudo tee % >/dev/null

" open file from same directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" insert today's date
nnoremap <Leader>t :put =strftime('%Y-%m-%d')<CR>

" execute current line as shell command
nnoremap <Leader>r :.!sh<CR>

" C-s to save
nnoremap <C-s> :w<CR>
vnoremap <C-s> <Esc>:w<CR>

" clipboard yank/paste via xsel
vnoremap <Leader>y :w !xsel -i -b<CR><CR>
nnoremap <Leader>y "hyiw:silent !echo "<C-r>h" \| xsel -b<CR>:redraw!<CR>
nnoremap <Leader>p :r !xsel -o -b<CR><CR>

" tig on current file
command! -nargs=0 -bar Tig execute '! tig %'

" ============================================================================
" Plugins (vim-plug)
" ============================================================================
" Auto-install vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

"" Meta
Plug 'junegunn/vim-plug'                 " :help for vim-plug

"" Theme: solarized8 (truecolor, degrades to 256/16 on poorer terminals)
Plug 'lifepillar/vim-solarized8'

"" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'                 " GitHub support for fugitive
Plug 'airblade/vim-gitgutter'

"" Navigating
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                  " replaces ctrlp
Plug 'chaoren/vim-wordmotion'            " replaces camelcasemotion
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

"" Editing
Plug 'tpope/vim-surround'                " replaces 'surround'
Plug 'tpope/vim-repeat'                  " '.' support for surround/abolish
Plug 'tpope/vim-commentary'              " replaces The_NERD_Commenter
Plug 'tpope/vim-abolish'                 " replaces 'abolish' (:Subvert)
Plug 'mg979/vim-visual-multi'            " replaces vim-multiple-cursors
Plug 'Raimondi/delimitMate'
Plug 'editorconfig/editorconfig-vim'

"" Linting / LSP (no-compile; replaces Syntastic + YouCompleteMe)
Plug 'dense-analysis/ale'

"" Statusline (replaces vim-powerline)
Plug 'itchyny/lightline.vim'

"" Syntax & Languages
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
Plug 'ARM9/arm-syntax-vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" C/C++ (linting + LSP via ALE/clangd; this adds modern syntax highlighting)
Plug 'bfrg/vim-cpp-modern'
" XML
Plug 'sukima/xmledit'                    " auto-close & edit XML/HTML tags

"" Misc
Plug 'MikeDacre/tmux-zsh-vim-titles'     " sensible tmux/zsh/vim titles
Plug 'tpope/vim-dispatch'                " async make/dispatch

call plug#end()

" ============================================================================
" Theme
" ============================================================================
" Force 256 colors minimum
if &term =~# '256color' || &term =~# 'tmux' || &term =~# 'screen'
  set t_Co=256
endif

" Enable truecolor support
if has('termguicolors')
  " tmux-256color support - set escape sequences for truecolor
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

syntax enable
set background=dark

" Load desert theme (built-in)
colorscheme desert

" ============================================================================
" Plugin config
" ============================================================================

" --- lightline: match solarized, and hide the default -- INSERT -- (it renders mode)
let g:lightline = { 'colorscheme': 'solarized' }
set noshowmode

" --- vim-json: turn off quote concealing
let g:vim_json_syntax_conceal = 0

" --- vim-racer
let g:racer_experimental_completer = 1

" --- fzf (replaces CtrlP) ---------------------------------------------------
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>] :Tags<CR>
" grep the word under cursor / selection with ripgrep
nnoremap <Leader>g :Rg <C-r><C-w><CR>
vnoremap <Leader>g "hy:Rg <C-r>h<CR>

" Use ripgrep for :grep
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" --- vim-abolish (:Subvert) -------------------------------------------------
" replace word under cursor / selection across the file, with confirmation
nnoremap <Leader>s "hyiw:%Subvert/<C-r>h//gc<left><left><left>
vnoremap <Leader>s "hy:%Subvert/<C-r>h//gc<left><left><left>

" --- ALE (lint + LSP, replaces Syntastic + YCM) -----------------------------
let g:ale_completion_enabled = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 0
" navigation / docs (formerly YcmCompleter GoToDefinition / GetDoc)
nmap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> <Leader>gd :ALEHover<CR>
" diagnostics navigation
nmap <silent> <Leader>aj :ALENext<CR>
nmap <silent> <Leader>ak :ALEPrevious<CR>

" --- quickfix ---------------------------------------------------------------
" jump to quickfix window after grep-like commands
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow
nmap <silent> <Leader>n :cn<CR>
nmap <silent> <Leader>N :cp<CR>

" ============================================================================
" Filetype tweaks
" ============================================================================
autocmd FileType markdown setlocal nofoldenable

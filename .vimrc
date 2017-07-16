" leader
let mapleader = ","

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
set ls=2 " Always show status line

" bash-like tabbing
set wildmode=longest,list,full
set wildmenu

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set novisualbell           " don't beep
set noerrorbells         " don't beep set scrolloff=999 " center screen on search scroll

" disable backup buffers
set nobackup
set noswapfile

" highlight evil whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" key maps
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>
imap kk <Esc>

nnoremap ; :
nnoremap j gj
nnoremap k gk

" center search display
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#z

" keep selection after in/outdent
vnoremap < <gv
vnoremap > >gv
" sudo save a file after editing it
cmap w!! w !sudo tee % >/dev/null

" Ctrl+C, Ctrl+V copy paste
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y

" VAM
set nocompatible | filetype indent plugin on | syn on

set t_RV= " http://bugs.debian.org/608242, http://groups.google.com/group/vim_dev/browse_thread/thread/9770ea844cec3282

fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME') . '/.vim/vim-addons'
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  " let g:vim_addon_manager = { your config here see "commented version" example and help
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
                \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons([], {'auto_install' : 1})
  " git
  VAMActivate fugitive
  VAMActivate github:junkblocker/patchreview-vim
  VAMActivate github:codegram/vim-codereview
  " universal language file rules
  VAMActivate editorconfig-vim
  " UI
  VAMActivate github:airblade/vim-gitgutter
  VAMActivate github:Lokaltog/vim-powerline
  VAMActivate Syntastic
  " Theme
  VAMActivate github:altercation/vim-colors-solarized
  " Editing
  VAMActivate abolish
  VAMActivate github:ervandew/supertab
  VAMActivate The_NERD_Commenter
  VAMActivate github:skwp/greplace.vim
  VAMActivate delimitMate
  VAMActivate github:terryma/vim-multiple-cursors
  VAMActivate surround
  VAMActivate YankRing
  " Navigating
  VAMActivate ctrlp
  VAMActivate camelcasemotion
  VAMActivate github:christoomey/vim-tmux-navigator
  VAMActivate ag
  " Other syntax
  VAMActivate scss-syntax
  VAMActivate vim-coffee-script
  VAMActivate github:freitass/todo.txt-vim
  VAMActivate github:jceb/vim-orgmode
  VAMActivate github:blindFS/vim-taskwarrior
  VAMActivate sql_iabbr
  VAMActivate changesqlcase
  VAMActivate github:tmux-plugins/vim-tmux
  VAMActivate github:honza/dockerfile.vim
  VAMActivate tpp
  VAMActivate github:pangloss/vim-javascript github:mxw/vim-jsx
  VAMActivate github:mrtazz/simplenote.vim
  " Ruby
  VAMActivate vim-ruby
  VAMActivate Conque_Shell github:skwp/vim-ruby-conque
  VAMActivate github:jgdavey/vim-blockle
  VAMActivate textobj-rubyblock
  VAMActivate github:danchoi/ri.vim
  VAMActivate endwise
  VAMActivate rails
  VAMActivate github:KurtPreston/vim-autoformat-rails
  VAMActivate github:vim-scripts/matchit.zip
  VAMActivate github:ecomba/vim-ruby-refactoring
  " clojure & overtone
  VAMActivate github:guns/vim-clojure-static
  VAMActivate github:tpope/vim-fireplace
  VAMActivate github:tpope/vim-classpath



  " Old, activate w/ caution and as needed
  " 'snipmate',
  " 'repeat',
  " 'rsi',
  " 'taglist',
  " 'bufkill',
  " 'vim-seek',
  " 'github:skammer/vim-css-color',
  " 'github:greyblake/vim-preview',
  " 'PA_ruby_ri',
  " 'dbext',
  " 'vim-scala',
  " 'Switch'
  " 'textobj-user',
  " 'vim-ruby',
  " 'closetag',
endfun
call SetupVAM()

" config for simplenote
source ~/.simplenoterc

" Solarized color scheme
syntax enable
set background=dark
set t_Co=16
colorscheme solarized

" http://stackoverflow.com/questions/901313
set synmaxcol=120

" Camel case motion ovrride default maps
map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Add 1 space to comments
let NERDSpaceDelims=1

" ruby conque runner
let g:ruby_conque_rspec_runner='rspec'
let g:ruby_conque_rspec_options=''

set grepprg=git\ grep
let g:grep_cmd_opts = '-n'

let g:rails_projections = {
      \ "spec/features/*s_spec.rb": {
      \ "command": "feature",
      \ "affinity": "view"
      \ } }
" snipmate rebinding
" let g:snips_trigger_key='<c-space>'

" Ruby conque shortcuts
nmap <silent> <Leader>j :call RunRspecCurrentFileConque()<CR>
nmap <silent> <Leader>l :call RunRspecCurrentLineConque()<CR>
nmap <silent> ,<Leader>j :call RunLastConqueCommand()<CR>

" CtrlP shortcut
nmap <silent> <Leader>f :CtrlP<CR>

" quickfix jump bindings
nmap <silent> <Leader>n :cn<CR>
nmap <silent> <Leader>N :cp<CR>

" clipboard yank/paste
vnoremap <Leader>y "+y
vnoremap <Leader>p "+p

" open file from same directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" replace visual selection
vnoremap <Leader>r "hy:%Subvert/<C-r>h//gc<left><left><left>
nnoremap <Leader>r "hyiw:%Subvert/<C-r>h//gc<left><left><left>

vnoremap <C-g> "hy:Ggrep <C-r>h
nnoremap <C-g> "hyiw:Ggrep <C-r>h

command! -nargs=0 -bar Tig execute '! tig %'

" Org-mode
let g:org_agenda_files=['~/todo/work.org']

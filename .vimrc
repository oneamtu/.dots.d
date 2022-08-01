" leader
let mapleader = " "

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

set history=5000         " remember more commands and search history
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
autocmd FileType go setlocal nolist

" https://github.com/neoclide/coc.nvim
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
" set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" end neoclide

" key maps
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>
imap kk <Esc>

nnoremap ; :
nnoremap j gj
nnoremap k gk

" make yank Y behave like C and D
" help Y
map Y y$

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
  VAMActivate github:tpope/vim-rhubarb
  VAMActivate github:junkblocker/patchreview-vim
  VAMActivate github:codegram/vim-codereview
  " universal language file rules
  VAMActivate editorconfig-vim
  " UI
  VAMActivate github:airblade/vim-gitgutter
  VAMActivate github:Lokaltog/vim-powerline
  VAMActivate Syntastic
  " Editing
  VAMActivate abolish
  VAMActivate github:ervandew/supertab
  VAMActivate github:ycm-core/YouCompleteMe
  VAMActivate The_NERD_Commenter
  VAMActivate delimitMate
  VAMActivate github:terryma/vim-multiple-cursors
  VAMActivate surround
  VAMActivate YankRing
  " Snippets
  " VAMActivate github:SirVer/ultisnips
  VAMActivate github:honza/vim-snippets
  " Navigating
  VAMActivate ctrlp
  VAMActivate github:sgur/ctrlp-extensions.vim
  VAMActivate github:ivalkeen/vim-ctrlp-tjump
  VAMActivate camelcasemotion
  VAMActivate github:christoomey/vim-tmux-navigator
  VAMActivate github:yegappan/grep
  VAMActivate github:vim-scripts/ctags.vim
  VAMActivate github:benmills/vimux
  " Other syntax
  VAMActivate scss-syntax
  VAMActivate vim-coffee-script
  VAMActivate github:freitass/todo.txt-vim
  VAMActivate github:jceb/vim-orgmode
  VAMActivate speeddating
  " VAMActivate github:blindFS/vim-taskwarrior
  VAMActivate sql_iabbr
  VAMActivate changesqlcase
  VAMActivate github:tmux-plugins/vim-tmux
  VAMActivate github:honza/dockerfile.vim
  VAMActivate tpp
  VAMActivate github:pangloss/vim-javascript github:mxw/vim-jsx
  " Ruby
  VAMActivate github:tpope/vim-bundler
  VAMActivate github:vim-ruby/vim-ruby
  VAMActivate github:tpope/vim-rake
  VAMActivate github:AndrewRadev/splitjoin.vim
  VAMActivate github:jgdavey/vim-blockle
  VAMActivate textobj-rubyblock
  VAMActivate github:ecomba/vim-ruby-refactoring
  VAMActivate endwise
  VAMActivate github:skalnik/vim-vroom
  VAMActivate rails
  VAMActivate github:KurtPreston/vim-autoformat-rails
  VAMActivate github:vim-scripts/matchit.zip
  " Crystal
  VAMActivate github:rhysd/vim-crystal
  " clojure & overtone
  VAMActivate github:guns/vim-clojure-static
  VAMActivate github:tpope/vim-fireplace
  VAMActivate github:tpope/vim-classpath
  " LaTeX
  VAMActivate github:lervag/vimtex
  " Elm
  " VAMActivate github:w0rp/ale

  " 'dbext',
endfun
call SetupVAM()

" auto set-up plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" TODO: Try EasyMotion
" TODO: Convert VAM plugins over to Plug

" Plug plugins
call plug#begin('~/.vim/bundle')

"" Meta
" Help for vim-plug
Plug 'junegunn/vim-plug'

" Theme
Plug 'altercation/vim-colors-solarized'

"" Syntax & Languages
" Better json syntax highlighting
Plug 'elzr/vim-json'
" golang
Plug 'fatih/vim-go'
" rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'
" AI code-completion
Plug 'github/copilot.vim'

let g:racer_experimental_completer = 1

" Markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Sensible tmux/zsh/vim titles
Plug 'MikeDacre/tmux-zsh-vim-titles'
" Make dispatched to other window
Plug 'tpope/vim-dispatch'

" Code Completion
" TODO: come back to coc, might work better with nvim
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" Solarized color scheme
syntax enable
set background=dark
set t_Co=16
colorscheme solarized

" Turn off weird quote hiding
let g:vim_json_syntax_conceal = 0

" Coc installed extensions
" NOTE: There may be a way to get these installed on load
"
" :CocInstall coc-marketplace
" :CocInstall coc-tag
" :CocInstall coc-ruby
" :CocInstall coc-snippets
" :CocInstall coc-emoji

" Fix syntax coloring issues for long lines
" God help you if you have lines > 300
" http://stackoverflow.com/questions/901313
set synmaxcol=300

" Camel case motion ovrride default maps
map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e
omap iw <Plug>CamelCaseMotion_iw
xmap iw <Plug>CamelCaseMotion_iw
omap ib <Plug>CamelCaseMotion_ib
xmap ib <Plug>CamelCaseMotion_ib
omap ie <Plug>CamelCaseMotion_ie
xmap ie <Plug>CamelCaseMotion_ie

" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Add 1 space to comments
let NERDSpaceDelims=1

" vimux
function! VimuxSlime()
  call VimuxSendText(@v)
endfunction
vmap <Leader>vs "vy :call VimuxSlime()<CR>
vmap <Leader>sms "vy :call VimuxSlime()<CR>
nmap <Leader>sms "vy :call VimuxSlime()<CR>

" vroom
let g:vroom_use_vimux=1
let g:vroom_use_zeus=1
let g:vroom_clear_screen=0

nmap <Leader>j :SplitjoinJoin<cr>
nmap <Leader>k :SplitjoinSplit<cr>

" Use ag by default for grepping
set grepprg='ag'
let g:grep_cmd_opts = '--vimgrep'

let g:rails_projections = {
      \ "spec/features/*s_spec.rb": {
      \ "command": "feature",
      \ "affinity": "view"
      \ } }

let g:rails_gem_projections = {
      \ "factory_girl_rails": {
      \   "spec/factories/*.rb": {
      \     "command": "factory",
      \     "affinity": "model",
      \     "alternate": "app/models/{}.rb",
      \     "related": "db/schema.rb#{plural}",
      \     "test": "spec/models/{}_spec.rb",
      \     "template": "FactoryGirl.create(:{})"}}}

" Rails spec factory navigation
" autocmd User Rails Rnavcommand factory  spec/factories -suffix=.rb

" ruby list newline expansion
nnoremap <Leader>h $v%lohc<CR><CR><Up><C-r>"<Esc>:s/,/,\r/g<CR>:'[,']norm ==<CR>']'"

"
nmap <silent> <Leader>d obinding.pry<Esc>

" CtrlP config
" CtrlPMixed has file, buffer and lru all in one
nmap <silent> <Leader>f :CtrlP<CR>
" Useful for seeing project .config files; will need to ignore some hidden things manually
let g:ctrlp_show_hidden = 1
" Useful extensions
let g:ctrlp_extensions = ['cmdline', 'yankring', 'menu']

" https://thoughtbot.com/blog/faster-grepping-in-vim
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s --nocolor --nogroup --hidden -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
" Clear the cache on every command
" nnoremap <silent> <leader>T :ClearCtrlPCache<cr>\|:CtrlP<cr>

nnoremap <c-]> :CtrlPtjump<cr>
vnoremap <c-]> :CtrlPtjumpVisual<cr>

" vim-ctrlp-tjump - CtrlP tags jump
" If there is only one tag found, it is possible to open it without opening
" CtrlP window:
let g:ctrlp_tjump_only_silent = 1

" ycm you complete me LSP server for ruby
let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'ruby',
  \     'cmdline': [ expand( '$HOME/.asdf/shims/solargraph' ), 'stdio' ],
  \     'filetypes': [ 'ruby' ],
  \   },
  \ ]

" make YCM compatible with UltiSnips (using supertab)
" https://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Automatically close preview doc after insert
let g:ycm_autoclose_preview_window_after_insertion = 1

" Show hover
nnoremap <Leader>gd :YcmCompleter GetDoc<CR>
nmap <silent> gd :YcmCompleter GoToDefinition<CR>

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>""

" quickfix jump bindings
nmap <silent> <Leader>n :cn<CR>
nmap <silent> <Leader>N :cp<CR>

" clipboard yank/paste
vnoremap <Leader>y :w !xsel -i -b <CR><CR>
nnoremap <Leader>y "hyiw:silent !echo "<C-r>h" \| xsel -b <CR>:redraw!<CR>
nnoremap <Leader>p :r !xsel -o -b <CR><CR>

" open file from same directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" replace visual selection
vnoremap <Leader>s "hy:%Subvert/<C-r>h//gc<left><left><left>
nnoremap <Leader>s "hyiw:%Subvert/<C-r>h//gc<left><left><left>

vnoremap <Leader>g "hy:Ag <C-r>h
nnoremap <Leader>g "hyiw:Ag <C-r>h

command! -nargs=0 -bar Tig execute '! tig %'

" Better command mode navigation
cmap <C-j> <down>
cmap <C-k> <up>

nnoremap <Leader>t :put =strftime('%Y-%m-%d')<CR>

" C-s makes vim freeze.. TODO: debug that
nnoremap <C-s> :w <CR>
vnoremap <C-s> :w <CR>

" node global version support
let $ASDF_NODEJS_VERSION = '18.1.0'

" Org-mode
let g:org_agenda_files=['~/org/work.org']

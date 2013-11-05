" leader
let mapleader = ","

" key maps
imap jj <Esc>
imap jk <Esc>
imap kj <Esc>
imap kk <Esc>

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

" bash-like tabbing
set wildmode=longest,list,full
set wildmenu

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set novisualbell           " don't beep
set noerrorbells         " don't beep

" disable backup buffers
set nobackup
set noswapfile

" highlight evil whitespaces
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

nnoremap ; :
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" sudo save a file after editing it
cmap w!! w !sudo tee % >/dev/null

" Ctrl+C, Ctrl+V copy paste
nmap <C-V> "+gP
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y

" for snipmate
filetype plugin on

" Strip trailing whitespaces
fun! StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python,sql autocmd BufWritePre <buffer> :call StripTrailingWhitespaces()

" VAM
set nocompatible | filetype indent plugin on | syn on

fun SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME') . '/.vim/vim-addons'
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  " let g:vim_addon_manager = { your config here see "commented version" example and help
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
                \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif
  call vam#ActivateAddons(['surround', 'ctrlp', 'delimitMate', 'closetag', 'The_NERD_Commenter', 'fugitive', 'Solarized', 'Syntastic', 'snipmate', 'rails', 'repeat', 'abolish', 'rsi', 'taglist', 'github:ervandew/supertab', 'multiselect', 'Conque_Shell', 'github:skwp/vim-ruby-conque', 'LustyJuggler', 'bufkill', 'github:airblade/vim-gitgutter', 'vim-seek', 'camelcasemotion', 'scss-syntax', 'github:skammer/vim-css-color', 'github:greyblake/vim-preview', 'vim-coffee-script', 'github:terryma/vim-multiple-cursors', 'PA_ruby_ri', 'dbext', 'github:freitass/todo.txt-vim'], {'auto_install' : 1})
endfun
call SetupVAM()

" Solarized color scheme
syntax on
set background=dark
colorscheme solarized

" Fixes signs for vim-gitgutter
highlight clear SignColumn

" Camel case motion ovrride default maps
map w <Plug>CamelCaseMotion_w
map b <Plug>CamelCaseMotion_b
map e <Plug>CamelCaseMotion_e
sunmap w
sunmap b
sunmap e

" Rudimentary session management
if version >= 700
   set sessionoptions=blank,buffers,curdir,tabpages,winpos,folds
endif

if !exists("s:sessionautoloaded")
   let s:sessionautoloaded = 0
endif

if filereadable('./.session.vim')
   if s:sessionautoloaded == 0
      source ./.session.vim
      let s:sessionautoloaded = 1
   endif
endif

function! SaveSession()
   if s:sessionautoloaded == 1
      mksession! ./.session.vim
      echo "Session saved."
   else
      echo "No session to save. Please create session with ':mksession .session.vim' first!"
   endif
endfunction

" Session is saved with ss ( is  by default)
nmap  ss :call SaveSession()

" Uncomment the following like if you want to save session(s) automatically on
" exit.
autocmd VimLeave * call SaveSession()

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
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
let g:ruby_conque_rspec_runner='zeus rspec'

" snipmate rebinding
let g:snips_trigger_key='<c-space>'

" Ruby conque shortcuts
nmap <silent> <Leader>j :call RunRspecCurrentFileConque()<CR>
nmap <silent> <Leader>l :call RunRspecCurrentLineConque()<CR>
nmap <silent> ,<Leader>j :call RunLastConqueCommand()<CR>

nmap <silent> <Leader>f :CtrlP<CR>

" quickfix jump bindings
nmap <silent> <Leader>n :cn<CR>
nmap <silent> <Leader>N :cp<CR>

" open file from same directory
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>

" replace visual selection
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Qargs
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(values(buffer_numbers))
endfunction


" live functionality
function EvalLiveRuby() range
  let text = [join(getline(a:firstline, a:lastline), ';')]
  return writefile(text, '/tmp/live-rb')
endfunction

map <Leader>x :call EvalLiveRuby()<enter>

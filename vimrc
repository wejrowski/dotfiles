let mapleader = " "

" copy filename " nnoremap <Leader>C :!echo '%' \| pbcopy"<cr>

" = VUNDLE > SETUP ===============================
" :PluginInstall  - install vundles
" :h vundle - for help
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'gmarik/vundle'

" = VUNDLE > NAVIGATING ==========================
Plugin 'kien/ctrlp.vim'
Plugin 'JazzCore/ctrlp-cmatcher'
let g:ctrlp_match_func = {'match' : 'matcher#cmatch' }
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_max_files=100000
set wildignore+=*build/iPhone*,*.jar,*.class,*target

Plugin 'scrooloose/nerdtree'
map <leader>f :NERDTreeFind<CR>
Plugin 'schickling/vim-bufonly' "Additional buffer helpers
Plugin 'jlanzarotta/bufexplorer'
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['.DS_STORE']
let g:NERDTreeWinPos = "left"

Plugin 'rking/ag.vim'
nnoremap <leader>a :Ag!<space>

Plugin 'Lokaltog/vim-easymotion'
nnoremap s <Plug>(easymotion-s2)
Plugin 'vim-scripts/ctags.vim' " make sure to brew install ctags
" open ctags link in new tab
nmap <Leader>] <C-w><C-]><C-w>T

Plugin 'ervandew/supertab'

"= JAVA ==========================================
" Plugin 'tpope/vim-classpath'
Plugin 'vim-scripts/groovy.vim'
set autoindent
set cindent


" = VUNDLE > COLORS / SYNTAX HELP ================
Plugin 'wejrowski/vim-codeschool'
color codeschool
syntax enable "Fixes terminal color issue

" Plugin 'stulzer/heroku-colorscheme'
Plugin 'DAddYE/soda.vim'
" create a toggler plugin for ooptions like this?

function ToggleTheme()
  if !exists("w:my_theme") || w:my_theme == 0
    let w:my_theme = 1
    set colorcolumn=0
    set cursorcolumn!
    noremap j gj
    noremap k gk
    set relativenumber!
    set wrap
    set linebreak
    set nolist  " list disables linebreak
    color soda
  else
    let w:my_theme = 0
    set colorcolumn=80
    set cursorcolumn
    noremap gj j
    noremap gk k
    set relativenumber
    set wrap!
    set linebreak!
    set list  " list disables linebreak
    color codeschool
  endif
endfunction
noremap <leader>T :call ToggleTheme()<cr>

" Plugin 'ap/vim-css-color' " THIS PLUGIN CAUSES LAG

Plugin 'pangloss/vim-javascript'
let javascript_enable_domhtmlcss = 1
Plugin 'jelera/vim-javascript-syntax'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'

Plugin 'scrooloose/syntastic'            " Syntax error help
let g:syntastic_html_tidy_exec = 'tidy5'

Plugin 'othree/html5.vim'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'

au BufNewFile,BufRead *.scss,*.sass,*.styl syntax cluster sassCssAttributes add=@cssColors
Plugin 'leafgarland/typescript-vim'
Plugin 'kchmck/vim-coffee-script'
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead Gruntfile set filetype=javascript
autocmd BufNewFile,BufRead *.ts set filetype=javascript

" = VUNDLE > SHORTCUTS/HELPERS ===================
nnoremap <leader>C :!echo '%' \| pbcopy<CR>
Plugin 'tpope/vim-commentary'
map <leader>c gcc<esc>
" Simple single line comments since commentary does not support this
" nnoremap <leader>/ :<c-u>execute "normal! I//\ "<cr>
" nnoremap <leader>? :<c-u>execute "normal! ^xxx"<cr>
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/\/\/ \1/'
    execute ':silent! s/^\( *\)\/\/ \/\/ /\1/'
endfunction

nnoremap <leader>/ :call CommentToggle()<CR>
vnoremap <leader>/ :call CommentToggle()<CR>



Plugin 'kana/vim-textobj-user'           " vim-textobj-rubyblock dependency
Plugin 'tmhedberg/matchit'               " Required for rubyblock
Plugin 'nelstrom/vim-textobj-rubyblock'  " Selecting ruby blocks

Plugin 'tpope/vim-endwise'               " auto end ruby blocks
Plugin 'groenewege/vim-markdown-preview'
Plugin 'kshenoy/vim-signature'           " Marker visuals
Plugin 'tpope/vim-fugitive'              " GIT - Gblame etc.
Plugin 'tpope/vim-surround'              " manipulate surrounding characters
Plugin 'godlygeek/tabular'               " pretty indents/formatting

Plugin 'junegunn/vim-easy-align'         " pretty align/indent with keys
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plugin 'mattn/webapi-vim'                " Needed for mattn/gist-vim
Plugin 'mattn/gist-vim'                  " Create/edit gists in vim

com! JSON %!python -m json.tool

" SnipMate
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

" VUNDLE > TESTING
Plugin 'thoughtbot/vim-rspec'
" Plugin 'skwp/vim-rspec'
" If using mvim
" let g:rspec_command = "silent !~/.vim/bundle/vim-rspec/bin/os_x_terminal 'zeus rspec {spec}'"
" let g:rspec_command = "compiler rspec | set makeprg=zeus | Make rspec {spec}"
let g:rspec_command = "!zeus rspec {spec}"
nnoremap <Leader>tt :call RunCurrentTestFile()<CR>
nnoremap <Leader>ts :call RunNearestTest()<CR>
nnoremap <Leader>ta :call RunAllTests()<CR>

function! RunCurrentTestFile()
  let file_name = expand('%')
  if match(file_name, '_test\.rb$') != -1
    exec ":!zeus test ' . file_name
  else
    RunCurrentSpecFile()
  endif
endfunction

function! RunNearestTest()
  let file_name = expand('%')
  "f match(a:filename, '\.rb$') != -1
  if match(file_name, '\test\.rb$') != -1
    exec ':!zeus test ' . file_name . ':' . line('.')
  else
    RunNearestSpec()
  endif
endfunction

function! RunAllTests()
  let file_name = expand('%')
  if match(file_name, '_test\.rb$') != -1
    exec ':!zeus test'
  else
    RunAllSpecs()
  endif
endfunction

nnoremap <Leader>Tt :exec ':!zeus test ' . expand('%')<CR>
nnoremap <Leader>Ts :exec ':!zeus test ' . expand('%') . ':' . line('.')<CR>
nnoremap <Leader>Ta :exec ':!zeus test'<CR>


" Plugin 'taylor/vim-zoomwin'

filetype plugin indent on " Required for vundle

"= GENERAL SETTINGS ==============================
set splitbelow
set splitright
set relativenumber
set number
set guifont=Panic\ Sans:h12 " Monaco:h12
set guioptions-=T           " Removes top toolbar
set guioptions-=r           " Removes right hand scroll bar
set go-=L                   " Removes left hand scroll bar
set list
set listchars=trail:.
set colorcolumn=80
set cursorcolumn
set expandtab
set tabstop=4
set softtabstop=4
set softtabstop=4
set shiftwidth=4
" autocmd BufNewFile,BufRead *.js set tabstop=4
" autocmd BufNewFile,BufRead *.json set tabstop=4
" autocmd BufNewFile,BufRead *.json set shiftwidth=4
set ruler       " Show row and col in footer
set incsearch
set hlsearch    " Highlight search matches
set ignorecase  " Ignore case in search
set backspace=2 " Fix vim backspace issue
set noswapfile
set laststatus=2 " Make use of statusbar
set statusline=%F%m%r%h%w%m\ \ %{fugitive#statusline()}\ %=[%l,%c]\ \ [%L,%p%%]
set undofile " Keep undo history between sessions
set undodir=~/.vim/undo

" With tmux, create bash alias: alias vim="reattach-to-user-namespace vim"
" and brew install reattach-to-user-namespace

" Clear search underlines
nnoremap <leader>S :nohlsearch<CR>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

nnoremap <leader>r :set relativenumber!<CR> " Toggle relative numbers
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
" nnoremap <leader>qq :q!<CR>
" OR ZZ
" nnoremap <leader>wq :wq<CR>

" easy store in main clipboard for later usage (gv rehighlights selection)
vnoremap <leader>y "+ygv
noremap <leader>p "+p
onoremap Yw "+yiw
onoremap YW "+yiW

" make it easier to call a macro, and apply on multiple lines in v mode
" you can also do this by, in visual mode, calling :norm! @<key>
noremap <leader>d @d
vnoremap <leader>d :g/^/ norm @d<CR>:nohlsearch<CR>

" One handed nav
function ToggleEasyNav()
  if !exists("w:easy_nav") || w:easy_nav == 0
    let w:easy_nav = 1
    noremap j <c-e>
    noremap k <c-y>
  else
    let w:easy_nav = 0
    noremap j gj
    noremap k gk
  endif
endfunction
noremap <leader>j :call ToggleEasyNav()<cr>

" Always move down a line on markdown only
autocmd FileType markdown noremap j gj
autocmd FileType markdown noremap k gk
autocmd FileType markdown noremap gj j
autocmd FileType markdown noremap gk k

" Easy resizing!
nnoremap - :vertical resize -1<CR>
nnoremap _ :vertical resize +1<CR>
nnoremap = :resize -1<CR>
nnoremap + :resize +1<CR>

" Quickly get inside next or previous parenthesis etc
onoremap in( :<c-u>execute "normal! /(\rlvi("<cr>
onoremap in) :<c-u>execute "normal! /)\rhvi("<cr>
onoremap il( :<c-u>execute "normal! /(\rNlvi("<cr>
onoremap il) :<c-u>execute "normal! /)\rNhvi("<cr>
onoremap in{ :<c-u>execute "normal! /{\rlvi{"<cr>
onoremap in} :<c-u>execute "normal! /}\rhvi{"<cr>
onoremap il{ :<c-u>execute "normal! /{\rNlvi{"<cr>
onoremap il} :<c-u>execute "normal! /}\rNhvi{"<cr>
onoremap in[ :<c-u>execute "normal! /[\rlvi["<cr>
onoremap in] :<c-u>execute "normal! /]\rhvi["<cr>
onoremap il[ :<c-u>execute "normal! /[\rNlvi["<cr>
onoremap il] :<c-u>execute "normal! /]\rNhvi["<cr>

" Easy edit/reload vimrc
nnoremap <leader>ev :tabe $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Save and load sessions (mks=mksession)
nnoremap <leader>ss :mks! ~/.vimsession<cr>
nnoremap <leader>sl :source ~/.vimsession<cr>

" Git shortcuts
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gl :!clear && git log -p %<cr>
nnoremap <leader>gd :!clear && git diff %<cr>

autocmd FileType markdown setlocal spell
autocmd FileType markdown set commentstring=<!--%s-->
autocmd FileType markdown set wrap
autocmd FileType markdown set linebreak
autocmd FileType markdown set nolist

" Use liquid highlighting in jekyll
au BufNewFile,BufRead */source/*.xml,*/source/*.html set ft=liquid

function RenameFile() " via Chris Hunt
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
nnoremap <leader>N :call RenameFile()<cr>

function! ExecuteFile(filename) " via Chris Hunt
  :w
  :silent !clear
  if match(a:filename, '\.rb$') != -1
    exec ":!ruby " . a:filename
  elseif match(a:filename, '\.js$') != -1
    exec ":!node " . a:filename
  elseif match(a:filename, '\.sh$') != -1
    exec ":!bash " . a:filename
  else
    exec ":!echo \"Don't know how to execute: \"" .  a:filename
  end
endfunction
nnoremap <leader>e :call ExecuteFile(expand("%"))<cr>

function! ExecuteRubyFileWithIRB(filename)
  exec ":!ruby -e \"load '" . a:filename . "'; require 'irb'; IRB.start;\""
endfunction
nnoremap <leader>ee :call ExecuteRubyFileWithIRB(expand("%"))<cr>

" = TAB NAVIGATION ===============================
" (and to move a split to a tab use ctrl+w T)
nnoremap <D-H> :tabprev<CR>
nnoremap <D-L> :tabnext<CR>
nnoremap <leader>h :tabprev<CR>
nnoremap <leader>l :tabnext<CR>
nnoremap <leader>H :call MoveTabLeft()<CR>
nnoremap <leader>L :call MoveTabRight()<CR>
nnoremap <leader><leader>H :call MergeTabLeft()<CR>
nnoremap <leader><leader>L :call MergeTabRight()<CR>

" Merge a tab into a split in the previous tab
function MergeTabLeft()
  "" Tab pages are not zero index
  if tabpagenr() == 1
    return
  endif

  let bufferName = bufname("%")
  if tabpagenr("$") == tabpagenr()
    close!
  else
    close!
    tabprev
  endif

  split
  execute "buffer" bufferName
endfunction

" Merge a tab into a split in the next tab
function MergeTabRight()
  " Tab pages are not zero index
  if tabpagenr() == tabpagenr("$")
    return
  endif

  let bufferName = bufname("%")
  if tabpagenr("$") == 1
    close!
  else
    close!
    tabN
  endif

  split
  execute "buffer" bufferName
endfunction

function MoveTabRight()
  if tabpagenr() == tabpagenr("$")
    let moveTabs = (tabpagenr("$")-1)
    execute "tabm -" . moveTabs
  else
    execute "tabm +1"
  endif
endfunction

function MoveTabLeft()
  if tabpagenr() == 1
    let moveTabs = (tabpagenr("$")-1)
    execute "tabm +" . moveTabs
  else
    execute "tabm -1"
  endif
endfunction

" Navigate between buffers
nnoremap <C-l> :bnext<CR>
nnoremap <C-h> :bprevious<CR>

" Mark extra whitespace
highlight ExtraWhitespace ctermfg=15 ctermbg=red guifg=black guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Remove all whitespace
nnoremap <leader>W :%s/\ \s*$//g

"Fix Air encoding NerdTree issue


let mapleader = " "

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
Plugin 'scrooloose/nerdtree'
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

" = VUNDLE > COLORS / SYNTAX HELP ================
Plugin 'wejrowski/vim-codeschool'
color codeschool
syntax enable "Fixes terminal color issue
Plugin 'ap/vim-css-color'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-haml'
au BufNewFile,BufRead *.scss,*.sass syntax cluster sassCssAttributes add=@cssColors
Plugin 'kchmck/vim-coffee-script'
autocmd BufNewFile,BufRead *.coffee set filetype=coffee

" = VUNDLE > SHORTCUTS/HELPERS ===================
Plugin 'tpope/vim-commentary'
map <leader>c gcc
Plugin 'kana/vim-textobj-user'           " vim-textobj-rubyblock dependency
Plugin 'nelstrom/vim-textobj-rubyblock'  " Selecting ruby blocks
Plugin 'Valloric/YouCompleteMe'          " Auto completion - Read YCM installation instructions
Plugin 'tpope/vim-endwise'               " auto end ruby blocks
Plugin 'groenewege/vim-markdown-preview'
Plugin 'kshenoy/vim-signature'           " Marker visuals
Plugin 'tpope/vim-fugitive'              " GIT - Gblame etc.
Plugin 'scrooloose/syntastic'            " Syntax error help
Plugin 'tpope/vim-surround'              " manipulate surrounding characters
Plugin 'godlygeek/tabular'               " pretty indents/formatting
Plugin 'junegunn/vim-easy-align'         " pretty align/indent with keys
Plugin 'mattn/webapi-vim'                " Needed for mattn/gist-vim
Plugin 'mattn/gist-vim'                  " Create/edit gists in vim

" VUNDLE > TESTING
Plugin 'thoughtbot/vim-rspec'
" Plugin 'skwp/vim-rspec'
" If using mvim
" let g:rspec_command = "silent !~/.vim/bundle/vim-rspec/bin/os_x_terminal 'zeus rspec {spec}'"
" let g:rspec_command = "compiler rspec | set makeprg=zeus | Make rspec {spec}"
let g:rspec_command = "!zeus rspec {spec}"
nnoremap <Leader>tt :call RunCurrentSpecFile()<CR>
nnoremap <Leader>ts :call RunNearestSpec()<CR>
nnoremap <Leader>ta :call RunAllSpecs()<CR>

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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ruler       " Show row and col in footer
set incsearch
set hlsearch    " Highlight search matches
set ignorecase  " Ignore case in search
set backspace=2 " Fix vim backspace issue
set noswapfile
set laststatus=2 " Make use of statusbar
set statusline=%F%m%r%h%w%m\ \ %{fugitive#statusline()}\ %=[%l,%c]\ \ [%L,%p%%]

" With tmux, create bash alias: alias vim="reattach-to-user-namespace vim"
" and brew install reattach-to-user-namespace
set clipboard=unnamed " Default use normal clipboard and

" Clear search underlines
nnoremap <leader>s :nohlsearch<CR>

nnoremap <leader>r :set relativenumber!<CR> " Toggle relative numbers
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
" nnoremap <leader>qq :q!<CR>
" OR ZZ
" nnoremap <leader>wq :wq<CR>

" Always move down a line
noremap j gj
noremap k gk
noremap gj j
noremap gk k

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

" Easy edit and load vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

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
nnoremap <leader>nn :call RenameFile()<cr>

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


" Mark extra whitespace
highlight ExtraWhitespace ctermfg=15 ctermbg=red guifg=black guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

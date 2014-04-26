let mapleader = " "

"------------------------------------------
"- VUNDLE & PLUGIN SETTINGS ---------------

" :PluginInstall  - install vundles
" :h vundle - for help
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Plugin 'gmarik/vundle'

"------------------------------------------
"- PLUGINS + PLUGIN SETTINGS --------------

" NAVIGATING
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'schickling/vim-bufonly' "Additional buffer helpers
Plugin 'jlanzarotta/bufexplorer'
let NERDTreeShowHidden=1
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['.DS_STORE']
let g:NERDTreeWinPos = "left"

Plugin 'mileszs/ack.vim'
map <leader>a :Ack<space>
map <D-F> :Ack<space>
if executable("ack")
  " use default config
elseif executable("ack-grep")
  let g:ackprg="ack-grep -H --nocolor --nogroup --column"
elseif executable("ag")
  let g:ackprg="ag --nocolor --nogroup --column"
else
  echo "The ack program is not installed"
endif

Plugin 'Lokaltog/vim-easymotion'
map s <Plug>(easymotion-s2)

Plugin 'vim-scripts/ctags.vim' " make sure to brew install ctags

" COLORS / SYNTAX HELP
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

" SHORTCUTS/HELPERS
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

" TESTING
Plugin 'thoughtbot/vim-rspec'
let g:rspec_command = "silent !~/.vim/bundle/vim-rspec/bin/os_x_terminal 'zeus rspec {spec}'"
map <Leader>tt :call RunCurrentSpecFile()<CR>
map <Leader>ts :call RunNearestSpec()<CR>
map <Leader>ta :call RunAllSpecs()<CR>

" Plugin 'taylor/vim-zoomwin'

filetype plugin indent on " Required for vundle

"------------------------------------------
"- SETTINGS -------------------------------

set splitbelow
set splitright
set relativenumber
set number
set guifont=Panic\ Sans:h12 " Monaco:h12
set guioptions-=T           " Removes top toolbar
set guioptions-=r           " Removes right hand scroll bar
set go-=L                   " Removes left hand scroll bar
autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
set list
set listchars=trail:.
set colorcolumn=80
set cursorcolumn
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ruler      " Show row and col in footer
set incsearch
set hlsearch   " Highlight search matches
set ignorecase " Ignore case in search

" Default use normal clipboard and
set clipboard=unnamed
" don't copy to clipboard when deleting
" nnoremap d "_d

" Clear search underlines
nnoremap <leader>s :nohlsearch<CR>
map <leader>w :w<CR>

autocmd FileType markdown setlocal spell
autocmd FileType markdown map j gj
autocmd FileType markdown map k gk
autocmd FileType markdown set commentstring=<!--%s-->
autocmd FileType markdown set wrap
autocmd FileType markdown set linebreak
autocmd FileType markdown set nolist

" Git shortcuts
map <leader>gb :Gblame<cr>
map <leader>gl :!clear && git log -p %<cr>
map <leader>gd :!clear && git diff %<cr>

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
map <leader>e :call ExecuteFile(expand("%"))<cr>

function! ExecuteRubyFileWithERB(filename)
  exec ":!ruby -e \"load '" . a:filename . "'; require 'irb'; IRB.start;\""
endfunction
map <leader>ee :call ExecuteRubyFileWithERB(expand("%"))<cr>

" TAB NAVIGATION
" - To move a split to a tab use ctrl+w T
" - Move splits around with ctrl+w H/L/J/K
" Instead of using ctrl+shift+{} to switch, I like ctrl+shift+H/L
map <D-H> :tabp<CR>
map <D-L> :tabn<CR>
map <leader>h :tabp<CR>
map <leader>l :tabn<CR>
nnoremap <leader>H :call MoveTabLeft()<CR>
nnoremap <leader>L :call MoveTabRight()<CR>
nnoremap <leader><leader>H :call MergeLeft()<CR>
nnoremap <leader><leader>L :call MergeRight()<CR>

"------------------------------------------
"- CUSTOM FUNCTIONS -----------------------

"" Merge a tab into a split in the previous tab
function MergeLeft()
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

"" Merge a tab into a split in the next tab
function MergeRight()
  "" Tab pages are not zero index
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


"COLOR ADJUSTMENTS
highlight ExtraWhitespace ctermfg=black ctermbg=red guifg=back guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

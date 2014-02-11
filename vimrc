let mapleader = " "

"------------------------------------------
"- VUNDLE & PLUGIN SETTINGS ---------------

" :BundleInstall  - install vundles
" see :h vundle for details
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'jlanzarotta/bufexplorer'
Bundle 'brettof86/vim-codeschool'

Bundle 'scrooloose/nerdtree'
let NERDTreeShowHidden=1
nmap <leader>n :NERDTreeToggle<CR>
let NERDTreeIgnore = ['.DS_STORE']
let g:NERDTreeWinPos = "left"

Bundle 'mileszs/ack.vim'
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

Bundle 'schickling/vim-bufonly'
Bundle 'tpope/vim-commentary'
Bundle 'kana/vim-textobj-user'
Bundle 'tmhedberg/matchit'
Bundle 'nelstrom/vim-textobj-rubyblock'
set nocompatible
if has("autocmd")
  filetype indent plugin on
endif

Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'plasticboy/vim-markdown'
Bundle 'taylor/vim-zoomwin'

" Make sure to read YCM installation instructions
Bundle 'Valloric/YouCompleteMe'

filetype plugin indent on " Required for vundle


"------------------------------------------
"- SETTINGS -------------------------------

color codeschool
set splitbelow
set splitright
set relativenumber
set number

set guifont=Panic\ Sans:h12 " Monaco:h12
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
set list
set listchars=trail:.
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set ruler
set incsearch
set hlsearch
" Clear search underlines
nnoremap <leader>s :nohlsearch

map <leader>c gcc

"" Tab navigation -- instead of using ctrl+shift+{} to switch, I like ctrl+shift+H/L 
map <D-H> :tabp<CR>
map <D-L> :tabn<CR>


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

map <Leader>h :call MoveTabLeft()<CR>
map <Leader>l :call MoveTabRight()<CR>

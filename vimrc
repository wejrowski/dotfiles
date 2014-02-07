let mapleader = " "


"" VUNDLE
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()
Bundle 'gmarik/vundle'
"" MY VUNDLES
Bundle 'jlanzarotta/bufexplorer'
Bundle 'brettof86/vim-codeschool'

Bundle 'tyok/nerdtree-ack'
nnoremap <D-S-F> :Ack<space> " Not working
"" Add nerdtree to persist across tabs
Bundle 'scrooloose/nerdtree'
let NERDTreeShowHidden=1
"" Auto start nerdtree on load
""autocmd VimEnter * NERDTree
""autocmd BufWinEnter * NERDTreeMirror
""autocmd VimEnter * wincmd w ""Auto go to the new file window
nmap <leader>n :NERDTreeToggle<CR>
" NERDTreeHighlightCursorline=1
let NERDTreeIgnore = ['.DS_STORE']

let g:NERDTreeWinPos = "left"

Bundle 'schickling/vim-bufonly'
Bundle 'tpope/vim-commentary'
Bundle 'kana/vim-textobj-user'

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

filetype plugin indent on


color codeschool
set splitbelow
set splitright
set relativenumber

set guifont=Panic\ Sans:h12 " Monaco:h12
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
:set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ commands

"" Tab navigation -- instead of using ctrl+shift+{} to switch, I like ctrl+shift+H/L 
map <D-H> :tabp<CR>
map <D-L> :tabn<CR>


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

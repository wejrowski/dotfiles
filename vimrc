
"" VUNDLE
Bundle 'jlanzarotta/bufexplorer'
Bundle 'brettof86/vim-codeschool'
Bundle 'tyok/nerdtree-ack'
Bundle 'plugin/'
Bundle 'schickling/vim-bufonly'
Bundle 'tpope/vim-commentary'
Bundle 'vim-textobj-rubyblock/'
Bundle 'vim-textobj-user/'


"""""""""""""""
"" .VIMRC.BEFORE
let mapleader = " "

"" Add nerdtree to persist across tabs
let NERDTreeShowHidden=1
"" Auto start nerdtree on load
""autocmd VimEnter * NERDTree
""autocmd BufWinEnter * NERDTreeMirror

""autocmd VimEnter * wincmd w ""Auto go to the new file window

"" Load multiple files with single command
"" found here: http://vim.wikia.com/wiki/Load_multiple_files_with_a_single_command 
"" (I'm actually not sure if this does much.. because I can do 
""   folder/*/file.xyz -p
"" to open in multiple tabs
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent <args>"

set splitbelow
set splitright

set relativenumber


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

"" for vim-textobj-rubyblock
set nocompatible
if has("autocmd")
  filetype indent plugin on
endif

"""""""""""""""
"" .VIMRC.AFTER

color codeschool
set guifont=Monaco:h12
let g:NERDTreeWinPos = "left"
set guioptions-=T " Removes top toolbar
set guioptions-=r " Removes right hand scroll bar
set go-=L " Removes left hand scroll bar
autocmd User Rails let b:surround_{char2nr('-')} = "<% \r %>" " displays <% %> correctly
:set cpoptions+=$ " puts a $ marker for the end of words/lines in cw/c$ commands

"" Tab navigation -- instead of using ctrl+shift+{} to switch, I like ctrl+shift+H/L 
map <D-H> :tabp<CR>
map <D-L> :tabn<CR>


map <Leader>h :call MoveTabLeft()<CR>
map <Leader>l :call MoveTabRight()<CR>
""Not working for some reason:
""map <A-{> :call MoveTabLeft()<CR>
""map <A-}> :call MoveTabRight()<CR>
""map <A-H> :call MoveTabLeft()<CR>
""map <A-L> :call MoveTabRight()<CR>


" If you want to default vim size (not good for actually using vim in terminal
" though.. annoyingly resizes
"set lines=73 columns=230



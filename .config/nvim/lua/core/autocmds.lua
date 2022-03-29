vim.cmd([[
"--- Netrw

" Open split of currently selected file in netrw to the right
function! OpenRight()
    :normal v
    let g:path=expand('%:p')
    echo g:path
    :q!
    execute 'belowright vnew' g:path
    :normal <c-l>
endfunction

" Open split of currently selected file in netrw on the bottom
function! OpenBelow()
    :normal v
    let g:path=expand('%:p')
    echo g:path
    :q!
    execute 'belowright new' g:path
    :normal <c-l>
endfunction

" Netrw mappings
function! NetrwMappings()
    nnoremap <buffer> <c-l> <c-w>l
    nnoremap V :call OpenRight()<cr>
    nnoremap H :call OpenBelow()<cr>
endfunction
augroup netrw_mappings
    autocmd!
    autocmd filetype netrw call NetrwMappings()
augroup END

" Close netrw after opening a file (which gets opened in another window)
let g:netrw_fastbrowse = 0
autocmd FileType netrw setl bufhidden=wipe
function! CloseNetrw() abort
  for bufn in range(1, bufnr('$'))
    if bufexists(bufn) && getbufvar(bufn, '&filetype') ==# 'netrw'
      silent! execute 'bwipeout ' . bufn
      if getline(2) =~# '^" Netrw '
        silent! bwipeout
      endif
      return
    endif
  endfor
endfunction
augroup closeOnOpen
  autocmd!
  autocmd BufWinEnter * if getbufvar(winbufnr(winnr()), "&filetype") != "netrw"|call CloseNetrw()|endif
aug END

" Close vim if netrw is the only open buffer
autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif



"--- Misc

" Clean up trailing spaces and single lines at the end of files
autocmd BufWritePre * %s/\s\+$//e

" File templates
augroup templates
    autocmd BufNewFile *.tex 0r ~/.config/nvim/templates/skeleton.tex
    autocmd BufNewFile *.sh 0r ~/.config/nvim/templates/skeleton.sh
augroup END

" Automatically enter insert mode when opening an empty file
autocmd BufNewFile * startinsert
autocmd VimEnter * if empty(expand("%")) | startinsert | endif
autocmd VimEnter * if getfsize(expand("%")) == 0 | startinsert | endif
]])

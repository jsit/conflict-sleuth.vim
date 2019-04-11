" conflict-sleuth.vim
" Language:	Vim 8.0 script
" Maintainer:	Jay Sitter <jay@diameterstudios.com>
" Last Change:	Apr 12, 2019
" URL:	https://github.com/jsit/conflict-sleuth.vim

function! s:ConflictSleuth(merged, base, local, remote)
    "
    " Set up BASE/LOCAL tab
    "

    " Default windows to diff
    let t:diff_windows = [1,2]

    " Open MERGED file
    silent execute "e " . a:merged
    call s:PrepWindow('merged')

    " Open LOCAL file in horizointal split
    silent execute "split " . a:local
    call s:PrepWindow('diff')

    " Open BASE file in vertical split
    silent execute "vsplit " . a:base
    call s:PrepWindow('diff')

    " Return forcus to MERGED
    wincmd j

    " " Remove conflict areas
    " silent execute "g/^<<<<<<< /,/^>>>>>>> /d"

    "
    " Set up BASE/REMOTE tab
    "
    silent execute "tabnew " . a:merged
    call s:PrepWindow('merged')

    " Default windows to diff
    let t:diff_windows = [1,2]

    silent execute "split " . a:remote
    call s:PrepWindow('diff')

    silent execute "vsplit " . a:base
    call s:PrepWindow('diff')

    " Return forcus to MERGED
    wincmd j

    " " Remove conflict areas
    " silent execute "g/^<<<<<<< /,/^>>>>>>> /d"

    " Go back to first tab
    silent execute "normal gT"

    echom "Use :cq to quit without successful merge"

    " Remaps
    nnoremap <silent> <leader>d :call CSRotateDiff()<cr>
    nnoremap <silent> <leader>f :call CSToggleFiller()<cr>
endfunction

function! s:PrepWindow(type)
  setlocal cul
  setlocal syntax=off
  silent execute "normal zM"
  if a:type == 'diff'
    diffthis
  else
    set scrollbind
    set filetype=conflict
    set syntax=conflict
  endif
endfunction

function! CSToggleFiller()
  if match(&diffopt, 'filler') > -1
    set diffopt-=filler
  else
    set diffopt+=filler
  endif
endfunction

function! CSRotateDiff()
  let s:current_window = winnr()

  if t:diff_windows == [1,2]
    let t:diff_windows = [1,3]
  elseif t:diff_windows == [1,3]
    let t:diff_windows = [2,3]
  elseif t:diff_windows == [2,3]
    let t:diff_windows = [1,2]
  endif

  diffoff!

  for i in t:diff_windows
    silent execute i . " wincmd w"
    diffthis
  endfor

  silent execute s:current_window . " wincmd w"
endfunction

command! -nargs=* ConflictSleuth call s:ConflictSleuth(<f-args>)

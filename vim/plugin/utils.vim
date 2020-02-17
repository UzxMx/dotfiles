command! WQ wq
command! Wq wq
command! W w
command! -bang Q q<bang>
command! -bang Qa qa<bang>

" Save previously closed window
augroup bufclosetrack
  au!
  autocmd WinLeave * let g:lastWinName = @%
augroup END
command! -nargs=0 LastWindow exe "split" g:lastWinName

"-------------------------------------------------------------------------------
" Tabpage utils
"-------------------------------------------------------------------------------

autocmd TabLeave * let g:prev_tabpagenr = tabpagenr()
autocmd TabClosed * if exists('g:prev_tabpagenr') && g:prev_tabpagenr == expand("<afile>") | unlet g:prev_tabpagenr | endif

function! s:GoToPrevTab()
  if exists('g:prev_tabpagenr')
    exec 'norm!' g:prev_tabpagenr . 'gt'
  endif
endfunction

nnoremap <Plug>(go-to-prev-tab) :call <SID>GoToPrevTab()<CR>
nmap <silent> <c-w>P <Plug>(go-to-prev-tab)

" Load buffer in the current window into a new window of a specified tab
command! -nargs=1 MoveToTab call s:OpenInTab(<q-args>, v:true)
command! -nargs=1 OpenInTab call s:OpenInTab(<q-args>, v:false)
function! s:OpenInTab(tab, close)
  let tabnr = tabpagenr()
  if tabnr == a:tab
    return
  endif

  let bufnr = bufnr('%')
  let winnr = winnr()

  execute 'normal! ' . a:tab . 'gt'
  vsplit
  execute 'buffer ' . bufnr

  if a:close == v:true
    call s:GoToPrevTab()
    let prev_tabpagenr = g:prev_tabpagenr

    execute winnr . 'wincmd w' | wincmd c

    " If g:prev_tabpagenr does't exist, that means a tabpage just closed
    " because of last code execution, so we need to set the correct value to
    " g:prev_tabpagenr.
    if !exists('g:prev_tabpagenr')
      let g:prev_tabpagenr = prev_tabpagenr - 1
    endif

    call s:GoToPrevTab()
  endif
endfunction

" Reference http://vimdoc.sourceforge.net/htmldoc/cmdline.html#filename-modifiers
command! PutFileName put =expand('%:t')
command! PutRelativePath put =expand('%')
command! PutRelativeParentPath put =expand('%:h')
command! PutAbsolutePath put =expand('%:p')
command! PutAbsoluteParentPath put =expand('%:p:h')

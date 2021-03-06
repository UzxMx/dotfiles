highlight TrailingWhitespace ctermbg=red guibg=red
match TrailingWhitespace /\s\+$/
autocmd BufWinEnter * if &modifiable && &ft != 'ctrlsf' | match TrailingWhitespace /\s\+$/ | endif
autocmd InsertEnter * if &modifiable && &ft != 'ctrlsf' | match TrailingWhitespace /\s\+\%#\@<!$/ | endif
autocmd InsertLeave * if &modifiable && &ft != 'ctrlsf' | match TrailingWhitespace /\s\+$/ | endif
autocmd BufWinLeave * call clearmatches()
autocmd FileType ctrlsf call clearmatches()

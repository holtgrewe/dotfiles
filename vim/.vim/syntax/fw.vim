set filetype=conf
set tabstop=4
set shiftwidth=4
set expandtab
set foldmethod=expr
function! FwFold()
    let thisline = getline(v:lnum)
    if match(thisline, '^config.*') >= 0
        return "a1"
    elseif match(thisline, '    edit ') >= 0
        return "a1"
    elseif match(thisline, '    next$') >= 0
        return "s1"
    elseif match(thisline, '^end$') >= 0
        return "s1"
    else
        return "="
    endif
endfunction
set foldexpr=FwFold()
set foldminlines=0
set foldcolumn=5
" set foldlevel=99

syntax match FWdisable /edit .*\n\(\s*set .*\n\)*.*status down\n\(\s*set .*\n\)*\s*next\n/ contains=FWdis
syntax match FWdisable /edit .*\n\(\s*set .*\n\)*.*status disable\n\(\s*set .*\n\)*\s*next\n/ contains=FWdis
highlight link FWdisable Comment
syn match FWdis /status disable/
syn match FWdis /status down/
highlight FWdis ctermfg=red
highlight link FWdis WarningMsg
syntax match FWpart /^config .*/
syntax match FWpart /^end/
highlight link FWpart Statement
" syntax case ignore
" syntax keyword FWimport all
" syntax keyword FWimport \"ALL\"
" syntax case match
" highlight link FWimport WarningMsg

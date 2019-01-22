
" Playframework
if isdirectory('app') | setlocal path+=app/**,conf suffixesadd+=.conf | endif

setlocal includeexpr=substitute(substitute(v:fname,'\\.','/','g'),'_','\.','g') 
compiler scalac


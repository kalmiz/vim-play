autocmd BufNewFile,BufRead conf/routes,conf/*.routes setlocal ft=playroutes
au BufRead,BufNewFile *.scala.html setlocal filetype=html syntax=playhtml
au BufRead,BufNewFile conf/application*.conf setlocal ft=playconf syntax=playconf path=.,conf

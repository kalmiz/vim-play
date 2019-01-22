" Vim filetype playframework routes 
" Language:	Play routes
" Maintainer:	Zoltan Kalmar <kalmiz@gmail.com>
" Last Change:	2019.01.22

if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo-=C

setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
setlocal includeexpr={n->n[max([0,len(n)-2])]}(split(v:fname,'\\.'))
setlocal path+=conf,app/**
setlocal suffixesadd=.scala

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8 sw=2

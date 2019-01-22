" Vim compiler file
" Compiler:	Scalac CLI
" Maintainer:	Zoltan Kalmar <kalmiz@gmail.com>
" Last Change:	2019.01.22

if exists('current_compiler')
	finish
endif
let current_compiler = 'scalac'

if exists(':CompilerSet') != 2		" older Vim always used :setlocal
	command -nargs=* CompilerSet setlocal <args>
endif

if !exists('g:scalac_sbt_options')
	let g:scalac_sbt_options = '-Ystop-before:cleanup'
endif

if !exists('g:scalac_sbt_disable_pattern')
	let g:scalac_sbt_disable_pattern = '\(@safeConfig\)'
endif

function! s:Log(msg) abort
  echomsg '[scalac.vim] ' . a:msg 
endfunction

function! s:ScalacSbtClasspath() abort
	func! CloseHandler(channel)
		let line = ''
		while ch_status(a:channel, {'part': 'out'}) == 'buffered'
			let line .= ch_read(a:channel)
		endwhile
		call writefile([g:scalac_sbt_options, '-cp ' . substitute(line, '\.jar/', '.jar:/', '')], '.scalac')
		call s:Log('Compiler settings has been written to .scalac')
	endfunc
	let cmd = 'sbt --error ";export compile:fullClasspath; export test:fullClasspath"'
	call s:Log('Running: ' . cmd)
	let job = job_start(cmd, {'close_cb': 'CloseHandler', 'in_mode': 'nl'})
endfunction

let s:cpo_save = &cpo
set cpo-=C

if exists('g:scalac_disable_sbt_classpath') || search(g:scalac_sbt_disable_pattern, 'wn') > 0
	CompilerSet makeprg=scalac\ -Ystop-after:parser 
else
	if !filereadable('.scalac')
		call s:ScalacSbtClasspath()
	endif
	CompilerSet makeprg=scalac\ @.scalac
endif

CompilerSet errorformat=%E%f:%l:\ %trror:\ %m,%W%f:%l:\ %tarning:%m,%Z%p^,%-G%.%# 

command! ScalacSbtClasspath call s:ScalacSbtClasspath()

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: ts=8 sw=2

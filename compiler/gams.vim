" Vim compiler file
" Compiler:	GAMS
" Maintainer:	Olivier Huber <oli.huber@gmail.com>
" Last Change:	2023 Nov 23

if exists("current_compiler")
  finish
endif
let current_compiler = "gams"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=gams\ \"%:p\"\ \$*
" CompilerSet errorformat=%C---\ %f,%E%[%#]%[%#]%[%#]\ \trror\ at\ line\ %l:\ %m,%Z---\ %f(%.%# ",%trror\ %n\ in\ %f,---\ %f(%l)\ %.%#\ %trror
" Matches
"     *** Error at line XX: MSG
"     --- thefile.gms(...
CompilerSet errorformat=%E%>%[%#]%[%#]%[%#]\ Error\ at\ line\ %l:\ %m,%Z---\ %f(%.%#,
         \[empinterp]\ %tRROR\ in\ file\ '%f'\ at\ line\ %l,
         \%E%>---\ %f(%l)\ %*\\d\ Mb\ %*\\d\ Error%[s]%#,%C%>%[%#]%[%#]%[%#]\ Error\ %n\ in\ %f,%Z\ \ \ \ %m,
         \%E%>---\ %f(%l)\ %*\\d\ Mb\ %*\\d\ Error%[s]%#,%Z%[%#]%[%#]%[%#]\ Status:\ %m,
         \%I%[%#]%[%#]%[%#]\ Status:\ %m,%Z---\ Job\ %f\ Stop\ %.%#

" Notes: the following doesn't work since vim does not enforce the second line
" to be matched ... TODO: try with %>?
" %I---\ %f(%l)\ %*\\d\ Mb%.%#,%Z%[%#]%[%#]%[%#]\ Status:\ %m,
let &cpo = s:cpo_save
unlet s:cpo_save

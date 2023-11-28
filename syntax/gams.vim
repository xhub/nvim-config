" Vim syntax file
" Language:	GAMS
" Maintainer:  David Vonka

syn clear
syn case ignore
syn sync lines=250
setlocal iskeyword+=$

syn keyword GAMSkwds solve minimizing maximizing using model positive variable[s] equation[s] parameter[s] scalar[s] set[s] file put putclose loop endloop if then else endif for to do endfor yes no alias display option ord card execute inf table abort
syn match GAMSdol /^$.*/
syn match GAMScomment1 /?.*/
syn region GAMScomment2 start=/\/?/ end=/?\// contains=@Spell
syn region GAMScomment3 start=/$ontext/ end=/$offtext/ contains=@Spell
syn match GAMScomment4 /^\*.*/ contains=@Spell
syn region GAMSstring start=/"/ end=/"/
syn region GAMSputstring start=/'/ end=/'/
syn match GAMSenvvar /%[^%]*%/

" hi GAMSkwds gui=bold guifg='LightBlue'
hi GAMSdol guifg='Red'

hi def link GAMSkwds Keyword
hi def link GAMSstring String
hi def link GAMSputstring String
hi def link GAMSenvvar SpecialChar

hi def link GAMScomment1 Comment
hi def link GAMScomment2 Comment
hi def link GAMScomment3 Comment
hi def link GAMScomment4 Comment


if exists('b:did_ftplugin')
  finish
endif
let b:did_ftplugin = 1

setlocal fo+=r " Automatically insert comment string after hitting ENTER in insert mode
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,:///,://

setlocal commentstring=//%s

setlocal isfname+=:
setlocal iskeyword+=$

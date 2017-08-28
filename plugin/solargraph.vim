
if exists("g:loaded_vim_solargraph")
  finish
endif
let g:loaded_vim_solargraph = 1


let s:plugindir = expand('<sfile>:p:h') . "/main.rb"
execute 'rubyfile ' . s:plugindir


"" https://github.com/ctrlpvim/ctrlp.vim/issues/59
"" Or else use https://github.com/dbakker/vim-projectroot
"function! s:setcwd()
function! s:rubySolarSetcwd()
  let cph = expand('%:p:h', 1)
  "echomsg projectroot#guess(cph)
  return projectroot#guess(cph)
endfunction


function! RubySolar()
  "echom "Hello, world!"
  ruby << EOF
  ko = VimSolargraph.new( VIM::evaluate("s:rubySolarSetcwd()") )
  VIM::command("return #{ko.suggest.inspect}")
EOF
endfunction

function! RubySolarPrepare()
  ruby << EOF
  ko = VimSolargraph.new( VIM::evaluate("s:rubySolarSetcwd()") )
  ko.prepare
EOF
endfunction


function! solargraph#CompleteSolar(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find classes matching "a:base"
        let res = []
				let matches=RubySolar()
        for m in matches
            if m =~ '^' . a:base
                call add(res, m)
            endif
        endfor
        return res
    endif
endfun

function! HAHA()
  execute 'silent echomsg "SKATA"'
endfun

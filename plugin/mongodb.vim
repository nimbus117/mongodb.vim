if exists('g:mongoPluginLoaded') || !executable('mongo')
  finish
endif
let g:mongoPluginLoaded = 1

let s:vimInputFile = './.vim.mongo.js'
let s:vimOutputFile = './vim.mongo-out.json'
let s:scriptFolder = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:mongoInputFile = s:scriptFolder . '/vim.mongo-in.js'
let s:mongoConfigFile = s:scriptFolder . '/config.js'

function! s:DB(...) abort
  let l:currentWindowNumber = winnr()

  " Set database connection string.
  if exists('b:db')
    let l:db = b:db
  elseif exists('g:db')
    let l:db = g:db
  else
    echo 'Set the connection string using b:db or g:db. let b:db = "mongodb://host/database"'
    return
  endif

  " Write the given range of commands to the mongo shell input file.
  let l:startLine = a:0 > 0 ? a:1 : line('.')
  let l:endLine = a:0 > 1 ? a:2 : line('.')
  silent execute l:startLine . ',' . l:endLine . 'write ' . s:mongoInputFile

  " Creates a new output buffer in a vertical split or if it already exists
  " moves the cursor to it.
  let l:outputWindowNumber = bufwinnr(s:vimOutputFile)
  if l:outputWindowNumber == -1
    silent execute 'vnew ' . s:vimOutputFile
    setlocal ft=json
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
  else
    execute l:outputWindowNumber . 'wincmd w'
  endif

  " Execute the contents of the mongo shell input file.
  silent 1,$delete
  silent execute 'read ! mongo "' . l:db . '"'
        \ . ' --quiet --norc --shell ' . s:mongoConfigFile . ' < ' . s:mongoInputFile
        \ . ' | grep -vE "^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}[+-][0-9]{4}\s+"'

  " Move to the top of the file and delete the blank line.
  normal gg
  .delete

  " Delete the mongo shell input file and return to the original window.
  silent call delete(s:mongoInputFile)
  execute l:currentWindowNumber . 'wincmd w'
endfunction
command! -range=% DB call s:DB(<line1>, <line2>)

function! s:Mongo() abort
  execute 'tabedit ' . s:vimInputFile
  nnoremap <silent> <buffer> <c-j> :.DB<cr>
  xnoremap <silent> <buffer> <c-j> :DB<cr>
endfunction
command! Mongo call s:Mongo()

let s:vimOutputBuffer = './mongo-out.json'
let s:scriptFolder = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:mongoTempInputFile = s:scriptFolder . '/mongo-temp-in.js'

let g:mongoPluginQueryRunning = 0

function! db#runQuery(startLine, endLine) abort
  if g:mongoPluginQueryRunning > 0
    echo "Query already running"
    return
  endif

  " Check the database connection string is set
  if exists('b:db')
    let l:db = b:db
  elseif exists('g:db')
    let l:db = g:db
  else
    echo 'Set the connection string using b:db or g:db. let b:db = "mongodb://host/database"'
    return
  endif

  " Write the given range to the mongo shell temporary input file
  silent execute a:startLine . ',' . a:endLine . 'write! ' . s:mongoTempInputFile

  " Open or move to the output window, delete the contents and return to the
  " original window
  let l:currentWindowNumber = winnr()
  let l:outputWindowNumber = bufwinnr(s:vimOutputBuffer)
  if l:outputWindowNumber == -1
    silent execute 'vnew ' . s:vimOutputBuffer
    setlocal ft=json
    setlocal buftype=nofile
    setlocal noswapfile
    " if ALE is installed disable for this buffer
    if exists(":ALEDisableBuffer")
      ALEDisableBuffer
    endif
  else
    execute l:outputWindowNumber . 'wincmd w'
  endif

  setlocal modifiable
  silent 1,$delete _
  setlocal nomodifiable
  execute l:currentWindowNumber . 'wincmd w'

  echo "Running..."
  let g:mongoPluginQueryRunning = 1
  let s:start_time = reltime()

  " execute mongo shell as an async job
  let l:mongoCommand = [
        \ "/bin/sh", "-c",
        \ "mongosh " . l:db . " --quiet --norc --shell " . 
        \   ' | grep -vE "^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{3}[+-][0-9]{4}\s+"' . 
        \   ' | head -n -1'
        \ ]

  function! CloseCallback(channel)
      echo "Elapsed time:" split(reltimestr(reltime(s:start_time)))[0] . 's'
      let g:mongoPluginQueryRunning = 0
      silent call delete(s:mongoTempInputFile)
  endfunc

  call job_start(l:mongoCommand, {
        \ 'in_io': 'file', 
        \ 'in_name': s:mongoTempInputFile,
        \ "out_modifiable": 0,
        \ 'out_io': 'buffer',
        \ 'out_name': s:vimOutputBuffer,
        \ "err_modifiable": 0,
        \ 'err_io': 'buffer',
        \ 'err_name': s:vimOutputBuffer,
        \ 'close_cb': 'CloseCallback',
        \ })
endfunction

let s:vimInputBuffer = './.vim.mongo.js'

function! mongodb#mongo#command() abort
  execute 'tabedit ' . s:vimInputBuffer
  nnoremap <silent> <buffer> <c-j> :.DB<cr>
  xnoremap <silent> <buffer> <c-j> :DB<cr>
  setlocal omnifunc=mongodb#completion#omnifunc
endfunction

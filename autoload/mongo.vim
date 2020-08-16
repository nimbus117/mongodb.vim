let s:vimInputBuffer = './.vim.mongo.js'

function! mongo#openTab() abort
  execute 'tabedit ' . s:vimInputBuffer
  nnoremap <silent> <buffer> <c-j> :.DB<cr>
  xnoremap <silent> <buffer> <c-j> :DB<cr>
  setlocal completefunc=completion#collectionMethods
endfunction

if exists('g:mongoPluginLoaded') || !executable('mongo') || has('win32')
  finish
endif
let g:mongoPluginLoaded = 1

command! -range DB call db#runQuery(<line1>, <line2>)

command! Mongo call mongo#openTab()

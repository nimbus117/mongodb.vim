if exists('g:mongoPluginLoaded') || !executable('mongo')
  finish
endif
let g:mongoPluginLoaded = 1

command! -range DB call mongodb#db#command(<line1>, <line2>)

command! Mongo call mongodb#mongo#command()

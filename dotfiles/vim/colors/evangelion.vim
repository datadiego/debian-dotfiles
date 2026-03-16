" Vim color file
" Name: evangelion
" Author: hachy
" License: MIT

set background=dark
highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'evangelion'

let s:ev = {
  \ "bg": "#201430",
  \ "core": "#000000",
  \ "dispair": "#101010",
  \ "tokyo3": "#111111",
  \ "fear": "#151515",
  \ "midnight": "#201430",
  \ "selee": "#222222",
  \ "casper": "#39274C",
  \ "balthasar": "#39274D",
  \ "melchior": "#402C56",
  \ "gehirn": "#43492A",
  \ "lost": "#444444",
  \ "s2engine": "#452F5C",
  \ "longingus": "#483160",
  \ "nerv": "#5B2B41",
  \ "fog": "#666666",
  \ "mari": "#67478A",
  \ "unit01": "#875FAF",
  \ "kaworu": "#87FF5F",
  \ "kozo": "#8BD450",
  \ "terminaldogma": "#8EDF5F",
  \ "ritsuko": "#9F50E1",
  \ "kaji": "#9CDA7C",
  \ "shinji": "#A1A0AD",
  \ "adam": "#A4D2EC",
  \ "unit00": "#9DAFD1",
  \ "dummyplug": "#AB92FC",
  \ "gendo": "#ADA4A0",
  \ "atfield": "#B968FC",
  \ "asuska": "#C586C0",
  \ "lilith": "#CE67F0",
  \ "misato": "#DB6088",
  \ "error": "#BF2D2D",
  \ "angel": "#D4D4D4",
  \ "lcl": "#D99145",
  \ "rei": "#E1D6F8",
  \ "penpen": "#E6BB85",
  \ }

function! s:hi(group, fg, bg, style)
  let cmd = 'hi ' . a:group
  if a:fg != ''
    let cmd .= ' guifg=' . a:fg
    let cmd .= ' ctermfg=' . s:cterm(a:fg)
  endif
  if a:bg != ''
    let cmd .= ' guibg=' . a:bg
    let cmd .= ' ctermbg=' . s:cterm(a:bg)
  endif
  if a:style != ''
    let cmd .= ' gui=' . a:style
    let cmd .= ' cterm=' . a:style
  endif
  execute cmd
endfunction

function! s:cterm(color)
  if a:color ==# '' | return 'NONE' | endif
  if a:color ==# '#000000' | return '16' | endif
  if a:color ==# '#000005' | return '17' | endif
  if a:color ==# '#870000' | return '52' | endif
  if a:color ==# '#aa0000' | return '52' | endif
  if a:color ==# '#ff5f87' | return '168' | endif
  if a:color ==# '#d99145' | return '172' | endif
  if a:color ==# '#9cda7c' | return '156' | endif
  if a:color ==# '#87ff5f' | return '119' | endif
  if a:color ==# '#a786ff' | return '99' | endif
  if a:color ==# '#875faf' | return '97' | endif
  if a:color ==# '#cfa1ed' | return '183' | endif
  if a:color ==# '#9dbee6' | return '75' | endif
  if a:color ==# '#d4d4d4' | return '188' | endif
  if a:color ==# '#c586c0' | return '182' | endif
  if a:color ==# '#bec7d1' | return '252' | endif
  if a:color ==# '#8784ad' | return '102' | endif
  if a:color ==# '#535177' | return '240' | endif
  if a:color ==# '#585858' | return '240' | endif
  return 'NONE'
endfunction

call s:hi('Normal', s:ev.shinji, s:ev.core, '')
call s:hi('Cursor', s:ev.core, s:ev.kaworu, '')
call s:hi('CursorLine', '', s:ev.tokyo3, '')
call s:hi('CursorLineNr', s:ev.casper, '', 'bold')
call s:hi('LineNr', s:ev.casper, '', '')
call s:hi('VertSplit', s:ev.unit01, '', '')
call s:hi('StatusLine', s:ev.dummyplug, s:ev.core, '')
call s:hi('StatusLineNC', s:ev.fog, s:ev.core, '')
call s:hi('TabLine', s:ev.shinji, s:ev.tokyo3, '')
call s:hi('TabLineSel', s:ev.dummyplug, s:ev.tokyo3, '')
call s:hi('TabLineFill', s:ev.shinji, '', '')
call s:hi('Pmenu', s:ev.kaworu, s:ev.gehirn, '')
call s:hi('PmenuSel', s:ev.core, s:ev.kaworu, '')
call s:hi('PmenuSbar', '', s:ev.tokyo3, '')
call s:hi('PmenuThumb', '', s:ev.kaworu, '')
call s:hi('Search', s:ev.core, s:ev.adam, 'bold')
call s:hi('IncSearch', s:ev.core, s:ev.kaworu, 'bold')
call s:hi('MatchParen', s:ev.angel, s:ev.fog, 'bold')
call s:hi('Visual', '', s:ev.casper, '')
call s:hi('Directory', s:ev.kaji, '', '')
call s:hi('Title', s:ev.lcl, '', '')
call s:hi('ErrorMsg', s:ev.misato, s:ev.error, 'bold')
call s:hi('WarningMsg', s:ev.lcl, s:ev.gehirn, 'bold')
call s:hi('ModeMsg', s:ev.kaworu, '', 'bold')
call s:hi('MoreMsg', s:ev.kaworu, '', 'bold')
call s:hi('Question', s:ev.kaworu, '', '')
call s:hi('NonText', s:ev.lcl, '', '')
call s:hi('SpecialKey', s:ev.mari, '', '')
call s:hi('EndOfBuffer', s:ev.kaworu, '', '')
call s:hi('Folded', s:ev.unit01, s:ev.tokyo3, 'bold')
call s:hi('FoldColumn', s:ev.unit01, '', 'bold')
call s:hi('SignColumn', s:ev.casper, s:ev.core, '')
call s:hi('ColorColumn', '', s:ev.unit01, '')
call s:hi('CursorColumn', '', s:ev.tokyo3, '')
call s:hi('DiffAdd', s:ev.core, s:ev.kaji, '')
call s:hi('DiffChange', s:ev.core, s:ev.lilith, '')
call s:hi('DiffDelete', s:ev.misato, '', '')
call s:hi('DiffText', s:ev.core, s:ev.misato, 'bold')
call s:hi('WildMenu', s:ev.kaworu, '', '')
call s:hi('SpellBad', '', '', 'undercurl')
call s:hi('SpellCap', '', s:ev.nerv, 'underline')
call s:hi('SpellLocal', '', s:ev.nerv, 'underline')
call s:hi('SpellRare', '', s:ev.nerv, 'underline')
call s:hi('Whitespace', s:ev.lcl, '', '')
call s:hi('Comment', s:ev.casper, '', '')
call s:hi('Constant', s:ev.lcl, '', '')
call s:hi('String', s:ev.atfield, '', '')
call s:hi('Number', s:ev.lcl, '', '')
call s:hi('PreProc', s:ev.ritsuko, '', '')
call s:hi('Include', s:ev.atfield, '', '')
call s:hi('Identifier', s:ev.adam, '', '')
call s:hi('Function', s:ev.kaji, '', '')
call s:hi('Statement', s:ev.dummyplug, '', '')
call s:hi('Type', s:ev.adam, '', '')
call s:hi('Special', s:ev.lcl, '', '')
call s:hi('Underlined', s:ev.kaji, '', 'underline')
call s:hi('Error', s:ev.misato, '', 'underline')
call s:hi('Todo', s:ev.misato, s:ev.error, 'bold')
call s:hi('FloatBorder', s:ev.kaji, '', '')
call s:hi('FloatTitle', s:ev.kaji, '', '')
call s:hi('NormalFloat', s:ev.shinji, s:ev.gehirn, '')
call s:hi('Conceal', s:ev.kaworu, '', '')
call s:hi('CurSearch', s:ev.core, s:ev.penpen, 'bold')
call s:hi('WinBar', s:ev.kaji, '', '')
call s:hi('WinBarNC', s:ev.gehirn, '', '')

hi! link Character String
hi! link Boolean Constant
hi! link Float Number
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Operator Statement
hi! link Keyword Statement
hi! link Label Identifier
hi! link Exception Preproc
hi! link Define Statement
hi! link Macro PreProc
hi! link PreCondit Preproc
hi! link StorageClass Identifier
hi! link Structure Type
hi! link SpecialChar Special
hi! link Tag Statement
hi! link Delimiter Statement
hi! link SpecialComment Special
hi! link Debug Special

" HTML
hi! link htmlTag Include
hi! link htmlEndTag Include

" Javascript
hi! link javaScriptIdentifier Type
hi! link javaScriptDOMMethods Normal
hi! link javaScriptDOMProperties Normal
hi! link javaScriptNumber Number
hi! link javaScriptParens Preproc
hi! link javaScriptFuncArg Normal

" TypeScript
hi! link typescriptTemplateSB Number

" Python
hi! link pythonBuiltin Type
hi! link pythonDecorator PreProc
hi! link pythonDecoratorName PreProc

" Go
hi! link goDeclType Preproc

" Ruby
hi! link rubyControl Preproc
hi! link rubyException Preproc

" Markdown
hi! def link markdownItalic NONE
hi! def link markdownBoldItalic NONE

" GitGutter
hi GitGutterAdd ctermfg=156 guifg=#9cda7c
hi GitGutterChange ctermfg=172 guifg=#d99145
hi GitGutterDelete ctermfg=168 guifg=#db6088

" Coc
hi CocHintSign ctermfg=60 guifg=#6d7ba6

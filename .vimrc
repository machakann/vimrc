" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldcolumn=2:
" vim:set foldmethod=marker: commentstring="%s:
" Last Change: 08-Apr-2017.
"
"***** Todo *****
"***** startup ***** {{{
"-------------------------------------------------------------------------
" encoding and file format
if has('win32') && !has('gui_running')
  set encoding=cp932
else
  set encoding=utf-8
  if has('win32')
    set shellpipe=2>\&1\|nkf\ -w>%s
  endif
endif
set fileencodings=ucs-bom,utf-8,euc-jp,cp932,latin1
set fileformat=unix
set fileformats=unix,dos
scriptencoding utf-8

if has('win32')
  let $USERDIR=expand('~/vimfiles')
  let $USERCACHEDIR=expand('~/vimcache')
else
  let $USERDIR=expand('~/.vim')
  let $USERCACHEDIR=expand('~/.vimcache')
endif

let $LANG = 'C'

" start syntax highlighting
syntax enable

augroup vimrc
  autocmd!
augroup END
"}}}
"***** plugins *****"{{{
"--------------------------------------------------------------------------
"*** neobundle.vim *** {{{
if has('vim_starting')
  set rtp+=$USERDIR/bundle/neobundle.vim/
end
call neobundle#begin(expand($USERDIR) . '/bundle/')
call neobundle#add('JuliaEditorSupport/julia-vim')
" call neobundle#add('julia-vim', {'base': '~/Dropbox/Works/', 'frozen': 1})
" call neobundle#add('julia-vim-extra', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('kana/vim-operator-user')
call neobundle#add('kana/vim-operator-replace')
" call neobundle#add('rhysd/vim-operator-surround')
call neobundle#add('kana/vim-smartinput')
call neobundle#add('kana/vim-submode')
call neobundle#add('kana/vim-textobj-user')
call neobundle#add('kana/vim-textobj-indent')
call neobundle#add('kana/vim-textobj-line')
call neobundle#add('Konfekt/FastFold')
" call neobundle#add('itchyny/lightline.vim')
" call neobundle#add('vim-airline/vim-airline')
" call neobundle#add('t9md/vim-ezbar')
call neobundle#add('machakann/vim-event-DotCommandPre')
" call neobundle#add('vim-event-DotCommandPre', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('machakann/vim-colorscheme-kemonofriends')
call neobundle#add('machakann/vim-columnmove')
" call neobundle#add('vim-cmdline-completion-extra', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('machakann/vim-lion')
call neobundle#add('machakann/vim-operator-insert')
call neobundle#add('machakann/vim-patternjump')
call neobundle#add('machakann/vim-sandwich')
" call neobundle#add('vim-sandwich', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('machakann/vim-highlightedyank')
" call neobundle#add('vim-highlightedyank', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('machakann/vim-swap')
" call neobundle#add('vim-swap', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('machakann/vim-textobj-functioncall')
" call neobundle#add('vim-textobj-functioncall', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('machakann/vim-textobj-delimited')
" call neobundle#add('vim-copycat', {'base': '~/Dropbox/Works/', 'frozen': 1})
" call neobundle#add('vim-textobj-mathblock', {'base': '~/Dropbox/Works/', 'frozen': 1})
call neobundle#add('machakann/vim-vimhelplint')
call neobundle#add('mattn/webapi-vim')
call neobundle#add('mbbill/undotree')
" call neobundle#add('neomake/neomake')
call neobundle#add('osyo-manga/vim-reanimate')
" call neobundle#add('plasticboy/vim-markdown')
call neobundle#add('sgur/vim-textobj-parameter')
call neobundle#add('Shougo/neobundle.vim', {'fetch': 1})
call neobundle#add('Shougo/neomru.vim')
call neobundle#add('Shougo/unite.vim')
call neobundle#add('Shougo/vimproc.vim', {
  \ 'build' : {
  \   'windows': 'tools\\update-dll-mingw',
  \   'cygwin' : 'make -f make_cygwin.mak',
  \   'mac'    : 'make -f make_mac.mak',
  \   'unix'   : 'make -f make_unix.mak',
  \  },
  \ })
call neobundle#add('superbrothers/vim-quickrun-markdown-gfm')
call neobundle#add('thinca/vim-prettyprint')
call neobundle#add('thinca/vim-visualstar')
call neobundle#add('thinca/vim-quickrun')
" call neobundle#add('thinca/vim-template')
call neobundle#add('thinca/vim-themis')
" call neobundle#add('tommcdo/vim-lion')
call neobundle#add('tyru/caw.vim')
call neobundle#add('tyru/open-browser.vim')
" call neobundle#add('vim-scripts/visualrepeat')
" call neobundle#add('vim-scripts/ingo-library')
" call neobundle#add('vim-scripts/ConflictMotions')
" call neobundle#add('vim-scripts/CountJump')
call neobundle#add('vim-jp/vimdoc-ja')

call neobundle#add('jceb/vim-hier', {
      \   'lazy': 1,
      \   'autoload' : {'commands' : ['HierUpdate', 'HierClear', 'HierStart', 'HierStop'],}
      \ })
call neobundle#add('osyo-manga/vim-anzu', {
      \   'lazy': 1,
      \   'autoload' : {'mappings' : '<Plug>(anzu-',}
      \ })
call neobundle#add('Shougo/neocomplete', {'lazy': 1})
call neobundle#add('machakann/neco-look', {
      \   'lazy': 1,
      \   'depends': 'Shougo/neocomplete',
      \ })
call neobundle#add('vim-jp/vital.vim', {
      \   'lazy': 1,
      \   'autoload' : {'commands' : 'Vitalize',},
      \ })
call neobundle#end()

filetype plugin indent on       " Required!
if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif
"}}}
"*** smartinput *** {{{
" Disable default settings
let g:smartinput_no_default_key_mappings = 1

" I know following description is too lengthy, but otherwise I would not be
" able to review them...

" doushite kounatta...
" chottoshita kyoukiwo kanjiru...

" NOTE: 'Comment' syntax is somewhat unique, since it is not highlighted only
"       at the end of line.  Or any other syntax working in similar way might
"       be same. Note it.
"       "oooooooooooooh, wahhoi!
"       |<-   Comment        ->|#Here is not comment.

" NOTE: Usually 'String' can not be used for syntax group assignment, but as
"       far as using 'mckn' colorscheme 'String' is available.  Since 'mckn'
"       sets a color directly for 'String' group.  I mean, in case I want to
"       change the colorscheme this settings might not work as I expect.

" map to trigger
let s:trig = [
      \   ['<Plug>(smartinput_SPACE)', '<Plug>(smartinput_SPACE)', '<Space>'],
      \   ['<Plug>(smartinput_BS)', '<Plug>(smartinput_BS)',   '<BS>'],
      \   ['<Plug>(smartinput_CR)', '<Plug>(smartinput_CR)',   '<CR>'],
      \   ['<Plug>(smartinput_^k)', '<Plug>(smartinput_^k)',  '<C-k>'],
      \   ['<Plug>(smartinput_^n)', '<Plug>(smartinput_^n)',  '<C-n>'],
      \   ['(', '(', '('],
      \   [')', ')', ')'],
      \   ['[', '[', '['],
      \   [']', ']', ']'],
      \   ['{', '{', '{'],
      \   ['}', '}', '}'],
      \   ["'", "'", "'"],
      \   ['"', '"', '"'],
      \   ['<', '<', '<'],
      \   ['>', '>', '>'],
      \   ['+', '+', '+'],
      \   ['-', '-', '-'],
      \   ['*', '*', '*'],
      \   ['/', '/', '/'],
      \   ['%', '%', '%'],
      \   ['&', '&', '&'],
      \   ['=', '=', '='],
      \   ['~', '~', '~'],
      \   ['#', '#', '#'],
      \   ['^', '^', '^'],
      \   ['!', '!', '!'],
      \   ['?', '?', '?'],
      \   [':', ':', ':'],
      \   ['.', '.', '.'],
      \   [',', ',', ','],
      \   ['<Bar>', '<Bar>', '<Bar>'],
      \ ]

for item in s:trig
  call smartinput#map_to_trigger('i', item[0], item[1], item[2])
  call smartinput#map_to_trigger('c', item[0], item[1], item[2])
endfor
unlet item

" clear default rules
call smartinput#clear_rules()

let s:rules = []

" imitate smartchr.vim
" '<' -> ' < ' -> ' << ' -> '<<' -> '<<<' -> '<<<<' ...
let s:rules += [
      \   {'char': '<', 'at': '\%#',     'input': '<',                },
      \   {'char': '<', 'at': '<\%#',    'input': '<BS> < ',          },
      \   {'char': '<', 'at': ' < \%#',  'input': '<BS>< ',           },
      \   {'char': '<', 'at': ' << \%#', 'input': '<BS><BS><BS><BS><<'},
      \   {'char': '<', 'at': '<<\+\%#', 'input': '<',                },
      \ ]
" '>' -> ' > ' -> ' >> ' -> '>>' -> '>>>' -> '>>>>' ...
let s:rules += [
      \   {'char': '>', 'at': '\%#',     'input': '>',                },
      \   {'char': '>', 'at': '>\%#',    'input': '<BS> > ',          },
      \   {'char': '>', 'at': ' > \%#',  'input': '<BS>> ',           },
      \   {'char': '>', 'at': ' >> \%#', 'input': '<BS><BS><BS><BS>>>'},
      \   {'char': '>', 'at': '>>\+\%#', 'input': '>',                },
      \ ]
" '+' -> ' + ' -> '++' -> '+++' -> '++++' ...
let s:rules += [
      \   {'char': '+', 'at': '\%#',     'input': '+',                 },
      \   {'char': '+', 'at': '+\%#',    'input': '<BS> + ',           },
      \   {'char': '+', 'at': ' + \%#',  'input': '<BS><BS><BS>++',    },
      \   {'char': '+', 'at': '++\+\%#', 'input': '+',                 },
      \ ]
" '-' -> ' - ' -> '--' -> '---' -> '----' ...
let s:rules += [
      \   {'char': '-', 'at': '\%#',          'input': '-',            },
      \   {'char': '-', 'at': '-\%#',         'input': '<BS> - ',      },
      \   {'char': '-', 'at': ' - \%#',       'input': '<BS><BS><BS>--'},
      \   {'char': '-', 'at': '--\+\%#',      'input': '-',            },
      \   {'char': '-', 'at': '[(=<>]\s*\%#', 'input': '-',            },
      \ ]
" '&' -> ' && ' -> '&&' -> '&&&' -> '&&&&' ...
let s:rules += [
      \   {'char': '&', 'at': '\%#',     'input': '&',                },
      \   {'char': '&', 'at': '&\%#',    'input': '<BS> && ',         },
      \   {'char': '&', 'at': ' && \%#', 'input': '<BS><BS><BS><BS>&&'},
      \   {'char': '&', 'at': '&&\+\%#', 'input': '&',                },
      \   {'char': '&', 'at': ' &\%#\S', 'input': '& ',               },
      \   {'char': '&', 'at': ' &\%#$',  'input': '& ',               },
      \   {'char': '&', 'at': '\S&\%# ', 'input': '<BS><Del> && ',    },
      \   {'char': '&', 'at': ' &\%# ',  'input': '<Del>& ',          },
      \ ]
" '|' -> ' | ' -> ' || ' -> '||' -> '|||' -> '||||' ...
let s:rules += [
      \   {'char': '<Bar>', 'at': '\%#',     'input': '|',                },
      \   {'char': '<Bar>', 'at': '|\%#',    'input': '<BS> | ',          },
      \   {'char': '<Bar>', 'at': ' | \%#',  'input': '<BS>| ',           },
      \   {'char': '<Bar>', 'at': ' || \%#', 'input': '<BS><BS><BS><BS>||'},
      \   {'char': '<Bar>', 'at': '||\+\%#', 'input': '|',                },
      \   {'char': '<Bar>', 'at': ' |\%#\S', 'input': '| ',               },
      \   {'char': '<Bar>', 'at': ' |\%#$',  'input': '| ',               },
      \   {'char': '<Bar>', 'at': '\S|\%# ', 'input': '<BS><Del> || ',    },
      \   {'char': '<Bar>', 'at': ' |\%# ',  'input': '<Del>| ',          },
      \ ]

" do not apply on 'Comment' or 'String' syntax
let s:rules += [
      \   {'char': '<',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '<'},
      \   {'char': '>',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '>'},
      \   {'char': '+',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+'},
      \   {'char': '-',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-'},
      \   {'char': '&',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '&'},
      \   {'char': '<Bar>', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '<Bar>'},
      \ ]

" smart '=' input
" ' = ' -> ' == ' -> '=' -> '==' ...
let s:rules += [
      \   {'char': '=', 'at': '\%#',     'input': ' = ',             },
      \   {'char': '=', 'at': ' = \%#',  'input': '<BS>= ',          },
      \   {'char': '=', 'at': ' == \%#', 'input': '<BS><BS><BS><BS>='},
      \   {'char': '=', 'at': '=\%#',    'input': '=',               },
      \ ]

let s:rules += [
      \   {'char': '=', 'at': '\%# = ',         'input': '<Del><Del><Del>==' },
      \   {'char': '=', 'at': ' \%#',           'input': '= ',               },
      \   {'char': '=', 'at': '[^= ]\%# ',      'input': '<Del> = ',         },
      \   {'char': '=', 'at': ' \%# ',          'input': '<Del>= ',          },
      \   {'char': '=', 'at': ' \%#=',          'input': '<Del>== ',         },
      \   {'char': '=', 'at': ' =\%#',          'input': '= ',               },
      \   {'char': '=', 'at': ' =\%# ',         'input': '<Del>= ',          },
      \   {'char': '=', 'at': '[-+<>~!] \%#',   'input': '<BS>= ',           },
      \   {'char': '=', 'at': ' [-+<>~!]\%#\S', 'input': '= ',               },
      \   {'char': '=', 'at': ' [-+<>~!]\%#$',  'input': '= ',               },
      \   {'char': '=', 'at': ' [-+<>~!]\%# ',  'input': '=',                },
      \   {'char': '=', 'at': '\S-\%#',         'input': '<BS> -= ',         },
      \   {'char': '=', 'at': '\S+\%#',         'input': '<BS> += ',         },
      \   {'char': '=', 'at': '\S<\%#',         'input': '<BS> <= ',         },
      \   {'char': '=', 'at': '\S>\%#',         'input': '<BS> >= ',         },
      \   {'char': '=', 'at': '\S!\%#',         'input': '<BS> != ',         },
      \   {'char': '=', 'at': ' -= \%#',        'input': '<BS><BS><BS><BS>-='},
      \   {'char': '=', 'at': ' += \%#',        'input': '<BS><BS><BS><BS>+='},
      \   {'char': '=', 'at': ' <= \%#',        'input': '<BS><BS><BS><BS><='},
      \   {'char': '=', 'at': ' >= \%#',        'input': '<BS><BS><BS><BS>>='},
      \   {'char': '=', 'at': ' != \%#',        'input': '<BS><BS><BS><BS>!='},
      \   {'char': '=', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '='},
      \ ]

" smart '<CR>' input
" delete line end spaces when line-breaking
let s:rules += [
      \   {'char': '<Plug>(smartinput_CR)', 'at': '\S\s\+\%#', 'input': '<CR><C-o>:call setline(line(''.'')-1, substitute(getline(line(''.'')-1), ''\s\+$'', '''', ''''))<CR>'},
      \   {'char': '<Plug>(smartinput_CR)', 'at': '{\%#}', 'input': '<CR><CR><Up><C-f>'},
      \ ]

" smart quotes input
let s:rules += [
      \   {'char': '''', 'at': '\%#',         'input': '''''<C-g>U<Left>'},
      \   {'char': '''', 'at': '''''''\%#''', 'input': '<C-g>U<Right>',  },
      \   {'char':  '"', 'at': '\%#',         'input': '""<C-g>U<Left>', },
      \   {'char':  '"', 'at': '\\\%#',       'input': '"',              },
      \   {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*\%#"',       'input': '""<C-g>U<Left>',      },
      \   {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',  'input': '""',                  },
      \   {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#"', 'input': '<C-g>U<Right>',       },
      \   {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*\%#''', 'input': '''''<C-g>U<Left>',    },
      \   {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\%#''', 'input': '<C-g>U<Right>'},
      \ ]

" correspondent parentheses
let s:rules += [
      \   {'char': '(', 'at': '\%#',   'input': '()<C-g>U<Left>',   'mode': 'i'},
      \   {'char': ')', 'at': '\%#)',  'input': '<C-g>U<Right>',    'mode': 'i'},
      \   {'char': '(', 'at': '\%#',   'input': '()<Left>',         'mode': '/?'},
      \   {'char': ')', 'at': '\%#)',  'input': '<Right>',          'mode': '/?'},
      \   {'char': '(', 'at': '[^\\]\%(\\\\\)*\\\%#', 'input': '(', 'mode': 'i/?'},
      \   {'char': '[', 'at': '\%#',   'input': '[]<C-g>U<Left>',   'mode': 'i'},
      \   {'char': ']', 'at': '\%#\]', 'input': '<C-g>U<Right>',    'mode': 'i'},
      \   {'char': '[', 'at': '\%#',   'input': '[]<Left>',         'mode': '/?'},
      \   {'char': ']', 'at': '\%#\]', 'input': '<Right>',          'mode': '/?'},
      \   {'char': '[', 'at': '[^\\]\%(\\\\\)*\\\%#', 'input': '[', 'mode': 'i/?'},
      \   {'char': '{', 'at': '\%#',   'input': '{}<C-g>U<Left>',   'mode': 'i'},
      \   {'char': '}', 'at': '\%#}',  'input': '<C-g>U<Right>',    'mode': 'i'},
      \   {'char': '{', 'at': '\%#',   'input': '{}<Left>',         'mode': '/?'},
      \   {'char': '}', 'at': '\%#}',  'input': '<Right>',          'mode': '/?'},
      \   {'char': '{', 'at': '[^\\]\%(\\\\\)*\\\%#', 'input': '{', 'mode': 'i/?'},
      \ ]

" delete correspondent parentheses and quotes
let s:rules += [
      \   {'char': '<Plug>(smartinput_BS)', 'at': '(\%#)',     'input': '<BS><Del>', 'mode': 'i/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '()\%#',     'input': '<BS><BS>',  'mode': 'i/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\[\%#\]',   'input': '<BS><Del>', 'mode': 'i/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\[\]\%#',   'input': '<BS><BS>',  'mode': 'i/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '{\%#}',     'input': '<BS><Del>', 'mode': 'i/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '{}\%#',     'input': '<BS><BS>',  'mode': 'i/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '''\%#''',   'input': '<BS><Del>'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '''''\%#',   'input': '<BS><BS>' },
      \   {'char': '<Plug>(smartinput_BS)', 'at': '''''\%#''', 'input': '<BS><BS>' },
      \   {'char': '<Plug>(smartinput_BS)', 'at': '"\%#"',     'input': '<BS><Del>'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '""\%#"',    'input': '<BS><BS>' },
      \ ]

" Delete operaters together with vicinal spaces
let s:rules += [
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' < \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' > \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' + \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' - \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' / \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' & \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' % \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' \* \%#',  'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' = \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' == \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' != \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' \~= \%#', 'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <> \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <= \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' >= \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' += \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' -= \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' && \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' || \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
      \ ]

" miscellaneous settings
let s:rules += [
      \   {'char': '>', 'at': ' < \%#', 'input': '<BS>> ', 'mode': 'i:'},
      \   {'char': ',', 'at': '\%#',    'input': ', ',     'mode': 'i'},
      \   {'char': ',', 'at': ', \%#',  'input': '<BS>',   'mode': 'i'},
      \   {'char': ',', 'at': '\%# ',   'input': ',',      'mode': 'i'},
      \   {'char': ',', 'at': '\w \%#', 'input': '<BS>, ', 'mode': 'i'},
      \   {'char': '(', 'at': '\C^[hH]elp \w\+\%#', 'input': '(', 'mode': ':'},
      \   {'char': '=', 'at': '\C\<set\> \w\+\%#',  'input': '=', 'mode': ':'},
      \ ]

" for commandline mode
" '|' is cursor. The character inside the -[]-> means keypress.
" = | -[~]-> =~ | -[?]-> =~? |
" ...and something like above.
let s:rules += [
      \   {'char': '"', 'at': '^\s*\%#', 'input': '" ',     'mode': ':'},
      \   {'char': '~', 'at': '= \%#',   'input': '<BS>~ ', 'mode': ':'},
      \   {'char': '#', 'at': '== \%#',  'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '== \%#',  'input': '<BS>? ', 'mode': ':'},
      \   {'char': '#', 'at': '!= \%#',  'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '!= \%#',  'input': '<BS>? ', 'mode': ':'},
      \   {'char': '#', 'at': '> \%#',   'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '> \%#',   'input': '<BS>? ', 'mode': ':'},
      \   {'char': '#', 'at': '>= \%#',  'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '>= \%#',  'input': '<BS>? ', 'mode': ':'},
      \   {'char': '#', 'at': '< \%#',   'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '< \%#',   'input': '<BS>? ', 'mode': ':'},
      \   {'char': '#', 'at': '<= \%#',  'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '<= \%#',  'input': '<BS>? ', 'mode': ':'},
      \   {'char': '#', 'at': '=\~ \%#', 'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '=\~ \%#', 'input': '<BS>? ', 'mode': ':'},
      \   {'char': '#', 'at': '!\~ \%#', 'input': '<BS># ', 'mode': ':'},
      \   {'char': '?', 'at': '!\~ \%#', 'input': '<BS>? ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' ==# \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' ==? \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !=# \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !=? \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' ># \%#',   'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' >? \%#',   'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' >=# \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' >=? \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <# \%#',   'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <? \%#',   'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <=# \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <=? \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' =\~ \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' =\~# \%#', 'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' =\~? \%#', 'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !\~ \%#',  'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !\~# \%#', 'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !\~? \%#', 'input': '<BS><BS> ', 'mode': ':'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '"\s\%#',    'input': '<BS><BS>',  'mode': ':'},
      \ ]

" for regular expression
" '#' is cursor. The character inside the -[]-> means keypress.
" (#  -  [(]  -> ((#
"     -[<C-k>]-> \%(#\) -[<C-k>]-> \(#\) -[<C-k>]-> \%(#\)

let s:rules += [
      \   {'char': ')', 'at': '\%#\\)',  'input': '<Right><Right>', 'mode': '/?'},
      \   {'char': ']', 'at': '\%#\\\]', 'input': '<Right><Right>', 'mode': '/?'},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '(\%#',        'input': '<BS><Del>\%(\)<Left><Left>', 'mode': '/?'},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\%(\%#\\)',  'input': '<Left><BS><Right>',          'mode': '/?'},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\(\%#\\)',   'input': '<Left>%<Right>',             'mode': '/?'},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\)\%#',      'input': '<Left><Left>)',              'mode': '/?'},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\[\%#',       'input': '<BS>\[\]<Left><Left>',       'mode': '/?'},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\]\%#',      'input': '<Left><Left>]',              'mode': '/?'},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '<\%#',        'input': '<BS>\<\><Left><Left>',       'mode': '/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\%(\%#\\)',  'input': '<BS><BS><BS><Del><Del>',     'mode': '/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\(\%#\\)',   'input': '<BS><BS><Del><Del>',         'mode': '/?'},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\\[\%#\\\]', 'input': '<BS><BS><Del><Del>',         'mode': '/?'},
      \ ]

" filetype option

" vim
let s:rules += [
      \   {'char': '"', 'at': '^\s*\%#', 'input': '" ',     'filetype': ['vim']},
      \   {'char': '~', 'at': '= \%#',   'input': '<BS>~ ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '== \%#',  'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '== \%#',  'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '!= \%#',  'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '!= \%#',  'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '> \%#',   'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '> \%#',   'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '>= \%#',  'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '>= \%#',  'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '< \%#',   'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '< \%#',   'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '<= \%#',  'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '<= \%#',  'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '=\~ \%#', 'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '=\~ \%#', 'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '#', 'at': '!\~ \%#', 'input': '<BS># ', 'filetype': ['vim']},
      \   {'char': '?', 'at': '!\~ \%#', 'input': '<BS>? ', 'filetype': ['vim']},
      \   {'char': '~', 'at': '!\%#',  'input': '<BS> !~ ', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' ==# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' ==? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !=# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !=? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' ># \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' >? \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' >=# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' >=? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <# \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <? \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <=# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <=? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' =\~ \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' =\~# \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' =\~? \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !\~ \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !\~# \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' !\~? \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*"\s\%#','input': '<BS><BS>',     'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' \. \%#',   'input': '<BS><BS><BS>', 'filetype': ['vim']},
      \   {'char': '=', 'at': '\. \%#',   'input': '<BS>= ',              'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.\%#\S', 'input': '= ',                  'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.\%#$',  'input': '= ',                  'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.\%# ',  'input': '=',                   'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': '\S\.\%#',  'input': '<BS> .= ',            'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.= \%#', 'input': '<BS><BS><BS><BS>.=',  'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': '<C-r>\%#', 'input': '=',                   'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': '\C\<set\%[local]\> \w\+\%#', 'input': '=', 'mode': 'i',  'filetype': ['vim']},
      \   {'char': '=', 'at': '^\s*let\s\+\[\%(\k\+,\s*\)*\k\+\%#\]', 'input': '<C-g>U<Right> = ', 'mode': 'i',  'filetype': ['vim']},
      \   {'char': '&', 'at': '\s\%#', 'input': '&<C-r>=Complete(col("."), getcompletion("", "option"))<CR><C-p>', 'filetype': ['vim']},
      \ ]

" '.' -> ' . ' -> '..' -> '...'
let s:rules += [
      \   {'char': '.', 'at': '\%#',       'input': '.',              'filetype': ['vim']},
      \   {'char': '.', 'at': '\.\%#',     'input': '<BS> . ',        'filetype': ['vim']},
      \   {'char': '.', 'at': ' \. \%#',   'input': '<BS><BS><BS>..', 'filetype': ['vim']},
      \   {'char': '.', 'at': '\.\.\%#',   'input': '.',              'filetype': ['vim']},
      \   {'char': '.', 'at': ' \.\%#\S',  'input': ' ',              'filetype': ['vim']},
      \   {'char': '.', 'at': '\S\.\%# ',  'input': '<BS><Del> . ',   'filetype': ['vim']},
      \   {'char': '.', 'at': ' \.\%# ',   'input': '<Del> ',         'filetype': ['vim']},
      \   {'char': '.', 'at': '^\s*function!\?\s\+\%(\%(s:\)\?\k\+\%(\.\k\+\)\?\|\%(g:\)\?\u\k*\%(\.\k\+\)\?\)(.*\%#', 'input': '...', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*function!\?\s\+\%(\%(s:\)\?\k\+\%(\.\k\+\)\?\|\%(g:\)\?\u\k*\%(\.\k\+\)\?\)(.*\.\.\.\%#', 'input': '<BS><BS><BS>', 'filetype': ['vim']},
      \   {'char': '.', 'at': '^\s*function!\?\s\+\%(\%(s:\)\?\k\+\|\%(g:\)\?\u\k*\)\%#\s\+\%(abort\)\?$', 'input': '. dict<C-g>U<Left><C-g>U<Left><C-g>U<Left><C-g>U<Left><C-g>U<Left>', 'filetype': ['vim']},
      \ ]

let s:rules += [
      \   {'char': ')', 'at': '\%#\\)',  'input': '<C-g>U<Right><C-g>U<Right>', 'filetype': ['vim']},
      \   {'char': ']', 'at': '\%#\\\]', 'input': '<C-g>U<Right><C-g>U<Right>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '(\%#)',       'input': '<BS><Del>\%(\)<C-g>U<Left><C-g>U<Left>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\[\%#\]',     'input': '<BS><Del>\[\]<C-g>U<Left><C-g>U<Left>',  'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '<\%#>',       'input': '<BS><Del>\<\><C-g>U<Left><C-g>U<Left>',  'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\%(\%#\\)',  'input': '<BS><BS>(',                  'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\(\%#\\)',   'input': '<BS>%(',                     'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\%(\%#\\)',  'input': '<BS><BS><BS><Del><Del>',     'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\(\%#\\)',   'input': '<BS><BS><Del><Del>',         'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\\[\%#\\\]', 'input': '<BS><BS><Del><Del>',         'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_CR)', 'at': '{\%#}', 'input': '<CR>\<Tab><Esc>O\<Tab><Tab>',      'filetype': ['vim']},
      \ ]

let s:rules += [
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*fu\%[nctio]\%#', 'input': '<C-w><C-r>=CloseBlock("function!  abort", "endfunction", " ")<CR><Esc>0f!la', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*if\%#', 'input': '<C-r>=CloseBlock(" ", "endif", " ")<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*if\%#\s', 'input': '<C-r>=CloseBlock("", "endif", " ")<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*for\s\+\S.*\%#', 'input': '<C-r>=VimCloseForBlock()<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*while\%#', 'input': '<C-r>=CloseBlock(" ", "endwhile", " ")<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*while\%#\s', 'input': '<C-r>=CloseBlock("", "endwhile", " ")<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*augroup\%#', 'input': '<C-r>=CloseBlock(" ", "augroup END", " ")<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*try\%#', 'input': '<C-r>=CloseBlock("", "endtry", " ")<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_CR)', 'at': '^\s*try\%#', 'input': '<C-r>=CloseBlock("", "endtry", "<C-v><CR>", "<C-v><CR>")<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*for\s\+\S.* in \%#', 'input': '<BS><BS><BS><BS>', 'filetype': ['vim']},
      \ ]

" matlab
let s:rules += [
      \   {'char': '%', 'at': '^\s*\%#',     'input': '% ',      'filetype': ['matlab']},
      \   {'char': '%', 'at': '^\s*%\+ \%#', 'input': '<BS>%% ', 'filetype': ['matlab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*%\s\%#',         'input': '<BS><BS>',      'filetype': ['matlab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*\(%%\)\+%\s\%#', 'input': '<BS><BS><BS> ', 'filetype': ['matlab']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*fu\%[nction]\%#', 'input': '<C-w><C-r>=CloseBlock("function ", "end", " ")<CR>', 'filetype': ['matlab']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*\%(if\|for\|while\)\%#', 'input': '<C-r>=CloseBlock(" ", "end", " ")<CR>', 'filetype': ['matlab']},
      \ ]

" scilab
let s:rules += [
      \   {'char': '/', 'at': '^\s*\%#',          'input': '// ',     'filetype': ['scilab']},
      \   {'char': '/', 'at': '^\s*\(//\)\+ \%#', 'input': '<BS>// ', 'filetype': ['scilab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*//\s\%#',         'input': '<BS><BS><BS>',  'filetype': ['scilab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*//\(//\)\+\s\%#', 'input': '<BS><BS><BS> ', 'filetype': ['scilab']},
      \ ]

" common in matlab, scilab and julia
" '+' -> ' + ' -> '++' -> '+++' ...
let s:rules += [
      \   {'char': '+', 'at': '\%#',      'input': '+',              'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '+', 'at': '[^+]+\%#', 'input': '<BS> + ',        'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '+', 'at': ' + \%#',   'input': '<BS><BS><BS>++', 'filetype': ['matlab', 'scilab']},
      \   {'char': '+', 'at': ' + \%#',  'input': '<BS><BS><BS> .+ ',   'filetype': ['julia']},
      \   {'char': '+', 'at': ' .+ \%#', 'input': '<BS><BS><BS><BS>++', 'filetype': ['julia']},
      \ ]
" '-' -> ' - ' -> '--' -> '---' ...
let s:rules += [
      \   {'char': '-', 'at': '\%#',      'input': '-',              'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '-', 'at': '[^-]-\%#', 'input': '<BS> - ',        'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '-', 'at': ' - \%#',   'input': '<BS><BS><BS>--', 'filetype': ['matlab', 'scilab']},
      \   {'char': '-', 'at': ' - \%#',  'input': '<BS><BS><BS> .- ',   'filetype': ['julia']},
      \   {'char': '-', 'at': ' .- \%#', 'input': '<BS><BS><BS><BS>--', 'filetype': ['julia']},
      \ ]
" '.^' -> '^' -> '^^' -> '^^^' ...
let s:rules += [
      \   {'char': '^', 'at': '\%#', 'input': '^', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '^', 'at': '[^\^.]\^\%#', 'input': '<BS>.^', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '^', 'at': '\.\^\%#', 'input': '<BS><BS>^^', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '[^^.]^\%#', 'input': '<BS>.^',    'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\.^\%#',    'input': '<BS><BS>^', 'filetype': ['matlab', 'scilab', 'julia']},
      \ ]
" '.*' -> '*' -> '**' -> '***' ...
let s:rules += [
      \   {'char': '*', 'at': '\%#', 'input': '*', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '*', 'at': '[^*.]\*\%#', 'input': '<BS>.*', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '*', 'at': '\.\*\%#', 'input': '<BS><BS>**', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '[^*.]\*\%#', 'input': '<BS>.*',    'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\.\*\%#',    'input': '<BS><BS>*', 'filetype': ['matlab', 'scilab', 'julia']},
      \ ]
" './' -> '/' -> '//' -> '///' ...
let s:rules += [
      \   {'char': '/', 'at': '\%#', 'input': '/', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '/', 'at': '[^/.]/\%#', 'input': '<BS>./', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '/', 'at': '\./\%#', 'input': '<BS><BS>//', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '[^/.]/\%#', 'input': '<BS>./',    'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\./\%#',    'input': '<BS><BS>/', 'filetype': ['matlab', 'scilab', 'julia']},
      \ ]

let s:rules += [
      \   {'char': '+', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '-', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '^', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '^', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '*', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '*', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '/', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '/', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\.[*/^]\%#', 'input': '<BS><BS>', 'filetype': ['matlab', 'scilab', 'julia']},
      \ ]

" Fortran
let s:rules += [
      \   {'char': ':', 'at': '^\s*\%(integer\|real\%(([[:alnum:]_%()]*)\)\?\|double precision\|complex\|complex([[:alnum:]_%()]*)\|logical\|character\)\%((\d\+)\)\?\%(\s*,\s*\%(dimension(\d\+\%(,\s*\d\+\))\|parameter\|allocatable\|save\|intent(\%(in\|out\|inout\))\)\)\?\%#', 'input': ' :: ', 'filetype': ['fortran']},
      \   {'char': ':', 'at': '^\s*type(\h\w*)\%(,\s*\%(dimension(\d\+\%(,\s*\d\+\))\|parameter\|allocatable\|private\|public\|save\)\)\?\%#', 'input': ' :: ', 'filetype': ['fortran']},
      \   {'char': ':', 'at': '^\s*\%(private\|public\)\%#', 'input': ' :: ', 'filetype': ['fortran']},
      \   {'char': ':', 'at': ' :: \%#', 'input': '<BS><BS><BS><BS>:',  'filetype': ['fortran']},
      \   {'char': '=', 'at': '/ \%#',   'input': '<BS>= ',             'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /\%#\S', 'input': '= ',                 'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /\%#$',  'input': '= ',                 'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /\%# ',  'input': '=',                  'filetype': ['fortran']},
      \   {'char': '=', 'at': '\S/\%#',  'input': '<BS> /= ',           'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /= \%#', 'input': '<BS><BS><BS><BS>/=', 'filetype': ['fortran']},
      \   {'char': '&', 'at': '^\s*\%(else\s\+\)\?if (.*\%#',   'input': ' .and. ', 'filetype': ['fortran']},
      \   {'char': '&', 'at': '^\s*\%(else\s\+\)\?if (.*\s\%#', 'input': '.and. ',  'filetype': ['fortran']},
      \   {'char': '|', 'at': '^\s*\%(else\s\+\)\?if (.*\%#',   'input': ' .or. ',  'filetype': ['fortran']},
      \   {'char': '|', 'at': '^\s*\%(else\s\+\)\?if (.*\s\%#', 'input': '.or. ',   'filetype': ['fortran']},
      \   {'char': '!', 'at': '^\s*\%(else\s\+\)\?if (.\+\%#',  'input': ' .not. ', 'filetype': ['fortran']},
      \   {'char': '!', 'at': '^\s*\%(else\s\+\)\?if (\%#',     'input': '.not. ',  'filetype': ['fortran']},
      \   {'char': '!', 'at': '^\s*\%(else\s\+\)\?if (.*\s\%#', 'input': '.not. ',  'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*\a*\%#', 'input': '<C-r>=LocalComplete(["type"], StCol(''\%(^\|\<\)\a*''))<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*\%(integer\|real\|double precision\|complex\|complex([[:alnum:]_%()]*)\|logical\|character\)[^:]*\%#', 'input': '<C-r>=LocalComplete(["attr"], StCol(''\%(^\|\<\)\a*''))<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' \.and\. \%#', 'input': '<BS><BS><BS><BS><BS><BS><BS>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' \.or\. \%#',  'input': '<BS><BS><BS><BS><BS><BS>',     'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' \.not\. \%#', 'input': '<BS><BS><BS><BS><BS><BS><BS>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*su\%[broutine]\%#', 'input': '<C-w>subroutine<C-r>=CloseBlock(" ", "end subroutine <C-v><C-f>", " ")<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*fu\%[nction]\%#', 'input': '<C-w>function<C-r>=CloseBlock(" ", "end function <C-v><C-f>", " ")<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*if\%#', 'input': ' ()<C-g>U<Left>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*if\s\+(.*)\%#$', 'input': ' then', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*do\%#$', 'input': '<C-r>=CloseBlock(" ", " end do", " ")<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*if\s\+(.*)\s\+then\%#', 'input': '<C-r>=CloseBlock("", "end if", " ")<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_CR)',    'at': '^\s*if\s\+(.*)\s\+then\%#', 'input': '<C-r>=CloseBlock("", "end if", "<C-v><CR>", "<C-v><CR>")<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_CR)',    'at': '^\s*if\s\+(.*)\%#', 'input': '<C-r>=CloseBlock(" then", "end if", "<C-v><CR>", "<C-v><CR>")<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*function\s\+\h\k*(.*)\%#', 'input': ' result()<C-g>U<Left>', 'filetype': ['fortran']},
      \   {'char': '(', 'at': '^\s*function\s\+\h\k*\%#', 'input': '<C-r>=FortranSyncName("function")<CR>()<C-g>U<Left>', 'filetype': ['fortran']},
      \   {'char': '(', 'at': '^\s*subroutine\s\+\h\k*\%#', 'input': '<C-r>=FortranSyncName("subroutine")<CR>()<C-g>U<Left>', 'filetype': ['fortran']},
      \   {'char': '.', 'at': '\s\%#', 'input': '.<C-r>=Complete(col(".")-1, [".true.", ".false.", ".and.", ".or."])<CR><C-p>', 'filetype': ['fortran']},
      \ ]
" ' + ' -> '+' -> '++' -> '+++' ...
let s:rules += [
      \   {'char': '+', 'at': '\%#',    'input': ' + ',           'filetype': ['fortran']},
      \   {'char': '+', 'at': ' + \%#', 'input': '<BS><BS><BS>+', 'filetype': ['fortran']},
      \   {'char': '+', 'at': '+\%#',   'input': '+',             'filetype': ['fortran']},
      \   {'char': '+', 'at': ' \%#',   'input': '+ ',            'filetype': ['fortran']},
      \   {'char': '+', 'at': ' \%# ',  'input': '<Del>+ ',       'filetype': ['fortran']},
      \ ]
" ' - ' -> '-' -> '--' -> '---' ...
let s:rules += [
      \   {'char': '-', 'at': '\%#',    'input': ' - ',           'filetype': ['fortran']},
      \   {'char': '-', 'at': ' - \%#', 'input': '<BS><BS><BS>-', 'filetype': ['fortran']},
      \   {'char': '-', 'at': '-\%#',   'input': '-',             'filetype': ['fortran']},
      \   {'char': '-', 'at': ' \%#',   'input': '- ',            'filetype': ['fortran']},
      \   {'char': '-', 'at': ' \%# ',  'input': '<Del>- ',       'filetype': ['fortran']},
      \   {'char': '-', 'at': '\c[(=<>,ed]\s*\%#', 'input': '-',  'filetype': ['fortran']},
      \ ]

" R
" ' <- ' -> ' < ' -> '<' -> '<<' -> '<<<' ...
let s:rules += [
      \   {'char': '<', 'at': '\%#',     'input': ' <- ',          'filetype': ['r']},
      \   {'char': '<', 'at': ' <- \%#', 'input': '<BS><BS> ',     'filetype': ['r']},
      \   {'char': '<', 'at': ' < \%#',  'input': '<BS><BS><BS><', 'filetype': ['r']},
      \   {'char': '<', 'at': '<\%#',    'input': '<',             'filetype': ['r']},
      \ ]
" ' > ' -> '>' -> ' -> ' -> '>>' -> '>>>' ...
let s:rules += [
      \   {'char': '>', 'at': '\%#',     'input': ' > ',                'filetype': ['r']},
      \   {'char': '>', 'at': ' > \%#',  'input': '<BS><BS><BS>>',      'filetype': ['r']},
      \   {'char': '>', 'at': '>\%#',    'input': '<BS> -> ',           'filetype': ['r']},
      \   {'char': '>', 'at': ' -> \%#', 'input': '<BS><BS><BS><BS>>>', 'filetype': ['r']},
      \   {'char': '>', 'at': '>>\+\%#', 'input': '>',                  'filetype': ['r']},
      \ ]

let s:rules += [
      \   {'char': '-', 'at': '< \%#',   'input': '<BS>- ', 'filetype': ['r']},
      \   {'char': '>', 'at': '- \%#',   'input': '<BS>> ', 'filetype': ['r']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' <- \%#', 'input': '<BS><BS><BS><BS>', 'filetype': ['r']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' -> \%#', 'input': '<BS><BS><BS><BS>', 'filetype': ['r']},
      \ ]

" python
let s:rules += [{'char': '<Plug>(smartinput_BS)', 'at': '#\s\%#', 'input': '<BS><BS>', 'filetype': ['python']}]

" c
let s:rules += [{'char': '<Plug>(smartinput_BS)', 'at': '//\s\%#', 'input': '<BS><BS><BS>', 'filetype': ['c']}]
" ' + ' -> '++' -> '+' -> '+++' -> '++++' ...
let s:rules += [
      \   {'char': '+', 'at': '\%#',      'input': ' + ',            'filetype': ['c']},
      \   {'char': '+', 'at': ' + \%#',   'input': '<BS><BS><BS>++', 'filetype': ['c']},
      \   {'char': '+', 'at': '++\%#',    'input': '<BS>',           'filetype': ['c']},
      \   {'char': '+', 'at': '+\%#',     'input': '++',             'filetype': ['c']},
      \   {'char': '+', 'at': '+++\+\%#', 'input': '+',              'filetype': ['c']},
      \ ]
" ' - ' -> '--' -> '-' -> '---' -> '----' ...
let s:rules += [
      \   {'char': '-', 'at': '\%#',    'input': ' - ',            'filetype': ['c']},
      \   {'char': '-', 'at': ' - \%#', 'input': '<BS><BS><BS>--', 'filetype': ['c']},
      \   {'char': '-', 'at': '--\%#',  'input': '<BS>',           'filetype': ['c']},
      \   {'char': '-', 'at': '-\%#',   'input': '--',             'filetype': ['c']},
      \   {'char': '-', 'at': '---\+\%#', 'input': '-',            'filetype': ['c']},
      \ ]

let s:rules += [
      \   {'char': '+', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+', 'filetype': ['c']},
      \   {'char': '-', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-', 'filetype': ['c']},
      \ ]

" Julia langage
let s:rules += [
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\k\+:\%#',  'input': ':<C-r>=LocalComplete(["type"])<CR>', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\k\+::\%#', 'input': '<C-r>=LocalComplete(["type"])<CR>', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\%(Dict\|Array\)\%#', 'input': '{, }<Left><Left><Left><C-r>=LocalComplete(["type"])<CR>', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': 'Vector\%#', 'input': '{}<Left><C-r>=LocalComplete(["type"])<CR>', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\%(convert\|zeros\|ones\)\%#', 'input': '(, )<Left><Left><Left><C-r>=LocalComplete(["type"])<CR>', 'filetype': ['julia']},
      \   {'char': '>', 'at': '-\%#', 'input': '<BS> -> ', 'filetype': ['julia']},
      \   {'char': '>', 'at': ' - \%#', 'input': '<BS>> ', 'filetype': ['julia']},
      \   {'char': '>', 'at': ' = \%#', 'input': '<BS>> ', 'filetype': ['julia']},
      \   {'char': '>', 'at': '\.\%#', 'input': '<BS> .< ', 'filetype': ['julia']},
      \   {'char': '<', 'at': '\.\%#', 'input': '<BS> .< ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\*\%#', 'input': '<BS> *= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '/\%#',  'input': '<BS> /= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s\*\%#', 'input': '<BS>*= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s/\%#',  'input': '<BS>/= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\.\*\%#', 'input': '<BS><BS> .*= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\./\%#',  'input': '<BS><BS> ./= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s\.\*\%#', 'input': '<BS><BS>.*= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s\./\%#',  'input': '<BS><BS>./= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s\.<\%#', 'input': '<BS><BS>.<= ',  'filetype': ['julia']},
      \   {'char': '=', 'at': '\S\.<\%#', 'input': '<BS><BS> .<= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s\.>\%#', 'input': '<BS><BS>.>= ',  'filetype': ['julia']},
      \   {'char': '=', 'at': '\S\.>\%#', 'input': '<BS><BS> .>= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s\.< \%#', 'input': '<BS><BS><BS>.<= ',  'filetype': ['julia']},
      \   {'char': '=', 'at': '\S\.< \%#', 'input': '<BS><BS><BS> .<= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '\s\.> \%#', 'input': '<BS><BS><BS>.>= ',  'filetype': ['julia']},
      \   {'char': '=', 'at': '\S\.> \%#', 'input': '<BS><BS><BS> .>= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '(.*,\s*\k\+\%#', 'input': '=', 'filetype': ['julia']},
      \   {'char': '+', 'at': '\S\.\%#', 'input': '<BS> .+ ', 'filetype': ['julia']},
      \   {'char': '-', 'at': '\S\.\%#', 'input': '<BS> .- ', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*fu\%[nction]\%#', 'input': '<C-w><C-r>=CloseBlock("function ", "end", " ")<CR>', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_SPACE)', 'at': '^\s*\%(if\|for\|while\)\%#', 'input': '<C-r>=CloseBlock(" ", "end", " ")<CR>', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' [*/]= \%#',  'input': '<BS><BS><BS><BS>', 'filetype': ['julia'], 'mode': 'i:'},
      \ ]

" dosbatch, shellscript
let s:rules += [
      \   {'char': '=', 'at': '\%#',      'input': '=',        'filetype': ['dosbatch', 'sh']},
      \   {'char': '=', 'at': '[^=]=\%#', 'input': '<BS> == ', 'filetype': ['dosbatch', 'sh']},
      \ ]

call map(copy(s:rules), 'smartinput#define_rule(v:val)')
let g:is_smartinput_active = 1

" These mappings could be modified somewhere else.
" But required just for safety-net.
imap <BS>  <Plug>(smartinput_BS)
cmap <BS>  <Plug>(smartinput_BS)
imap <CR>  <Plug>(smartinput_CR)
imap <C-k> <Plug>(smartinput_^k)
cmap <C-k> <Plug>(smartinput_^k)
imap <expr> <C-n> <SID>i_CTRL_n()
imap <Space> <Plug>(smartinput_SPACE)

function! s:i_CTRL_n() abort
  if pumvisible()
    return "\<C-n>"
  else
    return "\<Plug>(smartinput_^n)"
  endif
endfunction

function! s:smartinput_has_rule(key) abort
  let ft = &filetype
  let rules = deepcopy(s:rules)
  call filter(rules, 'v:val["char"] ==# a:key')
  call filter(rules, '!has_key(v:val, "filetype") || match(v:val["filetype"], ft) >= 0')
  call filter(rules, '!has_key(v:val, "mode") || match(v:val["mode"], "i") >= 0')
  let has_rule = 0
  for rule in rules
    if search(rule.at, 'bcnW')
      let has_rule = 1
      break
    endif
  endfor
  return has_rule
endfunction

" toggle switch
command! -nargs=0 SmartinputToggle call Smartinput_toggle_switch()
nnoremap <silent> <M-s> :SmartinputToggle<CR>
inoremap <silent> <M-s> <C-r>=Smartinput_toggle_switch()<CR>
cnoremap          <M-s> <C-r>=Smartinput_toggle_switch()<CR>

function! Smartinput_toggle_switch()
  if g:is_smartinput_active
    for item in s:trig
      if item[0] == item[2]
        execute 'iunmap ' . item[0]
        execute 'cunmap ' . item[0]
      else
        if item[2] =~# '^<Plug>.\+'
          execute 'imap ' . item[0] . ' ' . item[2]
          execute 'cmap ' . item[0] . ' ' . item[2]
        else
          execute 'inoremap ' . item[0] . ' ' . item[2]
          execute 'cnoremap ' . item[0] . ' ' . item[2]
        endif
      endif
    endfor

    let g:is_smartinput_active = 0
  else
    for item in s:trig
      call smartinput#map_to_trigger('i', item[0], item[1], item[2])
      call smartinput#map_to_trigger('c', item[0], item[1], item[2])
    endfor

    let g:is_smartinput_active = 1
  endif

  return ''
endfunction

" Local completion
function! LocalComplete(kinds, ...) abort
  if exists('b:local_compl')
    let candidates = []
    let col        = col('.') - 2
    let col        = col >= 0 ? col : 0
    let startpos   = get(a:000, 0, col)
    let startpos   = startpos >= 0 ? startpos : col
    let p = startpos <= col ? getline('.')[startpos : col] : ''
    let n = strlen(p) - 1
    if p ==# ''
      for kind in a:kinds
        let candidates += map(copy(get(b:local_compl, kind, [])), '{"word": v:val, "menu": kind}')
      endfor
    else
      for kind in a:kinds
        let hoge = copy(get(b:local_compl, kind, []))
        let candidates += map(filter(copy(get(b:local_compl, kind, [])), 'v:val[:n] ==# p'), '{"word": v:val, "menu": kind}')
      endfor
    endif
    if candidates != []
      call complete(startpos + 1, candidates)
      if len(candidates) > 1
        call feedkeys("\<C-p>", 'n')
      endif
    else
      call feedkeys("\<C-n>", 'n')
    endif
  endif
  return ''
endfunction

function! StCol(pat) abort
  " PP! a:pat
  return searchpos(a:pat, 'bcn', line('.'))[1] - 1
endfunction

" lovely aid for ', ' rule
autocmd vimrc InsertLeave * call s:eliminate_trailing_space()
function! s:eliminate_trailing_space() abort
  let lnum = line('.')
  if col('.') == col([lnum, '$'])-1 && search(', \+$', 'cen', lnum) != 0
    call setline(lnum, matchstr(getline(lnum), '.*,\ze \+$'))
  endif
endfunction

function! CloseBlock(current, close, fallback, ...) abort
  let nnb = nextnonblank(line('.')+1)
  let nnb_indent = indent(nnb)
  let cur_indent = indent('.')
  let closetext  = escape(substitute(get(split(a:close, "\n"), 0, '$'), '[^[:print:]]', '', 'g'), '~"\.^$[]*')
  let additional = get(a:000, 0, '')
  if nnb == 0 || nnb_indent < cur_indent || (nnb_indent == cur_indent && getline(nnb) !~# printf('^\s*\%%(%s\|else\)', closetext))
    return printf("%s\<End>\<CR>%s\<Esc>kA%s", a:current, a:close, additional)
  else
    return a:fallback
  endif
endfunction

function! VimCloseForBlock() abort
  let lnum = line('.')
  if searchpair("(", "", ")", "bn", "", lnum) > 0 || searchpair('\[', "", '\]', "bn", "", lnum) > 0
    return ' '
  else
    let keyseq = CloseBlock(' in ', 'endfor', ' ')
    if keyseq ==# ' ' && col('.') == col([lnum, '$'])
      let keyseq = ' in '
    endif
    return keyseq
  endif
endfunction

function! FortranSyncName(identifier) abort
  let pattern = '^\s*end\s\+' . a:identifier . ' $'
  let [botline, startcol] = searchpos(pattern, 'enW', 0, 500)
  if botline <= 0
    return ''
  endif

  let topline = line('.')
  if topline+1 <= botline-1
    let indent = indent(topline)
    if filter(map(range(topline+1, botline-1), 'indent(v:val)'), 'v:val != 0 && v:val <= indent') != []
      return ''
    endif
  endif

  let view = winsaveview()
  let name = matchstr(getline(view.lnum), printf('^\s*%s\s\+\zs\h\k*\ze', a:identifier))
  let reg  = ['"', getreg('"'), getregtype('"')]
  try
    call cursor([botline, startcol])
    let @" = name
    normal! ""p
  finally
    call call('setreg', reg)
    call winrestview(view)
    return ''
  endtry
endfunction

function! Complete(startcol, matches) abort
  call complete(a:startcol, a:matches)
  return ''
endfunction
"}}}
" *** anzu.vim *** {{{
" mapping
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" clear status
" nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
"}}}
"*** caw.vim *** {{{
" skip blank line
let g:caw_hatpos_skip_blank_line = 1

command! -nargs=0 CawToggle normal <Plug>(caw:hatpos:toggle)

nmap <Space>c <Plug>(operator-caw-hatpos-toggle)
xmap <Space>c <Plug>(operator-caw-hatpos-toggle)
omap <SID>line :normal! v^og_<CR>
nmap gci <Plug>(operator-caw-hatpos-comment)<SID>line
xmap gci <Plug>(operator-caw-hatpos-comment)
"}}}
"*** columnmove *** {{{
let g:columnmove_fold_open = {'x' : &foldnestmax, 'o' : &foldnestmax}
"}}}
"*** event-DotCommandPre *** {{{
nmap . <Plug>(event-DotCommandPre+Dot)
"}}}
"*** julia.vim *** {{{
"}}}
"*** neocomplete.vim *** {{{
let s:bundle = neobundle#get('neocomplete')
function! s:bundle.hooks.on_source(bundle)
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Ignore cases
  let g:neocomplete#enable_ignore_case = 1
  " Set completion start length
  let g:neocomplete#auto_completion_start_length = 3
  " Set minimum syntax keyword length.
  let g:neocomplete#sources#syntax#min_keyword_length = 3
  " Assign data directory path.
  let g:neocomplete#data_directory = $USERCACHEDIR . '/.neocon'
  " Delimiter automatic insertion.
  let g:neocomplete#enable_auto_delimiter = 1
  " Delimiter patterns for smart completion.
  if !exists('g:neocomplete#delimiter_patterns')
    let g:neocomplete#delimiter_patterns= {}
  endif
  let g:neocomplete#delimiter_patterns.vim = ['#', '.']
  " no fuzzy matching
  let g:neocomplete#enable_fuzzy_completion = 0

  " Define dictionary.
  let g:neocomplete#sources#dictionary#dictionaries = {
    \   'default' : '',
    \   'vimshell' : $USERCACHEDIR . '/.vimshell/command-history',
    \   'autohotkey' : $USERDIR . '/dict/AHK.dict'
    \ }

  " Define keyword.
  if !exists('g:neocomplete#keyword_patterns')
      let g:neocomplete#keyword_patterns = {}
  endif
  let g:neocomplete#keyword_patterns['default'] = '\h\w*'

  " Input assist for English
  if !exists('g:neocomplete#text_mode_filetypes')
      let g:neocomplete#text_mode_filetypes = {}
  endif
  let g:neocomplete#text_mode_filetypes.plaintex = 1

  " Enable heavy omni completion.
  if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
  endif
  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:jedi#auto_vim_configuration = 0
  let g:neocomplete#force_omni_input_patterns.python = '[^. \t]\.\w*'
  let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)\%(\h\w*\)\?'
  let g:neocomplete#sources#omni#input_patterns.scilab = '[^. \t]\+\.\?\w*'

  " Change default converter.
  call neocomplete#custom#source('_', 'converters',
        \ ['converter_remove_last_paren', 'converter_delimiter',
        \  'converter_remove_overlap', 'converter_case', 'converter_abbr'])

  " Recommended key-mappings.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  if maparg('<Plug>(smartinput_CR)', 'i') ==# ''
    function! s:my_cr_function() abort
      return (pumvisible() ? "\<C-y>" : '' ) . "\<CR>"
    endfunction
  else
    function! s:my_cr_function() abort
      call feedkeys("\<Plug>(smartinput_CR)", 'm')
      return (pumvisible() ? "\<C-y>" : '' )
    endfunction
  endif

  if maparg('<Plug>(smartinput_BS)', 'i') ==# ''
    imap <expr> <C-h> neocomplete#smart_close_popup() . "\<BS>"
    imap <expr> <BS> neocomplete#smart_close_popup() . "\<BS>"
  else
    imap <expr> <C-h> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
    imap <expr> <BS> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
  endif
endfunction
unlet s:bundle
"}}}
"*** neomru.vim *** {{{
let g:neomru#file_mru_path = $USERCACHEDIR . '/.neomru/file'
let g:neomru#directory_mru_path = $USERCACHEDIR . '/.neomru/directly'
"}}}
"*** operator-insert *** {{{
" operator mappings
nmap <Space>i <Plug>(operator-insert-i)
xmap <Space>i <Plug>(operator-insert-i)
nmap <Space>a <Plug>(operator-insert-a)
xmap <Space>a <Plug>(operator-insert-a)
nmap <Space>o <Plug>(operator-insert-o)
xmap <Space>o <Plug>(operator-insert-o)
nmap <Space>O <Plug>(operator-insert-O)
xmap <Space>O <Plug>(operator-insert-O)
omap gn <Plug>(gn-for-operator-insert-i)
omap gN <Plug>(gN-for-operator-insert-a)
"}}}
"*** highlightedyank *** {{{
map y <Plug>(highlightedyank)
let g:highlightedyank_highlight_duration = 3000
let g:highlightedyank_keep_curpos = 1
"}}}
"*** patternjump *** {{{
"   let g:patternjump_highlight = 1
let g:patternjump_caching   = 1
let g:patternjump_move_afap = 1

let g:patternjump_patterns = {
  \ '_' : {
  \   'i' : {
  \     'head' : ['\<\k*\>', '^\s*\zs\S', ',', '[^)\]}"'']\zs[)\]}]', '[([{"'']\zs[^([{]', '[)\]}"'']\+', '$'],
  \     'tail' : ['\<\k*\>', '^\s*\zs\S', ',', '[^)\]}"'']\zs[)\]}]', '[([{"'']\zs[^([{]', '[)\]}"'']\+', '$'],
  \     },
  \   'n' : {
  \     'head' : ['[[({''"]\+\zs\k'],
  \     },
  \   'x' : {
  \     'tail' : ['\<\k*\>'],
  \     },
  \   'o' : {
  \     'forward'  : {'head' : [',', ')', ']', '}', '$']},
  \     'backward' : {'head_inclusive' : ['^\s*\zs\S']},
  \     },
  \   },
  \ '*' : {
  \   'c' : {
  \     'head' : ['^', ' ', '/', '[A-Z]', ',', ')', ']', '}', '$'],
  \     },
  \   },
  \ }

nnoremap <silent> w :<C-u>call patternjump#forward('n', [[['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'], []], [[], []]])<CR>
nnoremap <silent> e :<C-u>call patternjump#forward('n', [[[], ['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']], [[], []]])<CR>
nnoremap <silent> b :<C-u>call patternjump#backward('n', [[['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'], []], [[], []]])<CR>
nnoremap <silent> ge :<C-u>call patternjump#backward('n', [[[], ['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']], [[], []]])<CR>
xnoremap <silent> w :<C-u>call patternjump#forward('x', [[['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'], []], [[], []]])<CR>
xnoremap <silent> e :<C-u>call patternjump#forward('x', [[[], ['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']], [[], []]])<CR>
xnoremap <silent> b :<C-u>call patternjump#backward('x', [[['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'], []], [[], []]])<CR>
xnoremap <silent> ge :<C-u>call patternjump#backward('x', [[[], ['\<\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']], [[], []]])<CR>
"}}}
"*** quickrun.vim *** {{{
let g:quickrun_config = {
      \ '_' : {
      \         'runner/vimproc/updatetime' : 500,
      \         'hook/time/enable' : 1,
      \         'runner': 'job',
      \       },
      \ 'julia' : {
      \         'exec': 'julia -E "include(\"%S\")"',
      \         'debug': 'quickrun_debug',
      \       },
      \ 'maxima' : {
      \         'command': 'maxima',
      \         'cmdopt': '-q -b',
      \         'runner': 'process_manager',
      \         'runner/process_manager/load': has('win32') ? &shellslash ? 'batch("%S:gs?/?\\\\\\\\\\?");' : 'batch(%s:gs?\\?\\\\\\\\);' : 'batch(%s)',
      \         'runner/process_manager/prompt': '(%[io]\d\+)'
      \       },
      \ 'markdown' : {
      \         'type' : 'markdown/gfm',
      \         'outputter': 'browser',
      \         'hook/time/enable' : 0,
      \       },
      \ 'tex' : {
      \         'command' : 'platex',
      \       },
      \ 'scilab'  : {
      \         'command': has('win32') ? 'scilex' : 'scilab-adv-cli',
      \         'cmdopt': '-l en -nb -nw -f',
      \         'runner': 'process_manager',
      \         'runner/process_manager/load': 'exec(%s,-1)',
      \         'runner/process_manager/prompt': '-->',
      \         'hook/output_encode/encoding' : has('win32') ? 'utf-8:cp932' : '&fileencoding',
      \         'hook/eval/enable': 1,
      \         'hook/eval/template': "%s\nmfprintf(6, '-->')",
      \       },
      \ 'r'   : {
      \         'command': has('win32') ? 'Rscript' : 'R',
      \         'exec': has('win32') ? '%c %o --no-save --slave %a %s' : 'sh -c ''%c %o --no-save --slave %a < %s''',
      \       },
      \ }
"}}}
"*** submode.vim *** {{{
let g:submode_keep_leaving_key = 1
" window size modulation
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>+')
call submode#map('winsize', 'n', '', '-', '<C-w>-')
" tab move
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'T', 'gT')
" buffer move
call submode#enter_with('changebuffer', 'n', '', 'gb', ':bn<CR>')
call submode#enter_with('changebuffer', 'n', '', 'gB', ':bN<CR>')
call submode#map('changebuffer', 'n', '', 'b', ':bn<CR>')
call submode#map('changebuffer', 'n', '', 'B', ':bN<CR>')
"}}}
"*** sandwich.vim *** {{{
nmap s <Nop>
xmap s <Nop>
nmap sx sdb
nmap sc srb
nmap s( <Plug>(operator-sandwich-add-query1st)(
nmap s8 <Plug>(operator-sandwich-add-query1st)(
nmap s) <Plug>(operator-sandwich-add-query1st))
nmap s9 <Plug>(operator-sandwich-add-query1st))
xmap s( <Plug>(operator-sandwich-add)(
xmap s8 <Plug>(operator-sandwich-add)(
xmap s) <Plug>(operator-sandwich-add))
xmap s9 <Plug>(operator-sandwich-add))
nmap s[ <Plug>(operator-sandwich-add-query1st)[
nmap s] <Plug>(operator-sandwich-add-query1st)]
xmap s[ <Plug>(operator-sandwich-add)[
xmap s] <Plug>(operator-sandwich-add)]
nmap s{ <Plug>(operator-sandwich-add-query1st){
nmap s} <Plug>(operator-sandwich-add-query1st)}
xmap s{ <Plug>(operator-sandwich-add){
xmap s} <Plug>(operator-sandwich-add)}
nmap s" <Plug>(operator-sandwich-add-query1st)"
nmap s2 <Plug>(operator-sandwich-add-query1st)"
xmap s" <Plug>(operator-sandwich-add)"
xmap s2 <Plug>(operator-sandwich-add)"
nmap s' <Plug>(operator-sandwich-add-query1st)'
nmap s7 <Plug>(operator-sandwich-add-query1st)'
xmap s' <Plug>(operator-sandwich-add)'
xmap s7 <Plug>(operator-sandwich-add)'
nmap sf <Plug>(operator-sandwich-add-query1st)f
xmap sf <Plug>(operator-sandwich-add)f

" keep cursor position after an operation
call operator#sandwich#set('all', 'all', 'cursor', 'keep')

" highlight
call operator#sandwich#set('all',    'all', 'hi_duration', 3000)
call operator#sandwich#set('delete', 'all', 'hi_duration', 200)

let g:sandwich#recipes = [
      \   {'buns': ['<', '>'], 'expand_range': 0, 'match_syntax': 1},
      \   {'buns': ['"', '"'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, 'input': ['"', '2']},
      \   {'buns': ["'", "'"], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, 'input': ["'", '7']},
      \   {'buns': ['"', '"'], 'kind': ['auto'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, 'syntax': ['Constant', 'Statement', 'Special', 'String', 'Comment'], 'inner_syntax': ['Constant', 'PreProc', 'Special', 'String', 'Comment'], 'input': ['"', '2']},
      \   {'buns': ["'", "'"], 'kind': ['auto'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, 'syntax': ['Constant', 'Statement', 'Special', 'String', 'Comment'], 'inner_syntax': ['Constant', 'String', 'Comment'], 'input': ["'", '7']},
      \   {'buns': ['"', '"'], 'filetype': ['', 'help', 'text', 'markdown'], 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'input': ['"', '2']},
      \   {'buns': ["'", "'"], 'filetype': ['', 'help', 'text', 'markdown'], 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'input': ["'", '7']},
      \   {'buns': ["'", "'"], 'filetype': ['vim'], 'skip_regex_head': ['\%(\%#\zs''\|''\%#\zs\)''\%(''''\)*[^'']'], 'skip_regex_tail': ['[^'']\%(''''\)*\%(\%#\zs''\|''\%#\zs\)'''], 'nesting': 0, 'linewise': 0, 'match_syntax': 2},
      \   {'buns': ['{', '}'], 'nesting': 1, 'match_syntax': 1, 'skip_break': 1},
      \   {'buns': ['[', ']'], 'nesting': 1, 'match_syntax': 1},
      \   {'buns': ['(', ')'], 'nesting': 1, 'match_syntax': 1, 'input': ['(', ')', '8', '9']},
      \   {'buns': ['$(', ')'], 'filetype': ['make'], 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'input': ['$']},
      \   {'buns': ['${', '}'], 'filetype': ['sh'], 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'input': ['$']},
      \   {'buns': ['%', '%'], 'filetype': ['dosbatch'], 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'input': ['%']},
      \   {'buns': ['\(', '\)'],  'filetype': ['vim'], 'expand_range': 0, 'nesting': 1, 'match_syntax': 1, 'syntax': ['Constant', 'String']},
      \   {'buns': ['\%(', '\)'], 'filetype': ['vim'], 'expand_range': 0, 'nesting': 1, 'match_syntax': 1, 'syntax': ['Constant', 'String']},
      \   {'buns': ['^\s*if\>',    '\<endif\>'],    'filetype': ['vim'], 'kind': ['delete', 'auto'], 'motionwise': ['line'], 'regex': 1, 'linewise': 2, 'command': ["'[,']normal! <<"], 'nesting': 1, 'skip_break': 1, 'syntax': ['Statement']},
      \   {'buns': ['^\s*for\>',   '\<endfor\>'],   'filetype': ['vim'], 'kind': ['delete', 'auto'], 'motionwise': ['line'], 'regex': 1, 'linewise': 2, 'command': ["'[,']normal! <<"], 'nesting': 1, 'skip_break': 1, 'syntax': ['Statement']},
      \   {'buns': ['^\s*while\>', '\<endwhile\>'], 'filetype': ['vim'], 'kind': ['delete', 'auto'], 'motionwise': ['line'], 'regex': 1, 'linewise': 2, 'command': ["'[,']normal! <<"], 'nesting': 1, 'skip_break': 1, 'syntax': ['Statement']},
      \   {'buns': ['^\s*try\>',   '\<endtry\>'],   'filetype': ['vim'], 'kind': ['delete', 'auto'], 'motionwise': ['line'], 'regex': 1, 'linewise': 2, 'command': ["'[,']normal! <<"], 'nesting': 1, 'skip_break': 1, 'syntax': ['Statement']},
      \   {'buns': 'sandwich#magicchar#t#tag()', 'listexpr': 1, 'kind': ['add'], 'action': ['add'], 'input': ['t']},
      \   {'buns': 'sandwich#magicchar#t#tag()', 'listexpr': 1, 'kind': ['replace'], 'action': ['add'], 'input': ['T']},
      \   {'buns': 'sandwich#magicchar#t#tagname()', 'listexpr': 1, 'kind': ['replace'], 'action': ['add'], 'input': ['t']},
      \   {'external': ["\<Plug>(textobj-sandwich-tag-i)", "\<Plug>(textobj-sandwich-tag-a)"], 'noremap' : 0, 'kind' : ['delete', 'textobj'], 'expr_filter': ['operator#sandwich#kind() !=# "replace"'], 'synchro': 1, 'linewise': 1, 'input': ['t', 'T']},
      \   {'external': ["\<Plug>(textobj-sandwich-tag-i)", "\<Plug>(textobj-sandwich-tag-a)"], 'noremap' : 0, 'kind' : ['replace', 'query'], 'expr_filter': ['operator#sandwich#kind() ==# "replace"'], 'synchro': 1, 'input': ['T']},
      \   {'external': ["\<Plug>(textobj-sandwich-tagname-i)", "\<Plug>(textobj-sandwich-tagname-a)"], 'noremap' : 0, 'kind' : ['replace', 'textobj'], 'expr_filter': ['operator#sandwich#kind() ==# "replace"'], 'synchro': 1, 'input': ['t']},
      \ ]

let g:operator#sandwich#recipes = [
      \   {'buns': ['sandwich#magicchar#f#fname()', '")"'], 'kind': ['add', 'replace'], 'action': ['add'], 'expr': 1, 'cursor': 'inner_tail', 'input': ['f']},
      \   {'buns': ['{', '}'], 'kind': ['add'],    'motionwise': ['line'], 'linewise': 1, 'command': ["'[+1,']-1normal! >>"]},
      \   {'buns': ['{', '}'], 'kind': ['delete'], 'motionwise': ['line'], 'linewise': 1, 'command': ["'[,']normal! <<"]},
      \   {'buns': 'VimSandwichBlocks()', 'filetype': ['vim'], 'kind': ['add'], 'motionwise': ['line'], 'listexpr': 1, 'linewise': 1, 'command': ['normal! `[=`]'], 'input': ['b'], 'cursor': 'headend'},
      \   {'buns': 'sandwich#magicchar#i#input("operator")', 'kind': ['add', 'replace'], 'action': ['add'], 'listexpr': 1, 'input': ['i']},
      \   {'buns': 'sandwich#magicchar#i#lastinput("operator", 1)', 'kind': ['add', 'replace'], 'action': ['add'], 'listexpr': 1, 'input': ['I']},
      \ ]

let g:textobj#sandwich#recipes = [
      \   {'external': ["\<Plug>(textobj-sandwich-function-ip)", "\<Plug>(textobj-sandwich-function-i)"], 'noremap': 0, 'kind': ['delete', 'replace', 'query'], 'input': ['f']},
      \   {'external': ["\<Plug>(textobj-sandwich-function-ap)", "\<Plug>(textobj-sandwich-function-a)"], 'noremap': 0, 'kind': ['delete', 'replace', 'query'], 'input': ['F']},
      \   {'buns': 'sandwich#magicchar#i#input("textobj", 1)', 'kind': ['delete', 'replace', 'query'], 'listexpr': 1, 'regex': 1, 'synchro': 1, 'input': ['i']},
      \   {'buns': 'sandwich#magicchar#i#lastinput("textobj")', 'kind': ['delete', 'replace', 'query'], 'listexpr': 1, 'regex': 1, 'synchro': 1, 'input': ['I']},
      \ ]

function! GetChar() abort
  let c = getchar()
  let c = type(c) == type(0) ? nr2char(c) : c
  return c ==# "\<Esc>" || c ==# "\<C-c>" ? '' : c
endfunction

function! VimSandwichBlocks() abort
  let table = {
        \   'i': {'start': 'if',    'end': 'endif'},
        \   'f': {'start': 'for',   'end': 'endfor'},
        \   'w': {'start': 'while', 'end': 'endwhile'},
        \   't': {'start': 'try',   'end': 'endtry'},
        \ }
  call s:vim_sandwich_blocks_echo_choices(table)
  let s:c = GetChar()
  if s:c ==# '' || !count(keys(table), s:c)
    echo ''
    throw 'OperatorSandwichCancel'
  endif
  return [table[s:c]['start'], table[s:c]['end']]
endfunction
function! s:vim_sandwich_blocks_echo_choices(table) abort
  let messages = [['sandwich.vim: ', 'MoreMsg']]
  let first = 1
  for [key, value] in items(a:table)
    if !first
      let messages += [[', ', 'NONE']]
    endif
    let messages += [[value.start . ': ', 'NONE']]
    let messages += [[key, 'Underlined']]
    let first = 0
  endfor
  call sandwich#util#echo(messages)
endfunction
"}}}
"*** swap.vim *** {{{
let g:swap#rules  = deepcopy(g:swap#default_rules)
let g:swap#rules += [
      \   {'filetype': ['vim'], 'delimiter': ['\\|'], 'surrounds': ['\\%\{,2}(', '\\)'], 'braket': [['\(', '\)'], ['\%(', '\)']]},
      \   {'filetype': ['julia'], 'delimiter': [',\s*'], 'surrounds': ['^\s*', '\ze\%($\|\s*=\)']},
      \   {'mode': 'x', 'delimiter': ['\s*[-+]\s*'], 'braket': [['(', ')']], 'priority': -10},
      \   {'mode': 'x', 'delimiter': ['\s*[*/]\s*'], 'braket': [['(', ')']], 'priority': -20},
      \   {'mode': 'x', 'delimiter': ['\s*||\s*'], 'braket': [['(', ')']], 'priority': 10},
      \   {'mode': 'x', 'delimiter': ['\s*&&\s*'], 'braket': [['(', ')']], 'priority': 10},
      \   {'mode': 'x', 'body': '_\?\%(\h\k*_\)\+\h\k*_\?', 'delimiter': ['_'], 'priority': -30},
      \ ]
"}}}
"*** template.vim *** {{{
let g:template_dir = $USERDIR
"}}}
"*** unite.vim *** {{{
if neobundle#tap('unite.vim')
  nnoremap <Space>uu :Unite<Space>
  nnoremap <Space>um :Unite -no-split file_mru<CR>
  nnoremap <Space>ub :Unite -no-split buffer_tab buffer<CR>
  nnoremap <Space>ud :Unite -no-split directory_mru directory directory/new<CR>
  nnoremap <Space>up :Unite neobundle/update<CR>

  if has('win32')
    nnoremap <Space>uf :Unite file_rec buffer<CR>
  else
    nnoremap <Space>uf :Unite file_rec/async buffer<CR>
  endif

  let g:unite_enable_start_insert = 1
  let g:unite_enable_ignore_case = 1
  let g:unite_data_directory = $USERCACHEDIR . '/.unite'
  let g:unite_source_history_yank_enable = 1

  " tiny optimizations
  call unite#custom#default_action('directory',     'lcd')
  call unite#custom#default_action('directory_mru', 'lcd')
  call unite#custom#source('file_mru', 'ignore_pattern', '\f*[\/]doc[\/]\f\+\.\(jax\|txt\)')
  " hi link uniteStatusSourceNames Directory
  " hi link uniteStatusSourceCandidates ModeMsg

  " last ':messages'
  " http://d.hatena.ne.jp/osyo-manga/20131030/1383144724
  let g:unite_source_alias_aliases = {'messages' : {'source': 'output', 'args': 'message'}}
  "   call unite#custom#source('messages', 'sorters', 'sorter_reverse')
  call unite#custom#default_action('messages', 'yank')
  call unite#custom#profile('source/messages', 'context', {'start_insert' : 0})
  call unite#custom#source('messages', 'syntax', '')
  nnoremap <Space>uM :Unite messages<CR>
endif
"}}}
"*** reanimate *** {{{
" default path to save session file
if !isdirectory(expand($USERCACHEDIR . '/reanimate'))
  call mkdir($USERCACHEDIR . '/reanimate')
endif
let g:reanimate_save_dir = $USERCACHEDIR . '/reanimate'

" default session file name
let g:reanimate_default_save_name = ''

" session options
let g:reanimate_sessionoptions = 'buffers,curdir,folds,globals,help,slash,tabpages,winsize'

call unite#custom#default_action('reanimate', 'reanimate_load')
nnoremap <Space>ur :Unite -auto-resize reanimate<CR>
"}}}
"*** vim-operator-replace *** {{{
nmap <Space>r <Plug>(operator-replace)
xmap <Space>r <Plug>(operator-replace)
"}}}
"*** vim-textobj-functioncall *** {{{
call textobj#functioncall#setlist([
      \   {'header': '\m\\\a\+\*\?\%({[^}]*}\)*\%(\[[^]]*\]\)*', 'bra': '{', 'ket': '}'},
      \   {'header': '\m\\\a\+\*\?\%(\[[^]]*\]\)*\%({[^}]*}\)*', 'bra': '{', 'ket': '}'},
      \ ], 'tex')
"}}}
"}}}
"***** fundamentals ***** {{{
"-------------------------------------------------------------------------
set backup                          " use backup
set swapfile                        " use swap file
set backupdir=$USERCACHEDIR/backup  " assign path to make backup files
let &directory=&backupdir           " assign that path to make swap files is same as that for backup file
set clipboard=unnamed,unnamedplus   " share clipboard with OS
set display+=lastline               " force to display long lines as possible
set spellfile=$USERDIR/spell/en.ascii.add
                                    " use file to add wors for spell check
set spelllang=en,cjk                " use english for spell check and cjk region is ignored
set spellsuggest=best               " choose correction engine for spell check
set helplang=ja,en                  " use japanese help preferentially
set hidden                          " move out from current buffer without warning even on editing
set history=100                     " the stored number of commands/searching history
set iminsert=0                      " turn off ime when getting into insert mode
set imsearch=0                      " turn off ime when getting into searching mode
set splitbelow                      " open new window below the current when splitting
set splitright                      " open new window in right hand side of the current when splitting
set synmaxcol=500                   " restrict the number of lines considered for syntax coloring
set timeoutlen=2000                 " The time in milliseconds that is waited for a key code or mapped key sequence to complete.
set viminfo&
set viminfo+=n$USERCACHEDIR/viminfo.txt
                                    " assign path to viminfo file
set viminfo^='1000                  " longer v:oldfiles lifetime
set wildmenu                        " use extended commandline completion
" set wildmode=longest:full,full      " way to complete in cmdline
set wildignore+=*.o

" use command-line window instead of command-line mode
" vim-users.jp Hacks #161
" nnoremap <sid>(command-line-enter) q:
" xnoremap <sid>(command-line-enter) q:

" nmap :  <sid>(command-line-enter)
" xmap :  <sid>(command-line-enter)

autocmd vimrc CmdwinEnter * call s:init_cmdwin()
function! s:init_cmdwin()
  nnoremap <buffer> q :<C-u>quit<CR>
  nnoremap <buffer> <CR> i<CR>
  imap <buffer><expr> <CR>  pumvisible() ? "\<C-y>\<Plug>(smartinput_CR)" : "\<Plug>(smartinput_CR)"
  imap <buffer><expr> <C-h> pumvisible() ? "\<C-y>\<Plug>(smartinput_BS)" : "\<Plug>(smartinput_BS)"
  imap <buffer><expr> <BS>  pumvisible() ? "\<C-y>\<Plug>(smartinput_BS)" : "\<Plug>(smartinput_BS)"

  setlocal iminsert=0
endfunction

" keep undo history (Vim7.3 or upper)
" vim-users.jp Hacks #162
if has('persistent_undo')
  set undodir=./.vimundo,$USERCACHEDIR/.vimundo
  set undofile
endif

" syntax coloring after reloading session (autocmd.en, 8. Groups)
" autocmd vimrc SessionLoadPost * doautoall highlight Bufread

" never use 'r' and 'o' option in formatoptions
autocmd vimrc FileType * setlocal formatoptions-=r
autocmd vimrc FileType * setlocal formatoptions-=o

" disable default plugins
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1
"}}}
"***** searching behavior ***** {{{
"--------------------------------------------------------------------------
set hlsearch | nohlsearch           " highlight searched words
set incsearch                       " use incremental search
set ignorecase                      " ignore upper/lower case of searching word
" set smartcase                       " do not ignore upper/lower cases when the searching word contains both of them
set wrapscan                        " go back to the top candidate after getting to the end of file
let &wildignorecase = &fileignorecase
if has('migemo')
  set migemo                        " use g? sequence of migemo

  if &encoding ==# 'cp932'
    set migemodict=$USERDIR/dict/cp932/migemo-dict
  else
    set migemodict=$USERDIR/dict/utf-8/migemo-dict
  endif
endif
"}}}
"***** editing configuration ***** {{{
"--------------------------------------------------------------------------
set backspace=indent,eol,start      " allow backspace key to delete indent and break line
set formatoptions&
set formatoptions+=mM               " handle line-breaking appropriately also with multi-byte
set nrformats=hex                   " do not use increment/decrement keys (<C-a>/<C-x>) for octal numbers and alphabets
set switchbuf=usetab,useopen        " switch to it when trying to open file which has already opened elsewhere
" set virtualedit=block               " freely cursor movement in blockwise visual mode
set whichwrap=b,s,h,l,<,>,[,]       " do not stop cursor at head/tail of line, move to tail/head of previous/next line

" indentation option
set autoindent                      " add indent automatically
set expandtab                       " use soft tabs
set tabstop=4                       " the width of a tab character
let &shiftwidth = &tabstop          " inserted number of space by a tab stroke or deleted number of space by a BS stroke
                                    " NOTE: Some indent functions use &sw directly. This is completely a bad habbit, should be used shiftwidth() instead now. However, just as a workaround, I wrote like this.
set softtabstop=-1                  " the indentation width for autoindent
set shiftround                      " round the indent width to the number of 'indentwidth' option when indented by '<' or '>'

" jump to the point where to have been edited last time when opening a file
autocmd vimrc BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" im control (for win)  "{{{
if has('win32')
  " at first
  augroup im-off
    autocmd!
    autocmd im-off InsertLeave * if &l:iminsert != 0 | setlocal iminsert=0 | endif
  augroup END

  function! s:im_switch()
    let b:iminsert = &l:iminsert

    if b:entering_with_c
      if strlen(@") != strchars(@")
        " contains multibyte character
        setl iminsert=2
      elseif @" =~# '\n\+'
        let &l:iminsert = b:iminsert
      else
        setl iminsert=0
      endif

      let b:entering_with_c = 0
    else
      let temp = @"
      normal! ""yl

      if strlen(@") != strchars(@")
        " contains multibyte character
        setl iminsert=2
      elseif @" =~# '\n\+'
        let &l:iminsert = b:iminsert
      else
        setl iminsert=0
      endif

      let @" = temp
    endif
  endfunction

  function! s:insert_enter_with_c()
    let b:entering_with_c = 1
    return 'c'
  endfunction

  function! s:switch_with_shift_space()
    " FIXME: it cannot be toggle!
    "        cannot capture <S-Space> when im is on.
    " NOTE: I decide to use external software like Autohotkey to controll this.
    call feedkeys("\<C-^>", 'n')
    return ' '
  endfunction

  function! s:im_auto_switch_start()
    let b:entering_with_c = 0
    nnoremap <silent><buffer><expr> c <SID>insert_enter_with_c()
    inoremap <silent><buffer><expr> <S-Space> <SID>switch_with_shift_space()
    augroup im_auto_switch
      autocmd! * <buffer>
      autocmd im_auto_switch InsertEnter <buffer> call s:im_switch()
      autocmd im_auto_switch InsertLeave <buffer> let &l:iminsert = 0
    augroup END
  endfunction

  function! s:im_auto_switch_stop()
    unlet! b:entering_with_c
    " This should not be done without any check, but mendoi.
    silent! nunmap <buffer> c
    silent! iunmap <buffer> <S-Space>
    augroup im_auto_switch
      autocmd! * <buffer>
    augroup END
  endfunction

  command! IMAutoSwitchStart call s:im_auto_switch_start()
  command! IMAutoSwitchStop  call s:im_auto_switch_stop()
endif
"}}}
"}}}
"***** displaying ***** {{{
"--------------------------------------------------------------------------
" let g:colorscheme_no_italic = 1
set background=light
" set background=dark
colorscheme reki
" colorscheme kemonofriends
let g:colorscheme_kemonofriends_sandstar_active = 0
" let g:lightline = {'colorscheme': 'kemonofriends'}
" let g:airline_theme = 'kemonofriends'
" let g:ezbar = {'theme': 'kemonofriends'}
set cmdheight=1                     " the height of commandline
" set cursorline                      " highlight corsor line
set laststatus=2                    " always display status line
set list                            " visualize special characters
set listchars=tab:>-,trail:-,eol:$,nbsp:%,extends:>,precedes:<
                                    " assign alternative expression for special characters
set nonumber                        " do not display row number
set showbreak=<\                    " display the sign for wrapped lines
set showcmd                         " display command information in commandline
set showmode                        " display current mode
set showmatch                       " emphasize correspondent parenthesis
set scrolloff=5                     " vertical scroll margin
set sidescrolloff=10                " horizontal scroll margin
set t_Co=256                        " use 256 coloring in modern terminal emulator
set title                           " display title
set nowrap                          " do not wrap in long line
set lazyredraw

" highlight cursor line only on active window - http://d.hatena.ne.jp/yuroyoro/searchdiary?word=vim%20
" autocmd vimrc WinLeave * set nocursorline
" autocmd vimrc WinEnter,BufRead * set cursorline

" " tabline
" function! GuiTabLabel()
"   let label = ''
"   let bufnrlist = tabpagebuflist(v:lnum)

"   for bufnr in bufnrlist
"     if getbufvar(bufnr, '&modified')
"       let label .= '+'
"       break
"     endif
"   endfor

"   let activewinnr = tabpagewinnr(v:lnum)
"   let activebufnr = bufnr(bufnrlist[activewinnr - 1])
"   let label .= activebufnr
"   let label .= ' '

"   let title = pathshorten(simplify(bufname(bufnrlist[activewinnr - 1])))
"   let title = title ==# '' ? '[anonymous]' : title
"   return label . title
" endfunction
" set guitablabel=%{GuiTabLabel()}
set guioptions-=e

" statusline displaying
" copie... inspired from vim-neatstatus
let &statusline =''
" file path
let &statusline .=' %<%F '
" read only, modified, modifiable flags in brackets
let &statusline .='%([%R%M]%) '

" right-align everything past this point
let &statusline .='%= '

" file type (eg. python, ruby, etc..)
let &statusline .='%(| %{&filetype} %)| '
" file format (eg. unix, dos, etc..)
let &statusline .='%{&fileformat} | '
" file encoding (eg. utf8, latin1, etc..)
let &statusline .='%(%{(&fenc!=""?&fenc:&enc)} | %)'
" buffer number
let &statusline .='BUF #%n |'
"}}}
"***** filetype settings ***** {{{
" These settings would be moved to ftplugin/$filetype.vim gradually
"-------------------------------------------------------------------------
"*** AutoHotkey ***
autocmd vimrc FileType autohotkey setlocal dictionary+=$USERDIR/dict/AHK.dict foldmethod=marker commentstring=;%s

"*** FORTRAN ***"
autocmd vimrc BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
                              \| let b:fortran_fold=1

"*** help ***"
augroup help_optimizer
  au!
  autocmd FileType help call s:help_bootstrap()
augroup END

function! s:help_bootstrap()
  augroup help_optimizer
    au!
    autocmd BufEnter * call s:help_conf_optimizer()
  augroup END
endfunction

function! s:help_conf_optimizer()
  if (&buftype ==# 'help') && !(exists('s:sidescrolloff') && exists('s:sidescroll') && (&sidescrolloff == 0) && (&sidescroll == 1))
    let s:sidescroll    = &sidescroll
    let s:sidescrolloff = &sidescrolloff
    let &sidescroll     = 1
    let &sidescrolloff  = 0
  elseif (&buftype !=# 'help') && exists('s:sidescroll')
    let &sidescroll     = s:sidescroll
    let &sidescrolloff  = s:sidescrolloff
    unlet s:sidescrolloff
    unlet s:sidescroll
  endif

  doautocmd FileType
endfunction

"*** markdown ***"
autocmd vimrc FileType markdown setlocal wrap iminsert=0

"*** tex ***"
autocmd vimrc FileType tex setlocal wrap iminsert=0 spellcapcheck

"*** quickfix ***"
autocmd vimrc FileType        qf setlocal nowrap
autocmd vimrc FileType        qf call s:qf_resize()
autocmd vimrc QuickFixCmdPost *  call s:qf_cmdpost()

function! s:qf_resize()
  let qflist = getqflist()

  " validation check of qflist
  let validation = filter(qflist, 'v:val["valid"] > 0')

  if validation != []
    let Nerror = len(qflist)
    if Nerror > 0
      let maximum = float2nr(&lines / 3)

      if Nerror > maximum
        execute 'resize ' . maximum
      else
        execute 'resize ' . Nerror
      endif
    endif
  endif
endfunction

function! s:qf_cmdpost()
  let qflist = getqflist()

  if filter(copy(qflist), 'v:val["valid"] != 0') == []
    cclose
  else
    if exists(':HierUpdate') == 2
      HierUpdate
    endif
    copen
    wincmd p
    normal! k:cn<CR>
  endif
endfunction

function! s:qf_flash() abort
  call setqflist([])

  if &filetype ==# 'qf'
    wincmd p
  endif
  let view = {}
  let view.tabnr = tabpagenr()
  let view.winnr = winnr()
  let view.view  = winsaveview()

  for tabnr in range(1, tabpagenr('$'))
    for winnr in range(1, tabpagewinnr(tabnr, '$'))
      if gettabwinvar(tabnr, winnr, '&filetype') ==# 'qf'
        execute 'tabnext' . tabnr
        execute winnr . 'wincmd w'
        quit
      endif
    endfor
  endfor

  execute 'tabnext' . view.tabnr
  execute view.winnr . 'wincmd w'
  call winrestview(view.view)
  if exists(':HierClear') == 2
    HierClear
  endif
endfunction
command! -nargs=0 QfFlash call s:qf_flash()

"*** anonymous ***"
" Close non-named buffer without any warning.
" Imperfect...
augroup anonymous
  au!
  autocmd QuitPre * call s:namaenonaikohainegala()
augroup END

function! s:namaenonaikohainegala()
  if winnr('$') == 1
    let g:namaenonaiko = []
    for nr in range(1, bufnr('$'))
      if bufname(nr) ==# '' && bufexists(nr)
        call add(g:namaenonaiko, [nr, getbufvar(nr, '&buftype')])
        call setbufvar(nr, '&buftype', 'nowrite')
      endif
    endfor

    augroup anonymous
      autocmd BufEnter * call s:tobacchirigomen()
    augroup END
  endif
endfunction

function! s:tobacchirigomen()
  if exists('g:namaenonaiko')
    for owabi in g:namaenonaiko
      if bufexists(owabi[0])
        call setbufvar(owabi[0], '&buftype', owabi[1])
      endif
    endfor
    unlet g:namaenonaiko

    augroup anonymous
      au! BufEnter
    augroup END
  endif
endfunction
"}}}
"***** key mappings ***** {{{
"--------------------------------------------------------------------------
" No need. See :help dos-standard-mappings.
if has('win32')
  silent! vunmap <C-x>
endif

" use of function keys
if has('win32')
  nnoremap <F11> :simalt ~x<CR>:redraw<CR>
endif
nnoremap <expr> <F12> ':set background=' . (&background !=# 'light' ? 'light' : 'dark') . '<CR>'

" disable distracting keys
map  <F1> <Nop>
map! <F1> <Nop>
imap <C-\> <Nop>

" do not store a character cut by x,s
nnoremap x "_x:<Esc>
" nnoremap s "_s:<Esc>

" I prefer to use <C-p>/<C-n> when ascending history
cnoremap <C-p> <Up>
cnoremap <Up> <C-p>
cnoremap <C-n> <Down>
cnoremap <Down> <C-n>

" match 'Y' behavior with 'D' : Y = yy -> y$
" NOTE: Use nmap for highlightedyank plugin.
nmap Y y$

" move cursor to the end of selected area after yank
xmap Y y`>

" line-break without any change to the current line in insert mode
" smartinputter no tashinami.
inoremap <C-j> <Esc>o
" inoremap <C-k> <Esc>O

" line-break for upper direction with hanging a following part
inoremap <S-CR> <Esc>lDO<C-r>"<Esc>I

" check syntax group of the character under the cursor
nnoremap \s :echo map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')<CR>

" reserve black hole register for the next operator
nnoremap <C-\> "_

" textobject a' and a" is not so convenient
onoremap a' 2i'
xnoremap a' 2i'
onoremap a" 2i"
xnoremap a" 2i"

" Close all the foldings in the buffer
nnoremap z_ ma:silent! %normal! zC<CR>'a

" Clear highlight
nnoremap <Space><Space> :nohlsearch<CR>

" wildcard for mulibyte characters of f, t, F, T
noremap <silent> f<CR> :<C-u>call <SID>wildcard_for_multibyte_characters('f')<CR>
noremap <silent> t<CR> :<C-u>call <SID>wildcard_for_multibyte_characters('t')<CR>
noremap <silent> F<CR> :<C-u>call <SID>wildcard_for_multibyte_characters('F')<CR>
noremap <silent> T<CR> :<C-u>call <SID>wildcard_for_multibyte_characters('T')<CR>

function! s:wildcard_for_multibyte_characters(kind) abort
  let flag = a:kind ==# 'F' || a:kind ==# 'T' ? 'b' : ''
  let stopline = line('.')

  for i in range(v:count1)
    if !search('[^\x01-\x7E]', flag, stopline)
      break
    endif
  endfor

  if has('patch-7.4.813')
    let reg = ['"', getreg('"'), getregtype('"')]
    normal! ""yl
    let c = @@
    let search = {
          \   'char': c,
          \   'forward': a:kind ==# 'f' || a:kind ==# 't' ? 1 : 0,
          \   'until': a:kind ==? 'f' ? 0 : 1,
          \ }
    call setcharsearch(search)
    call call('setreg', reg)
  endif

  if a:kind ==? 't'
    normal! h
  endif
endfunction

" get into incert mode at a character before the end of line.
" call hoge(piyo)
"               # I want to insert here.
" NOTE: 'nnoremap gA $i' is not good, because it is not repeatable.
nnoremap gA A<C-g>U<Left>

" browse fix-points
nnoremap [q :<C-u>execute v:count1 . 'cprevious'<CR>
nnoremap ]q :<C-u>execute v:count1 . 'cnext'<CR>

" move buffer list
nnoremap <Space>b :ls<CR>:b<Space>

" roaming matched texts in incremental searching by <Tab> key
" cnoremap <expr> <Tab>   getcmdtype() =~# '[/?]' ? "\<C-g>" : "\<Tab>"
" cnoremap <expr> <S-Tab> getcmdtype() =~# '[/?]' ? "\<C-t>" : "\<S-Tab>"

" Snake case motion
let g:milestones = [' ', '_', '#', '/']
function! s:n_underscore(direction) abort
  let pattern = printf('\%%(%s\)\zs.', join(g:milestones, '\|'))
  let flag = a:direction[0] ==# 'b' ? 'b' : ''
  return search(pattern, flag, line('.'))
endfunction
nnoremap <silent> [_ :<C-u>call <SID>n_underscore('backward')<CR>
nnoremap <silent> ]_ :<C-u>call <SID>n_underscore('forward')<CR>

" search in visualmode
xnoremap / <Esc>/<C-r>=<SID>visual_range()<CR>
xnoremap ? <Esc>?<c-r>=<SID>visual_range()<CR>
function! s:visual_range() abort
  return printf('\%%>%sl\%%<%sl', line("'<") - 1, line("'>") + 1)
endfunction

" easy :global
command! -nargs=1 -range=% Global <line1>,<line2>global//normal <args>/g

" A variant of i_CTRL-w "{{{
let g:stop_pattern = [' ', '_', '#', '-', '/', '\\', ':', '(', ')', '\[', '\]', '{', '}']
function! s:i_CTRL_b()
  let col  = col('.')
  let lnum = line('.')
  let dest = searchpos(printf('\%%(%s\)', join(g:stop_pattern, '\|')), 'be', lnum)[1]
  if col == dest + 1
    let dest = searchpos(printf('\%%(%s\)', join(g:stop_pattern, '\|')), 'ben', lnum)[1]
  endif
  call cursor(lnum, col)
  return repeat("\<BS>", col - dest - 1)
endfunction
inoremap <expr> <C-b> <SID>i_CTRL_b()
"}}}
" adjust spacing with the nearest former nonblank line "{{{
function! s:follow_prevline()
  let col  = col('.')
  let lnum = line('.')
  let line = getline(lnum)
  let head = searchpos('\s\zs\S\+',  'bcn', lnum)[1] - 1
  let tail = searchpos('\s\zs\S\+', 'bcen', lnum)[1] - 1

  if head < 0 || tail < 0
    return ''
  endif

  let text = line[head : tail]
  let dest = stridx(getline(prevnonblank(lnum-1)), text, head)

  if dest < 0
    let dest = stridx(getline(nextnonblank(lnum+1)), text, head)
    if dest < 0
      return ''
    endif
  endif

  return printf('%s%s%s',
              \ repeat("\<BS>", col - head - 1),
              \ repeat(' ', dest - head),
              \ line[head :]
              \ )
endfunction
inoremap <expr> <C-l> <SID>follow_prevline()
"}}}
" textobj-lastchanged "{{{
noremap <silent> gm :<C-u>normal! v`[o`]<CR>
"}}}
" textobj-number "{{{
" NOTE: Fortran allows the expression ended with dot, like 1. (= 1.0), 1.d0 (= 1.0d0)
"       In addition to that, the following description also valid. .5 (= 0.5), -.5 (= -0.5)
"       '\<-\?\%(\d\+\%(\.\d*\)\?\|\.\d\+\)\%([deDE]-\?\d\+\)\?\>'

"       Vim script uses dot as a concatenation operator, thus the above expressions
"       is not valid.
"       '\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'

"       When trying to select only one character, like 0, it seems strange.
"       'c' flag is not used for search() function...?
"       But no problem for practical use.

"       Removing '\<' and '\>' might be better.

call textobj#user#plugin('number', {
  \   'number-i': {
  \     'pattern': '-\?\%(\d\+\%(\.\d*\)\?\|\.\d\+\)\%([deDEf]-\?\d\+\)\?',
  \     'select': 'in',
  \   },
  \   'number-a': {
  \     'pattern': '\%(^\s*\zs\|\s*\)-\?\%(\d\+\%(\.\d*\)\?\|\.\d\+\)\%([deDEf]-\?\d\+\)\?\s*',
  \     'select': 'an',
  \   },
  \ })
"}}}
" paste operator  "{{{
function! Operator_paste_prerequisite() abort "{{{
  set operatorfunc=Operator_paste
  let s:register = v:register ==# s:default_register() ? '' : '"' . v:register
  return ''
endfunction
"}}}
function! Operator_paste(motionwise) abort  "{{{
  let v = s:v(a:motionwise)
  execute printf('normal! `[%s`]%sp', v, s:register)
endfunction
"}}}
function! s:default_register() abort  "{{{
  if &clipboard =~# 'unnamedplus'
    let default_register = '+'
  elseif &clipboard =~# 'unnamed'
    let default_register = '*'
  else
    let default_register = '"'
  endif
  return default_register
endfunction
"}}}
function! s:v(motionwise) abort "{{{
  if a:motionwise ==# 'char'
    let v = 'v'
  elseif a:motionwise ==# 'line'
    let v = 'V'
  elseif a:motionwise ==# 'block'
    let v = "\<C-v>"
  else
    let v = a:motionwise
  endif
  return v
endfunction
"}}}
nnoremap <expr> <SID>(operator-paste-prerequisite) Operator_paste_prerequisite()
nmap <silent> <SID>(operator-paste) <SID>(operator-paste-prerequisite)g@
nmap yp <SID>(operator-paste)
nmap ypp <SID>(operator-paste)g@
"}}}
"}}}
"***** commands ***** {{{
"--------------------------------------------------------------------------
" simple performance checker
function! Tic()
  let s:hayasa_maruwakari_kun = reltime()
endfunction
function! Toc()
  return reltimestr(reltime(s:hayasa_maruwakari_kun))
endfunction
function! Time(cmd)
  call Tic()
  execute a:cmd
  echomsg Toc()
endfunction
command! -nargs=0 Tic call Tic()
command! -nargs=0 Toc echomsg Toc()
command! -nargs=1 Time call Time(<q-args>)

" yank path
function! s:yank_path(path) abort
  let pathlist = map(map(glob(a:path, 1, 1), 'fnamemodify(v:val, ":p")'), 'filereadable(v:val) || isdirectory(v:val) ? v:val : ""')
  if pathlist != []
    let path = join(pathlist, "\n")
    call setreg(v:register, path, 'v')
    echo path
  else
    echo 'No path has been found.'
  endif
endfunction
function! YankPathComp(ArgLead, CmdLine, CursorPos) abort
  " To avoid E77 with -complete=file
  return join(glob(a:ArgLead, 1, 1), "\n")
endfunction
command! -nargs=1 -complete=custom,YankPathComp YankPath call s:yank_path(<q-args>)

" Open file browser
if has('win32')
  function! s:open_explorer(path) abort
    let shellslash = &shellslash
    let &shellslash = 0
    try
      let path = a:path ==# '' ? expand('%:p:h') : fnamemodify(a:path, ':p')
      execute '!start explorer ' . printf('"%s"', path)
    finally
      let &shellslash = shellslash
    endtry
  endfunction

  command! -nargs=? -complete=dir OpenExplorer call s:open_explorer(<q-args>)
endif

" preferable alternate of help command.
function! s:pref_alt_help(...)
  let [ splitright,  splitbelow] = [&splitright, &splitbelow]
  let [&splitright, &splitbelow] = [1, 1]
  let bang = a:1
  let  arg = a:2
  " Searching for the help window.
  let helptabnr = 0
  let helpwinnr = 0
  let tnr = tabpagenr()
  for wnr in range(1, tabpagewinnr(tnr, '$'))
    if gettabwinvar(tnr, wnr, '&buftype') ==# 'help'
      let helptabnr = tnr
      let helpwinnr = wnr
      break
    endif
  endfor
  if helptabnr == 0 && helpwinnr == 0
    for tnr in range(1, tabpagenr('$'))
      if tabpagewinnr(tnr, '$') == 1
        if gettabwinvar(tnr, 1, '&buftype') ==# 'help'
          let helptabnr = tnr
          let helpwinnr = wnr
          break
        endif
      endif
    endfor
  endif

  if helptabnr == 0 && helpwinnr == 0
    let width  = winwidth(0)
    let height = winheight(0)
    if width >= 140
      execute 'vert help' . bang . ' ' . arg
    elseif height >= 40 || height >= width/2
      execute 'help' . bang . ' ' . arg
    else
      execute 'tab help' . bang . ' ' . arg
    endif
  else
    execute 'normal! ' . helptabnr . 'gt'
    execute 'normal! ' . helpwinnr . "\<C-w>w"
    execute 'help' . bang . ' ' . arg
  endif

  let [&splitright, &splitbelow] = [splitright, splitbelow]
  normal! 0
endfunction

command! -bang -nargs=? -complete=help Help call s:pref_alt_help('<bang>', <f-args>)
nnoremap <Space>h :Help<Space>

" Modified :edit command
function! Edit(kind, arg) abort
  let target = a:arg
  if !filereadable(target)
    let ArgLead = a:arg
    let CmdLine = a:kind . ' ' . a:arg
    let CursorPos = getcmdpos()
    let candidates = filter(EditCompl(ArgLead, CmdLine, CursorPos), 'filereadable(v:val)')
    let candidate = get(candidates, 0, '')
    if candidate !=# ''
      let target = candidate
    endif
  endif
  execute 'edit ' . target
endfunction
function! EditCompl(ArgLead, CmdLine, CursorPos) abort
  let pwd = getcwd()
  let len = strlen(pwd)
  if a:CmdLine[0] ==# 'M'
    let candidates = map(copy(v:oldfiles), 'expand(v:val)')
  else
    let separator = has('win32') && !&shellslash ? '\' : '/'
    if a:ArgLead ==# ''
      let candidates = glob(pwd . separator . '*', 0, 1, 1)
    elseif isdirectory(a:ArgLead)
      " FIXME: This path determination is not a perfect solution!
      let path = a:ArgLead[strlen(a:ArgLead)-1] !=# separator ? a:ArgLead . separator : a:ArgLead
      let candidates = glob(path . '*', 0, 1, 1)
    else
      let candidates = glob(a:ArgLead . '*', 0, 1, 1)
    endif
    call map(candidates, 'isdirectory(v:val) ? v:val . separator : v:val')
  endif
  call map(candidates, 'v:val[: len-1] ==# pwd ? v:val[len+1 :] : v:val')
  for string in split(a:ArgLead, '[^\\]\%(\\\\\)*\s')
    call filter(candidates, 'match(v:val, ''\c'' . escape(string, ''~"\.^$[]*'')) > -1')
  endfor
  return filter(candidates, 'filereadable(v:val) || isdirectory(v:val)')
endfunction
command! -nargs=1 -complete=customlist,EditCompl E call Edit('E', <q-args>)
command! -nargs=1 -complete=customlist,EditCompl M call Edit('M', <q-args>)
nnoremap <Space>e :E<Space>
nnoremap <Space>m :M<Space>

" Variants of :buffer command, split and display buffer
command! -nargs=1 -complete=buffer S split     | buffer <args>
command! -nargs=1 -complete=buffer V vsplit    | buffer <args>
command! -nargs=1 -complete=buffer T tabedit % | buffer <args>

" glance a tag
function! s:TagGlance(arg) abort
  call s:TagGlanceClose()
  execute 'stjump ' . a:arg
  resize v:count1 " <- syntax sugar?
  let t:GlanceWindow = winnr()
  wincmd p
endfunction
function! s:TagGlanceClose() abort
  if exists('t:GlanceWindow')
    execute t:GlanceWindow . 'wincmd w'
    quit
    unlet t:GlanceWindow
  endif
endfunction
command! -nargs=1 TagGlance call s:TagGlance(<q-args>)
command! TagGlanceClose call s:TagGlanceClose()
"}}}
"***** abbreviation ***** {{{
let s:greeks = [
      \   ['alpha', 'α'], ['Alpha', 'Α'],
      \   ['beta', 'β'], ['Beta', 'Β'],
      \   ['gamma', 'γ'], ['Gamma', 'Γ'],
      \   ['delta', 'δ'], ['Delta', 'Δ'],
      \   ['epsilon', 'ε'], ['Epsilon', 'Ε'],
      \   ['zeta', 'ζ'], ['Zeta', 'Ζ'],
      \   ['eta', 'η'], ['Eta', 'Η'],
      \   ['theta', 'θ'], ['Theta', 'Θ'],
      \   ['iota', 'ι'], ['Iota', 'Ι'],
      \   ['kappa', 'κ'], ['Kappa', 'Κ'],
      \   ['lambda', 'λ'], ['Lambda', 'Λ'],
      \   ['mu', 'μ'], ['Mu', 'Μ'],
      \   ['nu', 'ν'], ['Nu', 'Ν'],
      \   ['xi', 'ξ'], ['Xi', 'Ξ'],
      \   ['omicron', 'ο'], ['Omicron', 'Ο'],
      \   ['pi', 'π'], ['Pi', 'Π'],
      \   ['rho', 'ρ'], ['Rho', 'Ρ'],
      \   ['sigma', 'σ'], ['Sigma', 'Σ'],
      \   ['tau', 'τ'], ['Tau', 'Τ'],
      \   ['upsilon', 'υ'], ['Upsilon', 'Υ'],
      \   ['phi', 'φ'], ['Phi', 'Φ'],
      \   ['chi', 'χ'], ['Chi', 'Χ'],
      \   ['psi', 'ψ'], ['Psi', 'Ψ'],
      \   ['omega', 'ω'], ['Omega', 'Ω'],
      \ ]

function! s:abbrev_greek(bang) abort
  if a:bang ==# ''
    for [lhs, rhs] in s:greeks
      execute printf('inoreabbrev <buffer> %s %s', lhs, rhs)
      execute printf('cnoreabbrev <buffer> %s %s', lhs, rhs)
    endfor
  else
    for [lhs, rhs] in s:greeks
      execute printf('iunabbrev <buffer> %s', lhs)
      execute printf('cunabbrev <buffer> %s', lhs)
    endfor
  endif
endfunction

command! -nargs=0 -bang GreekAbbrev call s:abbrev_greek(expand('<bang>'))
"}}}
"***** macros ***** {{{
" I think macros can be regarded as keymappings which can be re-written
" casually and instantly starting from '@' prefix.

let g:macros   = {}
" increment file number
let g:macros.a = "0t.5hi \<Esc>\<C-a>F xj"
let g:macros.x = "0t.5hi \<Esc>\<C-x>F xj"
" delete spaces at line-end
let g:macros.s = ":\<Home>keeppatterns \<End>s/\\s*$//g\<CR>j"
" change the type of v:register content to linewise type
let g:macros.l = ":call setreg(v:register, getreg(), 'l')\<CR>"
" Toggle commenting of the lines starting from 'PP' or 'echo'
let g:macros.d = 'm`:global/^"\?\s*\%(PP\|echo\)/CawToggle' . "\<CR>``:nohlsearch\<CR>"
" copy selected area & paste. (a kind of joke)   original : call setreg('u', "\<Esc>:let @u='\"=@u[15:]\<C-v>\<CR>p1000fa'\<CR>gv\"Uy")
let g:macros.u = "\<Esc>:let @u='\"\<Del>=@u[17:]\<C-v>\<CR>p1000fa'\<CR>gv\"Uy"

" presets
function! s:preset_macros(...)
  let targets = (a:0 > 0) ? split(a:1, '\zs') : keys(g:macros)

  for target in targets
    if has_key(g:macros, target)
      execute 'let @' . target . " = '" . substitute(g:macros[target], "'", "''", 'g') . "'"
    endif
  endfor
endfunction

command! -nargs=? PresetMacros call s:preset_macros()
call s:preset_macros()



""" macro editor
let s:reg_editor = {
      \   'tabnr': 0,
      \   'winnr': 0,
      \   'bufnr': 0,
      \   'reg': [],
      \   'parentwindownr': 0,
      \   'marks': {},
      \   'view': {},
      \ }

function! s:reg_editor_start() abort
  " save current information
  " FIXME: Any other?
  let s:reg_editor.parentwindownr = winnr()
  let s:reg_editor.marks.modify = [getpos("'["), getpos("']")]
  let s:reg_editor.marks.visual = [getpos("'<"), getpos("'>")]
  let s:reg_editor.view = winsaveview()

  " get register name
  let c = getchar()
  let c = type(c) == type(0) ? nr2char(c) : c
  if c =~# '["0-9-a-z*+]'
    " prepare buffer
    new
    let s:reg_editor.tabnr = tabpagenr()
    let s:reg_editor.winnr = winnr()
    let s:reg_editor.bufnr = bufnr('')
    resize 1
    setlocal buftype=nofile
    let reg = [c, getreg(c), getregtype(c)]
    let s:reg_editor.reg = reg
    call setline(1, reg[1])

    " fix view
    execute s:reg_editor.parentwindownr . 'wincmd w'
    call winrestview({'topline': s:reg_editor.view.topline})
    execute s:reg_editor.winnr . 'wincmd w'
    redraw

    " key mappings
    nnoremap <silent><buffer> <CR>  :<C-u>call <SID>reg_editor_return('n')<CR>
    xnoremap <silent><buffer> <CR>  :<C-u>call <SID>reg_editor_return('x')<CR>
    inoremap <silent><buffer> <CR>  <C-r>=<SID>reg_editor_return('i')<CR>
    nnoremap <silent><buffer> <Esc> :<C-u>call <SID>reg_editor_cancel()<CR>

    " autocmd
    augroup reg_editor
      autocmd!
      autocmd WinLeave <buffer> call s:reg_editor_cancel()
    augroup END
  endif
endfunction

function! s:reg_editor_return(mode) abort
  if a:mode ==# 'x'
    let temp_reg = ['"', getreg('"'), getregtype('"')]
    try
      normal! `<""y`>
      let new = @@
    finally
      call call('setreg', temp_reg)
    endtry
  else
    let new = join(getline(1, '$'), "\n")
  endif

  let reg = s:reg_editor.reg
  call s:reg_editor_finalize([reg[0], new, reg[2]])
endfunction

function! s:reg_editor_cancel() abort
  call s:reg_editor_finalize(s:reg_editor.reg)
endfunction

function! s:reg_editor_finalize(reg) abort
  if a:reg != []
    call call('setreg', a:reg)
  endif
  execute 'tabnext ' . s:reg_editor.tabnr
  execute s:reg_editor.winnr . 'wincmd w'
  execute s:reg_editor.bufnr . 'buffer!'
  augroup reg_editor
    autocmd!
  augroup END
  bwipeout!

  " restore information
  call setpos("'[", s:reg_editor.marks.modify[0])
  call setpos("']", s:reg_editor.marks.modify[1])
  call setpos("'<", s:reg_editor.marks.visual[0])
  call setpos("'>", s:reg_editor.marks.visual[1])
  call winrestview(s:reg_editor.view)
endfunction

nnoremap <silent> Q :<C-u>call <SID>reg_editor_start()<CR>
"}}}
"***** playpit ***** {{{
" textobj-instant
onoremap <silent> iI :<C-u>call Textobj_instant()<CR>
xnoremap <silent> iI :<C-u>call Textobj_instant()<CR>

" Prepare preset patterns
let g:textobj_instant_patterns = ['<C-.>', '<M-.>', '<Esc>', '<CR>', '<Up>', '<Down>', '<Left>', '<Right>', '<buffer>', '<nowait>', '<silent>', '<special>', '<script>', '<expr>', '<unique>', '<SID>', '<Plug>([^)]\{-})\>', '\<[abglstvw]:\k\+\>']

function! Textobj_instant()
  let patterns = g:textobj_instant_patterns
  " A kind of workaround
  " need the equivalent option with the 'c' flag of search() function
  let slipped = 0
  if col('.') != 1
    normal! h
    let slipped = 1
  endif

  " search for the target
  let output = patternjump#forward('n', [[[], patterns], [[], []]], v:count1, {'raw' : 2, 'highlight' : 0, 'caching' : 0, 'debug_mode' : 0, 'wrap_line' : 0, 'move_afap' : 0})

  if output.destination[0][1] > 0
    " derive the matched pattern
    let matched_pattern = output.candidates[match(map(copy(output.candidates), 'v:val[0][1]'), output.destination[0][1])][1]

    " (re-)entering to the visual mode
    normal! v

    " move to the head of matched pattern
    call search(matched_pattern, 'cb', line('.'))
  else
    if slipped
      normal! l
    endif
  endif
endfunction

command! -nargs=1 TextobjInstantAdd    let g:textobj_instant_patterns += [<q-args>]
command! -nargs=1 TextobjInstantDelete call filter(g:textobj_instant_patterns, 'v:val != <q-args>')
command!          TextobjInstantClear  let g:textobj_instant_patterns = []

"}}}
"***** finalize (rather for reloading .vimrc) ***** {{{
" loading local settings
if filereadable(expand($USERDIR . '/.vimrc.local'))
  source $USERDIR/.vimrc.local
endif

" recall filetype autocommand
if !has('vim_starting')
  doautocmd FileType
endif
"}}}

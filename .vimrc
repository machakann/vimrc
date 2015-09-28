" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldcolumn=2:
" vim:set foldmethod=marker: commentstring="%s:
" Last Change: 28-Sep-2015.
"
"***** Todo *****

"***** startup ***** {{{
"-------------------------------------------------------------------------
" encoding and file format
if has('win32') && !has('gui_running')
  set encoding=cp932
else
  set encoding=utf-8
endif
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,iso-2022-jp,latin1
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

" NeoBundle       'davidhalter/jedi-vim'
NeoBundle       'JuliaLang/julia-vim'
" NeoBundle       'julia-vim', {'base': '~/Dropbox/Works/', 'type': 'nosync'}
NeoBundle       'kana/vim-operator-user'
NeoBundle       'kana/vim-operator-replace'
NeoBundle       'kana/vim-smartinput'
NeoBundle       'kana/vim-submode'
NeoBundle       'kana/vim-textobj-user'
NeoBundle       'kana/vim-textobj-indent'
NeoBundle       'kana/vim-textobj-line'
NeoBundle       'machakann/vim-columnmove'
NeoBundle       'vim-cmdline-completion-extra', {'base': '~/Dropbox/Works/', 'type': 'nosync'}
NeoBundle       'machakann/vim-lion'
NeoBundle       'machakann/vim-operator-insert'
NeoBundle       'machakann/vim-operator-jerk'
NeoBundle       'machakann/vim-patternjump'
NeoBundle       'machakann/vim-sandwich'
" NeoBundle       'vim-sandwich', {'base': '~/Dropbox/Works/', 'type': 'nosync'}
NeoBundle       'machakann/vim-textobj-functioncall'
NeoBundle       'machakann/vim-textobj-delimited'
NeoBundle       'machakann/vim-textobj-equation'
NeoBundle       'mattn/webapi-vim'
NeoBundle       'osyo-manga/vim-reanimate'
NeoBundle       'sgur/vim-textobj-parameter'
NeoBundleFetch  'Shougo/neobundle.vim'
NeoBundle       'Shougo/neomru.vim'
NeoBundle       'Shougo/unite.vim'
NeoBundle       'Shougo/vimproc.vim' , {
                \ 'build' : {
                \     'windows' : 'tools\\update-dll-mingw',
                \     'cygwin'  : 'make -f make_cygwin.mak',
                \     'mac'     : 'make -f make_mac.mak',
                \     'unix'    : 'make -f make_unix.mak',
                \    },}
NeoBundle       'superbrothers/vim-quickrun-markdown-gfm'
NeoBundle       'thinca/vim-prettyprint'
NeoBundle       'thinca/vim-visualstar'
NeoBundle       'thinca/vim-quickrun'
NeoBundle       'thinca/vim-themis'
" NeoBundle       'tommcdo/vim-lion'
NeoBundle       'tpope/vim-fugitive'
NeoBundle       'tyru/caw.vim'
NeoBundle       'tyru/open-browser.vim'
NeoBundle       'ujihisa/unite-colorscheme' , {'depends' : 'Shougo/unite.vim'}
NeoBundle       'vim-jp/vimdoc-ja'

NeoBundleLazy   'jceb/vim-hier', {
      \ 'autoload' : {
      \   'commands' : ['HierUpdate', 'HierClear', 'HierStart', 'HierStop'],
      \ }}
NeoBundleLazy   'osyo-manga/vim-anzu', {
      \ 'autoload' : {
      \   'mappings' : '<Plug>(anzu-',
      \ }}
NeoBundleLazy   'sjl/gundo.vim', {
      \ 'autoload' : {'commands': 'GundoToggle'}
      \ }
NeoBundleLazy   'Shougo/neocomplete'
NeoBundleLazy   'Shougo/neosnippet.vim', {
      \ 'autoload' : {
      \   'insert'    : 1,
      \   'filetypes' : ['neosnippet'],
      \   },
      \ }
NeoBundle       'Shougo/neosnippet-snippets'
NeoBundleLazy   'ujihisa/neco-look', {
      \ 'depends'  : 'Shougo/neocomplete',
      \ 'type' : 'nosync',
      \}
NeoBundleLazy   'vim-jp/vital.vim', {
      \ 'autoload' : {
      \   'commands' : 'Vitalize',
      \   }
      \ }

if has('gui_running')
  NeoBundle 'thinca/vim-localrc'
endif

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
      \     ['<Plug>(smartinput_BS)', '<Plug>(smartinput_BS)',   '<BS>'],
      \     ['<Plug>(smartinput_CR)', '<Plug>(smartinput_CR)',   '<CR>'],
      \     ['<Plug>(smartinput_^k)', '<Plug>(smartinput_^k)',  '<C-k>'],
      \     ['<Plug>(smartinput_^n)', '<Plug>(smartinput_^n)',  '<C-n>'],
      \     ['(',     '(',     '('    ],
      \     [')',     ')',     ')'    ],
      \     ['[',     '[',     '['    ],
      \     [']',     ']',     ']'    ],
      \     ['{',     '{',     '{'    ],
      \     ['}',     '}',     '}'    ],
      \     ['''',    '''',    ''''   ],
      \     ['"',     '"',     '"'    ],
      \     ['<',     '<',     '<'    ],
      \     ['>',     '>',     '>'    ],
      \     ['+',     '+',     '+'    ],
      \     ['-',     '-',     '-'    ],
      \     ['*',     '*',     '*'    ],
      \     ['/',     '/',     '/'    ],
      \     ['%',     '%',     '%'    ],
      \     ['&',     '&',     '&'    ],
      \     ['<Bar>', '<Bar>', '<Bar>'],
      \     ['=',     '=',     '='    ],
      \     ['~',     '~',     '~'    ],
      \     ['#',     '#',     '#'    ],
      \     ['^',     '^',     '^'    ],
      \     ['?',     '?',     '?'    ],
      \     [':',     ':',     ':'    ],
      \     ['.',     '.',     '.'    ],
      \     [',',     ',',     ','    ],
      \    ]

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
      \   {'char': '''', 'at': '\%#\h',       'input': '''',             },
      \   {'char': '''', 'at': '''''''\%#''', 'input': '<C-g>U<Right>',  },
      \   {'char':  '"', 'at': '\%#',         'input': '""<C-g>U<Left>', },
      \   {'char':  '"', 'at': '\%#\h',       'input': '"',              },
      \   {'char':  '"', 'at': '\\\%#',       'input': '"',              },
      \   {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*\%#"',       'input': '""<C-g>U<Left>',      },
      \   {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',  'input': '""',                  },
      \   {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#"', 'input': '<C-g>U<Right>',       },
      \   {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*\%#''', 'input': '''''<C-g>U<Left>',    },
      \   {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\%#''', 'input': '<C-g>U<Right>'},
      \   {'char': '''', 'at': '\C\%(^\|\<\)\%(I\|[Yy]ou\|[Ww]e\|[Tt]hey\|[Tt]hat\|[Ii]t\|[Ww]h\%([oy]\|at\|ere\|en\)\|[Hh]ow\)\%#', 'input': "'"},
      \   {'char': '''', 'at': '\C\%(^\|\<\)\%([Ii]s\|[Aa]re\|[Ww]\%(as\|ere\|o\)\|[Dd]\%(o\%(es\)\?\|id\)\|[Hh]\%(ave\|as\)\|ca\|\%([CWcw]\|[Ss]h\)ould\|[Mm]ust\|[Mm]ight\)n\%#', 'input': "'t"},
      \   {'char': '''', 'at': '\C\%(^\|\<\)[Ll]et\%#', 'input': "'s"},
      \ ]

" correspondent parentheses
let s:rules += [
      \   {'char': '(',    'at': '\%#',   'input': '()<C-g>U<Left>',   'mode': 'i'},
      \   {'char': ')',    'at': '\%#)',  'input': '<C-g>U<Right>',    'mode': 'i'},
      \   {'char': '(',    'at': '\%#',   'input': '()<Left>',         'mode': '/?'},
      \   {'char': ')',    'at': '\%#)',  'input': '<Right>',          'mode': '/?'},
      \   {'char': '(',    'at': '[^\\]\%(\\\\\)*\\\%#', 'input': '(', 'mode': 'i/?'},
      \   {'char': '[',    'at': '\%#',   'input': '[]<C-g>U<Left>',   'mode': 'i'},
      \   {'char': ']',    'at': '\%#\]', 'input': '<C-g>U<Right>',    'mode': 'i'},
      \   {'char': '[',    'at': '\%#',   'input': '[]<Left>',         'mode': '/?'},
      \   {'char': ']',    'at': '\%#\]', 'input': '<Right>',          'mode': '/?'},
      \   {'char': '[',    'at': '[^\\]\%(\\\\\)*\\\%#', 'input': '[', 'mode': 'i/?'},
      \   {'char': '{',    'at': '\%#',   'input': '{}<C-g>U<Left>',   'mode': 'i'},
      \   {'char': '}',    'at': '\%#}',  'input': '<C-g>U<Right>',    'mode': 'i'},
      \   {'char': '{',    'at': '\%#',   'input': '{}<Left>',         'mode': '/?'},
      \   {'char': '}',    'at': '\%#}',  'input': '<Right>',          'mode': '/?'},
      \   {'char': '{',    'at': '[^\\]\%(\\\\\)*\\\%#', 'input': '{', 'mode': 'i/?'},
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
      \   {'char': '<Plug>(smartinput_BS)', 'at': '"\s\%#',    'input': '<BS><BS>',     'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' \. \%#',   'input': '<BS><BS><BS>', 'filetype': ['vim']},
      \   {'char': '=', 'at': '\. \%#',   'input': '<BS>= ',              'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.\%#\S', 'input': '= ',                  'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.\%#$',  'input': '= ',                  'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.\%# ',  'input': '=',                   'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': '\S\.\%#',  'input': '<BS> .= ',            'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': ' \.= \%#', 'input': '<BS><BS><BS><BS>.=',  'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': '<C-r>\%#', 'input': '=',                   'mode': 'i:', 'filetype': ['vim']},
      \   {'char': '=', 'at': '\C\<set\%[local]\> \w\+\%#', 'input': '=', 'mode': 'i',  'filetype': ['vim']},
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
      \   {'char': '.', 'at': '^\s*function!\?\s\+\%(\%(s:\)\?\k\+\|\%(g:\)\?\u\k*\)(.*\%#', 'input': '...', 'filetype': ['vim']},
      \ ]

let s:rules += [
      \   {'char': ')', 'at': '\%#\\)',  'input': '<C-g>U<Right><C-g>U<Right>', 'filetype': ['vim']},
      \   {'char': ']', 'at': '\%#\\\]', 'input': '<C-g>U<Right><C-g>U<Right>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '(\%#)',       'input': '<BS><Del>\%(\)<C-g>U<Left><C-g>U<Left>', 'filetype': ['vim'], 'priority': -2},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\[\%#\]',     'input': '<BS><Del>\[\]<C-g>U<Left><C-g>U<Left>',  'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '<\%#>',       'input': '<BS><Del>\<\><C-g>U<Left><C-g>U<Left>',  'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\%(\%#\\)',  'input': '<BS><BS>(',                  'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\\(\%#\\)',   'input': '<BS>%(',                     'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\%(\%#\\)',  'input': '<BS><BS><BS><Del><Del>',     'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\(\%#\\)',   'input': '<BS><BS><Del><Del>',         'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '\\\[\%#\\\]', 'input': '<BS><BS><Del><Del>',         'filetype': ['vim']},
      \ ]

let s:rules += [
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\<\k\+\%#', 'input': '<C-r>=LocalComplete(["vals", "builtin_funcs"], StCol(''\<[^.]''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': ' &\k*\%#', 'input': '<C-r>=LocalComplete(["options"], StCol(''&\zs''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\<[sg]:\k*\%#', 'input': '<C-r>=LocalComplete(["funcs", "vals"], StCol(''\<[sg]:''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\<[abglstvw]:\k*\%#', 'input': '<C-r>=LocalComplete(["vals", "funcs"], StCol(''\<[abglstvw]:''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*:\?\w*\%#', 'input': '<C-r>=LocalComplete(["commands"], StCol(''\%(^\|\s\zs\)''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '\s|\s*\%#', 'input': '<C-r>=LocalComplete(["commands"], StCol(''\s\zs''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*\%(un\)\?let\s\+\%([abglstvw]:\)\?\k*\%#', 'input': '<C-r>=LocalComplete(["vals"], StCol(''\s\zs''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*call\s\+\k*\%#', 'input': '<C-r>=LocalComplete(["builtin_funcs", "funcs"], StCol(''\s\zs''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*call\s\+[sg]:\k*\%#', 'input': '<C-r>=LocalComplete(["funcs", "builtin_funcs"], StCol(''\<[sg]:''))<CR>', 'filetype': ['vim']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*let\s\+&\l*\%#', 'input': '<C-r>=LocalComplete(["options"], StCol(''&\zs''))<CR>', 'filetype': ['vim']},
      \ ]

" matlab
let s:rules += [
      \   {'char': '%', 'at': '^\s*\%#',     'input': '% ',      'filetype': ['matlab']},
      \   {'char': '%', 'at': '^\s*%\+ \%#', 'input': '<BS>%% ', 'filetype': ['matlab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*%\s\%#',         'input': '<BS><BS>',      'filetype': ['matlab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*\(%%\)\+%\s\%#', 'input': '<BS><BS><BS> ', 'filetype': ['matlab']},
      \ ]

" scilab
let s:rules += [
      \   {'char': '/', 'at': '^\s*\%#',          'input': '// ',     'filetype': ['scilab']},
      \   {'char': '/', 'at': '^\s*\(//\)\+ \%#', 'input': '<BS>// ', 'filetype': ['scilab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*//\s\%#',         'input': '<BS><BS><BS>',  'filetype': ['scilab']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': '^\s*//\(//\)\+\s\%#', 'input': '<BS><BS><BS> ', 'filetype': ['scilab']},
      \ ]

" common in matlab, scilab and julia
" ' + ' -> '+' -> '++' -> '+++' ...
let s:rules += [
      \   {'char': '+', 'at': '\%#',    'input': ' + ',           'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '+', 'at': ' + \%#', 'input': '<BS><BS><BS>+', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '+', 'at': '+\%#',   'input': '+',             'filetype': ['matlab', 'scilab', 'julia']},
      \ ]
" ' - ' -> '-' -> '--' -> '---' ...
let s:rules += [
      \   {'char': '-', 'at': '\%#',    'input': ' - ',           'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '-', 'at': ' - \%#', 'input': '<BS><BS><BS>-', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '-', 'at': '-\%#',   'input': '-',             'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '-', 'at': '\c[(=<>,ed]\s*\%#', 'input': '-',  'filetype': ['matlab', 'scilab', 'julia']},
      \ ]
" '.^' -> '^' -> '^^' -> '^^^' ...
let s:rules += [
      \   {'char': '^', 'at': '\^\%#',  'input': '^', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '[^^.]^\%#', 'input': '<BS>.^',    'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\.^\%#',    'input': '<BS><BS>^', 'filetype': ['matlab', 'scilab', 'julia']},
      \ ]
" '.*' -> '*' -> '**' -> '***' ...
let s:rules += [
      \   {'char': '*', 'at': '\*\%#', 'input': '*', 'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '[^*.]\*\%#', 'input': '<BS>.*',    'filetype': ['matlab', 'scilab', 'julia']},
      \   {'char': '<Plug>(smartinput_^k)', 'at': '\.\*\%#',    'input': '<BS><BS>*', 'filetype': ['matlab', 'scilab', 'julia']},
      \ ]
" './' -> '/' -> '//' -> '///' ...
let s:rules += [
      \   {'char': '/', 'at': '/\%#', 'input': '/', 'filetype': ['matlab', 'scilab', 'julia']},
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
      \   {'char': ':', 'at': '^\s*\%(integer\|real\|double precision\|complex\|complex([[:alnum:]_%()]*)\|logical\|character\)\%((\d\+)\)\?\%(\s*,\s*\%(dimension(\d\+\%(,\s*\d\+\))\|parameter\|allocatable\|intent(\%(in\|out\|inout\))\)\)\?\%#', 'input': ' :: ', 'filetype': ['fortran']},
      \   {'char': ':', 'at': '^\s*type(\h\w\*)\%(,\s*\%(dimension(\d\+\%(,\s*\d\+\))\|parameter\|allocatable\|private\|public\)\)\?\%#', 'input': ' :: ', 'filetype': ['fortran']},
      \   {'char': ':', 'at': '^\s*\%(private\|public\)\%#', 'input': ' :: ', 'filetype': ['fortran']},
      \   {'char': ':', 'at': ' :: \%#', 'input': '<BS><BS><BS><BS>:',  'filetype': ['fortran']},
      \   {'char': '=', 'at': '/ \%#',   'input': '<BS>= ',             'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /\%#\S', 'input': '= ',                 'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /\%#$',  'input': '= ',                 'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /\%# ',  'input': '=',                  'filetype': ['fortran']},
      \   {'char': '=', 'at': '\S/\%#',  'input': '<BS> /= ',           'filetype': ['fortran']},
      \   {'char': '=', 'at': ' /= \%#', 'input': '<BS><BS><BS><BS>/=', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*\%#', 'input': '<C-r>=LocalComplete(["type"])<CR>', 'filetype': ['fortran']},
      \   {'char': '<Plug>(smartinput_^n)', 'at': '^\s*\%(integer\|real\|double precision\|complex\|complex([[:alnum:]_%()]*)\|logical\|character\)[^:]*\%#', 'input': '<C-r>=LocalComplete(["attr"])<CR>', 'filetype': ['fortran']},
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
      \   {'char': '-',    'at': '< \%#',   'input': '<BS>- ',           'filetype': ['r']},
      \   {'char': '>',    'at': '- \%#',   'input': '<BS>> ',           'filetype': ['r']},
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
      \   {'char': '>', 'at': ' = \%#', 'input': '<BS>> ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '*\%#', 'input': '<BS> *= ', 'filetype': ['julia']},
      \   {'char': '=', 'at': '/\%#', 'input': '<BS> /= ', 'filetype': ['julia']},
      \   {'char': '<Plug>(smartinput_BS)', 'at': ' [*/]= \%#',  'input': '<BS><BS><BS><BS>', 'filetype': ['julia'], 'mode': 'i:'},
      \ ]

" dosbatch, shellscript
let s:rules += [
      \   {'char': '=', 'at': '\%#',      'input': '=',        'filetype': ['dosbatch', 'sh']},
      \   {'char': '=', 'at': '[^=]=\%#', 'input': '<BS> == ', 'filetype': ['dosbatch', 'sh']},
      \ ]

for item in s:rules
  call smartinput#define_rule(item)
endfor
unlet item
let g:is_smartinput_active = 1

" These mappings could be modified somewhere else.
" But required just for safety-net.
imap <BS>  <Plug>(smartinput_BS)
cmap <BS>  <Plug>(smartinput_BS)
imap <CR>  <Plug>(smartinput_CR)
imap <expr> <C-k> <SID>i_CTRL_k()
cmap <C-k> <Plug>(smartinput_^k)
imap <expr> <C-n> <SID>i_CTRL_n()

function! s:i_CTRL_k() abort
  let key = ''
  if s:smartinput_has_rule('<Plug>(smartinput_^k)', 0)
    let key = "\<Plug>(smartinput_^k)"
  elseif neosnippet#expandable()
    let key = "\<Plug>(neosnippet_expand)"
  elseif s:smartinput_has_rule('<Plug>(smartinput_^k)', -1)
    let key = "\<Plug>(smartinput_^k)"
  elseif neosnippet#jumpable()
    let key = "\<Plug>(neosnippet_jump)"
  elseif s:smartinput_has_rule('<Plug>(smartinput_^k)', -2)
    let key = "\<Plug>(smartinput_^k)"
  endif
  return key
endfunction

function! s:i_CTRL_n() abort
  if pumvisible()
    return "\<C-n>"
  else
    return "\<Plug>(smartinput_^n)"
  endif
endfunction

function! s:smartinput_has_rule(key, priority) abort
  let ft = &filetype
  let rules = deepcopy(s:rules)
  call filter(rules, 'v:val["char"] ==# a:key')
  call filter(rules, '!has_key(v:val, "filetype") || match(v:val["filetype"], ft) >= 0')
  call filter(rules, '!has_key(v:val, "mode") || match(v:val["mode"], "i") >= 0')
  if a:priority == 0
    call filter(rules, '!has_key(v:val, "priority") || v:val["priority"] == 0')
  else
    call filter(rules, 'has_key(v:val, "priority") && v:val["priority"] == a:priority')
  endif
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
        execute "iunmap " . item[0]
        execute "cunmap " . item[0]
      else
        if item[2] =~# '^<Plug>.\+'
          execute "imap " . item[0] . " " . item[2]
          execute "cmap " . item[0] . " " . item[2]
        else
          execute "inoremap " . item[0] . " " . item[2]
          execute "cnoremap " . item[0] . " " . item[2]
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
    " PP! [startpos, col, p, getline('.')]
    " if has_key(b:local_compl, 'updatefunc')
      " call b:local_compl.updatefunc()
    " endif
    if p == ''
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
  return searchpos(a:pat, 'bn', line("."))[1] - 1
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
let g:caw_i_skip_blank_line = 1

function! Operator_caw(type)
  " There is some room to be improved, but menndoi.
  execute "'[,']normal \<Plug>(caw:i:toggle)"
endfunction

command! -nargs=0 CawToggle normal <Plug>(caw:i:toggle)

nnoremap <silent> <Space>c  :<C-u>set operatorfunc=Operator_caw<CR>g@
nnoremap <silent> <Space>cc :<C-u>CawToggle<CR>
xnoremap <silent> <Space>c  <Esc>:set operatorfunc=Operator_caw<CR>gvg@
"}}}
"*** columnmove *** {{{
let g:columnmove_auto_scroll = 1
let g:columnmove_strict_wbege = 1
let g:columnmove_fold_open = {'x' : &foldnestmax, 'o' : &foldnestmax}

nnoremap <silent>      <M-e> :<C-u>call columnmove#e('n', '', 0, {'strict_wbege':0})<CR>
xnoremap <silent>      <M-e> :<C-u>call columnmove#e('x', '', 0, {'strict_wbege':0})<CR>
onoremap <silent>      <M-e> :<C-u>call columnmove#e('o', 'V', 0, {'strict_wbege':0})<CR>
onoremap <silent>     v<M-e> :<C-u>call columnmove#e('o', '', 0, {'strict_wbege':0})<CR>
onoremap <silent>     V<M-e> :<C-u>call columnmove#e('o', 'V', 0, {'strict_wbege':0})<CR>
onoremap <silent> <C-v><M-e> :<C-u>call columnmove#e('o', "<Bslash><lt>C-v>", 0, {'strict_wbege':1})<CR>

nnoremap <silent> <M-o> :<C-u>call columnmove#e('n', '', 0, {'strict_wbege':0})<CR>o
nnoremap <silent> <M-O> :<C-u>call columnmove#b('n', '', 0, {'strict_wbege':0})<CR>o
"}}}
"*** jedi.vim *** {{{
" let g:jedi#auto_initialization = 1
" let g:jedi#rename_command = "<leader>R"
" let g:jedi#popup_on_dot = 0
" autocmd vimrc FileType python setlocal omnifunc=jedi#completions
"}}}
"*** neocomplete.vim *** {{{
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Ignore cases
let g:neocomplete#enable_ignore_case = 1
" Set completion start length
let g:neocomplete#auto_completion_start_length = 3
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Assign data directory path.
let g:neocomplete#data_directory = $USERCACHEDIR . '/.neocon'
" Delimiter automatic insertion.
let g:neocomplete#enable_auto_delimiter = 1
" Delimiter patterns for smart completion.
if !exists('g:neocomplete#delimiter_patterns')
  let g:neocomplete#delimiter_patterns= {}
endif
let g:neocomplete#delimiter_patterns.vim = ['#', '.']

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $USERCACHEDIR . '/.vimshell/command-history',
  \ 'autohotkey' : $USERDIR . '/dict/AHK.dict'
  \}

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

let bundle = neobundle#get('neocomplete')
function! bundle.hooks.on_source(bundle)
  " Source optimization
  call neocomplete#custom_source('look', 'rank', 100)
  call neocomplete#custom_source('file', 'rank', 100)
  " Change default converter.
  call neocomplete#custom#source('_', 'converters',
  \ ['converter_remove_last_paren', 'converter_delimiter',
  \  'converter_remove_overlap', 'converter_case', 'converter_abbr'])

  " Recommended key-mappings.
  if maparg('<Plug>(smartinput_CR)', 'i') ==# ''
    imap <silent><expr> <CR> neocomplete#smart_close_popup() . "\<CR>"
  else
    imap <silent><expr> <CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"
  endif

  if maparg('<Plug>(smartinput_BS)', 'i') ==# ''
    imap <expr> <C-h> neocomplete#smart_close_popup() . "\<BS>"
    imap <expr> <BS> neocomplete#smart_close_popup() . "\<BS>"
  else
    imap <expr> <C-h> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
    imap <expr> <BS> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
  endif
endfunction
unlet bundle
"}}}
"*** neomru.vim *** {{{
let g:neomru#file_mru_path = $USERCACHEDIR . '/.neomru/file'
let g:neomru#directory_mru_path = $USERCACHEDIR . '/.neomru/directly'
"}}}
"*** neosnippet.vim *** {{{
" imap <expr> <C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<C-k>"
smap        <C-k> <Plug>(neosnippet_expand_or_jump)
xmap        <C-k> <Plug>(neosnippet_expand_target)
xmap        <C-l> <Plug>(neosnippet_start_unite_snippet_target)

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory = $USERDIR . '/snippets'
let g:neosnippet#data_directory = $USERCACHEDIR . '/neosnippet'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
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
"*** patternjump *** {{{
"   let g:patternjump_highlight = 1
let g:patternjump_caching        = 1
let g:patternjump_move_afap      = 1

let g:patternjump_patterns = {
  \ '_' : {
  \   'i' : {
  \     'head' : ['^\s*\zs\S', ',', '[^)\]}]\zs)', '[^)\]}]\zs]', '[^)\]}]\zs}', '$'],
  \     'tail' : ['\<\k*\>', '[^.deDE-]\zs-\?\<\d\+\%(\.\d*\)\?\%([deDE]-\?\d\+\)\?\>', '[''"])}]\+[])}]'],
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
let g:quickrun_config = {}
let g:quickrun_config = {
      \ '_' : {
      \         'runner/vimproc/updatetime' : 100,
      \         'hook/time/enable' : 1,
      \       },
      \ 'julia' : {
      \         'command': 'julia',
      \         'cmdopt': '-q --color=no --no-history-file',
      \         'hook/output_encode/encoding' : has('win32') ? 'cp932' : '&fileencoding',
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
call submode#enter_with('changebuffer', 'n', '', 'gb', ':IsolateTabNext<CR>')
call submode#enter_with('changebuffer', 'n', '', 'gB', ':IsolateTabPrevious<CR>')
call submode#map('changebuffer', 'n', '', 'b', ':IsolateTabNext<CR>')
call submode#map('changebuffer', 'n', '', 'B', ':IsolateTabPrevious<CR>')
"}}}
"*** sandwich.vim *** {{{
nmap s <Nop>
xmap s <Nop>

function! GetChar() abort
  let c = getchar()
  let c = type(c) == type(0) ? nr2char(c) : c
  return c ==# "\<Esc>" || c ==# "\<C-c>" ? '' : c
endfunction

function! FuncName() abort
  let funcname = input('funcname: ', '', 'custom,FuncNameComp')
  if funcname ==# ''
    throw 'OperatorSandwichCancel'
  endif
  return funcname . '('
endfunction

function! FuncNameComp(ArgLead, CmdLine, CursorPos) abort
  return join(uniq(sort(map(getline(1, '$'), 'matchstr(v:val, ''\k\{3,}\ze('')'))), "\n")
endfunction

let g:sandwich#recipes = [
      \   {'buns': ['<', '>'], 'expand_range': 0, 'match_syntax': 1},
      \   {'buns': ['"', '"'], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, 'syntax': ['Constant', 'Statement', 'Special', 'String'], 'inner_syntax': ['Constant', 'PreProc', 'Special', 'String'], 'input': ['"', '2']},
      \   {'buns': ["'", "'"], 'quoteescape': 1, 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'match_syntax': 1, 'syntax': ['Constant', 'Statement', 'Special', 'String'], 'inner_syntax': ['Constant', 'PreProc', 'Special', 'String'], 'input': ["'", '7']},
      \   {'buns': ['{', '}'], 'nesting': 1, 'match_syntax': 1, 'skip_break': 1},
      \   {'buns': ['[', ']'], 'nesting': 1, 'match_syntax': 1},
      \   {'buns': ['(', ')'], 'nesting': 1, 'match_syntax': 1, 'input': ['(', ')', '8', '9']},
      \   {'buns': ["'", "'"], 'filetype': ['vim'], 'skip_regex_head': ['\%(\%#\zs''\|''\%#\zs\)''\%(''''\)*[^'']'], 'skip_regex_tail': ['[^'']\%(''''\)*\%(\%#\zs''\|''\%#\zs\)'''], 'nesting': 0, 'linewise': 0, 'match_syntax': 2},
      \   {'buns': ['\(', '\)'],  'filetype': ['vim'], 'expand_range': 0, 'nesting': 1, 'match_syntax': 1, 'syntax': ['Constant', 'String']},
      \   {'buns': ['\%(', '\)'], 'filetype': ['vim'], 'expand_range': 0, 'nesting': 1, 'match_syntax': 1, 'syntax': ['Constant', 'String']},
      \   {'buns': ['"', '"'], 'filetype': ['', 'text', 'markdown'], 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'input': ['"', '2']},
      \   {'buns': ["'", "'"], 'filetype': ['', 'text', 'markdown'], 'expand_range': 0, 'nesting': 0, 'linewise': 0, 'input': ["'", '7']},
      \ ]

let g:operator#sandwich#recipes = [
      \   {'buns': ['input("operator-sandwich:head: ")', 'input("operator-sandwich:tail: ")'], 'kind': ['add', 'replace'], 'action': ['add'], 'expr': 1, 'input': ['i']},
      \   {'buns': ['FuncName()', '")"'], 'kind': ['add', 'replace'], 'action': ['add'], 'expr': 1, 'input': ["\<C-f>"]},
      \   {'buns': ['{', '}'], 'kind': ['add'],    'motionwise': ['line'], 'linewise': 1, 'command': ["'[+1,']-1normal! >>"]},
      \   {'buns': ['{', '}'], 'kind': ['delete'], 'motionwise': ['line'], 'linewise': 1, 'command': ["'[,']normal! <<"]},
      \   {'buns': ['if', 'endif'], 'filetype': ['vim'], 'kind': ['add'],    'motionwise': ['line'], 'nesting': 1, 'syntax': ['Statement'], 'linewise': 1, 'command': ["'[+1,']-1normal! >>"], 'input': ['i'], 'cursor': 'head'},
      \   {'buns': ['if', 'endif'], 'filetype': ['vim'], 'kind': ['delete'], 'motionwise': ['line'], 'nesting': 1, 'syntax': ['Statement'], 'linewise': 2, 'command': ["'[+1,']-1normal! <<"], 'input': ['i']},
      \ ]

let g:textobj#sandwich#recipes = [
      \   {'buns': ['input("textobj-sandwich:head: ")', 'input("textobj-sandwich:tail: ")'], 'kind': ['query'], 'expr': 1, 'regex': 1, 'synchro': 1, 'input': ['i']},
      \   {'buns': ['GetChar()', 'GetChar()'], 'kind': ['query'], 'nesting': 1, 'expr': 1, 'synchro': 1, 'input': ['f']},
      \   {'external': ["\<Plug>(textobj-functioncall-innerparen-a)", "\<Plug>(textobj-functioncall-a)"], 'noremap': 0, 'kind': ['query'], 'synchro': 1, 'input': ["\<C-f>"]},
      \ ]
"}}}
"*** unite.vim *** {{{
if neobundle#tap('unite.vim')
  nnoremap [Unite] <Nop>
  nmap     <Space>u [Unite]
  nnoremap [Unite]u :Unite<Space>
  nnoremap [Unite]c :Unite history/command command<CR>
  nnoremap [Unite]y :Unite register history/yank<CR>
  nnoremap [Unite]m :Unite -no-split file_mru<CR>
  nnoremap [Unite]b :Unite -no-split buffer_tab buffer<CR>
  nnoremap [Unite]d :Unite -no-split directory_mru directory directory/new<CR>
  nnoremap [Unite]p :Unite neobundle/update<CR>

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
  hi link uniteStatusSourceNames Directory
  hi link uniteStatusSourceCandidates ModeMsg

  " last ':messages'
  " http://d.hatena.ne.jp/osyo-manga/20131030/1383144724
  let g:unite_source_alias_aliases = {'messages' : {'source': 'output', 'args': 'message'}}
"   call unite#custom#source('messages', 'sorters', 'sorter_reverse')
  call unite#custom#default_action('messages', 'yank')
  call unite#custom#profile('source/messages', 'context', {'start_insert' : 0})
  call unite#custom#source('messages', 'syntax', '')
  nnoremap [Unite]M :Unite messages<CR>
endif
"}}}
"*** reanimate *** {{{
" default path to save session file
if !isdirectory(expand($USERCACHEDIR . '/reanimate'))
  call mkdir($USERCACHEDIR . '/reanimate')
endif
let g:reanimate_save_dir = $USERCACHEDIR."/reanimate"

" default session file name
let g:reanimate_default_save_name = ""

" session options
let g:reanimate_sessionoptions="buffers,curdir,folds,globals,help,slash,tabpages,winsize"

call unite#custom#default_action('reanimate', 'reanimate_load')
nnoremap <Space>ur :Unite -auto-resize reanimate<CR>
"}}}
"*** vim-operator-replace *** {{{
nmap <Space>r <Plug>(operator-replace)
xmap <Space>r <Plug>(operator-replace)
"}}}
"}}}
"***** fundamentals ***** {{{
"-------------------------------------------------------------------------
set backup                          " use backup
set swapfile                        " use swap file
set backupdir=$USERCACHEDIR/backup  " assign path to make backup files
let &directory=&backupdir           " assign that path to make swap files is same as that for backup file
set clipboard=unnamed               " share clipboard with OS
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
set wildmenu                        " use extended commandline completion
" set wildmode=longest:full,full      " way to complete in cmdline
set wildignore+=*.o

" always set current directory to the directory of current file
" au vimrc BufEnter * execute ":lcd " . expand("%:p:h")

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

"isolate-tab {{{
" TODO
" unite source... -> found it : buffer_tab
" IsolateTabBuffers command
" Imperfect...

let g:ignore_filename_pattern = ['vimfiler:.*']
let g:ignore_filetype_pattern = ['qf']

function! s:isolate_tab_add(nr, filename)
  " define 't:isolated_buf_list' in new tab
  if !has_key(t:, 'isolated_buf_list')
    let t:isolated_buf_list = []
  endif

  " check ignore pattern
  let matched = 0
  for pattern in g:ignore_filename_pattern
    if a:filename =~# pattern
      let matched = 1
    endif
  endfor

  " add new buffer to 't:isolated_buf_list'
  if matched == 0
    if match(t:isolated_buf_list, a:nr) == -1
      if !buflisted(a:nr)
        call add(t:isolated_buf_list, a:nr)
      endif
    endif
  endif
endfunction

function! s:isolate_tab_delete(nr)
  if has_key(t:, 'isolated_buf_list')
    " delete buffer number from 't:isolated_buf_list'
    let delbuf_idx = match(t:isolated_buf_list, a:nr)
    if delbuf_idx >= 0
      call remove(t:isolated_buf_list, delbuf_idx)
    endif
  endif
endfunction

function! s:isolate_tab_next(...)
  " default displacement is 1
  if a:0 == 0
    let diff = 1
  else
    let diff = a:1
  endif
  " calculate destination buffer number
  let destindex = (match(t:isolated_buf_list, bufnr("%")) + diff) % len(t:isolated_buf_list)
  silent exec 'buffer ' . t:isolated_buf_list[destindex]
endfunction

function! s:isolate_tab_previous(...)
  " default displacement is 1
  if a:0 == 0
    let diff = 1
  else
    let diff = a:1
  endif
  " calculate destination buffer number
  let destindex = (match(t:isolated_buf_list, bufnr("%")) - (diff % len(t:isolated_buf_list)) + len(t:isolated_buf_list)) % len(t:isolated_buf_list)
  silent exec 'buffer ' . t:isolated_buf_list[destindex]
endfunction

function! s:isolate_tab_do(order)
  for buf_num in t:isolated_buf_list
    execute 'buffer' buf_num
    execute a:order
  endfor
endfunction

function! s:isolate_tab_ignore_filetypes()
  for filetype in g:ignore_filetype_pattern
    execute 'au vimrc FileType ' . ' call s:isolate_tab_delete(bufnr("%"))'
  endfor
endfunction

au vimrc BufAdd    * call s:isolate_tab_add(expand("<abuf>"), expand("<afile>"))
au vimrc BufDelete * call s:isolate_tab_delete(expand("<abuf>"))
call s:isolate_tab_ignore_filetypes()

command! -nargs=? IsolateTabNext     call s:isolate_tab_next(<args>)
command! -nargs=? IsolateTabPrevious call s:isolate_tab_previous(<args>)
command! -nargs=1 IsolateTabDo       call s:isolate_tab_do(<args>)
"}}}
" preferable alternate of help command. {{{
function! s:pref_alt_help(...)
  let bang = a:1
  let  arg = a:2
  " Searching for the help window.
  let helptabnr = 0
  let helpwinnr = 0
  for tnr in range(1, tabpagenr('$'))
    for wnr in range(1, tabpagewinnr(tnr, '$'))
      let buftype = gettabwinvar(tnr, wnr, '&buftype')
      if buftype ==# 'help'
        let helptabnr = tnr
        let helpwinnr = wnr
        break
      endif
    endfor
  endfor

  if helptabnr == 0 && helpwinnr == 0
    let width  = winwidth(0)
    let height = winheight(0)
    if width >= 140
      execute 'vert help' . bang . ' ' . arg
    elseif height >= width*3/4
      execute 'help' . bang . ' ' . arg
    else
      execute 'tab help' . bang . ' ' . arg
    endif
  else
    execute 'normal! ' . helptabnr . 'gt'
    execute 'normal! ' . helpwinnr . "\<C-w>w"
    execute 'help' . bang . ' ' . arg
  endif
  normal! 0
endfunction

command! -bang -nargs=? -complete=help Help call s:pref_alt_help('<bang>', <f-args>)
nnoremap <Space>h :Help<Space>
"}}}
"}}}
"***** searching behavior ***** {{{
"--------------------------------------------------------------------------
set hlsearch                        " highlight searched words
set incsearch                       " use incremental search
set ignorecase                      " ignore upper/lower case of searching word
" set smartcase                       " do not ignore upper/lower cases when the searching word contains both of them
set wrapscan                        " go back to the top candidate after getting to the end of file
if has('migemo')
  set migemo                        " use g? sequence of migemo

  if &encoding == 'cp932'
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
set cindent                         " use c style indentation
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

" im control (for win, and partially for *nix)  "{{{
if has('win32') || (has('unix') && &imactivatefunc != '' && &imactivatekey != '')
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
      elseif @" =~ '\n\+'
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
      elseif @" =~ '\n\+'
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

  function! s:im_auto_switch_bootstrap()
    augroup im_auto_switch
      autocmd! * <buffer>
    augroup END

    let lines = join(getline(1, get(g:, 'im_auto_switch_checked_lnum', 30)), '')
    if strlen(lines) != strchars(lines)
      call s:im_auto_switch_start()
    endif
  endfunction

  augroup im_auto_switch
    autocmd!
    autocmd BufRead * autocmd im_auto_switch InsertEnter <buffer> call s:im_auto_switch_bootstrap()
    autocmd SessionLoadPost * autocmd im_auto_switch InsertEnter <buffer> call s:im_auto_switch_bootstrap()
    autocmd SourceCmd ~/.vimrc doautoall im_auto_switch BufRead
  augroup END

  command! IMAutoSwitchStart call s:im_auto_switch_start()
  command! IMAutoSwitchStop  call s:im_auto_switch_stop()
endif
"}}}
"}}}
"***** displaying ***** {{{
"--------------------------------------------------------------------------
set background=light
colorscheme mckn
set cmdheight=1                     " the height of commandline
set cursorline                      " highlight corsor line
set laststatus=2                    " always display status line
set list                            " visualize special characters
set listchars=tab:>-,trail:-,eol:$,nbsp:%,extends:>,precedes:<
                                    " assign alternative expression for special characters
set nonumber                        " do not display row number
set showbreak=-\                    " display the sign for wrapped lines
set showcmd                         " display command information in commandline
set showmode                        " display current mode
set showmatch                       " emphasize correspondent parenthesis
set scrolloff=5                     " vertical scroll margin
set sidescrolloff=10                " horizontal scroll margin
set t_Co=256                        " use 256 coloring in modern terminal emulator
set title                           " display title
set nowrap                          " do not wrap in long line

" highlight cursor line only on active window - http://d.hatena.ne.jp/yuroyoro/searchdiary?word=vim%20
autocmd vimrc WinLeave * set nocursorline
autocmd vimrc WinEnter,BufRead * set cursorline

" tabline
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)

  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label .= '+'
      break
    endif
  endfor

  let activewinnr = tabpagewinnr(v:lnum)
  let activebufnr = bufnr(bufnrlist[activewinnr - 1])
  let label .= activebufnr
  let label .= ' '

  let title = pathshorten(simplify(bufname(bufnrlist[activewinnr - 1])))
  let title = title ==# '' ? '[anonymous]' : title
  return label . title
endfunction
set guitablabel=%{GuiTabLabel()}

" statusline displaying
" copie... inspired from vim-neatstatus
let &statusline =""
" file path
let &statusline .=" %<%F "
" read only, modified, modifiable flags in brackets
let &statusline .="%([%R%M]%) "

" right-align everything past this point
let &statusline .="%= "

" file type (eg. python, ruby, etc..)
let &statusline .="%(| %{&filetype} %)| "
" file format (eg. unix, dos, etc..)
let &statusline .="%{&fileformat} | "
" file encoding (eg. utf8, latin1, etc..)
let &statusline .="%(%{(&fenc!=''?&fenc:&enc)} | %)"
" buffer number
let &statusline .="BUF #%n |"
"}}}
"***** filetype settings ***** {{{
" These settings would be moved to ftplugin/$filetype.vim gradually
"-------------------------------------------------------------------------
"*** AutoHotkey ***
autocmd vimrc FileType autohotkey setlocal dictionary+=$USERDIR/dict/AHK.dict foldmethod=marker commentstring=;%s

"*** scilab ***"
autocmd vimrc FileType scilab setlocal omnifunc=scilabcomplete#Complete

"*** FORTRAN ***"
" autocmd vimrc BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
                              " \| let b:fortran_fold=1
autocmd vimrc BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1

"*** help ***"
autocmd vimrc FileType help if &buftype == 'help' | vertical resize 78 | endif

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
  elseif (&buftype !=# 'help') && exists("s:sidescroll")
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
autocmd vimrc FileType        qf set nowrap
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
      if bufname(nr) == '' && bufexists(nr)
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
"***** key mapping ***** {{{
"--------------------------------------------------------------------------
" do not store a character cut by x,s
nnoremap x "_x
" nnoremap s "_s

" I prefer to use <C-p>/<C-n> when ascending history
cnoremap <C-p> <Up>
cnoremap <Up> <C-p>
cnoremap <C-n> <Down>
cnoremap <Down> <C-n>

" match 'Y' behavior with 'D' : Y = yy -> y$
nnoremap Y y$

" move cursor to the end of selected area after yank
nnoremap gy :set operatorfunc=YankAndJumpToTail<CR>g@
xnoremap gy y`>
xnoremap Y y`>

function! YankAndJumpToTail(motionwise) abort
  let v = a:motionwise ==# 'char' ? 'v'
      \ : a:motionwise ==# 'line' ? 'V'
      \ : "\<C-v>"

  " use o_v, o_V, o_CTRL-v to keep the marks '<, '>
  execute printf('normal! `["%sy%s`]', v:register, v)

  let key_seq = printf(":call setpos('.', %s)\<CR>:echo \<CR>", string(getpos("']")))
  call feedkeys(key_seq, 'n')
endfunction

" line-break without any change to current line in insert mode
" smartinputter no tashinami.
inoremap <C-j> <Esc>o
" inoremap <C-k> <Esc>O

" line-break for upper direction with hanging a following part
" inoremap <S-CR> <Esc>lDO<C-r>*<Esc>I
inoremap <silent> <S-CR> <Esc>:call Linebreak_udhfp()<CR>

""" countermeasure for flickering
function! Linebreak_udhfp()
  if col('.') == col('$') - 1
    call feedkeys('O', 'n')
  else
    let string = getline('.')
    let col    = col('.')
    call setline('.', string[: col - 1])
    execute 'normal! O' . string[col :]
    call feedkeys('I', 'n')
  endif
endfunction

" check syntax group of the character under the cursor
nnoremap \s :echo map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')<CR>

" getting into insert mode after moving cursor
nnoremap <M-i> bi
nnoremap <M-a> ea

" reserve black hole register for the next operator
nnoremap <C-\> "_

" textobject a' and a" is not so convenient
onoremap a' 2i'
xnoremap a' 2i'
onoremap a" 2i"
xnoremap a" 2i"

" Close all the foldings in the buffer
nnoremap z_ ma:silent %normal! zC<CR>'a

" Clear highlight
nnoremap <Space><Space> :nohlsearch<CR>

" wildcard for mulibyte characters of f, t, F, T
noremap <silent> f<CR> :<C-u>call <SID>wildcard_for_multibyte_characers('f')<CR>
noremap <silent> t<CR> :<C-u>call <SID>wildcard_for_multibyte_characers('t')<CR>
noremap <silent> F<CR> :<C-u>call <SID>wildcard_for_multibyte_characers('F')<CR>
noremap <silent> T<CR> :<C-u>call <SID>wildcard_for_multibyte_characers('T')<CR>

function! s:wildcard_for_multibyte_characers(kind) abort
  let flag = a:kind ==# 'F' || a:kind ==# 'T' ? 'b' : ''
  let stopline = line('.')

  for i in range(v:count1)
    if !search('[^\x01-\x7E]', flag, stopline)
      break
    endif
  endfor

  if has('patch-7.4.813')
    let reg = ['"', getreg('"'), getregtype('"')]
    normal! yl
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
    return ''
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
" New NFA regular expression engine does not support the pattern '\%''['.
" FIXME: Which is better to assume inclusive or exclusive?
function! TextobjLastchanged(mode) abort
  let [view, whichwrap, virtualedit] = [winsaveview(), &whichwrap, &virtualedit]
  let [&whichwrap, &virtualedit] = ['h,l', 'onemore']   " I wish someone else wrote yet another syntax/vim.vim.
  try
    let head  = getpos("'[")
    let tail  = getpos("']")
    let empty = [0, 0, 0, 0]
  finally
    let [&whichwrap, &virtualedit] = [whichwrap, virtualedit]
    call winrestview(view)
  endtry

  if head != empty && tail != empty && s:is_ahead(tail, head)
    normal! v
    call setpos('.', head)
    normal! o
    call setpos('.', tail)

    " counter measure for the 'selection' option being 'exclusive'
    if &selection ==# 'exclusive'
      normal! l
    endif
  else
    " re-select the last selected if visual mode
    if a:mode ==# 'x'
      normal! gv
    endif
  endif

  " flash echoing
  echo ''
endfunction

function! s:is_ahead(pos1, pos2) abort
  return a:pos1[1] > a:pos2[1] || (a:pos1[1] == a:pos2[1] && a:pos1[2] > a:pos2[2])
endfunction

nnoremap <silent> gm :<C-u>call TextobjLastchanged('n')<CR>
xnoremap <silent> gm :<C-u>call TextobjLastchanged('x')<CR>
onoremap <silent> gm :<C-u>call TextobjLastchanged('o')<CR>
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
      execute "let @" . target . " = '" . substitute(g:macros[target], "'", "''", 'g') . "'"
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

" simple performance checker
function! Tic()
  let g:hayasa_maruwakari_kun = reltime()
endfunction

function! Toc()
  echom reltimestr(reltime(g:hayasa_maruwakari_kun))
endfunction

function! Time(cmd)
  call Tic()
  execute a:cmd
  call Toc()
endfunction

command! -nargs=0 Tic call Tic()
command! -nargs=0 Toc call Toc()
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

" To avoid E77 with -complete=file
function! YankPathComp(ArgLead, CmdLine, CursorPos) abort
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
"}}}
"***** finalize (rather for reloading .vimrc) ***** {{{
" loading local settings
if filereadable(expand($USERDIR . '/.vimrc.local'))
  source $USERDIR/.vimrc.local
endif

" start syntax highlighting
syntax enable
" to suppress highlighting the last searched word because of 'set hlsearch'
nohlsearch
" recall filetype autocommand
doautocmd FileType
"}}}

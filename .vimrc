" vim:set ts=8 sts=2 sw=2 tw=0:
" vim:set foldcolumn=2:
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" Last Change: 23-Jan-2014.
"
"***** Todo *****
" How to handle count? (v:count, v:count1 ...) in variational commands of 'f' or 't'
" When giving a count over two to vertical f, the cursor moves even if one inputs Esc.
" Make it responsive in visual mode
" improve columnjump
" matlabcomplete, matlabdoc
" color modulation
" alignment operator
" smartinput : ft=vim, <C-r>= <- do not expand this

"***** startup ***** {{{
"-------------------------------------------------------------------------
set shellslash                      " use '/' as a path delimiter

augroup vimrc
  autocmd!
augroup END

if has('win32') || has('win64')
  let $USERDIR=expand('~/vimfiles')
  let $USERCACHEDIR=expand('~/vimcache')
else
  let $USERDIR=expand('~/.vim')
  let $USERCACHEDIR=expand('~/.vimcache')
endif
if !isdirectory(expand($USERDIR))
  call mkdir($USERDIR)
endif
if !isdirectory(expand($USERDIR . '/bundle'))
  call mkdir($USERDIR . '/bundle')
endif
if !isdirectory(expand($USERDIR . '/dict'))
  call mkdir($USERDIR . '/dict')
endif
if !isdirectory(expand($USERDIR . '/spell'))
  call mkdir($USERDIR . '/spell')
endif
if !isdirectory(expand($USERCACHEDIR))
  call mkdir($USERCACHEDIR)
endif
if !isdirectory(expand($USERCACHEDIR.'/backup'))
  call mkdir($USERCACHEDIR . '/backup')
endif
if !isdirectory(expand($USERCACHEDIR.'/.vimundo'))
  call mkdir($USERCACHEDIR . '/.vimundo')
endif
"}}}
"***** plugins *****"{{{
"--------------------------------------------------------------------------
"*** neobundle.vim *** {{{
if has('vim_starting')
  set rtp+=$USERDIR/bundle/neobundle.vim/
end
call neobundle#rc($USERDIR.'/bundle/')

NeoBundle       'davidhalter/jedi-vim'
NeoBundle       'deris/columnjump'
NeoBundle       'gilligan/textobj-lastpaste'
NeoBundle       'junegunn/vim-easy-align'
NeoBundle       'kana/vim-operator-user'
NeoBundle       'kana/vim-operator-replace'
NeoBundle       'kana/vim-smartinput'
NeoBundle       'kana/vim-submode'
NeoBundle       'kana/vim-surround'
NeoBundle       'kana/vim-textobj-user'
NeoBundle       'kana/vim-textobj-indent'
NeoBundle       'kana/vim-textobj-line'
NeoBundle       'kana/vim-textobj-underscore'
NeoBundle       'mattn/learn-vimscript'
NeoBundle       'rhysd/vim-textobj-word-column'
NeoBundle       'sgur/vim-textobj-parameter'
NeoBundleFetch  'Shougo/neobundle.vim'
NeoBundle       'Shougo/unite.vim'
NeoBundle       'Shougo/vimproc.vim'            , {
                \ 'build' : {
                \     'windows' : 'make -f make_mingw64.mak',
                \     'cygwin'  : 'make -f make_cygwin.mak',
                \     'mac'     : 'make -f make_mac.mak',
                \     'unix'    : 'make -f make_unix.mak',
                \    },}
NeoBundle       'tpope/vim-markdown'
NeoBundle       'thinca/vim-prettyprint'
NeoBundle       'thinca/vim-unite-history'  , {'depends' : 'Shougo/unite.vim'}
NeoBundle       'thinca/vim-visualstar'
NeoBundle       'tsukkee/unite-help'        , {'depends' : 'Shougo/unite.vim'}
NeoBundle       'tyru/caw.vim'
NeoBundle       'ujihisa/unite-colorscheme' , {'depends' : 'Shougo/unite.vim'}
NeoBundle       'vim-jp/vimdoc-ja'
NeoBundle       'vim-jp/vital.vim'

NeoBundleLazy   'jceb/vim-hier', {
      \ 'autoload' : {
      \   'commands' : ['HierUpdate', 'HierClear', 'HierStart', 'HierStop'],
      \ }}
NeoBundleLazy   'nathanaelkane/vim-indent-guides', {
      \ 'autoload' : {
      \   'mappings' : '<Plug>IndentGuides',
      \ }}
NeoBundleLazy   'osyo-manga/vim-anzu', {
      \ 'autoload' : {
      \   'mappings' : '<Plug>(anzu-',
      \ }}
NeoBundleLazy   'osyo-manga/vim-owl', {
      \ 'autoload' : {
      \   'commands'  : ['OwlRun', 'OwlCheck'],
      \   'functions' : ['owl#run', 'owl#run_function', 'owl#filename_to_SID'],
      \ },
      \ 'depends' : ['osyo-manga/vim-budou', 'osyo-manga/vim-chained'],
      \ }
NeoBundleLazy   'osyo-manga/vim-reanimate', {
      \ 'autoload' : {
      \   'commands' : ['ReanimateSave', 'ReanimateLoad', 'ReanimateSaveInput',
      \                 'ReanimateLoadInput', 'ReanimateLoadLatest',
      \                 'ReanimateSaveCursorHold', 'ReanimateSwitch',
      \                 'ReanimateEditVimrcLocal', 'ReanimateUnLoad'],
      \ }}
NeoBundleLazy   'osyo-manga/vim-watchdogs', {
      \ 'autoload' : {
      \   'filetypes' : ['python', 'matlab'],
      \ },
      \ 'depends' : ['thinca/vim-quickrun','Shougo/vimproc.vim','osyo-manga/shabadou.vim'],
      \ }
NeoBundleLazy   'rbtnn/vimconsole.vim', {
      \ 'autoload' : {
      \   'commands' : ['VimConsole', 'VimConsoleLog', 'VimConsoleWarn', 'VimConsoleError',
      \                 'VimConsoleOpen', 'VimConsoleClose', 'VimConsoleToggle',
      \                 'VimConsoleCrear', 'VimConsoleRedraw', 'VimConsoleDump'],
      \}}
NeoBundleLazy   'sjl/gundo.vim', {
      \ 'autoload' : {'commands': 'GundoToggle'}
      \ }
NeoBundleLazy   'Shougo/neocomplete', {
      \ 'autoload' : {'insert' : 1},
      \ }
NeoBundleLazy 'Shougo/vimfiler', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimFiler',
      \                   'complete' : 'customlist,vimfiler#complete' },
      \                 'VimFilerExplorer',
      \                 'Edit', 'Read', 'Source', 'Write'],
      \   'mappings' : ['<Plug>(vimfiler_'],
      \   'explorer' : 1,
      \ }}
NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : 'Shougo/vimproc.vim',
      \ 'autoload' : {
      \   'commands' : [{ 'name' : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : ['<Plug>(vimshell_'],
      \ }}
NeoBundleLazy   'thinca/vim-quickrun', {
      \ 'autoload' : {
      \   'mappings' : '<Plug>(quickrun)',
      \   'commands' : 'QuickRun',
      \ }}
" NeoBundleLazy   'thinca/vim-ref'
NeoBundleLazy   'ujihisa/neco-look', {
      \ 'depends' : 'Shougo/neocomplete',
      \ 'autoload' : {
      \   'insert' : 1,
      \ },
      \ 'type' : 'nosync',
      \}

filetype plugin indent on       " Required!
NeoBundleCheck
if !has('vim_starting')
  " Call on_source hook when reloading .vimrc.
  call neobundle#call_hook('on_source')
endif
"}}}
"*** smartinput *** {{{
if neobundle#tap('vim-smartinput')
  " Disable default settings
  call smartinput#clear_rules()

  " I know following description is too lengthy, but otherwise I would be not able to review them...
  " doushite kounatta...
  " chottoshita kyoukiwo kanjiru...

  " NOTE: 'Comment' syntax is somewhat unique, since it is not highlighted only at the end of line.
  "       "oooooooooooooh, wahhoi!
  "       |<-   Comment        ->|#Here is not comment.

  " NOTE: Usually 'String' can not be used for syntax group assignment, but as far as using 'mckn' colorscheme 'String' is available.
  "       Since 'mckn' sets a color directly for 'String' group.
  "       I mean, in case I want to change the colorscheme this settings might not work as I expect.

  " map to trigger
  let trig = [
        \     ['<Plug>(smartinput_BS)', '<Plug>(smartinput_BS)',  '<BS>'],
        \     ['<Plug>(smartinput_CR)', '<Plug>(smartinput_CR)',  '<CR>'],
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
        \     ['<C-k>', '<C-k>', '<C-k>'],
        \    ]

  for item in trig
    call smartinput#map_to_trigger('i', item[0], item[1], item[2])
    call smartinput#map_to_trigger('c', item[0], item[1], item[2])
  endfor
  unlet item

  let rules = []

  " imitate smartchr.vim
  " '<' -> ' < ' -> ' << ' -> '<<' -> '<<<' -> '<<<<' ...
  let rules += [
        \       {'char': '<', 'at': '\%#',     'input': '<',                      'mode': 'i:'},
        \       {'char': '<', 'at': '<\%#',    'input': '<BS> < ',                'mode': 'i:'},
        \       {'char': '<', 'at': ' < \%#',  'input': '<BS>< ',                 'mode': 'i:'},
        \       {'char': '<', 'at': ' << \%#', 'input': '<BS><BS><BS><BS><<',     'mode': 'i:'},
        \       {'char': '<', 'at': '<<\+\%#', 'input': '<',                      'mode': 'i:'},
        \      ]
  " '>' -> ' > ' -> ' >> ' -> '>>' -> '>>>' -> '>>>>' ...
  let rules += [
        \       {'char': '>', 'at': '\%#',     'input': '>',                      'mode': 'i:'},
        \       {'char': '>', 'at': '>\%#',    'input': '<BS> > ',                'mode': 'i:'},
        \       {'char': '>', 'at': ' > \%#',  'input': '<BS>> ',                 'mode': 'i:'},
        \       {'char': '>', 'at': ' >> \%#', 'input': '<BS><BS><BS><BS>>>',     'mode': 'i:'},
        \       {'char': '>', 'at': '>>\+\%#', 'input': '>',                      'mode': 'i:'},
        \      ]
  " '+' -> ' + ' -> '++' -> '+++' -> '++++' ...
  let rules += [
        \       {'char': '+', 'at': '\%#',     'input': '+',                      'mode': 'i:'},
        \       {'char': '+', 'at': '+\%#',    'input': '<BS> + ',                'mode': 'i:'},
        \       {'char': '+', 'at': ' + \%#',  'input': '<BS><BS><BS>++',         'mode': 'i:'},
        \       {'char': '+', 'at': '++\+\%#', 'input': '+',                      'mode': 'i:'},
        \      ]
  " '-' -> ' - ' -> '--' -> '---' -> '----' ...
  let rules += [
        \       {'char': '-', 'at': '\%#',     'input': '-',                      'mode': 'i:'},
        \       {'char': '-', 'at': '-\%#',    'input': '<BS> - ',                'mode': 'i:'},
        \       {'char': '-', 'at': ' - \%#',  'input': '<BS><BS><BS>--',         'mode': 'i:'},
        \       {'char': '-', 'at': '--\+\%#', 'input': '-',                      'mode': 'i:'},
        \      ]
  " '*' -> ' * ' -> ' ** ' -> '**' -> '***' -> '****' ...
  let rules += [
        \       {'char': '*', 'at': '\%#',       'input': '*',                    'mode': 'i:'},
        \       {'char': '*', 'at': '\*\%#',     'input': '<BS> * ',              'mode': 'i:'},
        \       {'char': '*', 'at': ' \* \%#',   'input': '<BS>* ',               'mode': 'i:'},
        \       {'char': '*', 'at': ' \*\* \%#', 'input': '<BS><BS><BS><BS>**',   'mode': 'i:'},
        \       {'char': '*', 'at': '\*\*\+\%#', 'input': '*',                    'mode': 'i:'},
        \      ]
  " '/' -> ' / ' -> '//' -> '///' -> '////' ...
  let rules += [
        \       {'char': '/', 'at': '\%#',     'input': '/',                      'mode': 'i:'},
        \       {'char': '/', 'at': '/\%#',    'input': '<BS> / ',                'mode': 'i:'},
        \       {'char': '/', 'at': ' / \%#',  'input': '<BS><BS><BS>//',         'mode': 'i:'},
        \       {'char': '/', 'at': '//\+\%#', 'input': '/',                      'mode': 'i:'},
        \      ]
  " '%' -> ' % ' -> '%%' -> '%%%' -> '%%%%' ...
  let rules += [
        \       {'char': '%', 'at': '\%#',     'input': '%',                      'mode': 'i:'},
        \       {'char': '%', 'at': '%\%#',    'input': '<BS> % ',                'mode': 'i:'},
        \       {'char': '%', 'at': ' % \%#',  'input': '<BS><BS><BS>%%',         'mode': 'i:'},
        \       {'char': '%', 'at': '%%\+\%#', 'input': '%',                      'mode': 'i:'},
        \      ]
  " '&' -> ' && ' -> '&&' -> '&&&' -> '&&&&' ...
  let rules += [
        \       {'char': '&', 'at': '\%#',     'input': '&',                      'mode': 'i:'},
        \       {'char': '&', 'at': '&\%#',    'input': '<BS> && ',               'mode': 'i:'},
        \       {'char': '&', 'at': ' && \%#', 'input': '<BS><BS><BS><BS>&&',     'mode': 'i:'},
        \       {'char': '&', 'at': '&&\+\%#', 'input': '&',                      'mode': 'i:'},
        \      ]
  " '|' -> ' || ' -> '||' -> '|||' -> '||||' ...
  let rules += [
        \       {'char': '<Bar>', 'at': '\%#',     'input': '|',                  'mode': 'i:'},
        \       {'char': '<Bar>', 'at': '|\%#',    'input': '<BS> || ',           'mode': 'i:'},
        \       {'char': '<Bar>', 'at': ' || \%#', 'input': '<BS><BS><BS><BS>||', 'mode': 'i:'},
        \       {'char': '<Bar>', 'at': '||\+\%#', 'input': '|',                  'mode': 'i:'},
        \      ]

  " do not apply on 'Comment' or 'String' syntax
  let rules += [
        \       {'char': '<',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '<'},
        \       {'char': '>',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '>'},
        \       {'char': '+',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+'},
        \       {'char': '-',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-'},
        \       {'char': '*',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '*'},
        \       {'char': '/',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '/'},
        \       {'char': '%',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '%'},
        \       {'char': '&',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '&'},
        \       {'char': '<Bar>', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '<Bar>'},
        \      ]

  " smart '=' input
  " ' = ' -> ' == ' -> '=' -> '==' ...
  let rules += [
        \       {'char': '=', 'at': '\%#',     'input': ' = ',                    'mode': 'i:'},
        \       {'char': '=', 'at': ' = \%#',  'input': '<BS>= ',                 'mode': 'i:'},
        \       {'char': '=', 'at': ' == \%#', 'input': '<BS><BS><BS><BS>=',      'mode': 'i:'},
        \       {'char': '=', 'at': '=\%#',    'input': '=',                      'mode': 'i:'},
        \      ]

  let rules += [
        \       {'char': '=', 'at': '\%# = ',         'input': '<Del><Right><Del><Left>=',                  'mode': 'i:'},
        \       {'char': '=', 'at': ' \%#',           'input': '= ',                                        'mode': 'i:'},
        \       {'char': '=', 'at': '\S\%# ',         'input': ' =<Right>',                                 'mode': 'i:'},
        \       {'char': '=', 'at': ' \%# ',          'input': '=<Right>',                                  'mode': 'i:'},
        \       {'char': '=', 'at': '[-+<>~!] \%#',   'input': '<BS>= ',                                    'mode': 'i:'},
        \       {'char': '=', 'at': ' [-+<>~!]\%#\S', 'input': '= ',                                        'mode': 'i:'},
        \       {'char': '=', 'at': ' [-+<>~!]\%#$',  'input': '= ',                                        'mode': 'i:'},
        \       {'char': '=', 'at': ' [-+<>~!]\%# ',  'input': '=',                                         'mode': 'i:'},
        \       {'char': '=', 'at': '\S[-+<>~!]\%#',  'input': '<Left> <Right>= ',                          'mode': 'i:'},
        \       {'char': '=', 'at': ' [-+<>~!]= \%#', 'input': '<Left><Left><Left><BS><Right><Right><Del>', 'mode': 'i:'},
        \       {'char': '=', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '=',                   'mode': 'i:'},
        \      ]

  " smart '<CR>' input
  let rules += [
        \       {'char': '<Plug>(smartinput_CR)', 'at': '(\%#)',     'input': '<CR><Enter><Up><Esc>"_S'},
        \       {'char': '<Plug>(smartinput_CR)', 'at': '{\%#}',     'input': '<CR><CR><Up><Esc>"_S'},
        \      ]
  " delete line end spaces when line-breaking
  let rules += [{'char': '<Plug>(smartinput_CR)', 'at': '\S\s\+\%#', 'input': '<CR><C-o>:call setline(line(''.'')-1, substitute(getline(line(''.'')-1), ''\s\+$'', '''', ''''))<CR>'}]

  " smart quotes input
  let rules += [
        \       {'char': '''', 'at': '\%#',     'input': '''''<Left>', 'mode': 'i:'},
        \       {'char': '''', 'at': '''''\%#', 'input': '''''<Left>', 'mode': 'i:'},
        \       {'char': '''', 'at': '\\\%#',   'input': '''',         'mode': 'i:'},
        \       {'char':  '"', 'at': '\%#',     'input': '""<Left>',   'mode': 'i:'},
        \       {'char':  '"', 'at': '""\%#',   'input': '""""<Left>', 'mode': 'i:'},
        \       {'char':  '"', 'at': '\\\%#',   'input': '"',          'mode': 'i:'},
        \       {'char': '''', 'at': '\w\%#',   'input': '''',         'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*\%(\W\&[^"]\)"[^"]*\%#',           'input': '""',       'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*\%(\W\&[^"]\)"[^"]*\%#"',          'input': '<Right>',  'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*\%(\W\&[^'']\)''[^'']*\%#',   'input': '''''',     'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*\%(\W\&[^'']\)''[^'']*\%#''', 'input': '<Right>',  'mode': 'i:'},
        \      ]

  " correspondent parentheses
  let rules += [
        \       {'char': '(',    'at': '\%#',       'input': '()<Left>',                                           'mode': 'i:'},
        \       {'char': ')',    'at': '\%#\_s*)',  'input': '<C-r>=smartinput#_leave_block('')'')<Enter><Right>', 'mode': 'i:'},
        \       {'char': '(',    'at': '\\\%#',     'input': '(',                                                  'mode': 'i:'},
        \       {'char': '[',    'at': '\%#',       'input': '[]<Left>',                                           'mode': 'i:'},
        \       {'char': ']',    'at': '\%#\_s*\]', 'input': '<C-r>=smartinput#_leave_block('']'')<Enter><Right>', 'mode': 'i:'},
        \       {'char': '[',    'at': '\\\%#',     'input': '[',                                                  'mode': 'i:'},
        \       {'char': '{',    'at': '\%#',       'input': '{}<Left>',                                           'mode': 'i:'},
        \       {'char': '}',    'at': '\%#\_s*}',  'input': '<C-r>=smartinput#_leave_block(''}'')<Enter><Right>', 'mode': 'i:'},
        \       {'char': '{',    'at': '\\\%#',     'input': '{',                                                  'mode': 'i:'},
        \      ]

  " delete correspondent parentheses and quotes
  let rules += [
        \       {'char': '<Plug>(smartinput_BS)', 'at': '(\%#)',      'input': '<BS><Del>',       'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '()\%#',      'input': '<BS><BS>',        'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\[\%#\]',    'input': '<BS><Del>',       'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\[\]\%#',    'input': '<BS><BS>',        'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '{\%#}',      'input': '<BS><Del>',       'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '{}\%#',      'input': '<BS><BS>',        'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '''\%#''',    'input': '<BS><Del>',       'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '''''\%#',    'input': '<BS><BS>',        'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '''''\%#''',  'input': '<BS><BS>',        'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '"\%#"',      'input': '<BS><Del>',       'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '""\%#',      'input': '<BS><BS>',        'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '""\%#"',     'input': '<BS><BS>',        'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '()\%#',      'input': '<BS><BS>',        'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '{}\%#',      'input': '<BS><BS>',        'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '<>\%#',      'input': '<BS><BS>',        'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\[\]\%#',    'input': '<BS><BS>',        'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '''''\%#',    'input': '<BS><BS>',        'mode': ':'},
        \      ]

  " Delete operaters together with vicinal spaces
  let rules += [
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' < \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' > \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' + \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' - \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' / \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' & \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' % \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' \* \%#',  'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' = \%#',   'input': '<BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' == \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' != \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' \~= \%#', 'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <> \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <= \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >= \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' += \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' -= \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' && \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' || \%#',  'input': '<BS><BS><BS><BS>', 'mode': 'i:'},
        \      ]

  " miscellaneous settings
  let rules += [
        \       {'char': '>', 'at': ' < \%#', 'input': '<BS>> ', 'mode': 'i:'},
        \       {'char': ',', 'at': '\%#',    'input': ', ',     'mode': 'i:'},
        \       {'char': ',', 'at': ', \%#',  'input': '<BS>',   'mode': 'i:'},
        \       {'char': ',', 'at': '\%# ',   'input': ',',      'mode': 'i:'},
        \      ]

  " for commandline mode
  " '|' is cursor. The character inside the -[]-> means keypress.
  " = | -[~]-> =~ | -[?]-> =~? |
  " ...and something like above.
  let rules += [
        \       {'char': '"', 'at': '^\s*\%#', 'input': '" ',     'mode': ':'},
        \       {'char': '~', 'at': '= \%#',   'input': '<BS>~ ', 'mode': ':'},
        \       {'char': '#', 'at': '== \%#',  'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '== \%#',  'input': '<BS>? ', 'mode': ':'},
        \       {'char': '#', 'at': '!= \%#',  'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '!= \%#',  'input': '<BS>? ', 'mode': ':'},
        \       {'char': '#', 'at': '> \%#',   'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '> \%#',   'input': '<BS>? ', 'mode': ':'},
        \       {'char': '#', 'at': '>= \%#',  'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '>= \%#',  'input': '<BS>? ', 'mode': ':'},
        \       {'char': '#', 'at': '< \%#',   'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '< \%#',   'input': '<BS>? ', 'mode': ':'},
        \       {'char': '#', 'at': '<= \%#',  'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '<= \%#',  'input': '<BS>? ', 'mode': ':'},
        \       {'char': '#', 'at': '=\~ \%#', 'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '=\~ \%#', 'input': '<BS>? ', 'mode': ':'},
        \       {'char': '#', 'at': '!\~ \%#', 'input': '<BS># ', 'mode': ':'},
        \       {'char': '?', 'at': '!\~ \%#', 'input': '<BS>? ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ==# \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ==? \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !=# \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !=? \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ># \%#',   'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >? \%#',   'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >=# \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >=? \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <# \%#',   'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <? \%#',   'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <=# \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <=? \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~ \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~# \%#', 'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~? \%#', 'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~ \%#',  'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~# \%#', 'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~? \%#', 'input': '<BS><BS> ', 'mode': ':'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '"\s\%#',    'input': '<BS><BS>',  'mode': ':'},
        \      ]

  " for regular expression
  " '#' is cursor. The character inside the -[]-> means keypress.
  " (#  -  [(]  -> ((#
  "     -[<C-k>]-> \%(#\) -[<C-k>]-> \(#\) -[<C-k>]-> \%(#\)

  let rules += [
        \       {'char': ')',     'at': '\%#\\)',     'input': '<Right><Right>',        'mode': '/?'},
        \       {'char': ']',     'at': '\%#\\\]',    'input': '<Right><Right>',        'mode': '/?'},
        \       {'char': '<C-k>', 'at': '(\%#',       'input': '<BS>\%(\)<Left><Left>', 'mode': '/?'},
        \       {'char': '<C-k>', 'at': '\\%(\%#\\)', 'input': '<Left><BS><Right>',     'mode': '/?'},
        \       {'char': '<C-k>', 'at': '\\(\%#\\)',  'input': '<Left>%<Right>',        'mode': '/?'},
        \       {'char': '<C-k>', 'at': '\\)\%#',     'input': '<Left><Left>)',         'mode': '/?'},
        \       {'char': '<C-k>', 'at': '\[\%#',      'input': '<BS>\[\]<Left><Left>',  'mode': '/?'},
        \       {'char': '<C-k>', 'at': '\\]\%#',     'input': '<Left><Left>]',         'mode': '/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\\%(\%#\\)',  'input': '<BS><BS><BS><Del><Del>', 'mode': '/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\\(\%#\\)',   'input': '<BS><BS><Del><Del>',     'mode': '/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\\\[\%#\\\]', 'input': '<BS><BS><Del><Del>',     'mode': '/?'},
        \      ]

  " filetype option

  " vim
  let rules += [
        \       {'char': '"', 'at': '^\s*\%#', 'input': '" ',     'filetype': ['vim']},
        \       {'char': '~', 'at': '= \%#',   'input': '<BS>~ ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '== \%#',  'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '== \%#',  'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '!= \%#',  'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '!= \%#',  'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '> \%#',   'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '> \%#',   'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '>= \%#',  'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '>= \%#',  'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '< \%#',   'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '< \%#',   'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '<= \%#',  'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '<= \%#',  'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '=\~ \%#', 'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '=\~ \%#', 'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '#', 'at': '!\~ \%#', 'input': '<BS># ', 'filetype': ['vim']},
        \       {'char': '?', 'at': '!\~ \%#', 'input': '<BS>? ', 'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ==# \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ==? \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !=# \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !=? \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ># \%#',   'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >? \%#',   'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >=# \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >=? \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <# \%#',   'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <? \%#',   'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <=# \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <=? \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~ \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~# \%#', 'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~? \%#', 'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~ \%#',  'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~# \%#', 'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~? \%#', 'input': '<BS><BS> ',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '"\s\%#',    'input': '<BS><BS>',      'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' \. \%#',   'input': '<BS><BS><BS>',  'filetype': ['vim']},
        \       {'char': '=', 'at': '\. \%#',   'input': '<BS>= ',                                    'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.\%#\S', 'input': '= ',                                        'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.\%#$',  'input': '= ',                                        'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.\%# ',  'input': '=',                                         'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': '\S\.\%#',  'input': '<Left> <Right>= ',                          'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.= \%#', 'input': '<Left><Left><Left><BS><Right><Right><Del>', 'mode': 'i:', 'filetype': ['vim']},
        \      ]
  " '.' -> ' . ' -> '..' -> '...'
  let rules += [
        \       {'char': '.', 'at': '\%#',       'input': '.',              'filetype': ['vim']},
        \       {'char': '.', 'at': '\.\%#',     'input': '<BS> . ',        'filetype': ['vim']},
        \       {'char': '.', 'at': ' \. \%#',   'input': '<BS><BS><BS>..', 'filetype': ['vim']},
        \       {'char': '.', 'at': '\.\.\%#',   'input': '.',              'filetype': ['vim']},
        \       ]
  " if the cursor is inside a single quote string literal
  let rules += [
        \       {'char': '(', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*(\%#)',             'input': '<BS>\%(\)<Left><Left>',  'mode': '/?'},
        \       {'char': '(', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\%(\%#\\)',        'input': '<Left><BS><Right>',      'mode': '/?'},
        \       {'char': '(', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\%(\\\%#\\)',      'input': '<BS>(',                  'mode': '/?'},
        \       {'char': '(', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\(\%#\\)',         'input': '<Del><Left><BS><Right>', 'mode': '/?'},
        \       {'char': '(', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\(\\\%#\\)',       'input': '<BS>(',                  'mode': '/?'},
        \       {'char': '(', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*[^(](\%#)',         'input': '(',                      'mode': '/?'},
        \       {'char': ')', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\%#\\)',            'input': '<Right><Right>',         'mode': '/?'},
        \       {'char': ')', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\))\%#',           'input': '\)',                     'mode': '/?'},
        \       {'char': '[', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\[\%#\]',      'input': '<BS>\[\<Left>',     'filetype': ['vim']},
        \       {'char': ']', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\%#\\\]',      'input': '<Right><Right>',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\(\%#\\)',   'input': '<BS><BS><Del><Del>',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\%(\%#\\)',  'input': '<BS><BS><BS><Del><Del>', 'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\\\[\%#\\\]', 'input': '<BS><BS><Del><Del>',     'filetype': ['vim']},
        \      ]

  " matlab
  let rules += [
        \       {'char': '%', 'at': '^\s*\%#',     'input': '% ',      'filetype': ['matlab']},
        \       {'char': '%', 'at': '^\s*%\+ \%#', 'input': '<BS>%% ', 'filetype': ['matlab']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '^\s*%\s\%#',         'input': '<BS><BS>',      'filetype': ['matlab']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '^\s*\(%%\)\+%\s\%#', 'input': '<BS><BS><BS> ', 'filetype': ['matlab']},
        \      ]

  " scilab
  let rules += [
        \       {'char': '/', 'at': '^\s*\%#',          'input': '// ',     'filetype': ['scilab']},
        \       {'char': '/', 'at': '^\s*\(//\)\+ \%#', 'input': '<BS>// ', 'filetype': ['scilab']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '^\s*//\s\%#',         'input': '<BS><BS><BS>',  'filetype': ['scilab']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '^\s*//\(//\)\+\s\%#', 'input': '<BS><BS><BS> ', 'filetype': ['scilab']},
        \      ]

  " common in matlab and scilab
  " ' + ' -> '+' -> '++' -> '+++' ...
  let rules += [
        \       {'char': '+', 'at': '\%#',    'input': ' + ',           'filetype': ['matlab', 'scilab']},
        \       {'char': '+', 'at': ' + \%#', 'input': '<BS><BS><BS>+', 'filetype': ['matlab', 'scilab']},
        \       {'char': '+', 'at': '+\%#',   'input': '+',             'filetype': ['matlab', 'scilab']},
        \      ]
  " ' - ' -> '-' -> '--' -> '---' ...
  let rules += [
        \       {'char': '-', 'at': '\%#',    'input': ' - ',           'filetype': ['matlab', 'scilab']},
        \       {'char': '-', 'at': ' - \%#', 'input': '<BS><BS><BS>-', 'filetype': ['matlab', 'scilab']},
        \       {'char': '-', 'at': '-\%#',   'input': '-',             'filetype': ['matlab', 'scilab']},
        \      ]
  " '.^' -> '^' -> '^^' -> '^^^' ...
  let rules += [
        \       {'char': '^', 'at': '\%#',    'input': '.^',        'filetype': ['matlab', 'scilab']},
        \       {'char': '^', 'at': '\.^\%#', 'input': '<BS><BS>^', 'filetype': ['matlab', 'scilab']},
        \       {'char': '^', 'at': '\^\%#',  'input': '^',         'filetype': ['matlab', 'scilab']},
        \      ]
  " '.*' -> '*' -> '**' -> '***' ...
  let rules += [
        \       {'char': '*', 'at': '\%#',     'input': '.*',        'filetype': ['matlab', 'scilab']},
        \       {'char': '*', 'at': '\.\*\%#', 'input': '<BS><BS>*', 'filetype': ['matlab', 'scilab']},
        \       {'char': '*', 'at': '\*\%#',   'input': '*',         'filetype': ['matlab', 'scilab']},
        \      ]
  " './' -> '/' -> '//' -> '///' ...
  let rules += [
        \       {'char': '/', 'at': '\%#',    'input': './',        'filetype': ['matlab', 'scilab']},
        \       {'char': '/', 'at': '\./\%#', 'input': '<BS><BS>/', 'filetype': ['matlab', 'scilab']},
        \       {'char': '/', 'at': '/\%#',   'input': '/',         'filetype': ['matlab', 'scilab']},
        \      ]

  let rules += [
        \       {'char': '+', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+', 'filetype': ['matlab', 'scilab']},
        \       {'char': '-', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-', 'filetype': ['matlab', 'scilab']},
        \       {'char': '^', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '^', 'filetype': ['matlab', 'scilab']},
        \       {'char': '*', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '*', 'filetype': ['matlab', 'scilab']},
        \       {'char': '/', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '/', 'filetype': ['matlab', 'scilab']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\.[*/^]\%#', 'input': '<BS><BS>', 'filetype': ['matlab', 'scilab']},
        \      ]

  " FORTRAN
  let rules += [
        \       {'char': ':', 'at': '^\s*\(integer\|real\|double precision\|complex\|complex(kind(0d0))\|logical\|character\|type(\w\+)\)\((,\w\+)\)*\%#', 'input': ' :: ', 'filetype': ['fortran']},
        \       {'char': ':', 'at': ' :: \%#', 'input': '<BS><BS><BS><BS>:', 'filetype': ['fortran']},
        \      ]

  " R
  " ' <- ' -> ' < ' -> '<' -> '<<' -> '<<<' ...
  let rules += [
        \       {'char': '<', 'at': '\%#',     'input': ' <- ',          'filetype': ['r']},
        \       {'char': '<', 'at': ' <- \%#', 'input': '<BS><BS> ',     'filetype': ['r']},
        \       {'char': '<', 'at': ' < \%#',  'input': '<BS><BS><BS><', 'filetype': ['r']},
        \       {'char': '<', 'at': '<\%#',    'input': '<',             'filetype': ['r']},
        \      ]
  " ' > ' -> '>' -> ' -> ' -> '>>' -> '>>>' ...
  let rules += [
        \       {'char': '>', 'at': '\%#',     'input': ' > ',                'filetype': ['r']},
        \       {'char': '>', 'at': ' > \%#',  'input': '<BS><BS><BS>>',      'filetype': ['r']},
        \       {'char': '>', 'at': '>\%#',    'input': '<BS> -> ',           'filetype': ['r']},
        \       {'char': '>', 'at': ' -> \%#', 'input': '<BS><BS><BS><BS>>>', 'filetype': ['r']},
        \       {'char': '>', 'at': '>>\+\%#', 'input': '>',                  'filetype': ['r']},
        \      ]

  let rules += [
        \       {'char': '-',    'at': '< \%#',   'input': '<BS>- ',           'filetype': ['r']},
        \       {'char': '>',    'at': '- \%#',   'input': '<BS>> ',           'filetype': ['r']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <- \%#', 'input': '<BS><BS><BS><BS>', 'filetype': ['r']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' -> \%#', 'input': '<BS><BS><BS><BS>', 'filetype': ['r']},
        \      ]

  " python
  let rules += [{'char': '<Plug>(smartinput_BS)', 'at': '#\s\%#', 'input': '<BS><BS>', 'filetype': ['python']}]

  " c
  let rules += [{'char': '<Plug>(smartinput_BS)', 'at': '//\s\%#', 'input': '<BS><BS><BS>', 'filetype': ['c']}]
  " ' + ' -> '++' -> '+' -> '+++' -> '++++' ...
  let rules += [
        \       {'char': '+', 'at': '\%#',      'input': ' + ',            'filetype': ['c']},
        \       {'char': '+', 'at': ' + \%#',   'input': '<BS><BS><BS>++', 'filetype': ['c']},
        \       {'char': '+', 'at': '++\%#',    'input': '<BS>',           'filetype': ['c']},
        \       {'char': '+', 'at': '+\%#',     'input': '++',             'filetype': ['c']},
        \       {'char': '+', 'at': '+++\+\%#', 'input': '+',              'filetype': ['c']},
        \      ]
  " ' - ' -> '--' -> '-' -> '---' -> '----' ...
  let rules += [
        \       {'char': '-', 'at': '\%#',    'input': ' - ',            'filetype': ['c']},
        \       {'char': '-', 'at': ' - \%#', 'input': '<BS><BS><BS>--', 'filetype': ['c']},
        \       {'char': '-', 'at': '--\%#',  'input': '<BS>',           'filetype': ['c']},
        \       {'char': '-', 'at': '-\%#',   'input': '--',             'filetype': ['c']},
        \       {'char': '-', 'at': '---\+\%#', 'input': '-',            'filetype': ['c']},
        \      ]
  " ' * ' -> '*' -> ' *' -> '**' -> '***'
  let rules += [
        \       {'char': '*', 'at': '\%#',       'input': ' * ',           'filetype': ['c']},
        \       {'char': '*', 'at': ' \* \%#',   'input': '<BS><BS><BS>*', 'filetype': ['c']},
        \       {'char': '*', 'at': '\*\%#',     'input': '<BS> *',        'filetype': ['c']},
        \       {'char': '*', 'at': ' \*\%#',    'input': '<BS><BS>**',    'filetype': ['c']},
        \       {'char': '*', 'at': '\*\*\+\%#', 'input': '*',             'filetype': ['c']},
        \      ]
  " ' / ' -> '// ' -> '/' -> '//' -> '///'
  let rules += [
        \       {'char': '/', 'at': '\%#',    'input': ' / ',             'filetype': ['c']},
        \       {'char': '/', 'at': ' / \%#', 'input': '<BS><BS><BS>// ', 'filetype': ['c']},
        \       {'char': '/', 'at': '// \%#', 'input': '<BS><BS>',        'filetype': ['c']},
        \       {'char': '/', 'at': '/\%#',   'input': '/',               'filetype': ['c']},
        \       {'char': '+', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+', 'filetype': ['c']},
        \       {'char': '-', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-', 'filetype': ['c']},
        \       {'char': '*', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '*', 'filetype': ['c']},
        \       {'char': '/', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '/', 'filetype': ['c']},
        \      ]

  for item in rules
    call smartinput#define_rule(item)
  endfor
  unlet item

  cmap <BS> <Plug>(smartinput_BS)
endif
"}}}
" *** anzu.vim *** {{{
if neobundle#tap('vim-anzu')
  " mapping
  nmap n <Plug>(anzu-n-with-echo)
  nmap N <Plug>(anzu-N-with-echo)
  nmap * <Plug>(anzu-star-with-echo)
  nmap # <Plug>(anzu-sharp-with-echo)

  " clear status
  " nmap <Esc><Esc> <Plug>(anzu-clear-search-status)
endif
"}}}
"*** caw.vim *** {{{
if neobundle#tap('caw.vim')
  nmap <Space>c <Plug>(caw:I:toggle)
  vmap <Space>c <Plug>(caw:I:toggle)
endif
"}}}
"*** columnjump *** {{{
if neobundle#tap('columnjump')
  nmap \b <Plug>(columnjump-backward)
  nmap \w <Plug>(columnjump-forward)
endif
"}}}
"*** easy-align *** {{{
if neobundle#tap('vim-easy-align')
  " Start interactive EasyAlign in visual mode
  vmap <Enter> <Plug>(EasyAlign)

  " Start interactive EasyAlign with a Vim movement
  nmap <Leader>a <Plug>(EasyAlign)
endif
"}}}
"*** indent_guides.vim *** {{{
if neobundle#tap('vim-indent-guides')
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_guide_size = 1
  let g:indent_guides_auto_colors = 1
  let g:indent_guides_default_mapping = 0
  let g:indent_guides_exclude_filetypes = ['help']
  nmap <silent> <Space>i <Plug>IndentGuidesToggle
endif
"}}}
"*** neocomplete.vim *** {{{
if neobundle#tap('neocomplete')
  " Use neocomplete.
  let g:neocomplete#enable_at_startup = 1
  " Use smartcase.
  let g:neocomplete#enable_smart_case = 1
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

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=jedi#completions
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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
    \ ['converter_remove_next_keyword', 'converter_remove_last_paren',
    \  'converter_delimiter', 'converter_case', 'converter_abbr'])

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    imap <silent> <expr><CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"
    " <TAB>: completion.
    " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    imap <expr><C-h> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
    imap <expr><BS> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Plugin key-mappings.
    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()
  endfunction
  unlet bundle
endif
"}}}
"*** neosnippet.vim *** {{{
" if neobundle#tap('neosnippet')
"   imap <C-k> <Plug>(neosnippet_expand_or_jump)
"   smap <C-k> <Plug>(neosnippet_expand_or_jump)
"
"   " Tell Neosnippet about the other snippets
"   let g:neosnippet#snippets_directory = $USERDIR . '/snippets'
"
"   " For snippet_complete marker.
"   if has('conceal')
"     set conceallevel=2 concealcursor=i
"   endif
" endif
"}}}
"*** quickrun.vim *** {{{
if neobundle#tap('vim-quickrun')
  let g:quickrun_config = {}
  let g:quickrun_config = {
        \ '_' : {
        \       'runner' : 'vimproc',
        \       'runner/vimproc/updatetime' : 100,
        \       'hook/time/enable' : 1,
        \       },
        \ 'maxima' : {
        \       'command': 'maxima',
        \       'cmdopt': '-q -b',
        \       'runner': 'process_manager',
        \       'runner/process_manager/load': has('win32') || has('win64') ? &shellslash ? 'batch("%S:gs?/?\\\\\\\\\\?");' : 'batch(%s:gs?\\?\\\\\\\\);' : 'batch(%s)',
        \       'runner/process_manager/prompt': '(%[io]\d\+)'
        \       },
        \ 'markdown' : {
        \       'outputter': 'browser',
        \       'hook/time/enable' : 0,
        \       },
        \ 'tex' : {
        \       'command' : 'platex',
        \       },
        \ 'scilab'  : {
        \       'command': has('win32') || has('win64') ? 'scilex' : 'scilab-adv-cli',
        \       'cmdopt': '-l en -nb -nw -f',
        \       'runner': 'process_manager',
        \       'runner/process_manager/load': 'exec(%s,-1)',
        \       'runner/process_manager/prompt': '-->',
        \       'hook/output_encode/encoding' : has('win32') || has('win64') ? 'utf-8:cp932' : '&fileencoding',
        \       'hook/eval/enable': 1,
        \       'hook/eval/template': "%s\nmfprintf(6, '-->')",
        \       },
        \ 'r'   : {
        \       'command': has('win32') || has('win64') ? 'Rscript' : 'R',
        \       'exec': has('win32') || has('win64') ? '%c %o --no-save --slave %a %s' : 'sh -c ''%c %o --no-save --slave %a < %s''',
        \       }
        \ }
endif
"}}}
"*** submode.vim *** {{{
if neobundle#tap('vim-submode')
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
  " vertical cursor hopping
  call submode#enter_with('columnjump', 'n', 'r', '\w', '<Plug>(columnjump-forward)')
  call submode#enter_with('columnjump', 'n', 'r', '\b', '<Plug>(columnjump-backward)')
  call submode#map('columnjump', 'n', 'r', 'w', '<Plug>(columnjump-forward)')
  call submode#map('columnjump', 'n', 'r', 'b', '<Plug>(columnjump-backward)')
endif
"}}}
"*** textobj-lastpaste *** {{{
let g:textobj_comment_no_default_key_mappings = 1
call textobj#user#plugin('lastpaste', {
      \ '-': {
      \     'select-i': 'iP', '*select-i-function*': 'textobj#lastpaste#select_i',
      \ },
      \})
"}}}
"*** unite.vim *** {{{
if neobundle#tap('unite.vim')
  nnoremap [Unite] <Nop>
  nmap     <Space>u [Unite]
  nnoremap [Unite]u :Unite<Space>
  nnoremap [Unite]c :Unite history/command command<CR>
  nnoremap [Unite]y :Unite history/yank command<CR>
  nnoremap [Unite]m :Unite file_mru<CR>
  nnoremap [Unite]b :Unite buffer_tab<CR>
  nnoremap [Unite]h :Unite help:ja help<CR>
  nnoremap [Unite]d :Unite directory_mru directory directory/new<CR>
  nnoremap [Unite]p :Unite neobundle/update<CR>

  if has('win32') || has('win64')
    nnoremap <Space>uf :Unite file_rec buffer<CR>
  else
    nnoremap <Space>uf :Unite file_rec/async buffer<CR>
  endif

  let g:unite_enable_start_insert = 1
  let g:unite_enable_ignore_case = 1
  let g:unite_data_directory = $USERCACHEDIR . '/.unite'
  let g:unite_split_rule = "botright"
  let g:unite_source_history_yank_enable = 1

  " tiny optimizations
  call unite#custom#default_action('directory',     'lcd')
  call unite#custom#default_action('directory_mru', 'lcd')
  call unite#custom#source('file_mru', 'ignore_pattern', '\f*[\/]doc[\/]\f\+\.\(jax\|txt\)')

  " last ':messages'
  " http://d.hatena.ne.jp/osyo-manga/20131030/1383144724
  let g:unite_source_alias_aliases = {'messages' : {'source': 'output', 'args': 'message'}}
  call unite#custom#source('messages', 'sorters', 'sorter_reverse')
  call unite#custom#default_action('messages', 'yank')
  call unite#custom#profile('source/messages', 'context', {'start_insert' : 0})
  nnoremap [Unite]M :Unite messages<CR>
endif
"}}}
"*** reanimate *** {{{
if neobundle#tap('vim-reanimate')
  " default path to save session file
  if !isdirectory(expand($USERCACHEDIR . '/reanimate'))
    call mkdir($USERCACHEDIR . '/reanimate')
  endif
  let g:reanimate_save_dir = $USERCACHEDIR."/reanimate"

  " default session file name
  let g:reanimate_default_save_name = ""

  " session options
  let g:reanimate_sessionoptions="curdir,folds,globals,help,localoptions,slash,tabpages,winsize"

  call unite#custom#default_action('reanimate', 'reanimate_load')
  nnoremap <Space>ur :Unite reanimate<CR>
endif
"}}}
"*** ref.vim *** {{{
" if neobundle#tap('vim-ref')
"   let g:ref_cache_dir = $USERCACHEDIR . '/.ref'
"   let g:ref_pydoc_cmd = 'pydoc'
"   let g:ref_source_webdict_cmd = 'lynx -cfg "C:\Program Files (x86)\Lynx for Win32\lynx.cfg" -dump %s'
" endif
"}}}
"*** vim-operator-replace *** {{{
if neobundle#tap('vim-operator-replace')
  map _ <Plug>(operator-replace)
endif
"}}}
"*** vimshell.vim *** {{{
if neobundle#tap('vimshell')
  nnoremap <Space>s :VimShellPop -toggle<CR>
  nnoremap <Space>S :VimShellTab<CR>

  let g:vimshell_user_prompt = 'fnamemodify(getcwd(), ":~")'
  let g:vimshell_enable_smart_case = 1
  let g:vimshell_temporary_directory = $USERCACHEDIR . '/.vimshell'
  let g:vimshell_interactive_update_time = 500
  highlight link vimshellUserPrompt Function

  if has('win32') || has('win64')
    " Display user name on Windows.
    let g:vimshell_prompt = $USERNAME."% "
  else
    " Display user name on Linux.
    let g:vimshell_prompt = $USER."% "
  endif

  autocmd vimrc FileType vimshell
    \ setlocal nowrap
    \| setlocal nonumber
    \| call vimshell#altercmd#define('g', 'git')
    \| call vimshell#altercmd#define('i', 'iexe')
    \| call vimshell#altercmd#define('l', 'll')
    \| call vimshell#altercmd#define('ll', 'ls -lt')
    \| call vimshell#altercmd#define('scilab', 'iexe --encoding=utf-8 --split=tabnew Scilex')
    \| call vimshell#altercmd#define('maxima', 'iexe --split=tabnew maxima.bat')

  autocmd vimrc FileType int-* setlocal nowrap
endif
"}}}
"*** vimfiler.vim *** {{{
if neobundle#tap('vimfiler')
  nnoremap <Space>e :VimFiler<CR>
  nnoremap <Space>E :VimFiler -tab<CR>
  " let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_data_directory = $USERCACHEDIR . '/.vimfiler'
  let g:vimfiler_execute_file_list = {
    \ 'm'    : 'matlab',
    \ 'doc'  : 'winword',
    \ 'docx' : 'winword',
    \ 'xls'  : 'excel',
    \ 'xlsx' : 'excel',
    \ 'ppt'  : 'powerpnt',
    \ 'pptx' : 'powerpnt',
    \ 'bmp'  : 'vieas',
    \ 'gif'  : 'vieas',
    \ 'jpeg' : 'vieas',
    \ 'jpg'  : 'vieas',
    \ 'png'  : 'vieas',
    \ 'xcf'  : 'gimp-2.8',
    \ 'svg'  : 'inkscape',
    \ 'pdf'  : 'pdfxcview',
    \ }

  autocmd vimrc FileType vimfiler setlocal nowrap
  autocmd vimrc FileType vimfiler setlocal nonumber
endif
"}}}
"*** vital.vim *** {{{
if neobundle#tap('vital.vim')
  " use vital in vimrc
  if !exists('g:V')
      let g:V  = vital#of("vital")
      let g:Sl = g:V.import("Data.List")
      let g:Sd = g:V.import("Data.String")
      let g:s  = g:V.import("Prelude")
  endif
endif
"}}}
" *** watchdogs *** {{{
if neobundle#tap('vim-watchdogs')
  let bundle = neobundle#get('vim-watchdogs')
  function! bundle.hooks.on_source(bundle)
    " add watchdogs configuration to g:quickrun_config
    let g:quickrun_config['watchdogs_checker/pyflakes'] = {
          \   'hook/time/enable' : 0,
          \ }
    let g:quickrun_config['watchdogs_checker/matlab'] = {
          \   'command' : 'mlint',
          \   'exec'    : '%c -id %s:p %s:r',
          \   'quickfix/errorformat' : '%-P==========\ %f\ ==========,%-G%>==========\ %s\ ==========,%-G%>L\ %l\ (C\ %c):\ MDOTM%m,L\ %l\ (C\ %c):\ %m,L\ %l\ (C\ %c-%*[0-9]):\ %m,%-Q',
          \   'hook/time/enable' : 0,
          \ }
    let g:quickrun_config['matlab/watchdogs_checker'] = {
          \   'type'    : 'watchdogs_checker/matlab',
          \ }

    " please refer quickrun section about g:quickrun_config
    call watchdogs#setup(g:quickrun_config)

    " run syntax check after writing file
    let g:watchdogs_check_BufWritePost_enable = 1
    " filetype settings
    " let g:watchdogs_check_BufWritePost_enables = {
    "       \ "python" : 1,
    "       \ "matlab" : 1,
    "       \ }

    " run syntax check after stopping cursor for a while
    " ! run only once after stopping cursor !
    let g:watchdogs_check_CursorHold_enable = 0
    " filetype settings
    " let g:watchdogs_check_CursorHold_enables = {
    "       \ "python" : 1,
    "       \ "matlab" : 0,
    "       \ }
  endfunction
  unlet bundle
endif
"}}}
" *** yankround.vim *** {{{
if neobundle#tap('yankround.vim')
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)

  let g:yankround_dir = $USERCACHEDIR . '/yankround'
endif
"}}}
"}}}
"***** fundamentals ***** {{{
"-------------------------------------------------------------------------
set backup                          " use backup
set backupdir=$USERCACHEDIR/backup  " assign path to make backup files
let &directory=&backupdir           " assign that path to make swap files is same as that for backup file
set clipboard=unnamed               " share clipboard with OS
set spellfile=$USERDIR/spell/en.ascii.add
                                    " uset file to add wors for spell check
set spelllang=en,cjk                " use english for spell check and cjk region is ignored
set spellsuggest=best               " choose correction engine for spell check
set hidden                          " move out from current buffer without warning even on editing
set history=100                     " the stored number of commands/searching history
set iminsert=0                      " turn off ime when getting into insert mode
set imsearch=0                      " turn off ime when getting into searching mode
set scrolloff=5                     " horizontal scroll margin
set sidescrolloff=10                " vertical scroll margin
set showmode                        " display current mode
set splitbelow                      " open new window below the current when splitting
set splitright                      " open new window in right hand side of the current when splitting
set timeoutlen=2000                 " The time in milliseconds that is waited for a key code or mapped key sequence to complete.
set viminfo+=n$USERCACHEDIR/viminfo.txt
                                    " assign path to viminfo file

" set encoding{{{
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
if has('unix')
  set fileformats=unix,dos,mac
elseif has('win32') || has('win64')
  set fileformats=dos,unix,mac
endif
if exists('&ambiwidth')
  set ambiwidth=double
endif
"}}}

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
  inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
  inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
  inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"

  setlocal iminsert=0
endfunction

" keep undo history (Vim7.3 or upper)
" vim-users.jp Hacks #162
if has('persistent_undo')
  set undodir=./.vimundo,$USERCACHEDIR/.vimundo
  set undofile
endif

" syntax coloring after reloading session
autocmd vimrc SessionLoadPost doautoall highlight Bufread

" never use 'r' and 'o' option in formatoptions
autocmd vimrc FileType * setlocal formatoptions-=r
autocmd vimrc FileType * setlocal formatoptions-=o
"}}}
"***** searching behavior ***** {{{
"--------------------------------------------------------------------------
set hlsearch                        " highlight searched word
set incsearch                       " use incremental search
set ignorecase                      " ignore upper/lower case of searching word
set smartcase                       " do not ignore upper/lower case when searching word contains both of them
set wrapscan                        " go back to the top candidate after getting to the end of file
if has('migemo')
  set migemo                        " use g? sequence of migemo
  set migemodict=$USERDIR/dict/utf-8/migemo-dict
endif
"}}}
"***** editing configuration ***** {{{
"--------------------------------------------------------------------------
set autoindent                      " add indent automatically
set backspace=indent,eol,start      " allow backspace key to delete indent and break line
set cindent                         " use c style indentation
set expandtab                       " use soft tabs
set formatoptions+=mM               " handle line-breaking appropriately also with multi-byte
set nrformats=alpha,hex             " use increment/decrement keys (<C-a>/<C-x>) also with alphabet and hex number
set switchbuf=useopen,usetab        " switch to it when trying to open file which has already opened elsewhere
set showmatch                       " emphasize correspondent parenthesis
set shiftwidth=4                    " indent width
set shiftround                      " round the indent width to the number of 'indentwidth' option when indented by '<' or '>'
set softtabstop=4                   " soft-tabbed indentation width
set tabstop=4                       " hard-tabbed indentation width
set virtualedit=block               " freely cursor movement in blockwise visual mode
set whichwrap=b,s,h,l,<,>,[,]       " do not stop cursor at head/tail of line, move to tail/head of previous/next line
set wildmenu                        " use extended commandline completion

" jump to the point where to have been edited last time when opening file
autocmd vimrc BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" use syntax completion if nothing is assigned to omnifunc option
" autocmd FileType *
"   \   if &l:omnifunc == ''
"   \ |   setlocal omnifunc=syntaxcomplete#Complete
"   \ | endif

" move cursor as you like in insert mode
" TODO: implement the actions in cmd mode and normal mode
" TODO: add mode specific feature to mcayl_patterns
" TODO: make it responsive for the assignment of count
let s:type_str  = type('')
let s:type_list = type([])
let s:type_dict = type({})

let g:mcayl_patterns = {
      \ '_' : {
      \   'pre'     : [',\s*', ')', ']', '}'],
      \   'post'    : ['\w\ze(', '\w\ze\s\+[-+<>~!]\?=', '\w\ze\s\+[<>]=\?', '\w\ze\s\+&&', '\w\ze\s\+||', '\w\ze\s\+[-+*/%]'],
      \   },
      \ 'vim' : {
      \   'include' : '_',
      \   'pre'     : [':\k*]', '\s\+\.'],
      \   'post'    : ['\w\ze\s\+\.=', '\w\ze\s\+[=!<>][=~][#?]\?', '\w\ze\s\+is\%(not\)\?\s\+', '\w\ze[']
      \   },
      \ }
function! s:mcayl_gather_candidate_positions(direction, line, mcayl_patterns) "{{{
  " prepare matching pattern list
  let keys = keys(a:mcayl_patterns)
  let matched_key = filter(keys, 'v:val ==# "' . &filetype . '"')[0]
  if !empty(matched_key)
    let include_list = [matched_key]
    if has_key(a:mcayl_patterns[matched_key], 'include')
      if type(a:mcayl_patterns[matched_key].include) == s:type_str
        let include_list += [a:mcayl_patterns[matched_key].include]
      elseif type(a:mcayl_patterns[matched_key].include) == s:type_list
        let include_list += a:mcayl_patterns[matched_key].include
      endif
    endif
  else
    let include_list = ['_']
  endif

  let  pre_pattern_list = []
  let post_pattern_list = []
  for key in include_list
    let pattern_info = a:mcayl_patterns[key]

    if type(pattern_info) == s:type_list
      let  pre_pattern_list += pattern_info
    elseif type(pattern_info) == s:type_dict
      let common    = has_key(pattern_info,    'common')
      let direction = has_key(pattern_info, a:direction)
      let pre       = has_key(pattern_info,       'pre')
      let post      = has_key(pattern_info,      'post')

      if common || direction
        if common
          if type(pattern_info.common) == s:type_list
            let pre_pattern_list += pattern_info.common
          elseif type(pattern_info.common) == s:type_dict
            if has_key(pattern_info.common, 'pre')
              if type(pattern_info.common.pre) == s:type_list
                let pre_pattern_list += pattern_info.common.pre
              endif
            endif

            if has_key(pattern_info.common, 'post')
              if type(pattern_info.common.post) == s:type_list
                let post_pattern_list += pattern_info.common.post
              endif
            endif
          endif
        endif

        if direction
          if type(pattern_info[a:direction]) == s:type_list
            let pre_pattern_list += pattern_info[a:direction]
          elseif type(pattern_info[a:direction]) == s:type_dict
            if has_key(pattern_info[a:direction], 'pre')
              if type(pattern_info[a:direction].pre) == s:type_list
                let pre_pattern_list += pattern_info[a:direction].pre
              endif
            endif

            if has_key(pattern_info[a:direction], 'post')
              if type(pattern_info[a:direction].post) == s:type_list
                let post_pattern_list += pattern_info[a:direction].post
              endif
            endif
          endif
        endif
      elseif pre || post
        if pre
          if type(pattern_info.pre) == s:type_list
            let pre_pattern_list += pattern_info.pre
          endif
        endif

        if post
          if type(pattern_info.post) == s:type_list
            let post_pattern_list += pattern_info.post
          endif
        endif
      endif
    endif
  endfor

  " get the closest mathed position
  let candidate_positions  = map( pre_pattern_list, 'match(a:line, v:val) == 0 ? match(a:line, v:val, 0, 2) : match(a:line, v:val)')
  let candidate_positions += map(post_pattern_list, 'matchend(a:line, v:val) == 0 ? matchend(a:line, v:val, 0, 2) : matchend(a:line, v:val)')

  return filter(candidate_positions, 'v:val > 0')
endfunction
"}}}
function! Mcayl_forward(mode, line, col, ...) "{{{
  let mcayl_patterns = a:0 > 0 ? a:1 : g:mcayl_patterns
  let candidate_positions = s:mcayl_gather_candidate_positions('forward', a:line[a:col :], mcayl_patterns)

  let output = ''
  if !empty(candidate_positions)
    if a:mode ==# 'i'
      call cursor(0, a:col + min(candidate_positions) + 1)
    elseif a:mode =~# '[nv]'
      let output = min(candidate_positions) . 'l'
    elseif a:mode ==# 'c'
      call setcmdpos(a:col + min(candidate_positions) + 1)
    endif
  endif

  return output
endfunction
"}}}
function! Mcayl_backward(mode, line, col, ...) "{{{
  let mcayl_patterns = a:0 > 0 ? a:1 : g:mcayl_patterns
  let candidate_positions = s:mcayl_gather_candidate_positions('backward', a:line[: a:col-1], mcayl_patterns)

  let output = ''
  if !empty(candidate_positions)
    if a:mode ==# 'i'
      call cursor(0, max(candidate_positions) + 1)
    elseif a:mode =~# '[nv]'
      let output = (a:col - max(candidate_positions)) . 'h'
    elseif a:mode ==# 'c'
      call setcmdpos(max(candidate_positions))
    endif
  endif

  return output
endfunction
"}}}
nnoremap <expr> <Plug>(mcayl-forward)  Mcayl_forward('n', getline('.'), col('.'))
nnoremap <expr> <Plug>(mcayl-backward) Mcayl_backward('n', getline('.'), col('.'))
xnoremap <expr> <Plug>(mcayl-forward)  Mcayl_forward('v', getline('.'), col('.'))
xnoremap <expr> <Plug>(mcayl-backward) Mcayl_backward('v', getline('.'), col('.'))
inoremap <silent> <Plug>(mcayl-forward)  <C-r>=Mcayl_forward('i', getline('.'), col('.') - 1)<CR>
inoremap <silent> <Plug>(mcayl-backward) <C-r>=Mcayl_backward('i', getline('.'), col('.') - 1)<CR>
cnoremap <Plug>(mcayl-forward)  <C-r>=Mcayl_forward('c', getcmdline(), getcmdpos() - 1)<CR>
cnoremap <Plug>(mcayl-backward) <C-r>=Mcayl_backward('c', getcmdline(), getcmdpos() - 1)<CR>
nmap <M-;> <Plug>(mcayl-forward)
nmap <M-,> <Plug>(mcayl-backward)
xmap <M-;> <Plug>(mcayl-forward)
xmap <M-,> <Plug>(mcayl-backward)
imap <M-;> <Plug>(mcayl-forward)
imap <M-,> <Plug>(mcayl-backward)
cmap <M-;> <Plug>(mcayl-forward)
cmap <M-,> <Plug>(mcayl-backward)
"}}}
"***** displaying ***** {{{
"--------------------------------------------------------------------------
colorscheme mckn
set cmdheight=2                     " the height of commandline
set cursorline                      " highlight corsor line
set guioptions-=m                   " menu bar is not required
set guioptions-=T                   " tool bar is not required
set laststatus=2                    " always display status line
set list                            " visalize special characters
set listchars=tab:>-,trail:-,eol:$,nbsp:%,extends:>,precedes:<
                                    " assign alternative expression for special characters
set number                          " display row number
set showcmd                         " display command information in commandline
set t_Co=256                        " use 256 coloring in modern terminal emulator
set title                           " display title
set nowrap                          " do not wrap in long line

" highlight cursor line only on active window - http://d.hatena.ne.jp/yuroyoro/searchdiary?word=vim%20
autocmd vimrc WinLeave * set nocursorline
autocmd vimrc WinEnter,BufRead * set cursorline

" statusline displaying
" copie... inspired from vim-neatstatus
let &stl=""
" file path
let &stl.=" %<%F "
" read only, modified, modifiable flags in brackets
let &stl.="%([%R%M]%) "

" right-align everything past this point
let &stl.="%= "

" file type (eg. python, ruby, etc..)
let &stl.="%(| %{&filetype} %)| "
" file format (eg. unix, dos, etc..)
let &stl.="%{&fileformat} | "
" file encoding (eg. utf8, latin1, etc..)
let &stl.="%(%{(&fenc!=''?&fenc:&enc)} | %)"
" buffer number
let &stl.="BUF #%n |"
"line number / total lines
let &stl.=" LN %l/%L\ | "
" percentage done
" let &stl.="%p%% | "
" column number
let &stl.="COL %c%V |"


" color modulation
" refactoring is required!
function! RGB2HSV(rgb, ...) "{{{
  let r   = a:rgb[0]
  let g   = a:rgb[1]
  let b   = a:rgb[2]
  let rgb = a:rgb

  let rgb_max = get(a:000, 0, 255)
  let  sv_max = get(a:000, 1, 100)

  " invalid range of arguments
  if r < 0 || r > rgb_max | return [] | endif
  if g < 0 || g > rgb_max | return [] | endif
  if b < 0 || b > rgb_max | return [] | endif

  let max = max(rgb)
  let min = min(rgb)

  let max_color = match(rgb, max)

  " convert number type to float type
  let r   = r * 1.0
  let g   = g * 1.0
  let b   = b * 1.0
  let max = max * 1.0
  let min = min * 1.0
  let c   = max - min

  " translate RGB to HSV
  if max == min
    let h = 0
  else
    if max_color == 0
      " max == r[ed]
      let h = 60.0 * (g - b) / c
      " previous eq. could return negative value
      if h < 0
          let h += 360
      endif
    elseif max_color == 1
      " max == g[reen]
      let h = 60.0 * (b - r) / c + 120.0
    else
      " max == b[lue]
      let h = 60.0 * (r - g) / c + 240.0
    endif

    let h = float2nr(round(h))
  endif

  if max == 0
    let s = 0
  else
    let s = float2nr(round(c / max * sv_max))
  endif

  let v = float2nr(round(max * sv_max / rgb_max))

  return [h, s, v]
endfunction
"}}}
function! HSV2RGB(hsv, ...)  "{{{
  " NOTE: not so accurate...
  let [h, s, v] = a:hsv
  let  sv_max = get(a:000, 0, 100)
  let rgb_max = get(a:000, 1, 255)


  " invalid range of argument
  if h < 0 || h > 360 | return [] | endif
  if s < 0 || s > sv_max | return [] | endif
  if v < 0 || v > sv_max | return [] | endif

  if h == 360 | let h = 0 | endif
  let s  = 1.0 * s / sv_max
  let v  = 1.0 * v / sv_max
  let hi = (h / 60) % 6
  let f  = h / 60.0 - hi
  let p  = float2nr(round(v * (1.0 - s)             * rgb_max))
  let q  = float2nr(round(v * (1.0 - s * f)         * rgb_max))
  let t  = float2nr(round(v * (1.0 - s * (1.0 - f)) * rgb_max))
  let v  = float2nr(round(v * rgb_max))

  " translate HSV to RGB
  if s == 0
    let rgb = [v, v, v]
    return rgb
  endif

  if hi == 0
    let rgb = [v, t, p]
  elseif hi == 1
    let rgb = [q, v, p]
  elseif hi == 2
    let rgb = [p, v, t]
  elseif hi == 3
    let rgb = [p, q, v]
  elseif hi == 4
    let rgb = [t, p, v]
  elseif hi == 5
    let rgb = [v, p, q]
  else
    let rgb = []
  endif

  return rgb
endfunction
"}}}
function! RGB2HSL(rgb, ...) "{{{
  let r   = a:rgb[0]
  let g   = a:rgb[1]
  let b   = a:rgb[2]
  let rgb = a:rgb

  let rgb_max = get(a:000, 0, 255)
  let  sl_max = get(a:000, 1, 100)

  " invalid range of arguments
  if r < 0 || r > rgb_max | return [] | endif
  if g < 0 || g > rgb_max | return [] | endif
  if b < 0 || b > rgb_max | return [] | endif

  let max = max(rgb)
  let min = min(rgb)

  let max_color = match(rgb, max)

  " convert number type to float type
  let r   = r * 1.0
  let g   = g * 1.0
  let b   = b * 1.0
  let max = max * 1.0
  let min = min * 1.0
  let c   = max - min

  " translate RGB to HSL
  if max == min
    let h = 0
  else
    if max_color == 0
      " max == r[ed]
      let h = 60.0 * (g - b) / c
      " previous eq. could return negative value
      if h < 0
          let h += 360
      endif
    elseif max_color == 1
      " max == g[reen]
      let h = 60.0 * (b - r) / c + 120.0
    else
      " max == b[lue]
      let h = 60.0 * (r - g) / c + 240.0
    endif

    let h = float2nr(round(h))
  endif

  let l = (max + min) / rgb_max / 2 " Do I need to take into account Rec709 or Rec601?

  if max == 0
    let s = 0
  else
    let s = c / rgb_max / (1 - abs(2 * l - 1))
  endif

  let s = float2nr(round(s * sl_max))
  let l = float2nr(round(l * sl_max))

  return [h, s, l]
endfunction
"}}}
function! HSL2RGB(hsl, ...)  "{{{
  " NOTE: not so accurate...
  let [h, s, l] = a:hsl
  let  sl_max = get(a:000, 0, 100)
  let rgb_max = get(a:000, 1, 255)

  " invalid range of argument
  if h < 0 || h > 360 | return [] | endif
  if s < 0 || s > sl_max | return [] | endif
  if l < 0 || l > sl_max | return [] | endif

  if h == 360 | let h = 0 | endif
  let s  = 1.0 * s / sl_max
  let l  = 1.0 * l / sl_max
  let hi = (h / 60) % 6
  let f  = fmod(h / 60.0, 2)
  let c  = s * (1 - abs(2 * l - 1))
  let x  = c * (1 - abs(  f   - 1))
  let m  = l - c / 2.0
  let p  = float2nr(round((c + m) * rgb_max))
  let q  = float2nr(round((x + m) * rgb_max))
  let t  = float2nr(round(   m    * rgb_max))

  " translate HSL to RGB
  if s == 0
    return [p, p, p]
  endif

  if hi == 0
    let rgb = [p, q, t]
  elseif hi == 1
    let rgb = [q, p, t]
  elseif hi == 2
    let rgb = [t, p, q]
  elseif hi == 3
    let rgb = [t, q, p]
  elseif hi == 4
    let rgb = [q, t, p]
  elseif hi == 5
    let rgb = [p, t, q]
  else
    let rgb = []
  endif

  return rgb
endfunction
"}}}
function! s:parse_html_color(html)  "{{{
  " HTML like expression, '#0000ff' or '0000ff'
  let r   = s:hex2nr(matchstr(a:html, '\c#\?\zs[0-9a-f]\{2}\ze[0-9a-f]\{4}'))
  let g   = s:hex2nr(matchstr(a:html, '\c#\?[0-9a-f]\{2}\zs[0-9a-f]\{2}\ze[0-9a-f]\{2}'))
  let b   = s:hex2nr(matchstr(a:html, '\c#\?[0-9a-f]\{4}\zs[0-9a-f]\{2}\ze'))
  let rgb = [r, g, b]

  return rgb
endfunction
"}}}
function! s:hex2nr(hex) "{{{
  let nr     = 0
  let digit  = 0
  let idx    = len(a:hex) - 1

  while idx >= 0
    let char = a:hex[idx]

    if char =~ '\d'
      let nr += str2nr(char) * pow(16, digit)
    elseif char ==? 'a'
      let nr += 10 * pow(16, digit)
    elseif char ==? 'b'
      let nr += 11 * pow(16, digit)
    elseif char ==? 'c'
      let nr += 12 * pow(16, digit)
    elseif char ==? 'd'
      let nr += 13 * pow(16, digit)
    elseif char ==? 'e'
      let nr += 14 * pow(16, digit)
    elseif char ==? 'f'
      let nr += 15 * pow(16, digit)
    else
      let nr = -1
      break
    endif

    let idx   -= 1
    let digit += 1
  endwhile

  return float2nr(nr)
endfunction
"}}}
function! s:readRGBtxt()  "{{{
  " read rgb.txt (may be heavy).
  " from thinca/vim-guicolorscheme
  let table = {}
  let txt = globpath(&rtp, '**/rgb.txt')
  if empty(txt)
    return table
  endif
  for line in readfile(split(txt, "\n")[0])
    if line =~ '^\s*!'
      continue
    endif
    let r = split(line)
    let rgb = call('printf', ['#%02X%02X%02X'] + r[:2])
    for name in r[3:]
      let table[tolower(name)] = rgb
    endfor
  endfor
  return table
endfunction
"}}}
function! s:rgb_mod(rgb, displacement, ...) "{{{
  let rgb_max = get(a:000, 0, 255)

  let [ r,  g,  b] = a:rgb
  let [dr, dg, db] = a:displacement
  let [ r,  g,  b] = [r + dr, g + dg, b + db]

  " correct invalid range
  if r < 0
    let r = 0
  elseif r > rgb_max
    let r = rgb_max
  endif

  if g < 0
    let g = 0
  elseif g > rgb_max
    let g = rgb_max
  endif

  if b < 0
    let b = 0
  elseif b > rgb_max
    let b = rgb_max
  endif

  return [r, g, b]
endfunction
"}}}
function! s:hsv_mod(rgb, displacement, ...)  "{{{
  let rgb_max = get(a:000, 0, 255)

  let [ h,  s,  v] = RGB2HSV(a:rgb, rgb_max)
  let [dh, ds, dv] = a:displacement
  let [ h,  s,  v] = [h + dh, s + ds, v + dv]

  " correct invalid range
  if h < 0
    let h = 0
  elseif h > 360
    let h = h - 360
  endif

  if s < 0
    let s = 0
  elseif s > 100
    let s = 100
  endif

  if v < 0
    let v = 0
  elseif v > 100
    let v = 100
  endif

  return HSV2RGB([h, s, v], 100, rgb_max)
endfunction
"}}}
function! s:hsl_mod(rgb, displacement, ...)  "{{{
  let rgb_max = get(a:000, 0, 255)

  let [ h,  s,  l] = RGB2HSL(a:rgb, rgb_max)
  let [dh, ds, dl] = a:displacement
  let [ h,  s,  l] = [h + dh, s + ds, l + dl]

  " correct invalid range
  if h < 0
    let h = 0
  elseif h > 360
    let h = h - 360
  endif

  if s < 0
    let s = 0
  elseif s > 100
    let s = 100
  endif

  if l < 0
    let l = 0
  elseif l > 100
    let l = 100
  endif

  return HSL2RGB([h, s, l], 100, rgb_max)
endfunction
"}}}
function! g:exec_highlight_mod(hi_group, fg_displacement, bg_displacement, color_space)   "{{{
  if !exists('g:color_map')
    let g:color_map = s:readRGBtxt()
  endif

  redir => hi_line
    execute "silent highlight " . a:hi_group
  redir END
  let guifg = matchstr(hi_line, 'guifg=\zs#\?\w\+')
  let guibg = matchstr(hi_line, 'guibg=\zs#\?\w\+')
  let gui   = matchstr(hi_line, 'gui=\zs[a-zA-Z,]\+')
  let guisp = matchstr(hi_line, 'guisp=\zs#\?\w\+')

  " color modulation in assigned color space
  " NOTE: do not change 'fg' and 'bg' color item
  if guifg =~? '#[0-9a-f]\{6}'
    let guifg = call('printf', ['#%02x%02x%02x'] + s:{a:color_space}_mod(s:parse_html_color(guifg), a:fg_displacement))
  elseif guifg =~? '\w\+' && guifg !~# '\%(fg\)\|\%(bg\)\|\%(foreground\)\|\%(background\)'
    let guifg = get(g:color_map, tolower(guifg), '')
  endif

  if guibg =~? '#[0-9a-f]\{6}'
    let guifg = call('printf', ['#%02x%02x%02x'] + s:{a:color_space}_mod(s:parse_html_color(guibg), a:bg_displacement))
  elseif guibg =~? '\w\+' && guibg !~# '\%(fg\)\|\%(bg\)\|\%(foreground\)\|\%(background\)'
    let guibg = get(g:color_map, tolower(guibg), '')
  endif

  " set color
  let command = 'highlight ' . a:hi_group
  if guifg != ''
    let command .= ' guifg=' . guifg
  endif

  if guibg != ''
    let command .= ' guibg=' . guibg
  endif

  if gui != ''
    let command .= ' gui=' . gui
  endif

  if guisp != ''
    let command .= ' guisp=' . guisp
  endif

  if command != 'highlight ' . a:hi_group
    execute command
  endif

  return
endfunction
"}}}
function! g:exec_highlight_mod_all(fg_displacement, bg_displacement, color_space)   "{{{
  if !exists('g:color_map')
    let g:color_map = s:readRGBtxt()
  endif

  redir => hi_conf
    execute "silent highlight"
  redir END
  let hi_list = split(hi_conf, "\n")

  let command_list = []
  for hi_line in hi_list
    let hi_group = matchstr(hi_line, '^\w\+')
    let guifg    = matchstr(hi_line, 'guifg=\zs#\?\w\+')
    let guibg    = matchstr(hi_line, 'guibg=\zs#\?\w\+')
    let gui      = matchstr(hi_line, 'gui=\zs[a-zA-Z,]\+')
    let guisp    = matchstr(hi_line, 'guisp=\zs#\?\w\+')

    " color modulation in HSV color space
    " NOTE: do not change 'fg' and 'bg' color item
    if guifg =~? '#[0-9a-f]\{6}'
      let guifg = call('printf', ['#%02x%02x%02x'] + s:{a:color_space}_mod(s:parse_html_color(guifg), a:fg_displacement))
    elseif guifg =~? '\w\+' && guifg !~# '\%(fg\)\|\%(bg\)\|\%(foreground\)\|\%(background\)'
      let guifg = get(g:color_map, tolower(guifg), '')
    endif

    if guibg =~? '#[0-9a-f]\{6}'
      let guibg = call('printf', ['#%02x%02x%02x'] + s:{a:color_space}_mod(s:parse_html_color(guibg), a:bg_displacement))
    elseif guibg =~? '\w\+' && guibg !~# '\%(fg\)\|\%(bg\)\|\%(foreground\)\|\%(background\)'
      let guibg = get(g:color_map, tolower(guibg), '')
    endif
    " make command list
    if hi_group == ''
      let command = ''
    else
      let command = 'highlight ' . hi_group
    endif

    if guifg != ''
      let command .= ' guifg=' . guifg
    endif

    if guibg != ''
      let command .= ' guibg=' . guibg
    endif

    if gui != ''
      let command .= ' gui=' . gui
    endif

    if guisp != ''
      let command .= ' guisp=' . guisp
    endif

    if hi_group == ''
      " If the window width is not enough, the output of highlight command is wrapped.
      let command_list[-1] .= command
    else
      if command != 'highlight ' . hi_group
        let command_list += [command]
      endif
    endif
  endfor

  for command in command_list
    execute command
  endfor

  return
endfunction
"}}}
function! g:show_up_gui() "{{{
  new
  let winwidth  = winwidth(0)
  let winheight = winheight(0)
  if winwidth < 9
    echohl WarningMsg
    echo "colormod.vim : current window is too narrow for me!"
    echohl None
    return
  endif
  if winheight > 7
    resize 7
  endif
  setlocal nowrap
  setlocal nonumber
  if winwidth > 17
    let padding = (winwidth - 18) / 8
    let room    = (winwidth - 18) % 8
    let  left_room = float2nr(floor(room / 2.0))
    let right_room = float2nr( ceil(room / 2.0))
    let text  = ''
    let text .= repeat(' ', left_room)
    let text .= repeat(' ', padding) . 'guifg' . repeat(' ', padding)
    let text .= repeat(' ', padding) . 'guibg' . repeat(' ', padding)
    let text .= repeat(' ', padding) . 'gui' . repeat(' ', padding)
    let text .= repeat(' ', padding) . 'guisp' . repeat(' ', padding)
    let text .= repeat(' ', right_room)
    call setline(1, text)
  endif
endfunction
"}}}
"}}}
"***** filetype settings ***** {{{
" These settings would be moved to ftplugin/$filetype.vim gradually
"-------------------------------------------------------------------------
"*** AutoHotkey ***
autocmd vimrc FileType autohotkey setlocal dictionary+=$USERDIR/dict/AHK.dict
autocmd vimrc FileType autohotkey setlocal foldmethod=marker
autocmd vimrc FileType autohotkey setlocal commentstring=;%s

"*** scilab ***"
autocmd vimrc FileType scilab setlocal softtabstop=4
autocmd vimrc FileType scilab setlocal shiftwidth=4
autocmd vimrc FileType scilab setlocal omnifunc=scilabcomplete#Complete

"*** FORTRAN ***"
autocmd vimrc FileType fortran setlocal shiftwidth=2
autocmd vimrc FileType fortran setlocal softtabstop=2
autocmd vimrc FileType fortran compiler gfortran
autocmd vimrc FileType fortran let b:fortran_fold=1
autocmd vimrc FileType fortran let b:fortran_more_precise=1
autocmd BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
" au vimrc FileType fortran setlocal textwidth=72

"*** matlab ***"
autocmd vimrc FileType matlab compiler mlint
autocmd vimrc FileType matlab setlocal softtabstop=4
autocmd vimrc FileType matlab setlocal shiftwidth=4
autocmd vimrc FileType matlab syn keyword matlabfunc syms solve colormap
autocmd vimrc FileType matlab setlocal commentstring=%%s

"*** vim ***"
autocmd vimrc FileType vim setlocal softtabstop=2
autocmd vimrc FileType vim setlocal shiftwidth=2

"*** help ***"
autocmd vimrc FileType help vertical resize 78

"*** int-maxima ***"
autocmd vimrc FileType int-maxima nnoremap <buffer> yy 0f<Space>ly$G0f<Space>"_d$a<Space>*

"*** python ***"
" jedi.vim"
let g:jedi#auto_initialization = 1
let g:jedi#rename_command = "<leader>R"
let g:jedi#popup_on_dot = 0

"*** lua ***"

"*** markdown ***"
autocmd vimrc FileType markdown setlocal wrap
autocmd vimrc FileType markdown setlocal iminsert=0
autocmd vimrc FileType markdown setlocal spellcapcheck

"*** tex ***"
autocmd vimrc FileType tex setlocal wrap
autocmd vimrc FileType tex setlocal iminsert=0
autocmd vimrc FileType tex setlocal spellcapcheck

"*** anonymous ***"
" Close non-named buffer without any warning.
" Imperfect...
autocmd vimrc QuitPre * call s:namaenonaikohainegala()
autocmd vimrc BufEnter * call s:tobacchirigomen()

function! s:namaenonaikohainegala()
  if winnr('$') == 1
    let g:namaenonaiko = []
    for nr in range(1, bufnr('$'))
      if bufname(nr) == '' && bufexists(nr)
        call add(g:namaenonaiko, [nr, getbufvar(nr, '&buftype')])
        call setbufvar(nr, '&buftype', 'nowrite')
      endif
    endfor
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
  endif
endfunction
"}}}
"***** user defined commands ***** {{{
"-------------------------------------------------------------------------
"*** scilab script editing assistance *** {{{
"Vim-users.jp - Vim Advent Calendar 2012 ujihisa 4
"http://vim-users.jp/2013/02/vim-advent-calendar-2012-ujihisa-4/
function! s:start_scilab()
  let t:scilab_source = expand("%:p")
  if has('win32') || has('win64')
    execute 'VimShellInteractive --encoding=utf-8 Scilex'
  else
    execute 'VimShellInteractive --split=edit scilab-adv-cli'
  end
  stopinsert
  let t:scilab_bufname = bufname('%')
"   if !has_key(t:, 'scilab_cmds')
"     let t:scilab_cmds = [input('t:scilab_cmds[0] = ')]
"   endif
  wincmd p
endfunction

command! -nargs=0 StartScilab call <SID>start_scilab()

function! s:scilab_run()
  let cmds = get(t:, 'scilab_cmds', 'exec("' . t:scilab_source . '")')

  let scilab_bufname = get(t:, 'scilab_bufname')
  if scilab_bufname !=# ''
    call vimshell#interactive#set_send_buffer(scilab_bufname)
    call vimshell#interactive#send(cmds)
  else
    echoerr 'try StartScilab'
  endif
endfunction

function! s:vimrc_scilab()
  nnoremap <buffer> <Space>m :<C-u>write<Cr>:call <SID>scilab_run()<Cr>
endfunction

augroup vimrc_scilab
  autocmd!
  autocmd FileType scilab call s:vimrc_scilab()
  autocmd FileType scilab nnoremap <buffer> <Space>st :<C-u>StartScilab
augroup END

"}}}
"*** maxima script editing assistance *** {{{
"Vim-users.jp - Vim Advent Calendar 2012 ujihisa 4
"http://vim-users.jp/2013/02/vim-advent-calendar-2012-ujihisa-4/
function! s:start_maxima()
  execute 'VimShellInteractive maxima'
  stopinsert
  let t:maxima_bufname = bufname('%')
"   if !has_key(t:, 'maxima_cmds')
"     let t:maxima_cmds = [input('t:maxima_cmds[0] = ')]
"   endif
  wincmd p
endfunction

command! -nargs=0 StartMaxima call <SID>start_maxima()

function! s:maxima_run()
  let delimiter_conf = &shellslash
  setl shellslash
  let t:maxima_source = expand("%:p")
  let &shellslash = delimiter_conf
  let cmds = get(t:, 'maxima_cmds', 'batch("' . t:maxima_source . '");')

  let maxima_bufname = get(t:, 'maxima_bufname')
  if maxima_bufname !=# ''
    call vimshell#interactive#set_send_buffer(maxima_bufname)
    call vimshell#interactive#send(cmds)
  else
    echoerr 'try StartMaxima'
  endif
endfunction

function! s:vimrc_maxima()
  nnoremap <buffer> <Space>m :<C-u>write<Cr>:call <SID>maxima_run()<Cr>
endfunction

augroup vimrc_maxima
  autocmd!
  autocmd FileType maxima call s:vimrc_maxima()
  autocmd FileType maxima nnoremap <buffer> <Space>st :<C-u>StartMaxima
augroup END

"}}}
"*** edit japanese *** {{{
command! -nargs=0 EditJapaneseTXT :call <SID>edit_ja()
function! s:edit_ja()
  setlocal wrap                     " use wrap in long line
  setlocal iminsert=2               " turn on ime when getting into insert mode
  setlocal display+=lastline        " display lower line as long as possible
  if exists(":JpFormatToggle")
    JpFormatToggle
    let b:JpCountChars = 46         " paper width
    let b:JpCountLines = 38         " line width
    let JpCountOverChars = 1
  endif

  if has('kaoriya')
    setlocal ambiwidth=auto         " cursor displaying optimization
  else
    setlocal ambiwidth=double
  endif
endfunction
"}}}
"*** edit english ***""{{{
command! -nargs=0 EditEnglishTXT :call <SID>edit_en()
function! s:edit_en()
  setlocal wrap                     " use wrap in long line
  setlocal iminsert=0               " turn off ime when getting into insert mode
  setlocal spellcapcheck            " check sentence case
endfunction
"}}}
" RegCopy     - Function to copy the content of a register to the other one. {{{
" *argments*"{{{
" arg1 :  The register name of copy source. It can be acceptable only a
"        character, the second and after character will be ignored. If the
"        arg2 is omitted and being executed with ! modifier, arg1 is regarded
"        as the name of copy destination.
" arg2 :  The register name of copy destination.It can be acceptable only a
"        character, the second and after character will be ignored.
" bang :  This argment signify wether the command is executed with !
"        modifier or not.
""}}}
" *specifications*"{{{
"  If the command Regcopy is executed with only 1 argment, the content of the
" register asigned by argment is going to be copied into the register asigned
" by v:register.
"  However, in the case of the command is executed with ! modifier, that
" behavior, written above, is turned over. This means that the content of the
" register asigned by v:register is going to be copied into the register
" asigned by argment.
"  In the case of the command is executed with ! modifier, second and after
" argments will be ignored.
""}}}
function! RegCopy(bang, ...) "{{{
  let arg1 = a:1

  if a:0 > 1
    let arg2 = a:2

    if a:bang != '!'
      let SourceReg = arg1[0]
      let DestReg   = arg2[0]
    else
      let SourceReg = arg2[0]
      let DestReg   = arg1[0]
    endif
  else
    if a:bang != '!'
      let SourceReg = arg1[0]
      let DestReg   = v:register
    else
      let SourceReg = v:register
      let DestReg   = arg1[0]
    endif
  endif

  execute 'let @' . DestReg . ' = @' . SourceReg
  echo 'Regcopy : @' . SourceReg . ' ---> @' . DestReg
endfunction "}}}
command! -nargs=+ -bang RegCopy call RegCopy('<bang>',<f-args>)
"}}}
" RegExchange - Function to exchange each contents of two registers. {{{
" *argments*"{{{
" arg1
" arg2 :  The name of each registers exchanging the contents.
""}}}
" *specifications*"{{{
"  If the command Regexc is executed with only 1 argment, the second argment
" is going to be used v:register.
""}}}
function! RegExchange(...) "{{{
  let ExcReg1 = a:1[0]

  if a:0 > 1
    let ExcReg2 = a:2[0]
  else
    let ExcReg2 = v:register
  endif

  execute 'let temp = @' . ExcReg2
  execute 'let @' . ExcReg2 . ' = @' . ExcReg1
  execute 'let @' . ExcReg1 . ' = temp'
  echo 'Regexc : @'.l:ExcReg1.' <--> @'.l:ExcReg2
endfunction "}}}
command! -nargs=+ RegExchange call RegExchange(<f-args>)
"}}}
"isolate-tab {{{
"TODO
" unite source... -> found it : buffer_tab
" IsolateTabBuffers command
" still imperfect...

let g:ignore_pattern = ['vimfiler:.*']

function! s:isolate_tab_add()
  " define 't:isolated_buf_list' in new tab
  if !has_key(t:, 'isolated_buf_list')
    let t:isolated_buf_list = []
  endif

  " check ignore pattern
  let matched = 0
  for pattern in g:ignore_pattern
    if bufname("%") !~# pattern
      let matched = 1
    endif
  endfor

  " add new buffer to 't:isolated_buf_list'
  if matched > 0
    if match(t:isolated_buf_list,bufnr("%")) == -1
      if buflisted(bufnr("%"))
        call add(t:isolated_buf_list, bufnr("%"))
      endif
    endif
  endif
endfunction

function! s:isolate_tab_delete()
  if has_key(t:, 'isolated_buf_list')
    " delete buffer number from 't:isolated_buf_list'
    let delbuf_num = bufnr("%")
    let temp = []
    for buf_num in t:isolated_buf_list
      if buf_num != delbuf_num
        call add(temp, buf_num)
      endif
    endfor
    let t:isolated_buf_list = temp
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
  echom
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

au vimrc BufEnter,BufWinEnter,BufFilePost * call s:isolate_tab_add()
au vimrc BufDelete * call s:isolate_tab_delete()
command! -nargs=? IsolateTabNext call s:isolate_tab_next(<args>)
command! -nargs=? IsolateTabPrevious call s:isolate_tab_previous(<args>)
command! -nargs=1 IsolateTabDo call s:isolate_tab_do(<args>)
"}}}
" preferable alternate of help command. {{{
function! s:pref_alt_help(...)
  let bang = a:1
  let  arg = a:2
  " Searching for the help window.
  let helpwinnr = 0
  for nr in range(1, winnr('$'))
    let buftype = getwinvar(nr, '&buftype')
    if buftype ==# 'help'
      let helpwinnr = nr
      break
    endif
  endfor

  if helpwinnr == 0
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
    execute 'help' . bang . ' ' . arg
  endif
  normal! 0
endfunction

command! -bang -nargs=? -complete=help Help call s:pref_alt_help('<bang>', <f-args>)
nnoremap <Space>h :Help<Space>
"}}}
"}}}
"***** key mapping ***** {{{
"--------------------------------------------------------------------------
" do not add the char cut by x,s
nnoremap x "_x
nnoremap s "_s

" move cursor as you see
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" I prefer to use <C-p>/<C-n> when ascending history
cnoremap <C-p> <Up>
cnoremap <Up> <C-p>
cnoremap <C-n> <Down>
cnoremap <Down> <C-n>

" substitute selected region
nnoremap S :%s///g<left><left>

" match 'Y' behavior with 'D' : Y = yy -> y$
nnoremap Y y$

" line-break without any change to current line in insert mode
inoremap <C-J> <Esc>o
" inoremap <C-K> <Esc>O

" check syntax group of the character under the cursor
nnoremap \s :echo map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')<CR>

" enabling 'f' and 't' commands to use string class {{{
function! s:f_knows_string_class(pattern, is_t, is_capital)
  let wrapscan    = &wrapscan
  let &wrapscan = 0

  let flag = ''
  if a:is_capital > 0
    let flag = 'b'
  endif

  let col = search(a:pattern, flag, line("."))
  if col > 0
    if a:is_t > 0
      if a:is_capital > 0
        normal! l
      else
        normal! h
      endif
    endif
  endif
  let &wrapscan = wrapscan
endfunction

nnoremap f\\ f\
nnoremap F\\ F\
nnoremap t\\ t\
nnoremap T\\ T\
let string_class = [ '\i',  '\I',  '\k',  '\K',  '\f',  '\F',  '\p',  '\P',  '\s',  '\S',  '\d',  '\D',  '\x',  '\X',  '\o',  '\O',  '\w',  '\W',  '\h',  '\H',  '\a',  '\A',  '\l',  '\L',  '\u',  '\U',
      \             '\_i', '\_I', '\_k', '\_K', '\_f', '\_F', '\_p', '\_P', '\_s', '\_S', '\_d', '\_D', '\_x', '\_X', '\_o', '\_O', '\_w', '\_W', '\_h', '\_H', '\_a', '\_A', '\_l', '\_L', '\_u', '\_U' ]
for key in string_class
  execute 'noremap f' . key . " :call \<SID>f_knows_string_class('" . key . "', 0, 0)\<CR>"
  execute 'noremap t' . key . " :call \<SID>f_knows_string_class('" . key . "', 1, 0)\<CR>"
  execute 'noremap F' . key . " :call \<SID>f_knows_string_class('" . key . "', 0, 1)\<CR>"
  execute 'noremap T' . key . " :call \<SID>f_knows_string_class('" . key . "', 1, 1)\<CR>"
endfor
"}}}
" vertical 'f' and 't' commands {{{
function! s:vertical_f(is_t, is_capital)
  let col = col(".")
  let currentline = line(".")

  if a:is_capital > 0
    let startline = line("w0")
    let endline   = line(".") - 1
    let lines     = reverse(s:get_opened_fold_lines(startline, endline))
  else
    let startline = line(".") + 1
    let endline   = line("w$")
    let lines     = s:get_opened_fold_lines(startline, endline)
  endif

  let chars = []
  for line in lines
    let chars += [get(split(line, '\zs'), col-1, '')]
  endfor

  let highlight_rows = []
  let uniq_chars     = g:Sl.uniq(filter(deepcopy(chars), '!empty(v:val)'))
  for c in uniq_chars
    let highlight_rows += [match(chars, g:s.escape_pattern(c), 0, v:count1) + 1]
  endfor
  call filter(highlight_rows, 'v:val != 0')
  if a:is_capital
    call map(highlight_rows, 'currentline - v:val')
  else
    call map(highlight_rows, 'currentline + v:val')
  endif

  let id_list = []
  for row in highlight_rows
    call add(id_list, s:highlight_add(row, col))
  endfor
  redraw

  let key = nr2char(getchar())  " I guess 'getchar()' has some restriction,
                                " but in this case no ploblem practically.
                                " Maybe... TTT, I forgot. menndoi. iijann.
  let command = ''
  if key != ""
    let pattern = g:s.escape_pattern(key)
    let idx     = match(uniq_chars, pattern)

    if idx >= 0
      if a:is_t
        if a:is_capital
          let dest = [highlight_rows[idx]+1, col]
        else
          let dest = [highlight_rows[idx]-1, col]
        endif
      else
        let dest = [highlight_rows[idx], col]
      endif
      let command = ":call cursor(" . dest[0] . ", " . dest[1] . ")\<CR>"
"       let command = ":call cursor(" . dest[0] . ", " . dest[1] . ")\<CR>:normal! zz\<CR>"
    else
      " This looks bad practice...
      let command = ":\<Esc>"
    endif
  endif
  for id in id_list
    call s:highlight_del(id)
  endfor

  return command
endfunction

function! s:get_opened_fold_lines(startline, endline)
  let lines        = []
  let pos          = a:startline
  while pos <= a:endline
    let fold_closed_end_line = foldclosedend(pos)
    if fold_closed_end_line >= 0
      let pos = fold_closed_end_line + 1
    else
      call add(lines, getline(pos))
      let pos += 1
    endif
  endwhile

  return lines
endfunction

function! s:highlight_add(row, col)
  let pattern   = '\%' . a:row . 'l\%' . a:col . 'c.'
  let id = matchadd("IncSearch", pattern)
  return id
endfunction

function! s:highlight_del(id)
  call matchdelete(a:id)
endfunction

nmap <silent><expr> \f <SID>vertical_f(0,0)
nmap <silent><expr> \t <SID>vertical_f(1,0)
nmap <silent><expr> \F <SID>vertical_f(0,1)
nmap <silent><expr> \T <SID>vertical_f(1,1)
"}}}
"}}}
"***** macros ***** {{{
call setreg('a', "0t.7hi \<Esc>t.\<C-a>F xj")
call setreg('x', "0t.7hi \<Esc>t.\<C-x>F xj")
"}}}
"***** loading local settings ***** {{{
"-------------------------------------------------------------------------
if filereadable(expand($USERDIR . '/.vimrc.local'))
  source $USERDIR/.vimrc.local
endif
"}}}
"***** finalize (rather for reloading .vimrc) ***** {{{
syntax enable
nohlsearch
" recall filetype autocommand
doautocmd FileType
"}}}

" vim:set ts=8 sts=2 sw=2 tw=0:
" vim:set foldcolumn=2:
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" Last Change: 11-Mar-2014.
"
"***** Todo *****
" improve columnjump
" -> Finally my request getting too huge, I felt nervous to send it.
"    Thus I decided to make a independent plugin.
" matlabcomplete, matlabdoc
" color modulation

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
NeoBundle       'osyo-manga/vim-reanimate'
NeoBundle       'osyo-manga/vim-operator-jump_side'
NeoBundle       'rhysd/vim-textobj-word-column'
NeoBundle       'sgur/vim-textobj-parameter'
NeoBundleFetch  'Shougo/neobundle.vim'
NeoBundle       'Shougo/neomru.vim'
NeoBundle       'Shougo/unite-help'        , {'depends' : 'Shougo/unite.vim'}
NeoBundle       'Shougo/unite.vim'
NeoBundle       'Shougo/vimproc.vim'            , {
                \ 'build' : {
                \     'windows' : 'make -f make_mingw64.mak',
                \     'cygwin'  : 'make -f make_cygwin.mak',
                \     'mac'     : 'make -f make_mac.mak',
                \     'unix'    : 'make -f make_unix.mak',
                \    },}
NeoBundle       'thinca/vim-prettyprint'
NeoBundle       'thinca/vim-unite-history'  , {'depends' : 'Shougo/unite.vim'}
NeoBundle       'thinca/vim-visualstar'
NeoBundle       'tpope/vim-markdown'
NeoBundle       'tyru/caw.vim'
NeoBundle       'tyru/open-browser.vim'
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
      \   'commands' : [{ 'name'     : 'VimFiler',
      \                   'complete' : 'customlist,vimfiler#complete' },
      \                 'VimFilerExplorer',
      \                 'Edit', 'Read', 'Source', 'Write'],
      \   'mappings' : ['<Plug>(vimfiler_'],
      \   'explorer' : 1,
      \ }}
NeoBundleLazy 'Shougo/vimshell', {
      \ 'depends' : 'Shougo/vimproc.vim',
      \ 'autoload' : {
      \   'commands' : [{ 'name'     : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop'],
      \   'mappings' : ['<Plug>(vimshell_'],
      \ }}
NeoBundleLazy   'thinca/vim-quickrun', {
      \ 'autoload' : {
      \   'mappings' : ['<Plug>(quickrun)', '<Leader>r'],
      \   'commands' : 'QuickRun',
      \ }}
" NeoBundleLazy   'thinca/vim-ref'
NeoBundleLazy   'ujihisa/neco-look', {
      \ 'depends'  : 'Shougo/neocomplete',
      \ 'autoload' : {'insert' : 1},
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
" Disable default settings
let g:smartinput_no_default_key_mappings = 1

if neobundle#tap('vim-smartinput')
  call smartinput#clear_rules()

  " I know following description is too lengthy, but otherwise I would be not
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

  for item in s:trig
    call smartinput#map_to_trigger('i', item[0], item[1], item[2])
    call smartinput#map_to_trigger('c', item[0], item[1], item[2])
  endfor
  unlet item

  let rules = []

  " imitate smartchr.vim
  " '<' -> ' < ' -> ' << ' -> '<<' -> '<<<' -> '<<<<' ...
  let rules += [
        \       {'char': '<', 'at': '\%#',     'input': '<',                      'mode': 'i'},
        \       {'char': '<', 'at': '<\%#',    'input': '<BS> < ',                'mode': 'i'},
        \       {'char': '<', 'at': ' < \%#',  'input': '<BS>< ',                 'mode': 'i'},
        \       {'char': '<', 'at': ' << \%#', 'input': '<BS><BS><BS><BS><<',     'mode': 'i'},
        \       {'char': '<', 'at': '<<\+\%#', 'input': '<',                      'mode': 'i'},
        \      ]
  " '>' -> ' > ' -> ' >> ' -> '>>' -> '>>>' -> '>>>>' ...
  let rules += [
        \       {'char': '>', 'at': '\%#',     'input': '>',                      'mode': 'i'},
        \       {'char': '>', 'at': '>\%#',    'input': '<BS> > ',                'mode': 'i'},
        \       {'char': '>', 'at': ' > \%#',  'input': '<BS>> ',                 'mode': 'i'},
        \       {'char': '>', 'at': ' >> \%#', 'input': '<BS><BS><BS><BS>>>',     'mode': 'i'},
        \       {'char': '>', 'at': '>>\+\%#', 'input': '>',                      'mode': 'i'},
        \      ]
  " '+' -> ' + ' -> '++' -> '+++' -> '++++' ...
  let rules += [
        \       {'char': '+', 'at': '\%#',     'input': '+',                      'mode': 'i'},
        \       {'char': '+', 'at': '+\%#',    'input': '<BS> + ',                'mode': 'i'},
        \       {'char': '+', 'at': ' + \%#',  'input': '<BS><BS><BS>++',         'mode': 'i'},
        \       {'char': '+', 'at': '++\+\%#', 'input': '+',                      'mode': 'i'},
        \      ]
  " '-' -> ' - ' -> '--' -> '---' -> '----' ...
  let rules += [
        \       {'char': '-', 'at': '\%#',     'input': '-',                      'mode': 'i'},
        \       {'char': '-', 'at': '-\%#',    'input': '<BS> - ',                'mode': 'i'},
        \       {'char': '-', 'at': ' - \%#',  'input': '<BS><BS><BS>--',         'mode': 'i'},
        \       {'char': '-', 'at': '--\+\%#', 'input': '-',                      'mode': 'i'},
        \      ]
  " '*' -> ' * ' -> ' ** ' -> '**' -> '***' -> '****' ...
  let rules += [
        \       {'char': '*', 'at': '\%#',       'input': '*',                    'mode': 'i'},
        \       {'char': '*', 'at': '\*\%#',     'input': '<BS> * ',              'mode': 'i'},
        \       {'char': '*', 'at': ' \* \%#',   'input': '<BS>* ',               'mode': 'i'},
        \       {'char': '*', 'at': ' \*\* \%#', 'input': '<BS><BS><BS><BS>**',   'mode': 'i'},
        \       {'char': '*', 'at': '\*\*\+\%#', 'input': '*',                    'mode': 'i'},
        \      ]
  " '/' -> ' / ' -> '//' -> '///' -> '////' ...
  let rules += [
        \       {'char': '/', 'at': '\%#',     'input': '/',                      'mode': 'i'},
        \       {'char': '/', 'at': '/\%#',    'input': '<BS> / ',                'mode': 'i'},
        \       {'char': '/', 'at': ' / \%#',  'input': '<BS><BS><BS>//',         'mode': 'i'},
        \       {'char': '/', 'at': '//\+\%#', 'input': '/',                      'mode': 'i'},
        \      ]
  " '%' -> ' % ' -> '%%' -> '%%%' -> '%%%%' ...
  let rules += [
        \       {'char': '%', 'at': '\%#',     'input': '%',                      'mode': 'i'},
        \       {'char': '%', 'at': '%\%#',    'input': '<BS> % ',                'mode': 'i'},
        \       {'char': '%', 'at': ' % \%#',  'input': '<BS><BS><BS>%%',         'mode': 'i'},
        \       {'char': '%', 'at': '%%\+\%#', 'input': '%',                      'mode': 'i'},
        \      ]
  " '&' -> ' && ' -> '&&' -> '&&&' -> '&&&&' ...
  let rules += [
        \       {'char': '&', 'at': '\%#',     'input': '&',                      'mode': 'i'},
        \       {'char': '&', 'at': '&\%#',    'input': '<BS> && ',               'mode': 'i'},
        \       {'char': '&', 'at': ' && \%#', 'input': '<BS><BS><BS><BS>&&',     'mode': 'i'},
        \       {'char': '&', 'at': '&&\+\%#', 'input': '&',                      'mode': 'i'},
        \       {'char': '&', 'at': ' &\%#\S', 'input': '& ',                     'mode': 'i'},
        \       {'char': '&', 'at': '\S&\%# ', 'input': '<BS> &&<Right>',         'mode': 'i'},
        \       {'char': '&', 'at': ' &\%# ',  'input': '&<Right>',               'mode': 'i'},
        \      ]
  " '|' -> ' | ' -> ' || ' -> '||' -> '|||' -> '||||' ...
  let rules += [
        \       {'char': '<Bar>', 'at': '\%#',     'input': '|',                  'mode': 'i'},
        \       {'char': '<Bar>', 'at': '|\%#',    'input': '<BS> | ',            'mode': 'i'},
        \       {'char': '<Bar>', 'at': ' | \%#',  'input': '<BS>| ',             'mode': 'i'},
        \       {'char': '<Bar>', 'at': ' || \%#', 'input': '<BS><BS><BS><BS>||', 'mode': 'i'},
        \       {'char': '<Bar>', 'at': '||\+\%#', 'input': '|',                  'mode': 'i'},
        \       {'char': '<Bar>', 'at': ' |\%#\S', 'input': '| ',                 'mode': 'i'},
        \       {'char': '<Bar>', 'at': '\S|\%# ', 'input': '<BS> ||<Right>',     'mode': 'i'},
        \       {'char': '<Bar>', 'at': ' |\%# ',  'input': '|<Right>',           'mode': 'i'},
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
        \       {'char': '=', 'at': '\%#',     'input': ' = ',                    'mode': 'i'},
        \       {'char': '=', 'at': ' = \%#',  'input': '<BS>= ',                 'mode': 'i'},
        \       {'char': '=', 'at': ' == \%#', 'input': '<BS><BS><BS><BS>=',      'mode': 'i'},
        \       {'char': '=', 'at': '=\%#',    'input': '=',                      'mode': 'i'},
        \      ]

  let rules += [
        \       {'char': '=', 'at': '\%# = ',         'input': '<Del><Right><Del><Left>=',                  'mode': 'i'},
        \       {'char': '=', 'at': ' \%#',           'input': '= ',                                        'mode': 'i'},
        \       {'char': '=', 'at': '\S\%# ',         'input': ' =<Right>',                                 'mode': 'i'},
        \       {'char': '=', 'at': ' \%# ',          'input': '=<Right>',                                  'mode': 'i'},
        \       {'char': '=', 'at': '[-+<>~!] \%#',   'input': '<BS>= ',                                    'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]\%#\S', 'input': '= ',                                        'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]\%#$',  'input': '= ',                                        'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]\%# ',  'input': '=',                                         'mode': 'i'},
        \       {'char': '=', 'at': '\S[-+<>~!]\%#',  'input': '<Left> <Right>= ',                          'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]= \%#', 'input': '<Left><Left><Left><BS><Right><Right><Del>', 'mode': 'i'},
        \       {'char': '=', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '=',                   'mode': 'i'},
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
        \       {'char': '''', 'at': '\%#',       'input': '''''<Left>', 'mode': 'i:'},
        \       {'char': '''', 'at': '\\\%#',     'input': '''',         'mode': 'i:'},
        \       {'char':  '"', 'at': '\%#',       'input': '""<Left>',   'mode': 'i:'},
        \       {'char':  '"', 'at': '\\\%#',     'input': '"',          'mode': 'i:'},
        \       {'char': '''', 'at': '\w\%#',     'input': '''',         'mode': 'i:'},
        \       {'char': '''', 'at': '\w''\%#''', 'input': '<Del>',      'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*\%#"',               'input': '""<Left>',   'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',          'input': '""',         'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#"',         'input': '<Right>',    'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*\%#''',         'input': '''''<Left>', 'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\%#',   'input': '''''',       'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*''[^'']*\%#''', 'input': '<Right>',    'mode': 'i:'},
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
        \       {'char': '=', 'at': '<C-r>\%#', 'input': '=',                                         'mode': 'i:', 'filetype': ['vim']},
        \      ]
  " '.' -> ' . ' -> '..' -> '...'
  let rules += [
        \       {'char': '.', 'at': '\%#',       'input': '.',              'filetype': ['vim']},
        \       {'char': '.', 'at': '\.\%#',     'input': '<BS> . ',        'filetype': ['vim']},
        \       {'char': '.', 'at': ' \. \%#',   'input': '<BS><BS><BS>..', 'filetype': ['vim']},
        \       {'char': '.', 'at': '\.\.\%#',   'input': '.',              'filetype': ['vim']},
        \       {'char': '.', 'at': ' \.\%#\S',  'input': ' ',              'filetype': ['vim']},
        \       {'char': '.', 'at': '\S\.\%# ',  'input': '<BS> .<Right>',  'filetype': ['vim']},
        \       {'char': '.', 'at': ' \.\%# ',   'input': '<Right>',        'filetype': ['vim']},
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
  unlet rules
  let g:is_smartinput_valid = 1

  cmap <BS> <Plug>(smartinput_BS)

  " toggle switch
  command! -nargs=0 SmartinputToggle call Smartinput_toggle_switch()
  nnoremap <silent> <M-s> :SmartinputToggle<CR>
  inoremap <silent> <M-s> <C-r>=Smartinput_toggle_switch()<CR>
  cnoremap          <M-s> <C-r>=Smartinput_toggle_switch()<CR>

  function! Smartinput_toggle_switch()
    if g:is_smartinput_valid
      for item in s:trig
        if item[0] == item[2]
          execute "iunmap " . item[0]
        else
          if item[0] =~# '^<Plug>.\+'
            execute "imap " . item[0] . " " . item[2]
          else
            execute "inoremap " . item[0] . " " . item[2]
          endif
        endif
      endfor

      let g:is_smartinput_valid = 0
    else
      for item in s:trig
        call smartinput#map_to_trigger('i', item[0], item[1], item[2])
        call smartinput#map_to_trigger('c', item[0], item[1], item[2])
      endfor

      let g:is_smartinput_valid = 1
    endif

    return ''
  endfunction
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
"*** jedi.vim *** {{{
if neobundle#tap('jedi-vim')
  let g:jedi#auto_initialization = 1
  let g:jedi#rename_command = "<leader>R"
  let g:jedi#popup_on_dot = 0
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
    \  'converter_case', 'converter_abbr'])

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
"*** neomru.vim *** {{{
if neobundle#tap('neomru.vim')
  let g:neomru#file_mru_path = $USERCACHEDIR . '/.neomru/file'
  let g:neomru#directory_mru_path = $USERCACHEDIR . '/.neomru/directly'
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
let g:textobj_lastpaste_no_default_key_mappings = 1
omap iP <Plug>(textobj-lastpaste-i)
xmap iP <Plug>(textobj-lastpaste-i)
"}}}
"*** unite.vim *** {{{
if neobundle#tap('unite.vim')
  nnoremap [Unite] <Nop>
  nmap     <Space>u [Unite]
  nnoremap [Unite]u :Unite<Space>
  nnoremap [Unite]c :Unite history/command command<CR>
  nnoremap [Unite]y :Unite history/yank<CR>
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
"   call unite#custom#source('messages', 'sorters', 'sorter_reverse')
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
"*** vim-operator-jump_side ***"{{{
if neobundle#tap('vim-operator-jump_side')
  nmap \h <Plug>(operator-jump-head)
  nmap \l <Plug>(operator-jump-tail)
endif
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
set helplang=ja,en                  " use japanese help preferentially
set hidden                          " move out from current buffer without warning even on editing
set history=100                     " the stored number of commands/searching history
set iminsert=0                      " turn off ime when getting into insert mode
set imsearch=0                      " turn off ime when getting into searching mode
set splitbelow                      " open new window below the current when splitting
set splitright                      " open new window in right hand side of the current when splitting
set synmaxcol=500                   " restrict the number of lines considered for syntax coloring
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

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" use syntax completion if nothing is assigned to omnifunc option
" autocmd FileType *
"   \ if &l:omnifunc == '' |
"   \   setlocal omnifunc=syntaxcomplete#Complete |
"   \ endif

" let g:columnmove_auto_scroll = 1
" let g:patternjump_highlight = 1
" let g:patternjump_caching = 1

function! Speed_gun(...)
  let l:count = a:0 > 0 ? a:1 : 10
  let g:time = []
  while l:count > 0
    normal! $
    let start_time = reltime()
    normal h
    let g:time += [reltimestr(reltime(start_time))]
    let l:count -= 1
  endwhile
  execute "let mean_time = (" . join(g:time, '+') . ")/" . len(g:time)
  PP! mean_time
endfunction
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
set showmode                        " display current mode
set scrolloff=5                     " vertical scroll margin
set sidescrolloff=10                " horizontal scroll margin
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

augroup help_optimizer
  au!
  autocmd FileType help call s:help_bootstrap()
augroup END

function! s:help_bootstrap()
  augroup help_optimizer
    au!
    autocmd BufEnter *           call s:help_conf_optimizer()
    autocmd BufLeave *.txt,*.jax call s:help_conf_restorer()
  augroup END
endfunction

function! s:help_conf_optimizer()
  if &buftype ==# 'help'
    let s:sidescrolloff = &sidescrolloff
    set sidescrolloff=0
  endif

  doautocmd FileType
endfunction

function! s:help_conf_restorer()
  if &buftype ==# 'help'
    let &sidescrolloff = s:sidescrolloff
    unlet s:sidescrolloff
  endif
endfunction

"*** int-maxima ***"
autocmd vimrc FileType int-maxima nnoremap <buffer> yy 0f<Space>ly$G0f<Space>"_d$a<Space>*

"*** markdown ***"
autocmd vimrc FileType markdown setlocal wrap
autocmd vimrc FileType markdown setlocal iminsert=0
autocmd vimrc FileType markdown setlocal spellcapcheck

"*** tex ***"
autocmd vimrc FileType tex setlocal wrap
autocmd vimrc FileType tex setlocal iminsert=0
autocmd vimrc FileType tex setlocal spellcapcheck

"*** quickfix ***"
autocmd vimrc FileType qf call s:qf_resize()

function! s:qf_resize()
  let Nerror = len(getqflist())
  if Nerror > 0
    let maximum = floor(winheight(bufnr("#")) / 3)

    if Nerror > maximum
      execute 'resize ' . maximum
    else
      execute 'resize ' . Nerror
    endif
  endif
endfunction

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

" move cursor to the end of selected area after yank
xnoremap Y ygv<Esc>

" line-break without any change to current line in insert mode
inoremap <C-j> <Esc>o
" inoremap <C-k> <Esc>O

" check syntax group of the character under the cursor
nnoremap \s :echo map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')<CR>

" getting into insert mode after moving cursor
nnoremap <M-i> bi
nnoremap <M-a> ea

" reserve black hole register for the next operator
nnoremap <M-d> "_

" " enabling 'f' and 't' commands to use string class {{{
" function! s:f_knows_string_class(mode, pattern, is_t, is_capital)
"   let line = line('.')
"   let col  = col('.')
"   let flag = ''
"   if a:is_capital
"     let flag .= 'b'
"   endif
"
"   let l:count = 0
"   while l:count < v:count1
"     let l:count += 1
"     let dest = searchpos(a:pattern, flag, line)[1]
"   endwhile
"
"   if dest > 0
"     if a:is_capital
"       if a:is_t
"         let displ = col - dest + 1
"       else
"         let displ = col - dest
"       endif
"
"       let key = 'h'
"     else
"       if a:is_t
"         let displ = dest - col - 1
"       else
"         let displ = dest - col
"       endif
"
"       let key = 'l'
"     endif
"
"     if a:mode ==# 'n'
"       let command = "\<Esc>" . displ . key
"     elseif a:mode ==# 'v'
"       let command = "oo" . displ . key
"     endif
"   else
"     if a:mode ==# 'n'
"       let command = "\<Esc>"
"     elseif a:mode ==# 'v'
"       let command = "oo"
"     endif
"   endif
"
"   return command
" endfunction
"
" nnoremap f\\ f\
" nnoremap F\\ F\
" nnoremap t\\ t\
" nnoremap T\\ T\
" let string_class = [ '\i',  '\I',  '\k',  '\K',  '\f',  '\F',  '\p',  '\P',  '\s',  '\S',  '\d',  '\D',  '\x',  '\X',  '\o',  '\O',  '\w',  '\W',  '\h',  '\H',  '\a',  '\A',  '\l',  '\L',  '\u',  '\U',
"       \             '\_i', '\_I', '\_k', '\_K', '\_f', '\_F', '\_p', '\_P', '\_s', '\_S', '\_d', '\_D', '\_x', '\_X', '\_o', '\_O', '\_w', '\_W', '\_h', '\_H', '\_a', '\_A', '\_l', '\_L', '\_u', '\_U' ]
" for key in string_class
"   execute 'nmap <expr> f' . key . " \<SID>f_knows_string_class('n', '" . key . "', 0, 0)"
"   execute 'nmap <expr> t' . key . " \<SID>f_knows_string_class('n', '" . key . "', 1, 0)"
"   execute 'nmap <expr> F' . key . " \<SID>f_knows_string_class('n', '" . key . "', 0, 1)"
"   execute 'nmap <expr> T' . key . " \<SID>f_knows_string_class('n', '" . key . "', 1, 1)"
"   execute 'vmap <expr> f' . key . " \<SID>f_knows_string_class('v', '" . key . "', 0, 0)"
"   execute 'vmap <expr> t' . key . " \<SID>f_knows_string_class('v', '" . key . "', 1, 0)"
"   execute 'vmap <expr> F' . key . " \<SID>f_knows_string_class('v', '" . key . "', 0, 1)"
"   execute 'vmap <expr> T' . key . " \<SID>f_knows_string_class('v', '" . key . "', 1, 1)"
" endfor
" "}}}

" kind-f
function! s:kind_f(mode)  "{{{
  let line = line('.')
  let col  = col('.')

  if a:mode =~# '[ft]'
    let chars = split(getline('.')[col :], '\zs')
  elseif a:mode =~# '[FT]'
    let chars = reverse(split(getline('.')[:col-2], '\zs'))
  endif

  let uniq_chars = g:Sl.uniq_by(copy(chars), 'v:val')

  if a:mode =~# '[ft]'
    let indexes = filter(map(copy(uniq_chars), 'match(chars, v:val, 0, v:count1) + col'), 'v:val > col')
  elseif a:mode =~# '[FT]'
    let indexes = filter(map(copy(uniq_chars), 'col - match(chars, v:val, 0, v:count1) - 2'), 'v:val < col-1')
  endif

  " highlighting candidates
  let s:id_list = map(copy(indexes), "s:highlight_add(line, v:val+1)")
  redraw

  " reserving cleaner
  augroup kind-f:cleaner
    au!
    au CursorMoved,CursorMovedI,WinLeave <buffer> call g:kind_f_cleaner()
  augroup END

  return a:mode
endfunction
"}}}
function! g:kind_f_cleaner() "{{{
  " delete highlighting
  call filter(map(s:id_list, "s:highlight_del(v:val)"), 'v:val > 0')
  redraw

  if s:id_list == []
    augroup patternjump:cleaner
      au!
    augroup END
  endif
endfunction
"}}}
function! s:highlight_add(row, col) "{{{
  let pattern   = '\%' . a:row . 'l\%' . a:col . 'c.'
  let id = matchadd("IncSearch", pattern)
  return id
endfunction
"}}}
function! s:highlight_del(id) "{{{
  let result = matchdelete(a:id)

  let output = (result == 0) ? result : a:id
  return output
endfunction
"}}}
nnoremap <expr> f <SID>kind_f('f')
nnoremap <expr> t <SID>kind_f('t')
nnoremap <expr> F <SID>kind_f('F')
nnoremap <expr> T <SID>kind_f('T')
"}}}
"***** macros ***** {{{
" increment big number
call setreg('a', "0t.7hi \<Esc>t.\<C-a>F xj")
call setreg('x', "0t.7hi \<Esc>t.\<C-x>F xj")
" copy&paste   original : call setreg('u', "\<Esc>:let @u='\"=@u[11:]\<C-v>\<CR>p`u'\<CR>gv\"Uy")
call setreg('u', "\<Esc>:let @u='\"\<Del>=@u[13:]\<C-v>\<CR>p1000fa'\<CR>gv\"Uy")
call setreg('i', "\<Esc>:let @i='\"\<Del>=@i[13:]\<C-v>\<CR>p1000fa'\<CR>gv\"iy")
"}}}
"***** loading local settings ***** {{{
"-------------------------------------------------------------------------
if filereadable(expand($USERDIR . '/.vimrc.local'))
  source $USERDIR/.vimrc.local
endif
"}}}
"***** finalize (rather for reloading .vimrc) ***** {{{
" start syntax highlighting
syntax enable
" to suppress highlighting the last searched word because of 'set hlsearch'
nohlsearch
" recall filetype autocommand
doautocmd FileType
"}}}

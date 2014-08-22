" vim:set ts=2 sts=2 sw=2 tw=0:
" vim:set foldcolumn=2:
" vim:set foldmethod=marker:
" vim:set commentstring="%s:
" Last Change: 21-Aug-2014.
"
"***** Todo *****

"***** startup ***** {{{
"-------------------------------------------------------------------------
set shellslash                      " use '/' as a path delimiter

augroup vimrc
  autocmd!
augroup END

if has('win32')
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
"***** fundamentals ***** {{{
"-------------------------------------------------------------------------
set backup                          " use backup
set swapfile                        " use swap file
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
set viminfo&
set viminfo+=n$USERCACHEDIR/viminfo.txt
                                    " assign path to viminfo file
set wildmenu                        " use extended commandline completion

" encoding and file format
set fileencodings=ucs-bom,utf-8,cp932,euc-jp,iso-2022-jp,latin1
set encoding=utf-8
set fileformats=unix,dos

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
"}}}
"***** plugins *****"{{{
"--------------------------------------------------------------------------
"*** neobundle.vim *** {{{
if has('vim_starting')
  set rtp+=$USERDIR/bundle/neobundle.vim/
end
call neobundle#begin(expand($USERDIR . '/bundle/'))

NeoBundle       'davidhalter/jedi-vim'
NeoBundle       'gilligan/textobj-lastpaste'
NeoBundle       'JuliaLang/julia-vim'
NeoBundle       'kana/vim-operator-user'
NeoBundle       'kana/vim-operator-replace'
NeoBundle       'kana/vim-smartinput'
NeoBundle       'kana/vim-submode'
NeoBundle       'kana/vim-textobj-user'
NeoBundle       'kana/vim-textobj-indent'
NeoBundle       'kana/vim-textobj-line'
NeoBundle       'machakann/vim-columnmove'
NeoBundle       'machakann/vim-patternjump'
NeoBundle       'machakann/vim-textobj-functioncall'
NeoBundle       'machakann/vim-textobj-delimited'
" NeoBundle       'machakann/vim-textobj-equation'
NeoBundle       'mattn/learn-vimscript'
NeoBundle       'mattn/webapi-vim'
NeoBundle       'osyo-manga/vim-reanimate'
NeoBundle       'osyo-manga/vim-textobj-multitextobj'
NeoBundle       'rhysd/vim-textobj-word-column'
NeoBundle       'rhysd/vim-operator-surround'
NeoBundle       'sgur/vim-textobj-parameter'
NeoBundleFetch  'Shougo/neobundle.vim'
NeoBundle       'Shougo/neomru.vim'
NeoBundle       'Shougo/unite.vim'
NeoBundle       'Shougo/vimproc.vim' , {
                \ 'build' : {
                \     'windows' : 'make -f make_mingw32.mak',
                \     'cygwin'  : 'make -f make_cygwin.mak',
                \     'mac'     : 'make -f make_mac.mak',
                \     'unix'    : 'make -f make_unix.mak',
                \    },}
NeoBundle       'superbrothers/vim-quickrun-markdown-gfm'
NeoBundle       'thinca/vim-prettyprint'
NeoBundle       'thinca/vim-visualstar'
NeoBundle       'thinca/vim-localrc'
NeoBundle       'tommcdo/vim-lion'
NeoBundle       'tpope/vim-markdown'
NeoBundle       'tpope/vim-repeat'
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
NeoBundleLazy   'osyo-manga/vim-watchdogs', {
      \ 'autoload' : {
      \   'filetypes' : ['python', 'matlab'],
      \   },
      \ 'depends' : ['thinca/vim-quickrun','Shougo/vimproc.vim','osyo-manga/shabadou.vim'],
      \ }
NeoBundleLazy   'sjl/gundo.vim', {
      \ 'autoload' : {'commands': 'GundoToggle'}
      \ }
NeoBundleLazy   'Shougo/neocomplete', {
      \ 'autoload' : {'insert' : 1},
      \ }
NeoBundleLazy   'Shougo/neosnippet.vim', {
      \ 'autoload' : {
      \   'insert'    : 1,
      \   'filetypes' : ['neosnippet'],
      \   },
      \ }
NeoBundle       'Shougo/neosnippet-snippets'
NeoBundleLazy   'Shougo/vimfiler', {
      \ 'depends' : 'Shougo/unite.vim',
      \ 'autoload' : {
      \   'commands' : [{ 'name'     : 'VimFiler',
      \                   'complete' : 'customlist,vimfiler#complete' },
      \                 'VimFilerExplorer',
      \                 'Edit', 'Read', 'Source', 'Write'],
      \   'mappings' : ['<Plug>(vimfiler_'],
      \   'explorer' : 1,
      \ }}
NeoBundleLazy   'Shougo/vimshell', {
      \ 'depends' : 'Shougo/vimproc.vim',
      \ 'autoload' : {
      \   'commands' : [{ 'name'     : 'VimShell',
      \                   'complete' : 'customlist,vimshell#complete'},
      \                 'VimShellExecute', 'VimShellInteractive',
      \                 'VimShellTerminal', 'VimShellPop', 'VimShellTab'],
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
NeoBundleLazy   'vim-jp/vital.vim', {
      \ 'autoload' : {
      \   'commands' : 'Vitalize',
      \   }
      \ }

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

if neobundle#tap('vim-smartinput')
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
        \       {'char': '-', 'at': '\%#',          'input': '-',                 'mode': 'i'},
        \       {'char': '-', 'at': '-\%#',         'input': '<BS> - ',           'mode': 'i'},
        \       {'char': '-', 'at': ' - \%#',       'input': '<BS><BS><BS>--',    'mode': 'i'},
        \       {'char': '-', 'at': '--\+\%#',      'input': '-',                 'mode': 'i'},
        \       {'char': '-', 'at': '[(=<>]\s*\%#', 'input': '-',                 'mode': 'i'},
        \      ]
  " '&' -> ' && ' -> '&&' -> '&&&' -> '&&&&' ...
  let rules += [
        \       {'char': '&', 'at': '\%#',     'input': '&',                      'mode': 'i'},
        \       {'char': '&', 'at': '&\%#',    'input': '<BS> && ',               'mode': 'i'},
        \       {'char': '&', 'at': ' && \%#', 'input': '<BS><BS><BS><BS>&&',     'mode': 'i'},
        \       {'char': '&', 'at': '&&\+\%#', 'input': '&',                      'mode': 'i'},
        \       {'char': '&', 'at': ' &\%#\S', 'input': '& ',                     'mode': 'i'},
        \       {'char': '&', 'at': ' &\%#$',  'input': '& ',                     'mode': 'i'},
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
        \       {'char': '<Bar>', 'at': ' |\%#$',  'input': '| ',                 'mode': 'i'},
        \       {'char': '<Bar>', 'at': '\S|\%# ', 'input': '<BS> ||<Right>',     'mode': 'i'},
        \       {'char': '<Bar>', 'at': ' |\%# ',  'input': '|<Right>',           'mode': 'i'},
        \      ]

  " do not apply on 'Comment' or 'String' syntax
  let rules += [
        \       {'char': '<',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '<'},
        \       {'char': '>',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '>'},
        \       {'char': '+',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+'},
        \       {'char': '-',     'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-'},
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
        \       {'char': '=', 'at': '[^= ]\%# ',      'input': ' =<Right>',                                 'mode': 'i'},
        \       {'char': '=', 'at': ' \%# ',          'input': '=<Right>',                                  'mode': 'i'},
        \       {'char': '=', 'at': ' \%#=',          'input': '=<Right> ',                                 'mode': 'i'},
        \       {'char': '=', 'at': ' =\%#',          'input': '= ',                                        'mode': 'i'},
        \       {'char': '=', 'at': ' =\%# ',         'input': '=<Right>',                                  'mode': 'i'},
        \       {'char': '=', 'at': '[-+<>~!] \%#',   'input': '<BS>= ',                                    'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]\%#\S', 'input': '= ',                                        'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]\%#$',  'input': '= ',                                        'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]\%# ',  'input': '=',                                         'mode': 'i'},
        \       {'char': '=', 'at': '\S[-+<>~!]\%#',  'input': '<Left> <Right>= ',                          'mode': 'i'},
        \       {'char': '=', 'at': ' [-+<>~!]= \%#', 'input': '<Left><Left><Left><BS><Right><Right><Del>', 'mode': 'i'},
        \       {'char': '=', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '=',                   'mode': 'i'},
        \      ]

  " in constructing...
  function! Align_equal(pattern, padding)
    let orig_pos = [line("."), col(".")]
    " count a number of words ahead to the pattern (upto 9...)
    " FIXME: number limitation
    let pattern  = '^\s*' . repeat('\(\<\h\k*\>\s*\)\?', 9) . '\s*' . a:pattern
    let n_words  = len(filter(matchlist(getline(orig_pos[0])[0 : orig_pos[1] - 1], pattern), 'v:val != ""')) - 1

    " change the pattern to fit the current line
    let pattern  = '^\s*' . repeat('\(\<\h\k*\>\s*\)', n_words) . '\s*' . a:pattern

    " check the vicinal lines
    let end  = line("$")
    let list = []

    let line = orig_pos[0] - 1
    while match(getline(line), pattern) == 0
      let list += [line]
      let line -= 1
    endwhile

    let line = orig_pos[0] + 1
    while match(getline(line), pattern) == 0
      let list += [line]
      let line += 1
    endwhile

    PP! list

  endfunction

  " smart '<CR>' input
  " delete line end spaces when line-breaking
  let rules += [{'char': '<Plug>(smartinput_CR)', 'at': '\S\s\+\%#', 'input': '<CR><C-o>:call setline(line(''.'')-1, substitute(getline(line(''.'')-1), ''\s\+$'', '''', ''''))<CR>'}]

  " smart quotes input
  let rules += [
        \       {'char': '''', 'at': '\%#',         'input': '''''<Left>', 'mode': 'i:'},
        \       {'char': '''', 'at': '''''''\%#''', 'input': '<Right>',    'mode': 'i:'},
        \       {'char': '''', 'at': '\\\%#',       'input': '''',         'mode': 'i:'},
        \       {'char':  '"', 'at': '\%#',         'input': '""<Left>',   'mode': 'i:'},
        \       {'char':  '"', 'at': '\\\%#',       'input': '"',          'mode': 'i:'},
        \       {'char': '''', 'at': '\w\%#',       'input': '''',         'mode': 'i:'},
        \       {'char': '''', 'at': '\w''\%#''',   'input': '<Del>',      'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*\%#"',                          'input': '""<Left>',   'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#',                     'input': '""',         'mode': 'i:'},
        \       {'char':  '"', 'at': '^\%([^"]*"[^"]*"\)*[^"]*"[^"]*\%#"',                    'input': '<Right>',    'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*\%#''',                    'input': '''''<Left>', 'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*[^A-Za-z'']''[^'']*\%#',   'input': '''''',       'mode': 'i:'},
        \       {'char': '''', 'at': '^\%([^'']*''[^'']*''\)*[^'']*[^A-Za-z'']''[^'']*\%#''', 'input': '<Right>',    'mode': 'i:'},
        \      ]

  " correspondent parentheses
  let rules += [
        \       {'char': '(',    'at': '\%#',       'input': '()<Left>',                                           'mode': 'i:/?'},
        \       {'char': ')',    'at': '\%#\_s*)',  'input': '<C-r>=smartinput#_leave_block('')'')<Enter><Right>', 'mode': 'i:/?'},
        \       {'char': '(',    'at': '\\\%#',     'input': '(',                                                  'mode': 'i:/?'},
        \       {'char': '[',    'at': '\%#',       'input': '[]<Left>',                                           'mode': 'i:/?'},
        \       {'char': ']',    'at': '\%#\_s*\]', 'input': '<C-r>=smartinput#_leave_block('']'')<Enter><Right>', 'mode': 'i:/?'},
        \       {'char': '[',    'at': '\\\%#',     'input': '[',                                                  'mode': 'i:/?'},
        \       {'char': '{',    'at': '\%#',       'input': '{}<Left>',                                           'mode': 'i:/?'},
        \       {'char': '}',    'at': '\%#\_s*}',  'input': '<C-r>=smartinput#_leave_block(''}'')<Enter><Right>', 'mode': 'i:/?'},
        \       {'char': '{',    'at': '\\\%#',     'input': '{',                                                  'mode': 'i:/?'},
        \      ]

  " delete correspondent parentheses and quotes
  let rules += [
        \       {'char': '<Plug>(smartinput_BS)', 'at': '(\%#)',      'input': '<BS><Del>', 'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '()\%#',      'input': '<BS><BS>',  'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\[\%#\]',    'input': '<BS><Del>', 'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\[\]\%#',    'input': '<BS><BS>',  'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '{\%#}',      'input': '<BS><Del>', 'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '{}\%#',      'input': '<BS><BS>',  'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '''\%#''',    'input': '<BS><Del>', 'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '''''\%#',    'input': '<BS><BS>',  'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '''''\%#''',  'input': '<BS><BS>',  'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '"\%#"',      'input': '<BS><Del>', 'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '""\%#',      'input': '<BS><BS>',  'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '""\%#"',     'input': '<BS><BS>',  'mode': 'i:/?'},
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
        \       {'char': ',', 'at': '\%#',    'input': ', ',     'mode': 'i'},
        \       {'char': ',', 'at': ', \%#',  'input': '<BS>',   'mode': 'i'},
        \       {'char': ',', 'at': '\%# ',   'input': ',',      'mode': 'i'},
        \       {'char': '(', 'at': '\C^[hH]elp \w\+\%#', 'input': '(', 'mode': ':'},
        \       {'char': '=', 'at': '\C\<set\> \w\+\%#',  'input': '=', 'mode': ':'},
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
        \       {'char': ')',     'at': '\%#\\)',     'input': '<Right><Right>',             'mode': 'i:/?'},
        \       {'char': ']',     'at': '\%#\\\]',    'input': '<Right><Right>',             'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_^k)', 'at': '(\%#',        'input': '<BS><Del>\%(\)<Left><Left>', 'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_^k)', 'at': '\\%(\%#\\)',  'input': '<Left><BS><Right>',          'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_^k)', 'at': '\\(\%#\\)',   'input': '<Left>%<Right>',             'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_^k)', 'at': '\\)\%#',      'input': '<Left><Left>)',              'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_^k)', 'at': '\[\%#',       'input': '<BS>\[\]<Left><Left>',       'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_^k)', 'at': '\\]\%#',      'input': '<Left><Left>]',              'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\\%(\%#\\)',  'input': '<BS><BS><BS><Del><Del>',     'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\\(\%#\\)',   'input': '<BS><BS><Del><Del>',         'mode': 'i:/?'},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\\\[\%#\\\]', 'input': '<BS><BS><Del><Del>',         'mode': 'i:/?'},
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
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ==# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ==? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !=# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !=? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' ># \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >? \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >=# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' >=? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <# \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <? \%#',   'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <=# \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' <=? \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~ \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~# \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' =\~? \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~ \%#',  'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~# \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' !\~? \%#', 'input': '<BS><BS> ',    'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '"\s\%#',    'input': '<BS><BS>',     'filetype': ['vim']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': ' \. \%#',   'input': '<BS><BS><BS>', 'filetype': ['vim']},
        \       {'char': '=', 'at': '\. \%#',   'input': '<BS>= ',                                    'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.\%#\S', 'input': '= ',                                        'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.\%#$',  'input': '= ',                                        'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.\%# ',  'input': '=',                                         'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': '\S\.\%#',  'input': '<Left> <Right>= ',                          'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': ' \.= \%#', 'input': '<Left><Left><Left><BS><Right><Right><Del>', 'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': '<C-r>\%#', 'input': '=',                                         'mode': 'i:', 'filetype': ['vim']},
        \       {'char': '=', 'at': '\C\<set\%[local]\> \w\+\%#', 'input': '=',                        'mode':  'i', 'filetype': ['vim']},
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

  " common in matlab, scilab and julia
  " ' + ' -> '+' -> '++' -> '+++' ...
  let rules += [
        \       {'char': '+', 'at': '\%#',    'input': ' + ',           'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '+', 'at': ' + \%#', 'input': '<BS><BS><BS>+', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '+', 'at': '+\%#',   'input': '+',             'filetype': ['matlab', 'scilab', 'julia']},
        \      ]
  " ' - ' -> '-' -> '--' -> '---' ...
  let rules += [
        \       {'char': '-', 'at': '\%#',    'input': ' - ',           'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '-', 'at': ' - \%#', 'input': '<BS><BS><BS>-', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '-', 'at': '-\%#',   'input': '-',             'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '-', 'at': '\c[(=<>,ed]\s*\%#', 'input': '-',  'filetype': ['matlab', 'scilab', 'julia']},
        \      ]
  " '.^' -> '^' -> '^^' -> '^^^' ...
  let rules += [
        \       {'char': '^', 'at': '\%#',    'input': '.^',        'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '^', 'at': '\.^\%#', 'input': '<BS><BS>^', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '^', 'at': '\^\%#',  'input': '^',         'filetype': ['matlab', 'scilab', 'julia']},
        \      ]
  " '.*' -> '*' -> '**' -> '***' ...
  let rules += [
        \       {'char': '*', 'at': '\%#',     'input': '.*',        'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '*', 'at': '\.\*\%#', 'input': '<BS><BS>*', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '*', 'at': '\*\%#',   'input': '*',         'filetype': ['matlab', 'scilab', 'julia']},
        \      ]
  " './' -> '/' -> '//' -> '///' ...
  let rules += [
        \       {'char': '/', 'at': '\%#',    'input': './',        'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '/', 'at': '\./\%#', 'input': '<BS><BS>/', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '/', 'at': '/\%#',   'input': '/',         'filetype': ['matlab', 'scilab', 'julia']},
        \      ]

  let rules += [
        \       {'char': '+', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '-', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '^', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '^', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '*', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '*', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '/', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '/', 'filetype': ['matlab', 'scilab', 'julia']},
        \       {'char': '<Plug>(smartinput_BS)', 'at': '\.[*/^]\%#', 'input': '<BS><BS>', 'filetype': ['matlab', 'scilab', 'julia']},
        \      ]

  " FORTRAN
  let rules += [
        \       {'char': ':', 'at': '^\s*\%(integer\|real\|double precision\|complex\|complex(kind(0d0))\|logical\|character\)\%((\d\+)\)\?\%(\s*,\s*\%(dimension(\d\+\%(,\s*\d\+\))\|parameter\|allocatable\|intent(\%(in\|out\|inout\))\)\)\?\%#', 'input': ' :: ', 'mode': 'i', 'filetype': ['fortran']},
        \       {'char': ':', 'at': '^\s*type(\h\w\*)\%(,\s*\%(dimension(\d\+\%(,\s*\d\+\))\|parameter\|allocatable\)\)\?\%#', 'input': ' :: ', 'mode': 'i', 'filetype': ['fortran']},
        \       {'char': ':', 'at': '^\s*\%(private\|public\)\%#', 'input': ' :: ', 'mode': 'i', 'filetype': ['fortran']},
        \       {'char': ':', 'at': ' :: \%#', 'input': '<BS><BS><BS><BS>:', 'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '=', 'at': '/ \%#',   'input': '<BS>= ',                                     'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '=', 'at': ' /\%#\S', 'input': '= ',                                         'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '=', 'at': ' /\%#$',  'input': '= ',                                         'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '=', 'at': ' /\%# ',  'input': '=',                                          'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '=', 'at': '\S/\%#',  'input': '<Left> <Right>= ',                           'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '=', 'at': ' /= \%#', 'input': '<Left><Left><Left><BS><Right><Right><Del>',  'mode': 'i', 'filetype': ['fortran']},
        \      ]
  " ' + ' -> '+' -> '++' -> '+++' ...
  let rules += [
        \       {'char': '+', 'at': '\%#',    'input': ' + ',           'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '+', 'at': ' + \%#', 'input': '<BS><BS><BS>+', 'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '+', 'at': '+\%#',   'input': '+',             'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '+', 'at': ' \%#',   'input': '+ ',            'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '+', 'at': ' \%# ',  'input': '+<Right>',      'mode': 'i', 'filetype': ['fortran']},
        \      ]
  " ' - ' -> '-' -> '--' -> '---' ...
  let rules += [
        \       {'char': '-', 'at': '\%#',    'input': ' - ',           'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '-', 'at': ' - \%#', 'input': '<BS><BS><BS>-', 'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '-', 'at': '-\%#',   'input': '-',             'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '-', 'at': ' \%#',   'input': '- ',            'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '-', 'at': ' \%# ',  'input': '-<Right>',      'mode': 'i', 'filetype': ['fortran']},
        \       {'char': '-', 'at': '\c[(=<>,ed]\s*\%#', 'input': '-',       'mode': 'i', 'filetype': ['fortran']},
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

  let rules += [
        \       {'char': '+', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '+', 'filetype': ['c']},
        \       {'char': '-', 'at': '\%#', 'syntax': ['Comment', 'String'], 'input': '-', 'filetype': ['c']},
        \      ]

  for item in rules
    call smartinput#define_rule(item)
  endfor
  unlet item
  unlet rules
  let g:is_smartinput_active = 1

  " These mappings would be re-written somewhere else.
  " But required just for safety-net.
  imap <BS>  <Plug>(smartinput_BS)
  cmap <BS>  <Plug>(smartinput_BS)
  imap <CR>  <Plug>(smartinput_CR)
  imap <C-k> <Plug>(smartinput_^k)
  cmap <C-k> <Plug>(smartinput_^k)

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
  function! Operator_caw(type)
    " this could be modified but menndoi.
    execute "'[,']normal \<Plug>(caw:i:toggle)"
  endfunction

  command! -nargs=0 CawToggle normal <Plug>(caw:i:toggle)

  nnoremap <silent> <Space>c  :<C-u>set operatorfunc=Operator_caw<CR>g@
  nnoremap <silent> <Space>cc :<C-u>CawToggle<CR>
  xnoremap <silent> <Space>c  <Esc>:set operatorfunc=Operator_caw<CR>gvg@
endif
"}}}
"*** columnmove *** {{{
if neobundle#tap('vim-columnmove')
  let g:columnmove_auto_scroll = 1
  " let g:columnmove_strict_wbege = 0
  let g:columnmove_fold_open = {'x' : &foldnestmax, 'o' : &foldnestmax}

  nnoremap <silent> <M-o> :<C-u>call columnmove#e('n', 0, {'strict_wbege':0})<CR>o
  nnoremap <silent> <M-O> :<C-u>call columnmove#b('n', 0, {'strict_wbege':0})<CR>o
endif
"}}}
"*** jedi.vim *** {{{
if neobundle#tap('jedi-vim')
  let g:jedi#auto_initialization = 1
  let g:jedi#rename_command = "<leader>R"
  let g:jedi#popup_on_dot = 0
  autocmd vimrc FileType python setlocal omnifunc=jedi#completions
endif
"}}}
"*** neocomplete.vim *** {{{
if neobundle#tap('neocomplete')
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
    " <CR>: close popup and save indent.
    imap <silent><expr> <CR> neocomplete#smart_close_popup() . "\<Plug>(smartinput_CR)"
    " <TAB>: completion.
    " inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    imap <expr> <C-h> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
    imap <expr> <BS> neocomplete#smart_close_popup() . "\<Plug>(smartinput_BS)"
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
if neobundle#tap('neosnippet.vim')
  imap <expr> <C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<Plug>(smartinput_^k)"
  smap        <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap        <C-k> <Plug>(neosnippet_expand_target)
  xmap        <C-l> <Plug>(neosnippet_start_unite_snippet_target)

  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory = $USERDIR . '/snippets'

  " For snippet_complete marker.
  if has('conceal')
    set conceallevel=2 concealcursor=i
  endif
endif
"}}}
"*** operator-surround *** {{{
if neobundle#tap('vim-operator-surround')
  map s <NOP>

  " operator mappings
  map <silent> sa <Plug>(operator-surround-append)
  map <silent> sd <Plug>(operator-surround-delete)
  map <silent> sr <Plug>(operator-surround-replace)
endif
"}}}
"*** patternjump *** {{{
if neobundle#tap('vim-patternjump')
"   let g:patternjump_highlight = 1
  let g:patternjump_swap_head_tail = 1
  let g:patternjump_caching        = 1
  let g:patternjump_move_afap      = 1

  let g:patternjump_patterns = {
    \ '_' : {
    \   'i' : {
    \     'head' : ['^\s*\zs\S', ',', ')', ']', '}', '$'],
    \     'tail' : ['\<\h\k*\>', '[^.deDE-]\zs-\?\<\d\+\%(\.\d*\)\?\%([deDE]-\?\d\+\)\?\>'],
    \     },
    \   'n' : {
    \     'head' : ['[[({''"]\+\zs\k'],
    \     },
    \   'x' : {
    \     'tail' : ['\<\h\k*\>'],
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
    \ 'vim' : {
    \   'i' : {
    \     'head' : ['^\s*\zs\S', ',', ')', ']', '}', '$'],
    \     'tail' : ['\<\h\k*\>', '[^.deDE-]\zs-\?\<\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'],
    \     },
    \   'n' : {
    \     'head' : ['^\s*\\\s*\zs\S', '[[({''"]\+\zs\k'],
    \     },
    \   'x' : {
    \     'tail' : ['^\s*\\\s*\zs\S', '\%(^\|[^:]\)\zs\<\%([abglstvw]:\)\?\h\k*\>', '[^.deDE-]\zs-\?\<\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'],
    \     },
    \   'o' : {
    \     'forward'  : {'tail_inclusive' : ['\%(^\|[^:]\)\zs\<\%([abglstvw]:\)\?\h\k*\>', '[^.deDE-]\zs-\?\<\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']},
    \     'backward' : {'head_inclusive' : ['\%(^\|[^:]\)\zs\<\%([abglstvw]:\)\?\h\k*\>', '[^.deDE-]\zs-\?\<\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']},
    \     },
    \   },
    \ }

  nnoremap <silent> w :<C-u>call patternjump#forward('n', [['\%(^\\|[^:]\)\zs\<\%([abglstvw]:\)\?\h\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'], []], 0)<CR>
  nnoremap <silent> e :<C-u>call patternjump#forward('n', [[], ['\%(^\\|[^:]\)\zs\<\%([abglstvw]:\)\?\h\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']], 0)<CR>
  nnoremap <silent> b :<C-u>call patternjump#backward('n', [['\%(^\\|[^:]\)\zs\<\%([abglstvw]:\)\?\h\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>'], []], 0)<CR>
  nnoremap <silent> ge :<C-u>call patternjump#backward('n', [[], ['\%(^\\|[^:]\)\zs\<\%([abglstvw]:\)\?\h\k*\>', '[^.deDE-]\zs\<-\?\d\+\%(\.\d\+\)\?\%([eE]-\?\d\+\)\?\>']], 0)<CR>
endif
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
        \ 'julia' : {
        \       'command': 'julia',
        \       'cmdopt': '-q --color=no',
        \       'runner': 'process_manager',
        \       'runner/process_manager/load': 'include(%s:p)',
        \       'runner/process_manager/prompt': 'julia> ',
        \       'hook/eval/enable': 1,
        \       'hook/eval/template': "%s\nprintln(\"julia> \")",
        \       },
        \ 'maxima' : {
        \       'command': 'maxima',
        \       'cmdopt': '-q -b',
        \       'runner': 'process_manager',
        \       'runner/process_manager/load': has('win32') ? &shellslash ? 'batch("%S:gs?/?\\\\\\\\\\?");' : 'batch(%s:gs?\\?\\\\\\\\);' : 'batch(%s)',
        \       'runner/process_manager/prompt': '(%[io]\d\+)'
        \       },
        \ 'markdown' : {
        \       'type' : 'markdown/gfm',
        \       'outputter': 'browser',
        \       'hook/time/enable' : 0,
        \       },
        \ 'tex' : {
        \       'command' : 'platex',
        \       },
        \ 'scilab'  : {
        \       'command': has('win32') ? 'scilex' : 'scilab-adv-cli',
        \       'cmdopt': '-l en -nb -nw -f',
        \       'runner': 'process_manager',
        \       'runner/process_manager/load': 'exec(%s,-1)',
        \       'runner/process_manager/prompt': '-->',
        \       'hook/output_encode/encoding' : has('win32') ? 'utf-8:cp932' : '&fileencoding',
        \       'hook/eval/enable': 1,
        \       'hook/eval/template': "%s\nmfprintf(6, '-->')",
        \       },
        \ 'r'   : {
        \       'command': has('win32') ? 'Rscript' : 'R',
        \       'exec': has('win32') ? '%c %o --no-save --slave %a %s' : 'sh -c ''%c %o --no-save --slave %a < %s''',
        \       },
        \ 'vim/owl_test' : {
        \       'command': ':source',
        \       'exec'   : ["%C %s", "call owl#run('%s')"],
        \       'outputter' : "buffer",
        \       'runner' : "vimscript",
        \       },
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
endif
"}}}
"*** textobj-lastpaste *** {{{
let g:textobj_lastpaste_no_default_key_mappings = 1
omap gm <Plug>(textobj-lastpaste-i)
xmap gm <Plug>(textobj-lastpaste-i)
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
  nnoremap [Unite]o :Unite outline<CR>

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
  let g:reanimate_sessionoptions="curdir,folds,globals,help,slash,tabpages"

  call unite#custom#default_action('reanimate', 'reanimate_load')
  nnoremap <Space>ur :Unite -auto-resize reanimate<CR>
endif
"}}}
"*** vim-operator-replace *** {{{
if neobundle#tap('vim-operator-replace')
  nmap <Space>r <Plug>(operator-replace)
  xmap <Space>r <Plug>(operator-replace)
endif
"}}}
"*** vim-textobj-multitextobj ***"{{{
let g:textobj_multitextobj_textobjects_i = [[
      \   {'textobj': "i'", 'is_cursor_in': 1},
      \   {'textobj': 'i"', 'is_cursor_in': 1},
      \   {'textobj': 'i`', 'is_cursor_in': 1},
      \   'i(',
      \   'i[',
      \   'i{',
      \ ]]

let g:textobj_multitextobj_textobjects_a = [[
      \   {'textobj': "2i'", 'is_cursor_in': 1},
      \   {'textobj': '2i"', 'is_cursor_in': 1},
      \   {'textobj': '2i`', 'is_cursor_in': 1},
      \   'a(',
      \   'a[',
      \   'a{',
      \ ]]

omap ib <Plug>(textobj-multitextobj-i)
xmap ib <Plug>(textobj-multitextobj-i)
omap ab <Plug>(textobj-multitextobj-a)
xmap ab <Plug>(textobj-multitextobj-a)
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

  if has('win32')
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

  autocmd vimrc FileType vimfiler setlocal nowrap
  autocmd vimrc FileType vimfiler setlocal nonumber
  autocmd vimrc FileType vimfiler nmap <buffer><nowait> <Space> <Plug>(vimfiler_toggle_mark_current_line)
endif
"}}}
" *** watchdogs *** {{{
if neobundle#tap('vim-watchdogs')
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
endif
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
set virtualedit=block               " freely cursor movement in blockwise visual mode
set whichwrap=b,s,h,l,<,>,[,]       " do not stop cursor at head/tail of line, move to tail/head of previous/next line

" indentation option
set autoindent                      " add indent automatically
set cindent                         " use c style indentation
set expandtab                       " use soft tabs
set tabstop=4                       " the width of a tab character
let &softtabstop = &tabstop         " inserted number of space by a tab stroke or deleted number of space by a BS stroke
let &shiftwidth = &tabstop          " the indentation width for autoindent
set shiftround                      " round the indent width to the number of 'indentwidth' option when indented by '<' or '>'

" jump to the point where to have been edited last time when opening file
autocmd vimrc BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" im control (for win, and partially for *nix)
if has('win32') || (has('unix') && &imactivatefunc != '' && &imactivatekey != '')
  function! s:im_switch()
    let b:iminsert = &iminsert

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
      let temp = @*
      normal! "*yl

      if strlen(@*) != strchars(@*)
        " contains multibyte character
        setl iminsert=2
      elseif @* =~ '\n\+'
        let &l:iminsert = b:iminsert
      else
        setl iminsert=0
      endif

      let @* = temp
    endif
  endfunction

  function! s:insert_enter_with_c()
    let b:entering_with_c = 1
    return 'c'
  endfunction

  function! s:switch_with_shift_space()
    " FIXME: it cannot be toggle!
    "        cannot capture <S-Space> when im is on.
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
    autocmd im_auto_switch BufRead * autocmd im_auto_switch InsertEnter <buffer> call s:im_auto_switch_bootstrap()
    autocmd im_auto_switch SessionLoadPost * autocmd im_auto_switch InsertEnter <buffer> call s:im_auto_switch_bootstrap()
    autocmd im_auto_switch SourceCmd ~/.vimrc doautoall im_auto_switch BufRead
  augroup END

  command! IMAutoSwitchStart call s:im_auto_switch_start()
  command! IMAutoSwitchStop  call s:im_auto_switch_stop()
endif
"}}}
"***** displaying ***** {{{
"--------------------------------------------------------------------------
colorscheme mckn
set cmdheight=2                     " the height of commandline
set cursorline                      " highlight corsor line
set laststatus=2                    " always display status line
set list                            " visualize special characters
set listchars=tab:>-,trail:-,eol:$,nbsp:%,extends:>,precedes:<
                                    " assign alternative expression for special characters
set number                          " display row number
set showbreak=-\                    " display the sign for wrapped lines
set showcmd                         " display command information in commandline
set showmode                        " display current mode
set showmatch                       " emphasize correspondent parenthesis
set scrolloff=5                     " vertical scroll margin
set sidescrolloff=10                " horizontal scroll margin
set t_Co=256                        " use 256 coloring in modern terminal emulator
set title                           " display title

" wrapping
if (v:version > 704) || ((v:version == 704) && (has("patch338")))
  set wrap
  set breakindent

  autocmd vimrc BufEnter * let &l:breakindentopt = 'min:20,shift:' . &shiftwidth
else
  set nowrap                        " do not wrap in long line
endif

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
" let &stl.=" LN %l/%L\ | "
" percentage done
" let &stl.="%p%% | "
" column number
" let &stl.="COL %c%V |"
"}}}
"***** filetype settings ***** {{{
" These settings would be moved to ftplugin/$filetype.vim gradually
"-------------------------------------------------------------------------
"*** AutoHotkey ***
autocmd vimrc FileType autohotkey setlocal dictionary+=$USERDIR/dict/AHK.dict foldmethod=marker commentstring=;%s

"*** scilab ***"
autocmd vimrc FileType scilab setlocal omnifunc=scilabcomplete#Complete

"*** FORTRAN ***"
autocmd vimrc BufRead,BufNewFile *.f90 let b:fortran_do_enddo=1
                              \| let b:fortran_fold=1
                              \| let b:fortran_more_precise=1

"*** help ***"
autocmd vimrc FileType help vertical resize 78

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

  if len(qflist) == 0
    cclose
  else
    if exists(':HierUpdate') == 2
      HierUpdate
    endif
    copen
  endif
endfunction

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
"***** user defined commands ***** {{{
"-------------------------------------------------------------------------
"*** edit japanese *** {{{
command! -nargs=0 EditJapaneseTXT :call s:edit_ja()
function! s:edit_ja()
  setlocal wrap                     " use wrap in long line
  setlocal iminsert=2               " turn on ime when getting into insert mode
  setlocal display&
  setlocal display+=lastline        " display lower line as long as possible
  if exists(":JpFormatToggle")
    JpFormatToggle
    let b:JpCountChars = 46         " paper width
    let b:JpCountLines = 38         " line width
    let JpCountOverChars = 1
  endif

  if has('kaoriya') || has('gui_running')
    setlocal ambiwidth=auto         " cursor displaying optimization
  else
    setlocal ambiwidth=double
  endif
endfunction
"}}}
"*** edit english ***""{{{
command! -nargs=0 EditEnglishTXT :call s:edit_en()
function! s:edit_en()
  setlocal wrap                     " use wrap in long line
  setlocal iminsert=0               " turn off ime when getting into insert mode
  setlocal spellcapcheck            " check sentence case
  source $USERDIR/dict/auto_correct.vim
endfunction
"}}}
" RegCopy     - Function to copy the content of a register to the other one. {{{
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

  call setreg(DestReg, getreg(SourceReg), getregtype(SourceReg))
  echo 'Regcopy : @' . SourceReg . ' ---> @' . DestReg
endfunction "}}}

command! -nargs=+ -bang RegCopy call RegCopy('<bang>',<f-args>)
"}}}
" RegExchange - Function to exchange each content of two registers. {{{
function! RegExchange(...) "{{{
  let ExcReg1 = a:1[0]

  if a:0 > 1
    let ExcReg2 = a:2[0]
  else
    let ExcReg2 = v:register
  endif

  let temp = [getreg(ExcReg2), getregtype(ExcReg2)]
  call setreg(ExcReg2, getreg(ExcReg1), getregtype(ExcReg1))
  call setreg(ExcReg1,         temp[0],             temp[1])
  echo 'Regexc : @' . l:ExcReg1 . ' <--> @' . l:ExcReg2
endfunction "}}}

command! -nargs=+ RegExchange call RegExchange(<f-args>)
"}}}
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
xnoremap Y y`>

" line-break without any change to current line in insert mode
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

  return
endfunction

" check syntax group of the character under the cursor
nnoremap \s :echo map(synstack(line('.'), col('.')), 'synIDattr(synIDtrans(v:val), "name")')<CR>

" getting into insert mode after moving cursor
nnoremap <M-i> bi
nnoremap <M-a> ea

" reserve black hole register for the next operator
nnoremap \d "_

" delete all strings in the current line behind cursor
inoremap <silent> <C-U> <Esc>:call setline('.', getline('.')[: col('.') - 1])<CR>A

" textobject a' and a" is not so convenient
onoremap a' 2i'
xnoremap a' 2i'
onoremap a" 2i"
xnoremap a" 2i"

" enabling 'f' and 't' commands to use string class {{{
function! s:f_knows_string_class(mode, pattern, is_t, is_capital)
  let line = line('.')
  let col  = col('.')
  let flag = ''

  if a:is_capital
    let flag .= 'b'
  endif

  if (a:mode ==# 'o') && !a:is_capital
    normal! v
  endif

  let l:count = 0
  while l:count < v:count1
    let l:count += 1
    let dest = searchpos(a:pattern, flag, line)
  endwhile

  if dest != [0, 0]
    if a:is_t
      if a:is_capital
        normal! l
      else
        normal! h
      endif
    endif
  else
    call cursor(line, col)
  endif

  return
endfunction

nnoremap f\\ f\
nnoremap F\\ F\
nnoremap t\\ t\
nnoremap T\\ T\
xnoremap f\\ f\
xnoremap F\\ F\
xnoremap t\\ t\
xnoremap T\\ T\
onoremap f\\ f\
onoremap F\\ F\
onoremap t\\ t\
onoremap T\\ T\
let string_class = [ '\i',  '\I',  '\k',  '\K',  '\f',  '\F',  '\p',  '\P',  '\s',  '\S',  '\d',  '\D',  '\x',  '\X',  '\o',  '\O',  '\w',  '\W',  '\h',  '\H',  '\a',  '\A',  '\l',  '\L',  '\u',  '\U',
      \             '\_i', '\_I', '\_k', '\_K', '\_f', '\_F', '\_p', '\_P', '\_s', '\_S', '\_d', '\_D', '\_x', '\_X', '\_o', '\_O', '\_w', '\_W', '\_h', '\_H', '\_a', '\_A', '\_l', '\_L', '\_u', '\_U' ]
for key in string_class
  execute 'nnoremap <silent> f' . key . " :<C-u>call <SID>f_knows_string_class('n', '" . key . "', 0, 0)<CR>"
  execute 'nnoremap <silent> t' . key . " :<C-u>call <SID>f_knows_string_class('n', '" . key . "', 1, 0)<CR>"
  execute 'nnoremap <silent> F' . key . " :<C-u>call <SID>f_knows_string_class('n', '" . key . "', 0, 1)<CR>"
  execute 'nnoremap <silent> T' . key . " :<C-u>call <SID>f_knows_string_class('n', '" . key . "', 1, 1)<CR>"
  execute 'xnoremap <silent> f' . key . " :<C-u>call <SID>f_knows_string_class('v', '" . key . "', 0, 0)<CR>"
  execute 'xnoremap <silent> t' . key . " :<C-u>call <SID>f_knows_string_class('v', '" . key . "', 1, 0)<CR>"
  execute 'xnoremap <silent> F' . key . " :<C-u>call <SID>f_knows_string_class('v', '" . key . "', 0, 1)<CR>"
  execute 'xnoremap <silent> T' . key . " :<C-u>call <SID>f_knows_string_class('v', '" . key . "', 1, 1)<CR>"
  execute 'onoremap <silent> f' . key . " :<C-u>call <SID>f_knows_string_class('o', '" . key . "', 0, 0)<CR>"
  execute 'onoremap <silent> t' . key . " :<C-u>call <SID>f_knows_string_class('o', '" . key . "', 1, 0)<CR>"
  execute 'onoremap <silent> F' . key . " :<C-u>call <SID>f_knows_string_class('o', '" . key . "', 0, 1)<CR>"
  execute 'onoremap <silent> T' . key . " :<C-u>call <SID>f_knows_string_class('o', '" . key . "', 1, 1)<CR>"
endfor
"}}}
"}}}
"***** macros ***** {{{
" I think macros can be regarded as keymappings which can be re-written
" casually and instantly starting from '@' prefix.

let g:macros   = {}
" increment file number
let g:macros.a = "0t.7hi \<Esc>\<C-a>F xj"
let g:macros.x = "0t.7hi \<Esc>\<C-x>F xj"
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
"}}}
"***** playpit ***** {{{
" textobj-instant
onoremap <silent> iI :<C-u>call Textobj_instant()<CR>
xnoremap <silent> iI :<C-u>call Textobj_instant()<CR>

" Prepare preset patterns
" What kinds of characters can be used (and can not be used) for <Plug>?
" kore zenbu 'iW' de iina...
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
  let output = patternjump#forward('n', [[], patterns], v:count1, {'raw' : 2, 'highlight' : 0, 'caching' : 0, 'debug_mode' : 0, 'wrap_line' : 0, 'move_afap' : 0})

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

command! -nargs=1 TextobjInstantAdd let g:textobj_instant_patterns += [<q-args>]
command! -nargs=1 TextobjInstantDel call filter(g:textobj_instant_patterns, 'v:val != <q-args>')
command!          TextobjInstantClr let g:textobj_instant_patterns = []

" textobj-number
" NOTE: Fortran allows the expression ended with dot, like 1. (= 1.0), 1.d0 (= 1.0d0)
"       In addition to that, following description also valid. .5 (= 0.5), -.5 (= -0.5)
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
  \     'pattern': '-\?\%(\d\+\%(\.\d*\)\?\|\.\d\+\)\%([deDE]-\?\d\+\)\?',
  \     'select': 'in',
  \   },
  \   'number-a': {
  \     'pattern': '\s*-\?\%(\d\+\%(\.\d*\)\?\|\.\d\+\)\%([deDE]-\?\d\+\)\?\s*',
  \     'select': 'an',
  \   },
  \ })

" operator-insertion
" To use with textobject 'gn', I optimized the final position of cursor.
" But now I found the current situation has a problem with 'gN'.

" Solution : Use ':%s/\(bar\)/foo\1/gc' to convert 'bar' to 'foobar'.
" Shitteta.

nnoremap <silent> \i :<C-u>call Operator_insertion_map_clerk('n', 'i')<CR>
xnoremap <silent> \i :<C-u>call Operator_insertion_map_clerk('v', 'i')<CR>
nnoremap <silent> \a :<C-u>call Operator_insertion_map_clerk('n', 'a')<CR>
xnoremap <silent> \a :<C-u>call Operator_insertion_map_clerk('v', 'a')<CR>
nnoremap <silent> \p :<C-u>set operatorfunc=Operator_paste_to_tail<CR>g@
xnoremap <silent> \p <Esc>:set operatorfunc=Operator_paste_to_tail<CR>gvg@
nnoremap <silent> \P :<C-u>set operatorfunc=Operator_paste_to_head<CR>g@
xnoremap <silent> \P <Esc>:set operatorfunc=Operator_paste_to_head<CR>gvg@

function! Operator_insertion_map_clerk(mode, iora)
  let text = input("Insertion:", "", "buffer")
  let g:last_insertion = (text != '') ? text :
                       \ exists('g:last_insertion') ? g:last_insertion : ''

  if g:last_insertion != ''
    if a:iora ==# 'i'
      set operatorfunc=Operator_insertion
    elseif a:iora ==# 'a'
      set operatorfunc=Operator_appendage
    endif

    if a:mode ==# 'v'
      normal! gv
    endif

    call feedkeys('g@', 'n')
  endif
endfunction

function! Operator_insertion(type)
  let head_edge = [line("'["), col("'[")]
  let tail_edge = [line("']"), col("']")]
  let final_pos = copy(tail_edge)

  let text = repeat(g:last_insertion, (v:prevcount == 0 ? 1 : v:prevcount))

  let text_lines = split(text, "\n", 1)
  let line_inc   = len(text_lines) - 1

  if head_edge[0] == tail_edge[0]
    if line_inc > 0
      let final_pos[0] += line_inc
      let final_pos[1]  = len(get(text_lines, -1, '')) + (tail_edge[1] - head_edge[1]) + 2
    else
      let final_pos[0] += line_inc
      let final_pos[1] += len(get(text_lines, -1, '')) + 1
    endif
  else
    if (col([line("']"), "$"]) - 1) == tail_edge[1]
      let final_pos[0] += line_inc + 1
      let final_pos[1]  = 1
    else
      let final_pos[0] += line_inc
      let final_pos[1] += 1
    endif
  endif

  execute "normal! `[i" . text . "\<Esc>`["
  call cursor(final_pos)
endfunction

function! Operator_appendage(type)
  execute "normal! `]a" . repeat(g:last_insertion, (v:prevcount == 0 ? 1 : v:prevcount)) . "\<Esc>`]"
endfunction

function! Operator_paste_to_head(type)
  let reg_value = getreg()
  let reg_type  = getregtype()

  if reg_type != ""
    let head_edge = [line("'["), col("'[")]
    let tail_edge = [line("']"), col("']")]
    let final_pos = copy(tail_edge)

    if reg_type ==# 'v'
      " characterwise
      let text = repeat(reg_value, (v:prevcount == 0 ? 1 : v:prevcount))
      call setreg(v:register, text, reg_type)

      let text_lines = split(text, "\n", 1)
      let line_inc   = len(text_lines) - 1

      if head_edge[0] == tail_edge[0]
        if line_inc > 0
          let final_pos[0] += line_inc
          let final_pos[1]  = len(get(text_lines, -1, '')) + (tail_edge[1] - head_edge[1]) + 2
        else
          let final_pos[0] += line_inc
          let final_pos[1] += len(get(text_lines, -1, '')) + 1
        endif
      else
        if (col([line("']"), "$"]) - 1) == tail_edge[1]
          let final_pos[0] += line_inc + 1
          let final_pos[1]  = 1
        else
          let final_pos[0] += line_inc
          let final_pos[1] += 1
        endif
      endif
    elseif reg_type ==# "V"
      " linewise
      let text = repeat(reg_value, (v:prevcount == 0 ? 1 : v:prevcount))
      call setreg(v:register, text, reg_type)
      let final_pos[0] += len(split(reg_value, "\n")) + 1
      let final_pos[1]  = 0
    elseif reg_type =~# "\<C-v>\\d\\+"
      " blockwise
      let text = join(map(split(reg_value, "\n", 1), 'repeat(v:val, (v:prevcount == 0 ? 1 : v:prevcount))'), "\n")
      call setreg(v:register, text, reg_type)
      let final_pos[1] += len(split(text, "\n")[0]) + 1
    endif

    execute 'normal! `["' . v:register . 'P'
    call setreg(v:register, reg_value, reg_type)
    call cursor(final_pos)
  endif
endfunction

function! Operator_paste_to_tail(type)
  let reg_value = getreg()
  let reg_type  = getregtype()

  if reg_type != ""
    if reg_type ==? 'v'
      call setreg(v:register, repeat(reg_value, (v:prevcount == 0 ? 1 : v:prevcount)), reg_type)
    else
      call setreg(v:register, join(map(split(reg_value, "\n", 1), 'repeat(v:val, (v:prevcount == 0 ? 1 : v:prevcount)'), "\n"), reg_type)
    endif

    execute 'normal! `]"' . v:register . 'p`]'
    call setreg(v:register, reg_value, reg_type)
  endif
endfunction

" simple speed checker
function! Speed_gun(...)
  let l:count = a:0 > 0 ? a:1 : 10
  let g:time = []
  while l:count > 0
    normal! 0
    let start_time = reltime()
    execute "normal \<M-l>"
    let g:time += [reltimestr(reltime(start_time))]
    let l:count -= 1
  endwhile
  execute "let mean_time = (" . join(g:time, '+') . ")/" . len(g:time)
  PP! mean_time
endfunction
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

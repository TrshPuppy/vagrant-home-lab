" ONE OFFS --------------------------------------------------------------- {{{

"***** Disable compatibility with vi which can cause unexpected issues: *****
set nocompatible

"***** Enable file-type detection. Vim will be able to try to detect file-type in use: *****
filetype on

"***** Enable plugins and load plugin for the detected file-type: *****
filetype plugin on

"***** Load an indent file for the detected file type: *****
filetype indent on

"***** Enable syntax highlighting: *****
syntax on

"***** Add line numbers: *****
set number

"***** Highlight current line horizontally and/or vertically: *****
set cursorline
set cursorcolumn

"***** Set shift width to 4 spaces: *****
set shiftwidth=4

"***** Set tab width to 4 columns: *****
set tabstop=4

"***** Don't let cursor scroll below or above N number of lines: *****
set scrolloff=10

"*****  Use space characters instead of tabs: *****
"set expandtab

"***** Don't wrap lines (long lines extend as far as they go): *****
set nowrap

" Do not save backupfiles:
set nobackup

"***** While searching though a file incrementally highlight matching characters as you type: *****
set incsearch

"*****  Ignore capital letters during search: *****
set ignorecase

"*****  Override the ignorecase option if searching for capital letters: *****
" This will allow you to search specifically for capital letters:
set smartcase

"*****  Show partial command you type in the last line of the screen: *****
set showcmd

"*****  Show the mode you are on the last line: *****
set showmode

"*****  Show matching words during a search: *****
set showmatch

"*****  Use highlighting when doing a search: *****
set hlsearch

"*****  Set the commands to save in history default number is 20: *****
set history=100

"***** Enable auto completion menu after pressing TAB: *****
set wildmenu

"***** Make wildmenu behave like similar to Bash completion: *****
set wildmode=list:longest

"***** There are certain files that we would never want to edit with Vim: *****
"***** Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

"***** Set the second column to show current fold levels:
set foldcolumn=5
" }}}

" PLUGINS ------------------------------------------------------------- {{{

" Plugin code goes here:

" }}}

" MAPPINGS ------------------------------------------------------------- {{{"

" Mappings code goes here:
"inoremap jj <ESC>"+pa
inoremap jj <esc>
" }}}

" VIMSCRIPT ------------------------------------------------------------- {{{"

" This will enable code folding:
set foldmethod=indent

" Vim Editor Folding ----- {{{
autocmd FileType vim setlocal foldmethod=marker

autocmd FileType md setlocal foldmethod=marker
"augroup filetype_vim
"	autocmd!
"	autocmd FileType vim setlocal foldmethod=marker
"augroup END

" }}}
"
" JavaScript Folding -----{{{
autocmd FileType javascript setlocal foldmethod=expr
autocmd FileType javascript setlocal foldmethod=JSFolds()

" JS Fold expression for imports, etc:
function! JSFolds()
	let currentLine = getline(v:lnum)
	if currentLine =~? '|v^\s*$'
		return '-1'
	endif

	if currentLine =~ '^import.*$'
		return 1
	else
		return indent(v:lnum) / &shiftwidth
	endif
endfunction
" }}}
"
" More Vimscript code goes here:

"}}}

" STATUS LINE ------------------------------------------------------------- {{{"

" Status bar code goes here:

" }}}

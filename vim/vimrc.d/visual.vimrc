"===========
" Color support
"===========
" Enable 256 color
if (&term =~ "256color")
	set t_Co=256
	" Use Dracula
	colorscheme dracula
	" NOTE: Need add truecolor support
	" https://github.com/dracula/vim/issues/96
	" set termguicolors
else
	colorscheme darkblue
endif

"===========
" Highlight
"===========
" Column limit
" https://superuser.com/a/249856
set colorcolumn=100
highlight ColorColumn ctermbg=238 ctermfg=11
" Highlight current line
set cursorline
highlight CursorLine cterm=NONE ctermbg=238
" Highlight visual selection (aka click and drag)
hi Visual term=reverse ctermbg=3 ctermfg=4

"===========
" Whitespace markers
"===========
set list
" Custom linebreaks/tabs/trailing space indicators
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨

"===========
" Separation markers
"===========
set fillchars=vert:│

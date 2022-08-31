"===========
" Colorscheme
"===========
if !empty(&t_Co)
	if &t_Co == 256
	 	if !empty($COLORTERM) && ($COLORTERM == "truecolor" || $COLORTERM == "24bit")
		" Use Dracula
		colorscheme dracula
		set termguicolors
		let g:lightline = {
			\ "colorscheme": "dracula",
			\ }
		endif
	endif
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

"===========
" Netrw
"===========
" Use "tree style" listing
let g:netrw_liststyle=3

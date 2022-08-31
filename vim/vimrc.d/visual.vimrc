"===========
" Colorscheme
"===========
function SupportsTrueColor()
	return !empty($COLORTERM) && ($COLORTERM == "truecolor" || $COLORTERM == "24bit")
endfunction

" tmux documentation insists that term option is either "tmux"-like or "screen"-like.
" As such, Vim can not automatically tell if it is in an "xterm"-like terminal.
" Set `t_8f` and `t_8b` options when term option is "tmux"-like and tmux client term is
" "xterm"-like.
" For more information see :help xterm-true-color.
if SupportsTrueColor() && (&term =~ "^tmux")
	" Get tmux client's terminal name
	let tmux_client_term = system("tmux display-message -p -F '#{client_termname}'")
	if (tmux_client_term =~ "^xterm") " case where tmux_client_term is "xterm"-like
		let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
		let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
	endif
endif

if !empty(&t_Co) && (&t_Co == 256) && SupportsTrueColor()
	set termguicolors
	" Use Dracula
	colorscheme dracula
	let g:lightline = {
		\ "colorscheme": "dracula",
		\ }
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

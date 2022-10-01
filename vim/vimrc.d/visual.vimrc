"===========
" Colorscheme
"===========
function SupportsTrueColor()
	return has("termguicolors") && !empty($COLORTERM) && ($COLORTERM == "truecolor" || $COLORTERM == "24bit")
endfunction

function InTmux()
	return (&term =~ "^tmux" || &term =~ "^screen") && !empty($TMUX)
endfunction

" tmux documentation insists that term option is either "tmux"-like or "screen"-like.
" As such, Vim can not automatically tell if it is in an "xterm"-like terminal.
" Set `t_8f` and `t_8b` options when term option is "tmux"-like and tmux client term is
" "xterm"-like.
" For more information see :help xterm-true-color.
if SupportsTrueColor() && InTmux()
	" Get tmux client's terminal name
	let tmux_client_term = system("tmux display-message -p -F '#{client_termname}'")
	if (tmux_client_term =~ "^xterm") " case where tmux_client_term is "xterm"-like
		let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
		let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
	endif
endif

if !empty(&t_Co) && (&t_Co == 256) && SupportsTrueColor()
	set termguicolors
	try
		" Use Dracula
		colorscheme dracula
		let g:lightline = {
			\ "colorscheme": "dracula",
			\ }
	catch
	endtry
endif

"===========
" Highlight
"===========
" Column limit
" https://superuser.com/a/249856
set colorcolumn=+1
highlight ColorColumn
\          term=reverse
\         cterm=NONE      ctermfg=NONE      ctermbg=8
\           gui=NONE        guifg=NONE        guibg=#1c1c1c

" Highlight current line
set cursorline
set cursorlineopt=screenline,number
highlight CursorLine
\          term=underline
\         cterm=NONE      ctermfg=NONE      ctermbg=8
\           gui=NONE        guifg=NONE        guibg=#1c1c1c

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

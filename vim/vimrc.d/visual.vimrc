"===========
" Lightline
"===========
let g:lightline = {
	\ "colorscheme": "default",
\ }

let g:lightline.active = {
	\ 'left': [ [ 'mode', 'paste' ],
	\           [ 'readonly', 'filename', 'modified', 'winnr' ] ]
	\ }
let g:lightline.inactive = {
	\ 'left': [ [ 'filename' , 'winnr' ] ]
	\ }

augroup colorscheme_lightline_configuration
	autocmd!
	autocmd ColorScheme *
		\ call s:sync_lightline_colorscheme_with_colorscheme()
augroup END

function s:lightline_reload_colorscheme()
	" :help lightline-problem-13
	if !exists('g:loaded_lightline')
		return
	endif
	call lightline#init()
	call lightline#colorscheme()
	call lightline#update()
endfunction

function s:sync_lightline_colorscheme_with_colorscheme()
	if exists("g:colors_name")
		let g:lightline.colorscheme = g:colors_name
		call s:lightline_reload_colorscheme()
	endif
endfunction

"===========
" Highlight
"===========
augroup colorscheme_highlight_override
	autocmd!
	autocmd ColorScheme * call s:highlight_override()
augroup END

function s:highlight_override()
	if &diff
		return v:false
	endif

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
endfunction

call s:highlight_override()

"===========
" Whitespace markers
"===========
" Custom linebreaks/tabs/trailing space indicators
set list
set listchars=eol:\\u21B2           " ↲
set listchars+=tab:\\u22EE\ \\u2192 " ⋮ →
set listchars+=lead:\\u25E6         " ◦
set listchars+=trail:\\u2022        " •
set listchars+=extends:\\u27E9      " ⟩
set listchars+=precedes:\\u27E8     " ⟨
set listchars+=nbsp:\\u2298         " ⊘

function s:set_showbreak(flag)
	if a:flag == v:true
		let &showbreak="↪ "
	else
		set showbreak=
	endif
endfunction

call s:set_showbreak(1)

augroup optionset_whitespace_markers
	autocmd!
	autocmd OptionSet list call s:optionset_list()
augroup END

function s:optionset_list()
	" Only proceed if 'list' changed
	if v:option_old == v:option_new
		return
	endif

	if v:option_new
		call s:set_showbreak(1)
	else
		call s:set_showbreak(0)
	endif
endfunction

"===========
" Separation markers
"===========
set fillchars=vert:│

"===========
" Netrw
"===========
" Use "tree style" listing
let g:netrw_liststyle=3

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

function s:colorscheme_dracula()
	if !empty(&t_Co) && (&t_Co == 256) && SupportsTrueColor()
		set termguicolors
		try
			" Use Dracula
			colorscheme dracula
		catch
		endtry
	endif
endfunction

augroup colorscheme_dracula_customization
	autocmd!
	autocmd ColorScheme dracula call s:dracula_customization()
augroup END

function s:dracula_customization()
	highlight! link SpecialKey DraculaBoundary
	call s:sync_lightline_colorscheme_with_colorscheme()
endfunction

call s:colorscheme_dracula()
"
"===========
" Undercurl
"===========
function s:using_iterm()
	let envs = [$TERM_PROGRAM, $LC_TERMINAL]
	for env in envs
		if !empty(env) && env =~? "^iterm"
			return v:true
		endif
	endfor
	return v:false
endfunction

if s:using_iterm()
	let &t_Cs = "\e[4:3m"
	let &t_Ce = "\e[4:0m"
else
	let start_smulx = system("tput Smulx 3")
	if v:shell_error == 0
		let &t_Cs = start_smulx
		let &t_Ce = system("tput Smulx 0")
	endif
endif
